From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] symlinks: remove PATH_MAX limitation
Date: Sat, 5 Jul 2014 04:52:56 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1407050449220.14982@s15462909.onlinehome-server.info>
References: <53B72DAA.5050007@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBCZPH74Q5YNRBCOR3WOQKGQEYUMTIQY@googlegroups.com Sat Jul 05 04:53:00 2014
Return-path: <msysgit+bncBCZPH74Q5YNRBCOR3WOQKGQEYUMTIQY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f191.google.com ([209.85.217.191])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBCOR3WOQKGQEYUMTIQY@googlegroups.com>)
	id 1X3G5z-00031z-Ex
	for gcvm-msysgit@m.gmane.org; Sat, 05 Jul 2014 04:52:59 +0200
Received: by mail-lb0-f191.google.com with SMTP id c11sf263007lbj.28
        for <gcvm-msysgit@m.gmane.org>; Fri, 04 Jul 2014 19:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=EbFbeHOTnOBZgH5TdPZV7TIvrnANCc8blPciY9SXrig=;
        b=JHLIp7XQ0waxzbfht3uGaQTxsA/5AhPyNxTGC8sxKoUlnNTrKm0ZAMAHqGjPd2STZe
         28uiTsKvOVrpVbiUxq0LgnwFDp04OU/yoJ/Qnyf4lOj17X/yHDHnz//WQn9U0IW2RAop
         YLqAOkCjmXjfKx4vWaGdCtdG2SQDduYa+vBO8sKXktT6cSMG+sF3eWQY4t9n4BwAL8fU
         ExMxHry/+iTnRufvbwX9+mhoF4yNSfsor4UxDRH1MbzvBOUQfvZ5dK1FNIXjSVJfGhOz
         fLhz/Bu44bQuV7B62Plrjj4zNk6jX0A+RLV8CQ/aObf5WLyrZHwp/ZvqKL54VZGyPO/z
         h8NA==
X-Received: by 10.152.37.202 with SMTP id a10mr169499lak.2.1404528779199;
        Fri, 04 Jul 2014 19:52:59 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.234.34 with SMTP id ub2ls171854lac.47.gmail; Fri, 04 Jul
 2014 19:52:57 -0700 (PDT)
X-Received: by 10.112.171.35 with SMTP id ar3mr1322948lbc.0.1404528777529;
        Fri, 04 Jul 2014 19:52:57 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.17.21])
        by gmr-mx.google.com with ESMTPS id m9si1458190wiw.0.2014.07.04.19.52.57
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jul 2014 19:52:57 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.17.21 as permitted sender) client-ip=212.227.17.21;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0MCfcc-1WtsRW2YqI-009OuL;
 Sat, 05 Jul 2014 04:52:56 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <53B72DAA.5050007@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:KgvmIdFKeiDURjvL6ahZ3IVZCSfGaZRM3tayE4947ilYfPd5qLz
 ZyE5ldUt2EmtksS4w33TdXxacOqJirRr2wgpPPEA1/8N3L+TuHg7OZLyF4orm+Zq6qptiiC
 E64kPhFsPu+CrwB5EBO/QGaZkqrsQ9a9q3mssW9GMWFLpdJgFfK533yIu4xkz4wjSJFkhYD
 iF2fouoL9bNmN5qKYa/zg==
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.17.21 as
 permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252914>

Hi,

On Sat, 5 Jul 2014, Karsten Blees wrote:

> 'git checkout' fails if a directory is longer than PATH_MAX, because the
> lstat_cache in symlinks.c checks if the leading directory exists using
> PATH_MAX-bounded string operations.
> 
> Remove the limitation by using strbuf instead.
> 
> Signed-off-by: Karsten Blees <blees@dcon.de>
> ---
> 
> This fixes a bug on Windows with long paths [1].
> 
> [1] https://github.com/msysgit/msysgit/issues/227

For context: on Windows, PATH_MAX is ridiculously small. And it really is
that small, file functions of the Win32 API cannot handle longer paths.

However, there is a (pretty ugly, if you ask me) workaround: prefixing the
paths with "\\?\" and lo and behold, *many* (but not all) Win32 API
functions can then handle paths up to something around 32,000 characters!

The problem Karsten addressed here is caused exactly by this oddity: we
*can* handle paths much longer than PATH_MAX. Therefore, we need to
decouple the path buffers from that hardcoded limitation.

Karsten, you rock.

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
For more options, visit https://groups.google.com/d/optout.
