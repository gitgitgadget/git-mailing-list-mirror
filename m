From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH 2/2] mingw: avoid const warning
Date: Fri, 06 Jun 2014 17:08:06 +0200
Message-ID: <5391D956.7050903@gmail.com>
References: <20140529104329.GA24021@camelia.ucw.cz> <20140529104716.GC24021@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Erik Faye-Lund <kusmabite@gmail.com>, msysgit@googlegroups.com
To: Stepan Kasal <kasal@ucw.cz>, GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCH3XYXLXQDBBU5SY6OAKGQE6YS5KDI@googlegroups.com Fri Jun 06 17:08:07 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBU5SY6OAKGQE6YS5KDI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f184.google.com ([209.85.217.184])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBU5SY6OAKGQE6YS5KDI@googlegroups.com>)
	id 1WsvkS-0008CP-Qu
	for gcvm-msysgit@m.gmane.org; Fri, 06 Jun 2014 17:08:04 +0200
Received: by mail-lb0-f184.google.com with SMTP id n15sf327402lbi.1
        for <gcvm-msysgit@m.gmane.org>; Fri, 06 Jun 2014 08:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=4YaZ943LbUiLnTizNdb0Pevavaat7BPm1uulrdJNsjw=;
        b=vLXh/GtfRVryQOdYG5+XqjhZXjf/SUADY9UAHT7m0tTmReSoJ74U0pOajxHV125HGX
         Y96iAJDSN04gvAfAi4qZ0mS+GvVVj2iGdp9F8SOgywlFSHb4jMbRwWukva7XtqahnhjP
         KGbGtEU6wJ62l4TGn7d74NC49Mq/BI7dzUHhf2Wls7isQbkBzOgWPhqCDkXhJN9tdO18
         mSY5zOXSjal7IJKyKYAzjhwOHMVDHBalPAC4DguALVrGOMFQdYgd5LctSzM6eaHznfnz
         5aM0srXpuc1IE5g1wVqhoZqIGLm7G3ZmujM1Fa+uF8GpYMw5hZs6uDcT8YVCtBSWiicX
         QLZA==
X-Received: by 10.180.90.79 with SMTP id bu15mr22048wib.14.1402067284619;
        Fri, 06 Jun 2014 08:08:04 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.99.39 with SMTP id en7ls114270wib.8.gmail; Fri, 06 Jun
 2014 08:08:03 -0700 (PDT)
X-Received: by 10.180.72.19 with SMTP id z19mr1015040wiu.7.1402067283395;
        Fri, 06 Jun 2014 08:08:03 -0700 (PDT)
Received: from mail-wg0-x22f.google.com (mail-wg0-x22f.google.com [2a00:1450:400c:c00::22f])
        by gmr-mx.google.com with ESMTPS id se3si1945617wic.3.2014.06.06.08.08.03
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 06 Jun 2014 08:08:03 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::22f as permitted sender) client-ip=2a00:1450:400c:c00::22f;
Received: by mail-wg0-f47.google.com with SMTP id k14so2046047wgh.30
        for <msysgit@googlegroups.com>; Fri, 06 Jun 2014 08:08:03 -0700 (PDT)
X-Received: by 10.14.251.4 with SMTP id a4mr712943ees.20.1402067283245;
        Fri, 06 Jun 2014 08:08:03 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id q49sm23374366eeo.23.2014.06.06.08.08.01
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 06 Jun 2014 08:08:02 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <20140529104716.GC24021@camelia.ucw.cz>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::22f
 as permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250940>

Am 29.05.2014 12:47, schrieb Stepan Kasal:
> Fix const warnings in http-fetch.c and remote-curl.c main() where is
> argv declared as const.
> 
> The fix should work for all future declarations of main, no matter
> whether the second parameter's type is "char**", "const char**", or
> "char *[]".

I'm 100% in favor of a solution that doesn't restrict main to non-const char**! Thanks.

> Signed-off-by: Stepan Kasal <kasal@ucw.cz>
> ---
>  compat/mingw.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/compat/mingw.h b/compat/mingw.h
> index 15f0c9d..8745d19 100644
> --- a/compat/mingw.h
> +++ b/compat/mingw.h
> @@ -369,10 +369,11 @@ extern CRITICAL_SECTION pinfo_cs;
>  void mingw_startup();
>  #define main(c,v) dummy_decl_mingw_main(); \
>  static int mingw_main(c,v); \
> -int main(int argc, char **argv) \
> +int main(c, char **main_argv_not_used) \
>  { \
> +	typedef v, **argv_type; \
>  	mingw_startup(); \
> -	return mingw_main(__argc, __argv); \
> +	return mingw_main(__argc, (argv_type)__argv); \
>  } \
>  static int mingw_main(c,v)
>  

I have to admit I had trouble understanding what 'typedef v, **arv_type;' does (looks invalid at first glance), and why you would need main_argv_not_used instead of just main(c,v).

So, I'd like to award +10 points for cleverness, but -10 for obscurity ;-) Probably deserves a comment or an explanation in the commit message.

A simpler solution that works with all definitions of main() is to cast to void* (tell the compiler all responsibility is on us). I.e.:

void mingw_startup();
#define main(c,v) dummy_decl_mingw_main(); \
static int mingw_main(c,v); \
int main(c,v) \
{ \
	mingw_startup(); \
	return mingw_main(__argc, (void *) __argv); \
} \
static int mingw_main(c,v)

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
