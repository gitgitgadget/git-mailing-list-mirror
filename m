From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC] http_init: only initialize SSL for https
Date: Thu, 14 Mar 2013 16:23:59 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1303141621340.3794@s15462909.onlinehome-server.info>
References: <1363269079-6124-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: msysgit+bncBCZPH74Q5YNRBE6XQ6FAKGQE5SRCLXI@googlegroups.com Thu Mar 14 16:24:27 2013
Return-path: <msysgit+bncBCZPH74Q5YNRBE6XQ6FAKGQE5SRCLXI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f187.google.com ([209.85.217.187])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBE6XQ6FAKGQE5SRCLXI@googlegroups.com>)
	id 1UGA15-0007st-6t
	for gcvm-msysgit@m.gmane.org; Thu, 14 Mar 2013 16:24:27 +0100
Received: by mail-lb0-f187.google.com with SMTP id i15sf807005lbo.4
        for <gcvm-msysgit@m.gmane.org>; Thu, 14 Mar 2013 08:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-received:x-beenthere:x-received:received-spf:x-authenticated
         :x-provags-id:date:from:x-x-sender:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version:x-y-gmx-trusted
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-google-group-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe:content-type;
        bh=f23fHiEgT1niUhSPS6lspqpukyyoqn6cV+bj4M2b078=;
        b=C5+f6vHmXctrytpzETDJzFNdo15082JuIj3giLGFTihoNo8IN74wT94mE2oloV7g40
         B5GG3xCiDWGlRlk8UrhpNfDssItuUroNiu8DIx9kGH17mIWT4vjnlou2IOPL1zlKQAnA
         vzFCjQeZSwyBM7Vupr9uHuuZ88NghrIqTTfysZUOLJvH0XvGxHE7c+i2cxTtTKeh/PcD
         WZhpnIQo1rTdYMdAP3hxsm4dOCMo5C84kaP74rxPFwgGITRfHDx/C7Lt2gdAf9N+VjU6
      
X-Received: by 10.180.73.162 with SMTP id m2mr249856wiv.18.1363274644552;
        Thu, 14 Mar 2013 08:24:04 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.24.37 with SMTP id r5ls8682wif.3.gmail; Thu, 14 Mar 2013
 08:24:02 -0700 (PDT)
X-Received: by 10.14.149.138 with SMTP id x10mr4005794eej.5.1363274642971;
        Thu, 14 Mar 2013 08:24:02 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.15])
        by gmr-mx.google.com with ESMTP id 47si683622eeh.1.2013.03.14.08.24.02;
        Thu, 14 Mar 2013 08:24:02 -0700 (PDT)
Received-SPF: pass (google.com: domain of johannes.schindelin@gmx.de designates 212.227.15.15 as permitted sender) client-ip=212.227.15.15;
Received: from mailout-de.gmx.net ([10.1.76.16]) by mrigmx.server.lan
 (mrigmx002) with ESMTP (Nemesis) id 0Ld330-1Uxz9e2jSq-00iA2i for
 <msysgit@googlegroups.com>; Thu, 14 Mar 2013 16:24:02 +0100
Received: (qmail invoked by alias); 14 Mar 2013 15:24:02 -0000
Received: from s15462909.onlinehome-server.info (EHLO s15462909.onlinehome-server.info) [87.106.4.80]
  by mail.gmx.net (mp016) with SMTP; 14 Mar 2013 16:24:02 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/o/Tc8Ge7oibsyQ3IXsnsijATppuUYs1Hsj41tQJ
	caltxubHiXR/kg
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <1363269079-6124-1-git-send-email-kusmabite@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of johannes.schindelin@gmx.de designates 212.227.15.15 as
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218145>

Hi kusma,

On Thu, 14 Mar 2013, Erik Faye-Lund wrote:

> Since ancient times, we have been calling curl_global_init with the
> CURL_GLOBAL_ALL-flag, which initializes SSL (and the Win32 socket
> stack on Windows).
> 
> Initializing SSL takes quite some time on Windows, so let's avoid
> doing it when it's not needed.
> 
> timing of echo "" | ./git-remote-http.exe origin http://localhost
> 
> before
> 
> best of 10 runs:
> real    0m1.634s
> user    0m0.015s
> sys     0m0.000s
> 
> worst of 10 runs:
> real    0m2.701s
> user    0m0.000s
> sys     0m0.000s
> 
> after
> 
> best of 10 runs:
> real    0m0.018s
> user    0m0.000s
> sys     0m0.000s
> 
> worst of 10 runs:
> real    0m0.024s
> user    0m0.000s
> sys     0m0.015s

Good analysis!

> diff --git a/http.c b/http.c
> index 3b312a8..528a736 100644
> --- a/http.c
> +++ b/http.c
> @@ -343,7 +343,8 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
>  
>  	git_config(http_options, NULL);
>  
> -	curl_global_init(CURL_GLOBAL_ALL);
> +	curl_global_init(CURL_GLOBAL_WIN32 | (prefixcmp(url, "https:") ? 0 :
> +	    CURL_GLOBAL_SSL));
>  
>  	http_proactive_auth = proactive_auth;

I wonder whether we want to have something like this instead:

	flags = CURL_GLOBAL_ALL;
	if (prefixcmp(url, "https:"))
		flags &= ^CURL_GLOBAL_SSL;
	curl_global_init(flags);

I do see that CURL_GLOBAL_ALL is #define'd as CURL_GLOBAL_WIN32 |
CURL_GLOBAL_SSL in curl.h, but that might change in the future, no?

Ciao,
Dscho

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
