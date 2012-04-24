From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] contrib: add win32 credential-helper
Date: Tue, 24 Apr 2012 16:40:52 -0400
Message-ID: <20120424204052.GC21904@sigill.intra.peff.net>
References: <1334861122-3144-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: msysgit+bncCN2hpKqZChDZn9z8BBoE8AB83g@googlegroups.com Tue Apr 24 22:41:02 2012
Return-path: <msysgit+bncCN2hpKqZChDZn9z8BBoE8AB83g@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pb0-f58.google.com ([209.85.160.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCN2hpKqZChDZn9z8BBoE8AB83g@googlegroups.com>)
	id 1SMmXi-0002eJ-JF
	for gcvm-msysgit@m.gmane.org; Tue, 24 Apr 2012 22:40:58 +0200
Received: by pbcuo15 with SMTP id uo15sf417659pbc.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 24 Apr 2012 13:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:date:from:to:cc:subject:message-id
         :references:mime-version:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type:content-disposition;
        bh=CKxZtviTsS6OEEzvN+eQxMfNAMe25tjNwlqk3dv7eiE=;
        b=pBziSJEa5rGWXWGjfZGUN/bHvxriKzuNJBdRQu2eHCR38ruyQ03DSLIaaVTgt9UYUW
         HynhorP+XvOeCJ6S1aao+dPMETS0nKo6S4FBiG4Vu0IPAa3XY26QBpfscmqzVwdMQO3j
         SZuHP5ZbF9HvnRWv8yKYYf/Rw8exTAGcmd7eo=
Received: by 10.50.173.70 with SMTP id bi6mr4724071igc.6.1335300057078;
        Tue, 24 Apr 2012 13:40:57 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.231.71.151 with SMTP id h23ls11618401ibj.6.gmail; Tue, 24 Apr
 2012 13:40:55 -0700 (PDT)
Received: by 10.50.140.4 with SMTP id rc4mr34581igb.0.1335300055440;
        Tue, 24 Apr 2012 13:40:55 -0700 (PDT)
Received: by 10.50.140.4 with SMTP id rc4mr34578igb.0.1335300055426;
        Tue, 24 Apr 2012 13:40:55 -0700 (PDT)
Received: from peff.net (99-108-226-0.lightspeed.iplsin.sbcglobal.net. [99.108.226.0])
        by gmr-mx.google.com with ESMTPS id dd7si7469781igc.0.2012.04.24.13.40.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Apr 2012 13:40:55 -0700 (PDT)
Received-SPF: pass (google.com: domain of peff@peff.net designates 99.108.226.0 as permitted sender) client-ip=99.108.226.0;
Received: (qmail 19182 invoked by uid 107); 24 Apr 2012 20:41:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 24 Apr 2012 16:41:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Apr 2012 16:40:52 -0400
In-Reply-To: <1334861122-3144-1-git-send-email-kusmabite@gmail.com>
X-Original-Sender: peff@peff.net
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of peff@peff.net designates 99.108.226.0 as permitted sender) smtp.mail=peff@peff.net
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196249>

On Thu, Apr 19, 2012 at 08:45:22PM +0200, Erik Faye-Lund wrote:

> Here's an updated version of my Windows credential-helper.
> 
> The most important difference is that it doesn't suck as much as
> it used to ;)
> 
> Basically, I'm now using the attribute-system to store the meta-data
> for the credentials.
> 
> This passes the test for me, and seems to work OK.

This looks much better. As usual, I can't comment on the Windows-y
parts, but the credential logic looks good. One minor comment:

> +int main(int argc, char *argv[])
> +{
> [...]
> +	if (!protocol || !host)
> +		return 0;

You could have a protocol that does not have a "host" component. Git
will produce this for a cached certificate password (which will then
always have a "path" field). I don't know if anybody is using it to
cache certificate passwords, and I admit that it is not very well tested
by me, either. So I'm not sure anybody will actually care.

The credential-store helper uses this logic:

  $ sed -n '70,79p' credential-store.c
        /*
         * Sanity check that what we are storing is actually sensible.
         * In particular, we can't make a URL without a protocol field.
         * Without either a host or pathname (depending on the scheme),
         * we have no primary key. And without a username and password,
         * we are not actually storing a credential.
         */
        if (!c->protocol || !(c->host || c->path) ||
            !c->username || !c->password)
                return;

I'm pretty sure the OS X helper does not handle certificate passwords at
all. It is harder there, because I map directly to native protocol
types, and I haven't checked to see whether OS X handles this type. But
since you are just storing whatever protocol information git hands you,
I think for you it is just a matter of letting it through (and handling
the "!host" case when writing).

-Peff

-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***

*** Please avoid top-posting. ***

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en
