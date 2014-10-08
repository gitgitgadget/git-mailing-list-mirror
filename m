From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/14] MINGW: git-compat-util.h: use inttypes.h
 for printf macros
Date: Wed, 08 Oct 2014 12:25:44 -0700
Message-ID: <xmqq38ay9xdz.fsf@gitster.dls.corp.google.com>
References: <1412791267-13356-1-git-send-email-marat@slonopotamus.org>
	<1412791267-13356-9-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org,  msysGit <msysgit@googlegroups.com>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: msysgit+bncBCG77UMM3EJRBO4722QQKGQE22WCU7Y@googlegroups.com Wed Oct 08 21:25:48 2014
Return-path: <msysgit+bncBCG77UMM3EJRBO4722QQKGQE22WCU7Y@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yk0-f191.google.com ([209.85.160.191])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBO4722QQKGQE22WCU7Y@googlegroups.com>)
	id 1Xbwrs-00027b-EF
	for gcvm-msysgit@m.gmane.org; Wed, 08 Oct 2014 21:25:48 +0200
Received: by mail-yk0-f191.google.com with SMTP id q200sf1512809ykb.8
        for <gcvm-msysgit@m.gmane.org>; Wed, 08 Oct 2014 12:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=GYFCwQ7vfs5Oaxc+NEcSfoF7YrXJLsHuKG4wQloQK4g=;
        b=sMRNqbZ6grOtifyBkdVUhlb3PmVzTCCQHTLtcpJoe0sW5VJ3CpQ+qcSGmzXvrGRqmp
         RRXiZMMFQ2uLoHt39Y59rIAkhxgOs/kMvK79/vOVdLUHD1SOZkrodlXI8VmDqp3BCJbC
         4L/i8xZs+tMPY6yYpYXIUQgixDshGOb+YiyYX+zvrW8mAzAURFmX+2n4sYMX0lRa01fk
         0UYTOM3jfbjz57cWTRIrOZhcZQNiL92hS5GnsOHq8EYG7eXe7+SfQ8rvY7bS8AHSgR+f
         8p2/iroskw9acZg5qfWIgMhjQYUAAt+zekWVkDf++o/tZhfcDDEPvfUk/boGHecehbQJ
         t0kw==
X-Received: by 10.140.98.237 with SMTP id o100mr33905qge.37.1412796347507;
        Wed, 08 Oct 2014 12:25:47 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.80.213 with SMTP id c79ls202qgd.56.gmail; Wed, 08 Oct 2014
 12:25:47 -0700 (PDT)
X-Received: by 10.236.126.103 with SMTP id a67mr8199854yhi.4.1412796347004;
        Wed, 08 Oct 2014 12:25:47 -0700 (PDT)
Received: from sasl.smtp.pobox.com (pb-smtp1.int.icgroup.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id fl6si393425qcb.0.2014.10.08.12.25.46
        for <msysgit@googlegroups.com>;
        Wed, 08 Oct 2014 12:25:46 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B69881480D;
	Wed,  8 Oct 2014 15:25:46 -0400 (EDT)
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AE1851480B;
	Wed,  8 Oct 2014 15:25:46 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 211FC1480A;
	Wed,  8 Oct 2014 15:25:46 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E70645A4-4F20-11E4-8D57-855A93717476-77302942!pb-smtp1.pobox.com
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

Marat Radchenko <marat@slonopotamus.org> writes:

> All MinGW flavors have inttypes.h, so just include it.
>
> However, we need to pass -D__USE_MINGW_ANSI_STDIO=1 to select
> GNU-compatible macro definitions on MinGW-W64:
> http://sourceforge.net/p/mingw-w64/wiki2/gnu%20printf/
>
> As a side-effect, Git no longer builds with MSVC < 2010 due to
> its lack of stdint.h but hopefully that is not a problem.

That "hopefully" does not build much confidence.

"All have inttypes.h, so just include it" does not say why it is a
good idea to do so, if the source before this patch built OK without
including it.

    Bad things like this and that happen because the current code
    does not include inttypes.h, but the header exists everywhere so
    we can fix this and that by including it.

would be more understandable, but otherwise, it is unclear what
problems it attempts to fix, and if it is an improvement overall to
trade it off with the possible breakage on some systems.

The log message also needs to explain why inclusion order in
git-compat-util.h must be changed.  What problem does that change
fix?

> Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
> ---
>  compat/mingw.h    |  2 --
>  compat/msvc.h     |  3 +++
>  config.mak.uname  |  3 ++-
>  git-compat-util.h | 11 ++++++-----
>  4 files changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/compat/mingw.h b/compat/mingw.h
> index ba05044..59a50fc 100644
> --- a/compat/mingw.h
> +++ b/compat/mingw.h
> @@ -358,8 +358,6 @@ static inline char *mingw_find_last_dir_sep(const char *path)
>  int mingw_offset_1st_component(const char *path);
>  #define offset_1st_component mingw_offset_1st_component
>  #define PATH_SEP ';'
> -#define PRIuMAX "I64u"
> -#define PRId64 "I64d"
>  
>  void mingw_open_html(const char *path);
>  #define open_html mingw_open_html
> diff --git a/compat/msvc.h b/compat/msvc.h
> index a63d878..84a03f9 100644
> --- a/compat/msvc.h
> +++ b/compat/msvc.h
> @@ -17,6 +17,9 @@
>  
>  typedef int pid_t;
>  
> +#define PRIuMAX "I64u"
> +#define PRId64 "I64d"
> +
>  static __inline int strcasecmp (const char *s1, const char *s2)
>  {
>  	int size1 = strlen(s1);
> diff --git a/config.mak.uname b/config.mak.uname
> index 4470a928..c7aaa1c 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -328,6 +328,7 @@ ifeq ($(uname_S),Windows)
>  	NO_PREAD = YesPlease
>  	NEEDS_CRYPTO_WITH_SSL = YesPlease
>  	NO_LIBGEN_H = YesPlease
> +	NO_INTTYPES_H = UnfortunatelyYes
>  	NO_POLL = YesPlease
>  	NO_SYMLINK_HEAD = YesPlease
>  	NO_IPV6 = YesPlease
> @@ -510,7 +511,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
>  	NO_POSIX_GOODIES = UnfortunatelyYes
>  	DEFAULT_HELP_FORMAT = html
>  	NO_D_INO_IN_DIRENT = YesPlease
> -	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/win32
> +	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -D__USE_MINGW_ANSI_STDIO=1 -DNOGDI -Icompat -Icompat/win32
>  	ifneq (,$(findstring i686,$(CC_MACH)))
>  		COMPAT_CFLAGS += -D_USE_32BIT_TIME_T
>  		BASIC_LDFLAGS += -Wl,--large-address-aware
> diff --git a/git-compat-util.h b/git-compat-util.h
> index fb41118..b338277 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -96,6 +96,12 @@
>  #define GIT_WINDOWS_NATIVE
>  #endif
>  
> +#ifndef NO_INTTYPES_H
> +#include <inttypes.h>
> +#else
> +#include <stdint.h>
> +#endif
> +
>  #include <unistd.h>
>  #include <stdio.h>
>  #include <sys/stat.h>
> @@ -147,11 +153,6 @@
>  #include <netdb.h>
>  #include <pwd.h>
>  #include <sys/un.h>
> -#ifndef NO_INTTYPES_H
> -#include <inttypes.h>
> -#else
> -#include <stdint.h>
> -#endif
>  #ifdef NO_INTPTR_T
>  /*
>   * On I16LP32, ILP32 and LP64 "long" is the save bet, however
> -- 
> 2.1.1
>
> -- 

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
