From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git grep -O -i: if the pager is 'less', pass
 the '-i' option
Date: Wed, 14 May 2014 15:07:17 -0400
Message-ID: <20140514190716.GA2715@sigill.intra.peff.net>
References: <20140514155010.GA4592@camelia.ucw.cz>
 <xmqq7g5okztp.fsf@gitster.dls.corp.google.com>
 <20140514182654.GA9218@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Stepan Kasal <kasal@ucw.cz>,
	GIT Mailing-list <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	msysGit <msysgit@googlegroups.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: msysgit+bncBDO2DJFKTEFBB2H5Z2NQKGQEERD24CA@googlegroups.com Wed May 14 21:07:27 2014
Return-path: <msysgit+bncBDO2DJFKTEFBB2H5Z2NQKGQEERD24CA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yk0-f186.google.com ([209.85.160.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDO2DJFKTEFBB2H5Z2NQKGQEERD24CA@googlegroups.com>)
	id 1WkeWQ-0002ir-7Z
	for gcvm-msysgit@m.gmane.org; Wed, 14 May 2014 21:07:22 +0200
Received: by mail-yk0-f186.google.com with SMTP id q9sf195987ykb.23
        for <gcvm-msysgit@m.gmane.org>; Wed, 14 May 2014 12:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type
         :content-disposition;
        bh=CWN2s/dibMTI3cIb8700KT4mK6+PN8iZ96JhSaqJHTA=;
        b=osLFV+kN9xkq0fvv0gij9T0EaYYDC70Oym/ZND81I3eJsXwhgc3EdW1pmiOH8t3GAr
         6TP0xK+UowV4qkfVHglH131CkDRQvxQtAtFFeLLXu3gPpYnI2xWzsF/mrDjL7uaeQlNS
         MY0YEr49HDCnO1JigLEFcPjVjLRr2HiASKfajIcM+Pc31KA6+w0jO5UdgsfnpUzxz8tq
         nNzo0bft8AI5wzcnv23Ut8l2igaUsIGv8NyGXErS7qEKtN6sc+0jgI5tbOE9mAKAgU17
         7muDxSnrFy3W3pUCs7rtS6kEB+azYorY/IkfzPfRdUqZnoOodoTqoScbTDXKiiSq2PG3
         ArCQ==
X-Received: by 10.50.59.179 with SMTP id a19mr886319igr.10.1400094441235;
        Wed, 14 May 2014 12:07:21 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.50.174 with SMTP id d14ls2943255igo.13.gmail; Wed, 14 May
 2014 12:07:20 -0700 (PDT)
X-Received: by 10.66.102.36 with SMTP id fl4mr2496194pab.20.1400094440649;
        Wed, 14 May 2014 12:07:20 -0700 (PDT)
Received: from peff.net (cloud.peff.net. [50.56.180.127])
        by gmr-mx.google.com with SMTP id la2si199168igb.1.2014.05.14.12.07.20
        for <msysgit@googlegroups.com>;
        Wed, 14 May 2014 12:07:20 -0700 (PDT)
Received-SPF: pass (google.com: domain of peff@peff.net designates 50.56.180.127 as permitted sender) client-ip=50.56.180.127;
Received: (qmail 8387 invoked by uid 102); 14 May 2014 19:07:20 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 14 May 2014 14:07:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 May 2014 15:07:17 -0400
In-Reply-To: <20140514182654.GA9218@google.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248936>

On Wed, May 14, 2014 at 11:26:54AM -0700, Jonathan Nieder wrote:

> "git grep" has other options that affect interpretation of the pattern
> which this patch does not help with:
> 
>  * -v / --ignore-match: probably should disable this feature of -O.
>  * -E / --extended-regexp
>  * -P / --perl-regexp
>  * -F / --fixed-strings: ideally would auto-escape regex specials.
>  * -e<pattern1> --or -e<pattern2>
> 
> And git grep -Ovi has a similar bug, for which the fix is to add
> \c to the pattern instead of passing an -I option.

We've already found the lines of interest to the user. It would be nice
if we could somehow point the pager at them by number, rather than
repeating the (slightly incompatible) search.

We can do "less +25", but that only points it to the first instance (and
doesn't highlight it), whereas the current code lets the repeat-search
find other instances. I don't think there's a way to queue up a set of
interesting lines to visit in less. At least I could not think of one.

This is more or less how I ended up at the design of contrib/git-jump,
which uses quickfix lists to make such a queue (only editors
understand those, not pagers, but I consider being dumped into the
editor a feature :) ).

> But as is, it's an improvement, so (except that "-i" should be
> replaced by "-I") it seems like a good change.

Agreed. Thanks for the list of problematic options.

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
