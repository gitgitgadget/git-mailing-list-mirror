From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Wrap RUNTIME_PREFIX warning in a compile-time 
	condition
Date: Tue, 23 Feb 2010 10:42:00 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1002231041230.20986@pacific.mpi-cbg.de>
References: <4B839282.1020605@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Git Mailing List <git@vger.kernel.org>, 
    msysGit <msysgit@googlegroups.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: 3U6GDSxMGB8Msxqjwwn1.1lqrwmnurwpv6.mnv171pr2pxxpunp0x3y1.lxv@groups.bounces.google.com Tue Feb 23 10:35:35 2010
Return-path: <3U6GDSxMGB8Msxqjwwn1.1lqrwmnurwpv6.mnv171pr2pxxpunp0x3y1.lxv@groups.bounces.google.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f155.google.com ([209.85.210.155])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <3U6GDSxMGB8Msxqjwwn1.1lqrwmnurwpv6.mnv171pr2pxxpunp0x3y1.lxv@groups.bounces.google.com>)
	id 1NjrB0-00073u-HV
	for gcvm-msysgit@m.gmane.org; Tue, 23 Feb 2010 10:35:34 +0100
Received: by mail-yx0-f155.google.com with SMTP id 27sf638060yxe.21
        for <gcvm-msysgit@m.gmane.org>; Tue, 23 Feb 2010 01:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received-spf:received:received:x-authenticated
         :x-provags-id:date:from:x-x-sender:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version:x-y-gmx-trusted
         :x-fuhafi:x-original-authentication-results:x-original-sender
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :x-thread-url:x-message-url:sender:list-subscribe:list-unsubscribe
         :content-type;
        bh=cvPD9sjQUQaxiV+v8lY6CNEUDDsn66Gpxy3hN57V04A=;
        b=0GAtt9MuANkswj/Mc9xXjQ+s4Kwfh8Pmaw/WQci4RLEPfZpKOiyO9FzfP6gQQ/KUSs
         en2Ai+4Cx80CmZgHKGt5ocwIktYRj/uKt1oKY4GnIC6aUgaA5UhTZNi4DLHdLy5Iq6gd
         V1TQh7Ga0r8v2XjG4kPvna9SRJYfQAnAPKUdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:x-authenticated:x-provags-id:date:from
         :x-x-sender:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-y-gmx-trusted:x-fuhafi
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-subscribe:list-unsubscribe:content-type;
        b=IMlulk6kX0l8xV8PAsjQ9bkhTBWB8lJ2PNqJ9jvIMl/rJGjocZzYb4e6SK9cs8HcI8
         +JOmo5A1BMzLoGWz3/0babABnzuIsDTSKYBghMvvtGOh1ezjOhjrYeiHQNf569fHkdez
         VEaxX954VqHfjNOFNBRoaYCPCnsWLFhbb5rbk=
Received: by 10.91.216.20 with SMTP id t20mr249400agq.8.1266917715226;
        Tue, 23 Feb 2010 01:35:15 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.87.3.10 with SMTP id f10ls1115634fgi.3.p; Tue, 23 Feb 2010 
	01:35:14 -0800 (PST)
Received: by 10.87.74.24 with SMTP id b24mr506731fgl.1.1266917714181;
        Tue, 23 Feb 2010 01:35:14 -0800 (PST)
Received: by 10.87.74.24 with SMTP id b24mr506730fgl.1.1266917714159;
        Tue, 23 Feb 2010 01:35:14 -0800 (PST)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
        by gmr-mx.google.com with SMTP id 17si518247fxm.11.2010.02.23.01.35.14;
        Tue, 23 Feb 2010 01:35:14 -0800 (PST)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Received: (qmail invoked by alias); 23 Feb 2010 09:35:13 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp065) with SMTP; 23 Feb 2010 10:35:13 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Zlox9JLIZ+rxkuysCHfCr4Qa9oReiu/HZ3Km6F7
	aaj98rswcMKgbD
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4B839282.1020605@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com: 
	domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted 
	sender) smtp.mail=Johannes.Schindelin@gmx.de
X-Original-Sender: johannes.schindelin@gmx.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, 
	<mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
X-Thread-Url: http://groups.google.com/group/msysgit/t/904b4d256ab2836b
X-Message-Url: http://groups.google.com/group/msysgit/msg/9d328b2083767229
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, 
	<mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140781>

Hi,

On Tue, 23 Feb 2010, Johannes Sixt wrote:

> From: Johannes Sixt <j6t@kdbg.org>
> 
> When RUNTIME_PREFIX is enabled, the installation prefix is derived by
> trying a limited set of known locations where the git executable can
> reside. If none of these is found, a warning is emitted.
> 
> When git is built in a directory that matches neither of these known names,
> the warning would always be emitted when the uninstalled executable is run.
> This is a problem on Windows, where gitk picks the uninstalled git when
> invoked on the build directory and gets confused by the warning.
> 
> With this patch, individual developers can disable the warning by setting
> 
>    BASIC_CFLAGS += -DNO_WARN_RUNTIME_PREFIX
> 
> in config.mak.

Would this option not prefer to be a runtime option? An environment 
variable should suffice.

Ciao,
Dscho
