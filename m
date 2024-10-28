Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52401DFE28
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 16:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730131981; cv=none; b=Ax6K1pMYgv7hbkaLezaHjLEqk8kdXvz50ahIhVF2GbtkCl21Yh86M9Z9MdOlWO7beHJIAcY6GduFK/XRWFaAvd6fl5BN0xukkLJZpAOKr9wOjn73I/Pg71MdSDQ78Jf/0ohSNwjiVvnmYVNLO+GMYWe5Od5UlPZVgVv+jC1MZOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730131981; c=relaxed/simple;
	bh=XstDszNL6B579Q+7gYXOpnXRWzvOmanSOqTm5kl/eyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jovUpLssrIFx1HHXHJCSxxCG1mquhKq3hMAPL3d4V+NSdiPSdVafrGKYobC2Ub2VlAWNkXdSaVnZ9jmAJZUYH4MLsSTCfl3zIapp4yQFfceN6q1iuQD+zRX5nqoiGQixoz1itEEtqfmTrJCoqBdIFUBt7BW2b9+YGNOadz0zw20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=v1jj1CNj; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="v1jj1CNj"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e29218d34f8so3383294276.1
        for <git@vger.kernel.org>; Mon, 28 Oct 2024 09:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730131979; x=1730736779; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=udxyHFIE+wnE1RoItDsOJfC+nQwbDJP80bBz2nR5+4E=;
        b=v1jj1CNjL8HTQoy/3oufGOifDab8TjukYQNgko5fSydeaa5CaKIVJBOADiwiuKpkQV
         MAymXMeK9kYmsALpMAJBFWr/6W/kUlLPH07k4lP+79xEObpOI96aT7gQg1UJc0IjjCTj
         APmN+7FcTlbr29okEQjcnUAHYpquXmwFM1ID9eNM0XY7HB1EVJqkJNsFdWp2pxbf1F8g
         IKDRvY+i89EF7SUUTKO68KUQ1d3y83p9UEmqiuOCXT0kR3/59AeLrn6qV3ag5e+xjpb9
         hRW7j+Ep4SLkivR1l1F7weVJAQDCZhWkInd3O1M6egPwNW7jFwGt8tQXpVzoEN7XDf4f
         wD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730131979; x=1730736779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udxyHFIE+wnE1RoItDsOJfC+nQwbDJP80bBz2nR5+4E=;
        b=NDnYFE8R+KZ5o3BXlBdw9E1euavOwaOj/hXt5CIygb/L65vnvKYa0Yb0yaok3arINq
         E9NoZvmSgSXoeq2544ZRUnKiyZACoTwV5Fqt3eYjU9d55o/Z6dKUzSzemcaii2mYG6cy
         usAC5JFBrUM1BEc/J5KfcIvh76UDq6p/SkqKIu5BYHthqOmrladVo+6F8SO7ZKjM4oyB
         vt0WH9Rax1wq99ubbryPeqNnXvoITU2AQbgHIOW2DIm1Rhfh/yrTK7tnor+6Q691rVyi
         XK3zgFfS+ep6wr6Kf77zjKa8kOm70FsM9VU4EyiC5Zju+6DYZZnzPK+D0xhqomNLnNC2
         Axcw==
X-Gm-Message-State: AOJu0Yyma6vDcgE5yK5XF1qjrC83xcWElraAlhk9h/Vzz+ukQ3AnnDrf
	2kHtYsWOzJFVJ8Wqb4ZAS9LPVrCMYTFTn9l6pBBmumWSqIoHm3uHLaZkgYgvRzA=
X-Google-Smtp-Source: AGHT+IFpBLPJZltzk2m4A5MpGOMGSzGeBHBvSo+GTcOI2lUCIQi0zooCtH3bR2+3awb0ucwwjFS94g==
X-Received: by 2002:a05:6902:a06:b0:e2e:303e:d697 with SMTP id 3f1490d57ef6-e30bc675380mr145645276.23.1730131978633;
        Mon, 28 Oct 2024 09:12:58 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e3079d55bafsm1475970276.13.2024.10.28.09.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 09:12:58 -0700 (PDT)
Date: Mon, 28 Oct 2024 12:12:56 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 3/8] packfile: pass `repository` to static function in
 the file
Message-ID: <Zx+4CNUHks2VRMEn@nand.local>
References: <cover.1730122499.git.karthik.188@gmail.com>
 <1f8ef580e5a62ac145501c124407f9bf399b5da2.1730122499.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1f8ef580e5a62ac145501c124407f9bf399b5da2.1730122499.git.karthik.188@gmail.com>

On Mon, Oct 28, 2024 at 02:43:41PM +0100, Karthik Nayak wrote:
> Some of the static functions in the `packfile.c` access global
> variables, which can simply be avoiding by passing the `repository`
> struct down to them. Let's do that.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  packfile.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/packfile.c b/packfile.c
> index 9b353db331..cc558f06cc 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -460,13 +460,13 @@ static void find_lru_pack(struct packed_git *p, struct packed_git **lru_p, struc
>  	*accept_windows_inuse = has_windows_inuse;
>  }
>
> -static int close_one_pack(void)
> +static int close_one_pack(struct repository *repo)

Same note on naming this parameter as 'struct repository *r' instead of
"repo".

>  {
>  	struct packed_git *p, *lru_p = NULL;
>  	struct pack_window *mru_w = NULL;
>  	int accept_windows_inuse = 1;
>
> -	for (p = the_repository->objects->packed_git; p; p = p->next) {
> +	for (p = repo->objects->packed_git; p; p = p->next) {
>  		if (p->pack_fd == -1)
>  			continue;
>  		find_lru_pack(p, &lru_p, &mru_w, &accept_windows_inuse);
> @@ -555,7 +555,7 @@ static int open_packed_git_1(struct packed_git *p)
>  			pack_max_fds = 1;
>  	}
>
> -	while (pack_max_fds <= pack_open_fds && close_one_pack())
> +	while (pack_max_fds <= pack_open_fds && close_one_pack(p->repo))

Makes sense, as does the remainder of the patch. Looking good.

Thanks,
Taylor
