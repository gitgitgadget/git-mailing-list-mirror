From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Re: [PATCH 3/3] Win32: implement nanosecond-precision file times
Date: Fri, 13 Feb 2015 00:15:24 +0100
Message-ID: <54DD340C.50204@virtuell-zuhause.de>
References: <54DBEAA5.6000205@gmail.com> <54DBEB5C.5070804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Karsten Blees <karsten.blees@gmail.com>, 
 Git List <git@vger.kernel.org>,
 msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCL7JHHTPAII32HUUYCRUBHXRKEZI@googlegroups.com Fri Feb 13 00:15:27 2015
Return-path: <msysgit+bncBCL7JHHTPAII32HUUYCRUBHXRKEZI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f186.google.com ([209.85.217.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCL7JHHTPAII32HUUYCRUBHXRKEZI@googlegroups.com>)
	id 1YM2yk-0004wI-IB
	for gcvm-msysgit@m.gmane.org; Fri, 13 Feb 2015 00:15:26 +0100
Received: by mail-lb0-f186.google.com with SMTP id b6sf3386669lbj.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 12 Feb 2015 15:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=FgrJANH3fJJ+cO8Axt/w2ysZJc1SXB291vaiZQlINf0=;
        b=CV3H/Q+iDH3ikR226lBACXBbuh+KVnE8SY5g4HdBqQeSAbDm1GNwnC/S0Tx1QP7mc0
         dIYlF8ciuBesr4yuGBNo1K3PwTgtG13ooDzEzKit6x0enthXpqmsZ0LuQR4oIQG7EFID
         XfqvmI31m+7uxzhdCQCOqtytCRZhZKEdPQD+VOvz6wOZ4f8STmUn3K38YfrpHWeFMwkN
         JCKvXqKaQOKMD80rboWIlkdX6jract6m5zyp9ssgFpj+qZpBZ7u1wj5L1HZmfxE2Djrm
         p7cRsLDFcuxN717g+8ebogzftlu3Qnla66Np85PdLq7bOO89ufj9dITX6AL/y1ufpw02
         o2Xw==
X-Received: by 10.152.121.74 with SMTP id li10mr94882lab.20.1423782926253;
        Thu, 12 Feb 2015 15:15:26 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.6.97 with SMTP id z1ls262416laz.35.gmail; Thu, 12 Feb 2015
 15:15:24 -0800 (PST)
X-Received: by 10.112.181.198 with SMTP id dy6mr966127lbc.22.1423782924973;
        Thu, 12 Feb 2015 15:15:24 -0800 (PST)
Received: from wp156.webpack.hosteurope.de (wp156.webpack.hosteurope.de. [80.237.132.163])
        by gmr-mx.google.com with ESMTPS id o9si2986771wiw.0.2015.02.12.15.15.24
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 12 Feb 2015 15:15:24 -0800 (PST)
Received-SPF: none (google.com: thomas.braun@virtuell-zuhause.de does not designate permitted sender hosts) client-ip=80.237.132.163;
Received: from p5ddc1ffb.dip0.t-ipconnect.de ([93.220.31.251] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	id 1YM2yh-0005AD-Rf; Fri, 13 Feb 2015 00:15:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <54DBEB5C.5070804@gmail.com>
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1423782924;df65e58e;
X-Original-Sender: thomas.braun@virtuell-zuhause.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=none
 (google.com: thomas.braun@virtuell-zuhause.de does not designate permitted
 sender hosts) smtp.mail=thomas.braun@virtuell-zuhause.de
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263786>

Am 12.02.2015 um 00:53 schrieb Karsten Blees:
> We no longer use any of MSVCRT's stat-functions, so there's no need to
> stick to a CRT-compatible 'struct stat' either.
> 
> Define and use our own POSIX-2013-compatible 'struct stat' with nanosecond-
> precision file times.
> 
> Signed-off-by: Karsten Blees <blees@dcon.de>
> ---
>  compat/mingw.c   | 12 ++++++------
>  compat/mingw.h   | 43 +++++++++++++++++++++++++++++++------------
>  config.mak.uname |  4 ++--
>  3 files changed, 39 insertions(+), 20 deletions(-)
> 
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 6d73a3d..e4d5e3f 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -442,9 +442,9 @@ static int do_lstat(int follow, const char *file_name, struct stat *buf)
>  		buf->st_size = fdata.nFileSizeLow |
>  			(((off_t)fdata.nFileSizeHigh)<<32);
>  		buf->st_dev = buf->st_rdev = 0; /* not used by Git */
> -		buf->st_atime = filetime_to_time_t(&(fdata.ftLastAccessTime));
> -		buf->st_mtime = filetime_to_time_t(&(fdata.ftLastWriteTime));
> -		buf->st_ctime = filetime_to_time_t(&(fdata.ftCreationTime));
> +		filetime_to_timespec(&(fdata.ftLastAccessTime), &(buf->st_atim));
> +		filetime_to_timespec(&(fdata.ftLastWriteTime), &(buf->st_mtim));
> +		filetime_to_timespec(&(fdata.ftCreationTime), &(buf->st_ctim));
>  		if (fdata.dwFileAttributes & FILE_ATTRIBUTE_REPARSE_POINT) {
>  			WIN32_FIND_DATAW findbuf;
>  			HANDLE handle = FindFirstFileW(wfilename, &findbuf);
> @@ -550,9 +550,9 @@ int mingw_fstat(int fd, struct stat *buf)
>  		buf->st_mode = file_attr_to_st_mode(fdata.dwFileAttributes);
>  		buf->st_size = fdata.nFileSizeLow |
>  			(((off_t)fdata.nFileSizeHigh)<<32);
> -		buf->st_atime = filetime_to_time_t(&(fdata.ftLastAccessTime));
> -		buf->st_mtime = filetime_to_time_t(&(fdata.ftLastWriteTime));
> -		buf->st_ctime = filetime_to_time_t(&(fdata.ftCreationTime));
> +		filetime_to_timespec(&(fdata.ftLastAccessTime), &(buf->st_atim));
> +		filetime_to_timespec(&(fdata.ftLastWriteTime), &(buf->st_mtim));
> +		filetime_to_timespec(&(fdata.ftCreationTime), &(buf->st_ctim));
>  		return 0;
>  
>  	case FILE_TYPE_CHAR:
> diff --git a/compat/mingw.h b/compat/mingw.h
> index f2a78b4..8dee9c9 100644
> --- a/compat/mingw.h
> +++ b/compat/mingw.h
> @@ -293,22 +293,48 @@ static inline long long filetime_to_hnsec(const FILETIME *ft)
>  	return winTime - 116444736000000000LL;
>  }
>  
> -static inline time_t filetime_to_time_t(const FILETIME *ft)
> +struct timespec {
> +	time_t tv_sec;
> +	long tv_nsec;
> +};
> +
> +static inline void filetime_to_timespec(const FILETIME *ft, struct timespec *ts)
>  {
> -	return (time_t)(filetime_to_hnsec(ft) / 10000000);
> +	long long hnsec = filetime_to_hnsec(ft);
> +	ts->tv_sec = (time_t)(hnsec / 10000000);
> +	ts->tv_nsec = (hnsec % 10000000) * 100;
>  }
>  
>  /*
> - * Use mingw specific stat()/lstat()/fstat() implementations on Windows.
> + * Use mingw specific stat()/lstat()/fstat() implementations on Windows,
> + * including our own struct stat with 64 bit st_size and nanosecond-precision
> + * file times.
>   */
>  #define off_t off64_t
>  #define lseek _lseeki64
>  
> -/* use struct stat with 64 bit st_size */
> +struct mingw_stat {
> +    _dev_t st_dev;
> +    _ino_t st_ino;
> +    _mode_t st_mode;
> +    short st_nlink;
> +    short st_uid;
> +    short st_gid;
> +    _dev_t st_rdev;
> +    off64_t st_size;
> +    struct timespec st_atim;
> +    struct timespec st_mtim;
> +    struct timespec st_ctim;
> +};
> +
> +#define st_atime st_atim.tv_sec
> +#define st_mtime st_mtim.tv_sec
> +#define st_ctime st_ctim.tv_sec
> +
>  #ifdef stat
>  #undef stat
>  #endif
> -#define stat _stati64
> +#define stat mingw_stat
>  int mingw_lstat(const char *file_name, struct stat *buf);
>  int mingw_stat(const char *file_name, struct stat *buf);
>  int mingw_fstat(int fd, struct stat *buf);
> @@ -321,13 +347,6 @@ int mingw_fstat(int fd, struct stat *buf);
>  #endif
>  #define lstat mingw_lstat
>  
> -#ifndef _stati64
> -# define _stati64(x,y) mingw_stat(x,y)
> -#elif defined (_USE_32BIT_TIME_T)
> -# define _stat32i64(x,y) mingw_stat(x,y)
> -#else
> -# define _stat64(x,y) mingw_stat(x,y)
> -#endif
>  
>  int mingw_utime(const char *file_name, const struct utimbuf *times);
>  #define utime mingw_utime
> diff --git a/config.mak.uname b/config.mak.uname
> index b64b63c..a18a4cc 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -346,7 +346,7 @@ ifeq ($(uname_S),Windows)
>  	NO_SVN_TESTS = YesPlease
>  	RUNTIME_PREFIX = YesPlease
>  	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
> -	NO_NSEC = YesPlease
> +	USE_NSEC = YesPlease
>  	USE_WIN32_MMAP = YesPlease
>  	# USE_NED_ALLOCATOR = YesPlease
>  	UNRELIABLE_FSTAT = UnfortunatelyYes
> @@ -498,7 +498,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
>  	NO_PERL_MAKEMAKER = YesPlease
>  	RUNTIME_PREFIX = YesPlease
>  	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
> -	NO_NSEC = YesPlease
> +	USE_NSEC = YesPlease
>  	USE_WIN32_MMAP = YesPlease
>  	USE_NED_ALLOCATOR = YesPlease
>  	UNRELIABLE_FSTAT = UnfortunatelyYes
> 

Why not also enable it in our special msysgit section?

diff --git a/config.mak.uname b/config.mak.uname
index b64b63c..6326794 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -535,6 +535,7 @@ ifneq (,$(wildcard ../THIS_IS_MSYSGIT))
        INTERNAL_QSORT = YesPlease
        HAVE_LIBCHARSET_H = YesPlease
        NO_GETTEXT = YesPlease
+       USE_NSEC = YesPlease
 else
        NO_CURL = YesPlease
 endif

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
