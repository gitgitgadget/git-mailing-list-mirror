From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add custom memory allocator to MinGW and MacOS
 builds
Date: Sat, 4 Apr 2009 01:16:47 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904040116300.10279@pacific.mpi-cbg.de>
References: <1238766761-3576-1-git-send-email-marius@trolltech.com> <49D61B35.8060508@trolltech.com> <a5b261830904031412o60b7eb4fv7e25a2ca4f89fe60@mail.gmail.com>
Reply-To: Johannes.Schindelin@gmx.de
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: marius@trolltech.com, git@vger.kernel.org, msysgit@googlegroups.com
To: Pat Thoyts <patthoyts@googlemail.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Sat Apr 04 01:16:00 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qy0-f163.google.com ([209.85.221.163])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lpsc9-0007zS-FS
	for gcvm-msysgit@m.gmane.org; Sat, 04 Apr 2009 01:15:57 +0200
Received: by mail-qy0-f163.google.com with SMTP id 35so2174252qyk.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 03 Apr 2009 16:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=KN1SUuZY0iSZ5XY3eDYY+eAzuIdRVEmSk2MM7pk394k=;
        b=oBMKENmHcTv1sYRk+Q6zNJrExEMS5Qw7SkJIcNRFjhtQ2l5/U+pU1LHxx7/Htru0KM
         XmxS9tmDlKxqhDjV7BKDv4QdOl+a4Vm+PZ6wnlZnAMhZkBvmOERms+9/f1CC9wWvceRQ
         /+0zs+yymQgY+ryfU3KuXKXLuIBOIxWxgcNhE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject
         :in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=PGZHodQpvvWC5SDjAqN9QK9DYexvAMbVdAP2sDgb53eBZFfDNux10PP8jLOQLQTt3V
         WJ765OkMJ4eYp0QFf+E3r5s4hEQxRqPe989CyTDH1VRPCO0vIfvj4ADdlpa/4NjmrkFB
         J+da2TkFoeCGV7GhvidNPm8/M1cdxmrYjcmXQ=
Received: by 10.229.82.77 with SMTP id a13mr139032qcl.18.1238800462183;
        Fri, 03 Apr 2009 16:14:22 -0700 (PDT)
Received: by 10.177.145.19 with SMTP id x19gr4638yqn.0;
	Fri, 03 Apr 2009 16:14:22 -0700 (PDT)
X-Sender: Johannes.Schindelin@gmx.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.86.51.10 with SMTP id y10mr16375fgy.12.1238800461348; Fri, 03 Apr 2009 16:14:21 -0700 (PDT)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by gmr-mx.google.com with SMTP id 5si96916fge.4.2009.04.03.16.14.21; Fri, 03 Apr 2009 16:14:21 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Received: (qmail invoked by alias); 03 Apr 2009 23:14:20 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38] by mail.gmx.net (mp060) with SMTP; 04 Apr 2009 01:14:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+xWOIYm6Wx0Mz0xiahH369VguuFfinM32NWf3ZnK TTzdhJHLG/VF0t
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <a5b261830904031412o60b7eb4fv7e25a2ca4f89fe60@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115564>


Hi,

On Fri, 3 Apr 2009, Pat Thoyts wrote:

> 2009/4/3 Marius Storm-Olsen <marius@trolltech.com>:
> >
> > Marius Storm-Olsen said the following on 03.04.2009 15:52:
> >> The standard allocator on Windows is pretty bad prior to Windows 
> >> Vista, and nedmalloc is better than the modified dlmalloc provided 
> >> with newer versions of the MinGW libc.
> >
> > Actually, it just struck me that it's probably the synchronization 
> > primitives which are better on Vista than XP, and not the memory 
> > manager? (Since mingw 4.3.3-tdm on XP and Vista most likely use the 
> > same dlmalloc fork?) ^shrug^
> >
> > Anyways, not that I haven't tried to 'tune' nedmalloc in any way, just 
> > ensured that it compiles with the different MinGWs which I 
> > benchmarked. So, if anyone feels like it, maybe we can squeeze more 
> > performance out of it by tweaking it.
> 
> The difference on Windows Vista is that the low fragmentation heap is 
> the default memory allocator. On Windows XP you need to enable it 
> specifically for an application. So a possible alternative to this is 
> just to enable the low fragmentation heap. (done via GetProcessHeaps and 
> HeapSetInformation Win32 API calls).

Does this also work on NT?

Ciao,
Dscho
