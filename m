From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add custom memory allocator to MinGW and MacOS
 builds
Date: Fri, 3 Apr 2009 17:01:04 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904031659290.10279@pacific.mpi-cbg.de>
References: <1238766761-3576-1-git-send-email-marius@trolltech.com>
Reply-To: Johannes.Schindelin@gmx.de
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Fri Apr 03 17:00:29 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yx-out-2122.google.com ([74.125.44.25])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpksS-0003HA-VY
	for gcvm-msysgit@m.gmane.org; Fri, 03 Apr 2009 17:00:17 +0200
Received: by yx-out-2122.google.com with SMTP id 22so344016yxm.63
        for <gcvm-msysgit@m.gmane.org>; Fri, 03 Apr 2009 07:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=dqLj4zW5UWY8w4anxA4Oob2oSp9xe3a+WCa/nGf7YjM=;
        b=tr584NEjWDAeXGEv7QHuT6umJaEEXES1bJDngrW7zTmo0nS2vKvYCc0bkAJSmwsRqW
         WKfTjx74EwoRpxU8gnlNocizhPRsPGX/Z810pFBYPXfCScDrtOlp4LyE+6P7QsQjRrzg
         ejjZbNWVKzF2BwaqGV1eIapQkl3Dv2zZ9JuQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject
         :in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=QTa2t/AMObQT4XWr8IPjCQfI2B6tVaLzvHlKqMDZaM9aNPK3LkOGk2ehPmJjAAtmFk
         pcofrSDP+QoYI7dQ5oZdFKm52hkfpwT3vflObRKpFTBv67i5XQPU/8cytFMCGD1oyWcl
         FqxLOL6ueKxY6GCJ+0F0yDz8Pp2odhm3rODok=
Received: by 10.100.12.4 with SMTP id 4mr180835anl.11.1238770721103;
        Fri, 03 Apr 2009 07:58:41 -0700 (PDT)
Received: by 10.177.113.42 with SMTP id q42gr4633yqm.0;
	Fri, 03 Apr 2009 07:58:41 -0700 (PDT)
X-Sender: Johannes.Schindelin@gmx.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.103.131.18 with SMTP id i18mr12271mun.19.1238770719722; Fri, 03 Apr 2009 07:58:39 -0700 (PDT)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by gmr-mx.google.com with SMTP id 15si167772bwz.6.2009.04.03.07.58.39; Fri, 03 Apr 2009 07:58:39 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Received: (qmail invoked by alias); 03 Apr 2009 14:58:39 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38] by mail.gmx.net (mp004) with SMTP; 03 Apr 2009 16:58:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18VJZBiynUVQTOXrDThDAXb5TXIFCsHSLK4u66oV2 fG5o9hrBwx1O9S
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1238766761-3576-1-git-send-email-marius@trolltech.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115534>


Hi,

On Fri, 3 Apr 2009, Marius Storm-Olsen wrote:

> The standard allocator on Windows is pretty bad prior to Windows Vista, 
> and nedmalloc is better than the modified dlmalloc provided with newer 
> versions of the MinGW libc.
> 
> Note that both Windows and MacOSX need to have an implementation of 
> strdup, which I added at the end of nedmalloc.c, to ensure that strdup 
> use the same heap. So, setting USE_NED_ALLOCATION = YesPlease will also 
> add this function reimplementation, unless you define 
> NEDMALLOC_DONT_OVERRIDE_STRDUP.
> 
> NedMalloc stats in Git
> ----------------------
>   All results are the best result out of 3 runs. The
>   benchmarks have been done on different hardware, so
>   the repack times are not comparable.
> 
>   These benchmarks are all based on 'git repack -adf'
>   on the Linux kernel.
> 
>   XP
>   -----------------------------------------------
>   MinGW               Threads  Total Time   Speed
>   -----------------------------------------------
>   3.4.2                  (1T)  00:12:28.422
>   3.4.2     + nedmalloc  (1T)  00:07:25.437 1.68x
> 
>   3.4.5                  (1T)  00:12:20.718
>   3.4.5     + nedmalloc  (1T)  00:07:24.809 1.67x
> 
>   4.3.3-tdm              (1T)  00:12:01.843
>   4.3.3-tdm + nedmalloc  (1T)  00:07:16.468 1.65x
> 
>   4.3.3-tdm              (2T)  00:07:35.062
>   4.3.3-tdm + nedmalloc  (2T)  00:04:57.874 1.54x

Wow!  That is impressive.

>  Makefile                     |   10 +
>  compat/nedmalloc/License.txt |   23 +
>  compat/nedmalloc/Readme.txt  |  136 +
>  compat/nedmalloc/malloc.c.h  | 5750 ++++++++++++++++++++++++++++++++++++++++++
>  compat/nedmalloc/nedmalloc.c |  966 +++++++
>  compat/nedmalloc/nedmalloc.h |  180 ++
>  6 files changed, 7065 insertions(+), 0 deletions(-)

However, this is impressive, too ;-)

Ciao,
Dscho
