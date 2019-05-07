Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDBED1F45F
	for <e@80x24.org>; Tue,  7 May 2019 14:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfEGO6h (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 10:58:37 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45277 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfEGO6h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 10:58:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id s15so22768185wra.12
        for <git@vger.kernel.org>; Tue, 07 May 2019 07:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tlxJTVNgFJuZogTeube9yRTB0LmARrW7I7GrKEgmcqs=;
        b=u45l87tDiH93PloK9IKxFb+3BxLpR8tJd9boYYn1+2xmSMgCtKqX9IelNKVaaH4kXg
         3kZL+EoAwvVTaufZUbB5QjE5+CMieuM1ITjRuknyVII/m4BQ879CVYzLcFVGcmMBwlBM
         urkl4PMeiTvMyXSnOGqg7a5M7zBXNawnJtNl97utTw6wOaM2jeVqHpMOr3kby/XV4PYg
         c37JpHv5VzMElP7BAL5E2NdboQGRbtdo7zBEBkICcsFaqQUmQxbdaswDZgsWZxU9jY1w
         OPvlHazAfj8cgrXQH2cVnn3Djxv83wyWpJUCGLR3Yf1nzUSilSxH0b826bX5Zb3sxS6X
         JFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tlxJTVNgFJuZogTeube9yRTB0LmARrW7I7GrKEgmcqs=;
        b=o5WK5tVV3cNqwpmC7Pr+w49MJmOGzAk93oMiE57NmHOSb1vE/SeAZ48uK8WEQFQPIf
         nNOWtL8JkudmRHNCgVGLN/32+TSkzRoGB1c2n6FKNGyP/5TrLvdgK/2qZGGChqZlMjyo
         F1l2e8nX6PC+sqXWaK2iBEqzZuyUKvPOVuoNqsQFo1e9DaU7UCqScCLFWywSgjzFdclb
         hI5vLxlg7D/HXF7mCrR7B7LDsg1o9VbhwbRHLvhapU//7wzE6xzaFvvDGmy8dsT6VqN4
         pKdHVc/3/0OyTJ85qoc6wJFQINdfHCR8zUFCEEvL6rbPrNIbrrhrbek5WMdWmaLTcnB4
         oa7A==
X-Gm-Message-State: APjAAAUGnvjHLr0gjKz4vjgtlxTjKrfbpnzkYnFUsuyWLUVlDIvjjRVv
        QPsEcff8BZwNLgyqXmLFFC4=
X-Google-Smtp-Source: APXvYqxmSZwlUvTI8NCrA8y5xTHXGLn65vjh9aI8Dz+HF4a8bNLMAhlLDFLDUsqUWmSHe9N/3uiQmQ==
X-Received: by 2002:adf:d850:: with SMTP id k16mr15656206wrl.57.1557241115681;
        Tue, 07 May 2019 07:58:35 -0700 (PDT)
Received: from szeder.dev (x4db46d44.dyn.telefonica.de. [77.180.109.68])
        by smtp.gmail.com with ESMTPSA id z5sm34815188wre.70.2019.05.07.07.58.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 07:58:34 -0700 (PDT)
Date:   Tue, 7 May 2019 16:58:32 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] Make fread/fwrite-like functions in http.c more like
 fread/fwrite.
Message-ID: <20190507145832.GN14763@szeder.dev>
References: <20190501085635.7125-1-mh@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190501085635.7125-1-mh@glandium.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 01, 2019 at 05:56:35PM +0900, Mike Hommey wrote:
> The fread/fwrite-like functions in http.c, namely fread_buffer,
> fwrite_buffer, fwrite_null, fwrite_sha1_file all return the
> multiplication of the size and number of items they are being given.
> 
> Practically speaking, it doesn't matter, because in all contexts where
> those functions are used, size is 1.
> 
> But those functions being similar to fread and fwrite (the curl API is
> designed around being able to use fread and fwrite directly), it might
> be preferable to make them behave like fread and fwrite, which, from
> the fread/fwrite manual page, is:
>    On  success, fread() and fwrite() return the number of items read
>    or written.  This number equals the number of bytes transferred
>    only when size is 1.  If an error occurs, or the end of the file
>    is reached, the return value is a short item count (or zero).

This patch breaks the test 'push to remote repository with packed
refs' in 't5540-http-push-webdav.sh':

  https://travis-ci.org/git/git/jobs/529223857#L2603

That test makes Apache spin like crazy at 100% CPU usage for about
30secs, after which, according to 'error.log':

  [Tue May 07 14:50:55.555166 2019] [mpm_prefork:notice] [pid 12638]
AH00169: caught SIGTERM, shutting down


> Signed-off-by: Mike Hommey <mh@glandium.org>
> ---
>  http.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/http.c b/http.c
> index 98fb06df0b..8dbc91f607 100644
> --- a/http.c
> +++ b/http.c
> @@ -176,7 +176,7 @@ size_t fread_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
>  	memcpy(ptr, buffer->buf.buf + buffer->posn, size);
>  	buffer->posn += size;
>  
> -	return size;
> +	return nmemb;
>  }
>  
>  #ifndef NO_CURL_IOCTL
> @@ -204,12 +204,12 @@ size_t fwrite_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
>  	struct strbuf *buffer = buffer_;
>  
>  	strbuf_add(buffer, ptr, size);
> -	return size;
> +	return nmemb;
>  }
>  
>  size_t fwrite_null(char *ptr, size_t eltsize, size_t nmemb, void *strbuf)
>  {
> -	return eltsize * nmemb;
> +	return nmemb;
>  }
>  
>  static void closedown_active_slot(struct active_request_slot *slot)
> @@ -2319,14 +2319,14 @@ static size_t fwrite_sha1_file(char *ptr, size_t eltsize, size_t nmemb,
>  			BUG("curl_easy_getinfo for HTTP code failed: %s",
>  				curl_easy_strerror(c));
>  		if (slot->http_code >= 300)
> -			return size;
> +			return nmemb;
>  	}
>  
>  	do {
>  		ssize_t retval = xwrite(freq->localfile,
>  					(char *) ptr + posn, size - posn);
>  		if (retval < 0)
> -			return posn;
> +			return posn / eltsize;
>  		posn += retval;
>  	} while (posn < size);
>  
> @@ -2339,7 +2339,7 @@ static size_t fwrite_sha1_file(char *ptr, size_t eltsize, size_t nmemb,
>  		the_hash_algo->update_fn(&freq->c, expn,
>  					 sizeof(expn) - freq->stream.avail_out);
>  	} while (freq->stream.avail_in && freq->zret == Z_OK);
> -	return size;
> +	return nmemb;
>  }
>  
>  struct http_object_request *new_http_object_request(const char *base_url,
> -- 
> 2.21.0
> 
