From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Windows: Allow using UNC path for git repository
Date: Tue, 20 May 2014 11:57:56 -0700
Message-ID: <xmqqy4xwxop7.fsf@gitster.dls.corp.google.com>
References: <20140519132334.GA1435@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: GIT Mailing-list <git@vger.kernel.org>,  Erik Faye-Lund <kusmabite@gmail.com>,  msysGit <msysgit@googlegroups.com>,  Cezary Zawadka <czawadka@gmail.com>,  Eric Sunshine <sunshine@sunshineco.com>
To: Stepan Kasal <kasal@ucw.cz>
X-From: msysgit+bncBCG77UMM3EJRBOWL52NQKGQEGL4MH3A@googlegroups.com Tue May 20 20:58:08 2014
Return-path: <msysgit+bncBCG77UMM3EJRBOWL52NQKGQEGL4MH3A@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vc0-f184.google.com ([209.85.220.184])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBOWL52NQKGQEGL4MH3A@googlegroups.com>)
	id 1WmpEi-0000v6-8I
	for gcvm-msysgit@m.gmane.org; Tue, 20 May 2014 20:58:04 +0200
Received: by mail-vc0-f184.google.com with SMTP id hq16sf218156vcb.11
        for <gcvm-msysgit@m.gmane.org>; Tue, 20 May 2014 11:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=qGYnt1ut3dszbjhv1dPE2b6rPKUNcadkZmmPnGvPAaY=;
        b=mDEMkYc6fdpL9HGJSSeJffO24huofbhXJKKhh3aLghoW994vd01KABfz2yfxa0U/0D
         WpwUSSKuvj4q0AVLiE+54HDOSxpIyKo9TYv/9p4QDbK0i1GjL483lSt2gvbelbZRzoVV
         SC/BjkdfZG8BahCGRtk+rxLECk9x8BSiptwHt8ZqGME1qC56a/KeEcuPcyv2vR/B55QN
         Obx0ZnwUrfUrh1ds6bc/CpSryvU1LWow9WTXJZ2NLEvT7smST6xXZKvJd2bsQHmdMyFF
         oIvN1I4uegheDweCwRa7zkepdh7VZBh/ZpaQGxO1uKCnp+YDyruGLwFIKVOyv63JCRej
         TOIw==
X-Received: by 10.182.117.138 with SMTP id ke10mr1229obb.42.1400612283469;
        Tue, 20 May 2014 11:58:03 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.182.142.4 with SMTP id rs4ls128986obb.14.gmail; Tue, 20 May
 2014 11:58:02 -0700 (PDT)
X-Received: by 10.182.125.4 with SMTP id mm4mr1362442obb.49.1400612282435;
        Tue, 20 May 2014 11:58:02 -0700 (PDT)
