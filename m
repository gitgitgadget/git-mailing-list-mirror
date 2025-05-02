Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780591DB127
	for <git@vger.kernel.org>; Fri,  2 May 2025 23:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746229368; cv=none; b=r9ykyFq48/e8S1gdE+9tsR9eIE65nHWbDNLx7Ivzk5sAN+ncaeZ2bWTSVr1JMDe3rOQZrrpsmRFPWDPN1ou9z/C1+V9H+/Mkr0f/y2UUelINmDq6RefkHxc8ElLmJt7kDUMqNrXiv7woVeujldKhepVvtUt2JUyNdk61/lG4Yxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746229368; c=relaxed/simple;
	bh=WgRToOJSkBV410nJqu7aVilihLb2O+HxpT7n/W0kZjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVzxyOkGqa/UaD2nrETo+1Ws/Z7d9VOllEZnm27PjBS1lJ/6VG+RoUpjmxLLRkscGAHm0vF+qMV5FAG3/J5ZAjnb1AgKKEjQRId39qaUF437F8ozmYK8Vy/j497x0Hgz0DFSYtoh74KaPyphcFVW1h2wpYeYqyxR/H2IdmXPvmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=tJDDrNZZ; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="tJDDrNZZ"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6e8f7019422so27202446d6.1
        for <git@vger.kernel.org>; Fri, 02 May 2025 16:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1746229356; x=1746834156; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+pn5wa1/kkSgUti4ckbFZZMPkK4Rf9Jkt4lXOQ7azk=;
        b=tJDDrNZZdhp2c+wvQ+BQzTjnVvSeh+yl9/e5r4IjSzwlhU+NdmbKBcfJ/8sfeDmHIH
         De097TDuCMm4Kp+oNX/uF3ywI2lZktaujTSKM+IkwZwgqng/QYHk/C4OhemcrgUVvrtf
         XWgNzXoXJpC6JA/Q5i12WzQAMybZz/YCDjZPBa89rRZSsRYsfWWxODYkexwVrqUM5EDh
         FL7Wwmq7lTINsJcZKo3RS09M6lVM5VtNNRvnGGn0kRmC3aUBDbBVHqObPBEBmIdh3LuK
         u4mbgXOSc9iMqrx4Z3J+5j9xHoZzwEvLASC7ksqmRMuZ3pPP0F96W176hvPIfoniWQl8
         2PBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746229356; x=1746834156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q+pn5wa1/kkSgUti4ckbFZZMPkK4Rf9Jkt4lXOQ7azk=;
        b=RTVHrNu0BDHZzREDUFUxiWgkT+r2cufmDKoLT4RKDtWeS/iDfD+FA5cWA2Djdnixc1
         Bkk83Qs5er1qVvUssDttPbfdRrN+6w5cSAnpFY8CCqD47sOOhPer/EVV3Mjt7doiXP3E
         it9DqB/tTplci+ZEMxix8DI960iMeyaTusX79TVi+OVtouWmrNhiCGNJ3wdMCl7J6pvd
         lWDW/Fj/GvTgPP8+TCjA3ySA84tvb/rnvR0xmR96IZ0qh3Lbj9NV0S/b+9vFZqTS13K5
         3u7NTsKO2on3NQJ25A+a5BO03igDVAN4Ubxqa4aPR9gr9AWzB9jA3qJYbRVaL81YofLy
         wWPQ==
X-Gm-Message-State: AOJu0Yw1/JDv3WLmTESyV90N6Rev5D/epDazVF5BekIILWAnKkQLTiiu
	dbLM8EV4Niwksy06c12ExTjwEFGLpJRycZyZzx4cgedXiGcqvb96xzh35em6e+g=
X-Gm-Gg: ASbGncuRNcUQI2saxndnqx6QQcrLJVKI5i+s/pjIr0Y/0B2JrEyVGKf1ByduQmuNlbO
	UfcTXxBmVR6AOglwZXH5Cx3zLTwSOZQ2mYN1dV/5TdSsMNEJI21ToXeXdvMiRDNFzpEYYjQHu8n
	RJ23CIRhziYaAoGxn+r66aGCc0trsvyGz8r9mgpqcstiX4RNTAaUqCtTmlOKVNWYEZpIH370Dcx
	pkTetn94hbMGHAIv7zfFDdwrPcQG3tVUeDvhkA0Ls4xlTFBa3DLUJjS8r6DZPt8bT4CSOpuHWGO
	bUCO5bc/XV/Ww7r/eL1eCJ8TSuqwjGX+J234M9ScZyREhT0aQ5a1TPrzzNGc5USAwBQ/u4/znOf
	IwcHSmpd8Lo/RmY39p2bye+w=
