From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] compat/mingw: stubs for getpgid() and tcgetpgrp()
Date: Wed, 15 Apr 2015 11:48:01 -0700
Message-ID: <xmqq3841kz32.fsf@gitster.dls.corp.google.com>
References: <20150413134850.GC23475@mewburn.net>
	<alpine.LFD.2.11.1504130954420.5619@knanqh.ubzr>
	<20150413144039.GD23475@mewburn.net>
	<alpine.LFD.2.11.1504131052090.5619@knanqh.ubzr>
	<20150414110312.GE23475@mewburn.net> <552EAE0A.3040208@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nicolas Pitre <nico@fluxnic.net>,  git@vger.kernel.org,  msysGit <msysgit@googlegroups.com>
To: Johannes Sixt <j6t@kdbg.org>, Luke Mewburn <luke@mewburn.net>
X-From: msysgit+bncBCG77UMM3EJRBZPEXKUQKGQEV3KNBVI@googlegroups.com Wed Apr 15 20:48:08 2015
Return-path: <msysgit+bncBCG77UMM3EJRBZPEXKUQKGQEV3KNBVI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pd0-f184.google.com ([209.85.192.184])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBZPEXKUQKGQEV3KNBVI@googlegroups.com>)
	id 1YiSM3-0007tm-HY
	for gcvm-msysgit@m.gmane.org; Wed, 15 Apr 2015 20:48:07 +0200
Received: by pdjg10 with SMTP id g10sf7370568pdj.0
        for <gcvm-msysgit@m.gmane.org>; Wed, 15 Apr 2015 11:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=3Tqsia/WLyGWNsYrMo1f8eJRTvLVxZ8arsIT5a1SkLw=;
        b=RYNUqX8MrWAavKv8zYUV6vE689FWQ1HAkx7sh/wFt4ZVZeCTo4k/mLUmbvN9Jb4BOs
         gYec5QF3Squ7T2W8XEW6hHbPNZ80PuTAFjEWO0LeIQbK8V6am3Aqo4TeMnDK6Q6Zt5j1
         FSFiI2BEKFZgDOQHzgM96KCuTUbwcEZ/bSA7ik/z4o/DzN8/Ikwu6GAvlX8X6ZJ9iUBH
         MBoSZy/AOyRnEVdG01YyHLEtJXaMJOPJtlS4/2WwIpTzQpobfK08cu5iQYcvbMddyZY8
         ZriE9bp8FdHewgtt1JlfBacSEewyJcRXTiE+iIBUzXjb7BNfqBgaJ+3WDnpGFEaoBg4A
         PLMg==
X-Received: by 10.50.25.199 with SMTP id e7mr10061igg.16.1429123686166;
        Wed, 15 Apr 2015 11:48:06 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.114.4 with SMTP id jc4ls1519761igb.23.canary; Wed, 15 Apr
 2015 11:48:05 -0700 (PDT)
X-Received: by 10.66.147.132 with SMTP id tk4mr36108819pab.23.1429123685637;
        Wed, 15 Apr 2015 11:48:05 -0700 (PDT)
Received: from sasl.smtp.pobox.com (pb-smtp1.int.icgroup.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id ei3si661157pdb.1.2015.04.15.11.48.05
        for <msysgit@googlegroups.com>;
        Wed, 15 Apr 2015 11:48:05 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9C45F48AFE;
	Wed, 15 Apr 2015 14:48:03 -0400 (EDT)
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 95DA048AFD;
	Wed, 15 Apr 2015 14:48:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EB12F48AFB;
	Wed, 15 Apr 2015 14:48:02 -0400 (EDT)
In-Reply-To: <552EAE0A.3040208@kdbg.org> (Johannes Sixt's message of "Wed, 15
	Apr 2015 20:29:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F22F3B2A-E39F-11E4-B8FE-11859F42C9D4-77302942!pb-smtp1.pobox.com
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted
 sender) smtp.mail=junio@pobox.com;       dkim=pass header.i=@pobox.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267230>

Johannes Sixt <j6t@kdbg.org> writes:

> Windows does not have process groups. It is, therefore, the simplest
> to pretend that each process is in its own process group.
>
> While here, move the getppid() stub from its old location (between
> two sync related functions) next to the two new functions.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---

Thanks for a quick update.

The patch should do for now, but I suspect that it may give us a
better abstraction to make the "is_foreground_fd(int fd)" or even
"is_foreground(void)" the public API that would be implemented as

	int we_are_in_the_foreground(void)
        {
		return getpgid(0) == tcgetpgrp(fileno(stderr));
	}

in POSIX and Windows can implement entirely differently.

Thoughts?

>  compat/mingw.h | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/compat/mingw.h b/compat/mingw.h
> index 7b523cf..a552026 100644
> --- a/compat/mingw.h
> +++ b/compat/mingw.h
> @@ -95,8 +95,6 @@ static inline unsigned int alarm(unsigned int seconds)
>  { return 0; }
>  static inline int fsync(int fd)
>  { return _commit(fd); }
> -static inline pid_t getppid(void)
> -{ return 1; }
>  static inline void sync(void)
>  {}
>  static inline uid_t getuid(void)
> @@ -118,6 +116,12 @@ static inline int sigaddset(sigset_t *set, int signum)
>  #define SIG_UNBLOCK 0
>  static inline int sigprocmask(int how, const sigset_t *set, sigset_t *oldset)
>  { return 0; }
> +static inline pid_t getppid(void)
> +{ return 1; }
> +static inline pid_t getpgid(pid_t pid)
> +{ return pid == 0 ? getpid() : pid; }
> +static inline pid_t tcgetpgrp(int fd)
> +{ return getpid(); }
>  
>  /*
>   * simple adaptors

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
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
