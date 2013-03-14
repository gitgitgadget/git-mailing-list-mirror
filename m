From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Re: [PATCH/RFC] http_init: only initialize SSL for https
Date: Thu, 14 Mar 2013 17:57:43 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1303141756100.3794@s15462909.onlinehome-server.info>
References: <1363269079-6124-1-git-send-email-kusmabite@gmail.com> <7vy5dqx913.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org, 
    msysgit@googlegroups.com
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBCZPH74Q5YNRBCEDRCFAKGQEZVEBP4A@googlegroups.com Thu Mar 14 17:58:07 2013
Return-path: <msysgit+bncBCZPH74Q5YNRBCEDRCFAKGQEZVEBP4A@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ea0-f186.google.com ([209.85.215.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBCEDRCFAKGQEZVEBP4A@googlegroups.com>)
	id 1UGBTj-0003Dr-MH
	for gcvm-msysgit@m.gmane.org; Thu, 14 Mar 2013 17:58:07 +0100
Received: by mail-ea0-f186.google.com with SMTP id d10sf747422eaj.13
        for <gcvm-msysgit@m.gmane.org>; Thu, 14 Mar 2013 09:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-received:x-beenthere:x-received:received-spf:x-authenticated
         :x-provags-id:date:from:x-x-sender:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version:x-y-gmx-trusted
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-google-group-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe:content-type;
        bh=Vi8AgVO6LgBREnTDt++XVIhUpsCcuD/bgR/QDAsWNPA=;
        b=Krv1AgDfHBKlhebXzXQXqWwbpMOCMz0g6tBF5yjbLd7pArggtaVDyEa8IR2B264k9t
         Ix/C5hJYIx1RarUo07F2RjmX3u/XPRKt7K8qTADISQ6EiGzp0t3f+JGU2CQk/TmfNnWH
         SxuddJWLVhUocUfKHCgKOcEfr2RBsut2KzVKvneD6lhxDkmTeUGHUg8/cU//6rJMY/PT
         xDC17Qse+6XA9dyvwatczjYGyYLdjYc2FTLKSvcylLOHEAcMqCCxVIzE7AqWoQaUafYD
      
X-Received: by 10.180.37.225 with SMTP id b1mr2666277wik.9.1363280265009;
        Thu, 14 Mar 2013 09:57:45 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.82.3 with SMTP id e3ls1864039wiy.11.canary; Thu, 14 Mar
 2013 09:57:44 -0700 (PDT)
X-Received: by 10.15.44.2 with SMTP id y2mr4406749eev.2.1363280264119;
        Thu, 14 Mar 2013 09:57:44 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.18])
        by gmr-mx.google.com with ESMTP id 6si794350eej.0.2013.03.14.09.57.44;
        Thu, 14 Mar 2013 09:57:44 -0700 (PDT)
Received-SPF: pass (google.com: domain of johannes.schindelin@gmx.de designates 212.227.15.18 as permitted sender) client-ip=212.227.15.18;
Received: from mailout-de.gmx.net ([10.1.76.33]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0LpAT4-1Uv2XL3gvs-00etgA for
 <msysgit@googlegroups.com>; Thu, 14 Mar 2013 17:57:43 +0100
Received: (qmail invoked by alias); 14 Mar 2013 16:57:43 -0000
Received: from s15462909.onlinehome-server.info (EHLO s15462909.onlinehome-server.info) [87.106.4.80]
  by mail.gmx.net (mp033) with SMTP; 14 Mar 2013 17:57:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+5HrkvUmC50mTinYrr7bl2ytnQvrxM/6JzIGdsRV
	6bfre2w25FV5Aw
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <7vy5dqx913.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of johannes.schindelin@gmx.de designates 212.227.15.18 as
 permitted sender) smtp.mail=johannes.schindelin@gmx.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218153>

Hi Junio,

On Thu, 14 Mar 2013, Junio C Hamano wrote:

> Erik Faye-Lund <kusmabite@gmail.com> writes:
> 
> > diff --git a/http.c b/http.c
> > index 3b312a8..528a736 100644
> > --- a/http.c
> > +++ b/http.c
> > @@ -343,7 +343,8 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
> >  
> >  	git_config(http_options, NULL);
> >  
> > -	curl_global_init(CURL_GLOBAL_ALL);
> > +	curl_global_init(CURL_GLOBAL_WIN32 | (prefixcmp(url, "https:") ? 0 :
> > +	    CURL_GLOBAL_SSL));
> 
> The first and obvious question is what the symbol with a name
> specific to one single platform doing in this generic codepath.
> In order to get convinced that the patch does not regress, one
> somehow need to know that bits in ALL other than WIN32 and SSL
> do not matter (or there is no such bit).
> 
> I'd understand if it were "ALL & ~SSL" though.

Hence my earlier suggestion (with the obvious tyop '^' instead of '~').
You will also find the information in my mail (unless you plonk my mails)
that CURL_GLOBAL_ALL is defined as CURL_GLOBAL_WIN32 | CURL_GLOBAL_SSL,
and in kusma's response the suggestion to use DEFAULT & ~SSL instead.

Ciao,
Johannes

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
For more options, visit https://groups.google.com/groups/opt_out.
