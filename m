Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB7413BC02
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 22:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728943617; cv=none; b=j0JImlr8aJ4sr5MocEcBdIFyn+YICsDrP4uBixkQSYTSVgeKUTrurI3k8uGW/XyVonsmHRfcKZLKz1ciWO8c/56ifiaKzjlexPZZwSYykBUNYGPHvDy/J2qQPApVpJ+PCqVLP3KLyOdp2EnmVllTsQ7wUT4JvQWTqURHMkrJ16g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728943617; c=relaxed/simple;
	bh=07biAHHADLf8dItLH5gWkkLbTeJLNPh9xqLGOIvDE1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0Xeee521oCOFyVOoljxB3vLat3LjotAAOr6jRymlonT5/Co8uPz+96UsE5EiVMNBeV66pC8zrzDC7eddLxyjJRuAD8fO+9IqUqYKWVlLvsOhIn/qjAv6sDr+ugpK43YdWEHZ8EAl7C/o5uuyyvs9pSPe+LUIESWQZpUex5KyPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=J7ZBaeJI; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="J7ZBaeJI"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4603ee602a0so37731081cf.2
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 15:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728943615; x=1729548415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sPTU5JciZ085E68UJkO1m3DRQrbvv5dImIMDW4kMHFE=;
        b=J7ZBaeJIo+nmjOOC3xXTAa80nlRTzLS3zPybC+uWiQ+zvEHltAkcrCVW8vGJo7a+E6
         fOq9h/eC2qnj/Dlts4jLthSNBAnSPEsM2Rrv8UwByCENf9P7Tac4yEQpfWnSbvChWQFD
         KhNjHHG9cAtnWHbTsMY6N2vJy+eZ81BmAt86QM+tDYqEe9+j1d3OYBsaP+Vzb+gPO4+i
         yVm4kIxuFvV5na46ITIW6RLpbYXgvvqWWtXnUFzNLH0vgtFv+p3TEAwy5e7FcAJMrRy8
         IMjeHLOy1366yEIvNh0wVJdMTdxaDHLoRXTnDbh76tEYeUXflVvS0h7RlU2Wbapwe8m4
         wZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728943615; x=1729548415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sPTU5JciZ085E68UJkO1m3DRQrbvv5dImIMDW4kMHFE=;
        b=Eaimc2Q+PRxvVHUTbDiBTBdFfdzNyWChz4z4aK+YMLt3ICXqW3oBGujD7qQjdNOpIw
         iQVqoyoVqJOaTblTPhhG2HnMRf3w2i0kXHqUp+lG6Yqzu0H5K/0HylQy1lZKINQqQftH
         QXtZbrKSVFtWHp4XeKkucGE8+U/1YDhBrtihMz1cAYdJweoFVULWxcUN25c2i3djH3u+
         4QBCDXI94K40fxNEHxhxrR//7VhwJvfFo2yB3QYoyTUwYUz83LJeDEMfaak5hRs/CB01
         hro15BjxfEmicmGt3IhX+zRGTDvn/7GiJ+HuY7o6GtWwt4es8SArqchYDphaVd6m9dgT
         JZCQ==
X-Gm-Message-State: AOJu0Yyg1+WqaAUBSuJoBk/mppNz2vQckJowtc+n1ekRUozNkuT9p4Ig
	cqbELXT3/6mhKx/fKk4Ti3gXQEkYsT9LWmb/rQHhIyH1ht+1mR8hkAaI0xrEz5mjF6WP3LgDNXz
	B
X-Google-Smtp-Source: AGHT+IEjsAufE2wjS/QeyVjr9U6hbz01PtbUwYbZ6M83r27qZaPvXAWpEkkFKpZNM96DZLDRSncfvg==
X-Received: by 2002:a05:6214:459e:b0:6cb:e934:152c with SMTP id 6a1803df08f44-6cbf00f7900mr189001436d6.40.1728943614827;
        Mon, 14 Oct 2024 15:06:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc22990432sm78626d6.141.2024.10.14.15.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 15:06:54 -0700 (PDT)
Date: Mon, 14 Oct 2024 18:06:53 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 03/10] t/lib-gitweb: test against the build version of
 gitweb
Message-ID: <Zw2V/Xy5niJh9dr9@nand.local>
References: <cover.1728906490.git.ps@pks.im>
 <eda73d81139e640f4f942818f6035770b7bc9121.1728906490.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eda73d81139e640f4f942818f6035770b7bc9121.1728906490.git.ps@pks.im>

On Mon, Oct 14, 2024 at 02:21:18PM +0200, Patrick Steinhardt wrote:
> When testing gitweb we set up the CGI script as "gitweb.perl", which is
> the source file of the build target "gitweb.cgi". This works alright as
> long as we run in-tree tests. But we're about to make out-of-tree tests
> a reality, and there things will break because "gitweb.perl" will not be
> found in the build directory.
>
> Fix this by using "gitweb.cgi" instead.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/lib-gitweb.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/lib-gitweb.sh b/t/lib-gitweb.sh
> index 1f32ca66ea5..c64c87fb87d 100644
> --- a/t/lib-gitweb.sh
> +++ b/t/lib-gitweb.sh
> @@ -49,7 +49,7 @@ EOF
>  		error "Cannot find gitweb at $GITWEB_TEST_INSTALLED."
>  		say "# Testing $SCRIPT_NAME"
>  	else # normal case, use source version of gitweb
> -		SCRIPT_NAME="$GIT_BUILD_DIR/gitweb/gitweb.perl"
> +		SCRIPT_NAME="$GIT_BUILD_DIR/gitweb/gitweb.cgi"

This one I am a bit confused above. Could the same thing not be
accomplished with the '$GITWEB_TEST_INSTALLED' variable above?

If not, why not? And likewise, I believe the "source version" part of
this comment would need an update.

Thanks,
Taylor