Received: from smtp.pobox.com (smtp.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id gy6si1023105igb.2.2014.05.20.11.58.02
        for <msysgit@googlegroups.com>;
        Tue, 20 May 2014 11:58:02 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C6EB818613;
	Tue, 20 May 2014 14:58:01 -0400 (EDT)
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9193218612;
	Tue, 20 May 2014 14:58:01 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2890818610;
	Tue, 20 May 2014 14:57:58 -0400 (EDT)
In-Reply-To: <20140519132334.GA1435@camelia.ucw.cz> (Stepan Kasal's message of
	"Mon, 19 May 2014 15:23:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A8A1932A-E050-11E3-AF3C-B784E8FBB39C-77302942!pb-smtp0.pobox.com
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
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249728>

Stepan Kasal <kasal@ucw.cz> writes:

> From: Cezary Zawadka <czawadka@gmail.com>
> Date: Tue, 13 Jul 2010 16:17:43 +0200
>
> [efl: moved MinGW-specific part to compat/]
> [jes: fixed compilation on non-Windows]
>
> Eric Sunshine fixed mingw_offset_1st_component() to return consistently "foo"
> for UNC "//machine/share/foo", cf
> http://groups.google.com/group/msysgit/browse_thread/thread/c0af578549b5dda0
>
> Author: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Cezary Zawadka <czawadka@gmail.com>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Stepan Kasal <kasal@ucw.cz>
> ---
>
> Hello,
> this is another patch that lived in msysGit for years, at least from
> Jul 13, 2010.  It was there in two parts, first sketch by Cezary and
> a fix from Eric Sunshine, but I decided to submit the combined
> version.
>
> Let me note that this patch should not affect any non-Windows
> platform.  The chnage of offset_1st_component() to a simple macro is
> ok, because has_dos_drive_prefix() is 0 there.

As I do not think anybody takes the address of the function, I agree
it should be a no-op for non-Windows platform.

It would be nice if somebody in the S-o-b chain can double-check
that the "combined" version is sane.  I didn't read the mingw.c part
carefully enough for me to say returning 0 upon error is sane with
confidence, for example.

Thanks.

> Regards,
>   Stepan
>
>  cache.h           |  1 -
>  compat/mingw.c    | 24 ++++++++++++++++++++++++
>  compat/mingw.h    |  2 ++
>  git-compat-util.h |  4 ++++
>  path.c            |  7 -------
>  5 files changed, 30 insertions(+), 8 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index ebe9a40..0961fb5 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -781,7 +781,6 @@ int normalize_path_copy(char *dst, const char *src);
>  int longest_ancestor_length(const char *path, struct string_list *prefixes);
>  char *strip_path_suffix(const char *path, const char *suffix);
>  int daemon_avoid_alias(const char *path);
> -int offset_1st_component(const char *path);
>  
>  /* object replacement */
>  #define LOOKUP_REPLACE_OBJECT 1
> diff --git a/compat/mingw.c b/compat/mingw.c
> index e9892f8..a0e13bc 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -1823,3 +1823,27 @@ pid_t waitpid(pid_t pid, int *status, int options)
>  	errno = EINVAL;
>  	return -1;
>  }
> +
> +int mingw_offset_1st_component(const char *path)
> +{
> +	int offset = 0;
> +	if (has_dos_drive_prefix(path))
> +		offset = 2;
> +
> +	/* unc paths */
> +	else if (is_dir_sep(path[0]) && is_dir_sep(path[1])) {
> +
> +		/* skip server name */
> +		char *pos = strpbrk(path + 2, "\\/");
> +		if (!pos)
> +			return 0; /* Error: malformed unc path */
> +
> +		do {
> +			pos++;
> +		} while (*pos && !is_dir_sep(*pos));
> +
> +		offset = pos - path;
> +	}
> +
> +	return offset + is_dir_sep(path[offset]);
> +}
> diff --git a/compat/mingw.h b/compat/mingw.h
> index e033e72..3eaf822 100644
> --- a/compat/mingw.h
> +++ b/compat/mingw.h
> @@ -339,6 +339,8 @@ static inline char *mingw_find_last_dir_sep(const char *path)
>  	return ret;
>  }
>  #define find_last_dir_sep mingw_find_last_dir_sep
> +int mingw_offset_1st_component(const char *path);
> +#define offset_1st_component mingw_offset_1st_component
>  #define PATH_SEP ';'
>  #define PRIuMAX "I64u"
>  #define PRId64 "I64d"
> diff --git a/git-compat-util.h b/git-compat-util.h
> index d493a8c..ec41cfb 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -270,6 +270,10 @@ extern char *gitbasename(char *);
>  #define has_dos_drive_prefix(path) 0
>  #endif
>  
> +#ifndef offset_1st_component
> +#define offset_1st_component(path) (is_dir_sep((path)[0]))
> +#endif
> +
>  #ifndef is_dir_sep
>  #define is_dir_sep(c) ((c) == '/')
>  #endif
> diff --git a/path.c b/path.c
> index f9c5062..bc804a3 100644
> --- a/path.c
> +++ b/path.c
> @@ -823,10 +823,3 @@ int daemon_avoid_alias(const char *p)
>  		}
>  	}
>  }
> -
> -int offset_1st_component(const char *path)
> -{
> -	if (has_dos_drive_prefix(path))
> -		return 2 + is_dir_sep(path[2]);
> -	return is_dir_sep(path[0]);
> -}
> -- 
> 1.9.2.msysgit.0.490.ga07b726
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
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
