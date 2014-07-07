From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] symlinks: remove PATH_MAX limitation
Date: Mon, 07 Jul 2014 11:30:30 -0700
Message-ID: <xmqqsimdc988.fsf@gitster.dls.corp.google.com>
References: <53B72DAA.5050007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,  msysGit <msysgit@googlegroups.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBCG77UMM3EJRBUOO5OOQKGQE2SAEXKI@googlegroups.com Mon Jul 07 20:30:44 2014
Return-path: <msysgit+bncBCG77UMM3EJRBUOO5OOQKGQE2SAEXKI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pd0-f186.google.com ([209.85.192.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBUOO5OOQKGQE2SAEXKI@googlegroups.com>)
	id 1X4DgY-0006D7-Pn
	for gcvm-msysgit@m.gmane.org; Mon, 07 Jul 2014 20:30:43 +0200
Received: by mail-pd0-f186.google.com with SMTP id fp1sf1362489pdb.13
        for <gcvm-msysgit@m.gmane.org>; Mon, 07 Jul 2014 11:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=NiNIMAXn6ZGTniqlySA/3Z6VRLST8ZlReNLMMPd054M=;
        b=czVHXB3P+EyMh77o8ijwMRquncbqySGp6B4sJMeRUpKtg6XbFPcWCccTUfIl1x3qS1
         K3lSGEKdOsKK3ko8gWanRDicl0PCp/OgcsvRznUNKlLjocnhFUV4tt5LOjJpOKJzV1oz
         ySN1ywANmIQ1Laeu9bYIZ/yIrZmgYudFnLjohh9SGHYKOJDnStn42NwjXtotFRrGnQh8
         9e4760lBTN/htDwx/lwNaLDV1xiI/vyAUavWE0YhM8uIAu/2fKDeaJorkYk+6AxYc0Rp
         IU6XUtpWxkHMrw1BmI+jTFRUgpEOaRewUXOzUJJyJNJ2nVy7P8PwDEFibJWHAQ0EvGMH
         3C9w==
X-Received: by 10.140.102.50 with SMTP id v47mr45123qge.19.1404757841528;
        Mon, 07 Jul 2014 11:30:41 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.94.163 with SMTP id g32ls1761306qge.17.gmail; Mon, 07 Jul
 2014 11:30:40 -0700 (PDT)
X-Received: by 10.236.124.100 with SMTP id w64mr6273085yhh.57.1404757840968;
        Mon, 07 Jul 2014 11:30:40 -0700 (PDT)
Received: from smtp.pobox.com (smtp.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id b39si2358687yhj.0.2014.07.07.11.30.39
        for <msysgit@googlegroups.com>;
        Mon, 07 Jul 2014 11:30:39 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 60191272F1;
	Mon,  7 Jul 2014 14:30:26 -0400 (EDT)
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 185D8272EF;
	Mon,  7 Jul 2014 14:30:26 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 71B6E272E2;
	Mon,  7 Jul 2014 14:30:20 -0400 (EDT)
In-Reply-To: <53B72DAA.5050007@gmail.com> (Karsten Blees's message of "Sat, 05
	Jul 2014 00:41:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C05AFCC0-0604-11E4-AE9F-9903E9FBB39C-77302942!pb-smtp0.pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252980>

Karsten Blees <karsten.blees@gmail.com> writes:

> 'git checkout' fails if a directory is longer than PATH_MAX, because the
> lstat_cache in symlinks.c checks if the leading directory exists using
> PATH_MAX-bounded string operations.
>
> Remove the limitation by using strbuf instead.

Good.

> diff --git a/cache.h b/cache.h
> index df65231..44aa439 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1090,12 +1090,16 @@ struct checkout {
>  extern int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *topath);
>  
>  struct cache_def {
> -	char path[PATH_MAX + 1];
> -	int len;
> +	struct strbuf path;
>  	int flags;
>  	int track_flags;
>  	int prefix_len_stat_func;
>  };
> +#define CACHE_DEF_INIT { STRBUF_INIT, 0, 0, 0 }
> +static inline void cache_def_free(struct cache_def *cache)
> +{
> +	strbuf_release(&cache->path);
> +}

The above cache_def_free(cache) does not free the cache itself, but
only its associated data, so the name cache_def_free() is somewhat
misleading.

It seems that we use the name that consists solely of "something"
and "free" if the pointer to "something" itself is also freed.  For
example "diff_free_filespec_data(struct diff_filespec *)" frees data
associated with the filespec but not the filespec itself, which is
done with "diff_free_filespec()".

Another name that may not be misleading would be cache_def_clear();
I think I'd prefer it over cache_def_free_data().

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