X-Google-Smtp-Source: AGHT+IECtx163+dcABKVdU5YLkb4YU0i6bAI08WdB4D82oJrSmnYD7bVEGwruKK90NC8HcLC9d2KFw==
X-Received: by 2002:ad4:5cc1:0:b0:6e8:9525:2ac3 with SMTP id 6a1803df08f44-6f515602e5emr79051396d6.34.1746229356342;
        Fri, 02 May 2025 16:42:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f50f49cbb4sm25006996d6.124.2025.05.02.16.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 16:42:36 -0700 (PDT)
Date: Fri, 2 May 2025 19:42:35 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
	johannes.schindelin@gmx.de, johncai86@gmail.com,
	jonathantanmy@google.com, karthik.188@gmail.com,
	kristofferhaugsbakk@fastmail.com, newren@gmail.com, peff@peff.net,
	ps@pks.im, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 08/13] pack-objects: enable --path-walk via config
Message-ID: <aBVYa9SzXk7eguIz@nand.local>
References: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
 <pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
 <dd66a5b46f2ef52eedea323df891a2e24fcd48c1.1742829770.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dd66a5b46f2ef52eedea323df891a2e24fcd48c1.1742829770.git.gitgitgadget@gmail.com>

On Mon, Mar 24, 2025 at 03:22:44PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <stolee@gmail.com>
>
> Users may want to enable the --path-walk option for 'git pack-objects' by
> default, especially underneath commands like 'git push' or 'git repack'.
>
> This should be limited to client repositories, since the --path-walk option
> disables bitmap walks, so would be bad to include in Git servers when
> serving fetches and clones. There is potential that it may be helpful to
> consider when repacking the repository, to take advantage of improved deltas
> across historical versions of the same files.
>
> Much like how "pack.useSparse" was introduced and included in
> "feature.experimental" before being enabled by default, use the repository
> settings infrastructure to make the new "pack.usePathWalk" config enabled by
> "feature.experimental" and "feature.manyFiles".
>
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  Documentation/config/feature.adoc | 4 ++++
>  Documentation/config/pack.adoc    | 8 ++++++++
>  builtin/pack-objects.c            | 3 +++
>  repo-settings.c                   | 3 +++
>  repo-settings.h                   | 1 +
>  5 files changed, 19 insertions(+)
>
> diff --git a/Documentation/config/feature.adoc b/Documentation/config/feature.adoc
> index f061b64b748..cb49ff2604a 100644
> --- a/Documentation/config/feature.adoc
> +++ b/Documentation/config/feature.adoc
> @@ -20,6 +20,10 @@ walking fewer objects.
>  +
>  * `pack.allowPackReuse=multi` may improve the time it takes to create a pack by
>  reusing objects from multiple packs instead of just one.
> ++
> +* `pack.usePathWalk` may speed up packfile creation and make the packfiles be
> +significantly smaller in the presence of certain filename collisions with Git's
> +default name-hash.
>
>  feature.manyFiles::
>  	Enable config options that optimize for repos with many files in the
> diff --git a/Documentation/config/pack.adoc b/Documentation/config/pack.adoc
> index da527377faf..08d06271177 100644
> --- a/Documentation/config/pack.adoc
> +++ b/Documentation/config/pack.adoc
> @@ -155,6 +155,14 @@ pack.useSparse::
>  	commits contain certain types of direct renames. Default is
>  	`true`.
>
> +pack.usePathWalk::
> +	When true, git will default to using the '--path-walk' option in
> +	'git pack-objects' when the '--revs' option is present. This
> +	algorithm groups objects by path to maximize the ability to
> +	compute delta chains across historical versions of the same
> +	object. This may disable other options, such as using bitmaps to
> +	enumerate objects.
> +

Same note here as in the previous patch, I think it's fine to refer
readers to the git-pack-objects[1] documentation instead of repeating
yourself here. (And it removes the risk of these three descriptions
falling out of sync with one another).

>  pack.preferBitmapTips::
>  	When selecting which commits will receive bitmaps, prefer a
>  	commit at the tip of any reference that is a suffix of any value
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index a6b8a78d42a..0ea85754c52 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -4652,6 +4652,9 @@ int cmd_pack_objects(int argc,
>  		if (use_bitmap_index > 0 ||
>  		    !use_internal_rev_list)
>  			path_walk = 0;
> +		else if (the_repository->gitdir &&
> +			 the_repository->settings.pack_use_path_walk)
> +			path_walk = 1;
>  		else
>  			path_walk = git_env_bool("GIT_TEST_PACK_PATH_WALK", 0);
>  	}

The limited diff context makes it hard for me to tell for sure, but this
takes place after git_config(), right? If so, I think we can avoid using
the repository settings machinery here and just use the config API
directly.

(FWIW, I typically think of repository settings as a way to expose
config information to some part of the codebase that doesn't otherwise
have easy access to, e.g., a static field that was set by a git_config()
callback).

Separate from the above: should this have a sanity test to makes sure
that we read the config setting correctly?

Thanks,
Taylor
