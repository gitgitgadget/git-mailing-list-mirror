From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH v4 2/3] add trace_performance facility to
 debug performance issues
Date: Wed, 21 May 2014 16:55:24 -0400
Message-ID: <20140521205524.GB8381@sigill.intra.peff.net>
References: <537BA806.50600@gmail.com>
 <537BA8D7.4000007@gmail.com>
 <20140521165806.GD2040@sigill.intra.peff.net>
 <537CF1C7.6030408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBDO2DJFKTEFBBPVF6SNQKGQEO6VCX6Y@googlegroups.com Wed May 21 22:55:28 2014
Return-path: <msysgit+bncBDO2DJFKTEFBBPVF6SNQKGQEO6VCX6Y@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vc0-f190.google.com ([209.85.220.190])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDO2DJFKTEFBBPVF6SNQKGQEO6VCX6Y@googlegroups.com>)
	id 1WnDXr-0001gF-O2
	for gcvm-msysgit@m.gmane.org; Wed, 21 May 2014 22:55:27 +0200
Received: by mail-vc0-f190.google.com with SMTP id lg15sf629101vcb.7
        for <gcvm-msysgit@m.gmane.org>; Wed, 21 May 2014 13:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type
         :content-disposition;
        bh=+ePCPeO/4rC5ccv6nXnCLabHAGfF6KybX4o7Oa0MPWU=;
        b=uQTfN4PL+jRZPDuzy3XPwYEsDsqGM3atr9HUJONFyD9eA+CCO7hFzxH8rxKb8UJFOB
         gblVhcpLSvwTWWbOWoUOxb+An2U6RjsSvhkDAtIj37Mjf/bbdcika75dPJp8TFn0VZwG
         LndhBK18gOU29DAOdkUrYGA5eRsN6HB3HtIoi5RfzbMtGG5wBsiaZR3FAH7TCMzw6npc
         OjEncLMZv5vEqZ4umxkwpE0D8AFqVqQpgSBixeb8IMDwrXf8cRGP4sVbMEKAZp2m4/c9
         uamefEeifVMlVRQL9wU1CfO9gwhJQVNmbRaad595of6mSUWEAo4YPUcZZXnaRk90s8Ed
         Fh1g==
X-Received: by 10.182.158.167 with SMTP id wv7mr132509obb.29.1400705726954;
        Wed, 21 May 2014 13:55:26 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.182.73.165 with SMTP id m5ls291105obv.52.gmail; Wed, 21 May
 2014 13:55:26 -0700 (PDT)
X-Received: by 10.182.252.166 with SMTP id zt6mr23406496obc.17.1400705726264;
        Wed, 21 May 2014 13:55:26 -0700 (PDT)
Received: from peff.net (cloud.peff.net. [50.56.180.127])
        by gmr-mx.google.com with SMTP id la2si310730igb.1.2014.05.21.13.55.25
        for <msysgit@googlegroups.com>;
        Wed, 21 May 2014 13:55:26 -0700 (PDT)
Received-SPF: pass (google.com: domain of peff@peff.net designates 50.56.180.127 as permitted sender) client-ip=50.56.180.127;
Received: (qmail 2631 invoked by uid 102); 21 May 2014 20:55:25 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 21 May 2014 15:55:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 May 2014 16:55:24 -0400
In-Reply-To: <537CF1C7.6030408@gmail.com>
X-Original-Sender: peff@peff.net
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of peff@peff.net designates 50.56.180.127 as permitted
 sender) smtp.mail=peff@peff.net
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249828>

On Wed, May 21, 2014 at 08:34:47PM +0200, Karsten Blees wrote:

> Macros are mainly used to supply __FILE__ and __LINE__, so that lazy
> people don't need to think of a unique message for each use of
> trace_performance_*. Without __FILE__, __LINE__ and message, the
> output would be pretty useless (i.e. just the time without any
> additional info).
> 
> If there's platforms that don't support variadic macros, I'd suggest
> to drop the __FILE__ __LINE__ feature completely and make message
> mandatory (with the added benefit that manually provided messages
> don't change if the code is moved, i.e. trace logs would become
> somewhat comparable across versions).

I do think __FILE__ and __LINE__ can be useful, and it would not be the
end of the world to simply omit them on platforms that can't do the
variadic macros (there shouldn't be many these days, and I think they
are used to living with reduced functionality in some cases).

But if this were attached to trace_printf, we would always have a
message anyway, no?

-Peff

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
