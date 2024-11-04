Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5C41FCC69
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 22:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730758975; cv=none; b=Fr0DLSMKHDAFRjmKiBPbZ9TiRPFCxdGWgo8ZQaGNKfHYdV6sFpWTkVRyZl4HJa6wgMCC02w+U+NmYGOTyGwHQ0lW1zofDpkMqC+wxNyh4aFsRnwAMqaKnSyGE23PtjUsn0u/8E4fZDYdDiBBwzaezhBUSaFSbQD7Ep/ISPW6SVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730758975; c=relaxed/simple;
	bh=jhaAQYKnjA6Y8pIzGm87ttUSkeZcs/oq+YnDD1ufZ7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHYJ3tOogJ3DGCwymHDYySRlhLAeTrJnNctV0GtgT7xAiccVkMrXAHTdlaAIim07HED2O+oGh+EwKKC2XNCYW2oePdaTIs7JtYnBratZjCet7tLFDLlrrkcPo3xSIXPbVVLBwLyBZDfnGeK/fbgLIvPmRemBGE1gL0KCYX/VtPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8A4AEnM; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8A4AEnM"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5ebc22e6362so2233216eaf.2
        for <git@vger.kernel.org>; Mon, 04 Nov 2024 14:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730758973; x=1731363773; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Aji9Sg+HKnza6lCReh1pHW2gNNAt+NBU7izbh4SIB4I=;
        b=k8A4AEnMbrUQ1URQwXQ1lKUjz6pHTfMsAdQ0hu71L9w67Fk7VVvn+UNLZZ7i16h7P+
         4CBdgpzvoOwmnGfIrZ/SBQ9EQAtbgjtK495GaVKNnA3acoQb5kcHxB+ZMUxiB8/Hxtpj
         mxuqE7M3xTox0nVCnPBtgIIQh3PLSOKYhtn703/fxIJYAN++i+dAm7iLThmHaap6Dtv7
         Noj5Xc8f4wJ1PUGKjN/ZUT2tMrNMqkrLj785PKrCvtoaS2YGvYD9NCGlQFU4FSfppX4z
         di7G21LfSKReTUyFrIi+gFBWConQ8QMmd5G0WhdoJXq5rTD8L6PLrmnvhpk4+sslN6+P
         uQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730758973; x=1731363773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aji9Sg+HKnza6lCReh1pHW2gNNAt+NBU7izbh4SIB4I=;
        b=kmBJK7xvgtz4r/guKrAf1lQzup2ioA02UllJU/GXTWi83CkXaMs1O7lkX+/XoLSryT
         vPJU6wx8lpGKEmaSd8EMOAhpcRRgiFt8CmoZOx0iEuZz60v9uTZFhtE3pGFtOO/lRONd
         fHNWG64AZ3lGr1ufYmJ75Qlgjq0w+gHeXndahfaxQoBwLUiijknHPC9iKVdEIDxd2RnV
         b3fRrpq+rnqCagJKa7kmaX4DpeRtSgBNKAQgnbbWsSl+XlUroX4yFOmuMrR/LwhbrA9c
         XF2SBIacCpvh37OM5gHXn92xiGtMs004hPWXEmUbpdKr7UdJK7hUL1bG88U0w675cA9O
         hgNQ==
X-Gm-Message-State: AOJu0YwFy9LXBdAsEMSPeLGtwAOM5m2EXzL9bUqgu1v8bxCGOZE6po5k
	75TGRzA+Fc21XA5xaACrVxOA6oogOvn6NEQo0oqeiyNIjzDTbHL5
X-Google-Smtp-Source: AGHT+IEt0moQV9YJtqCW2WEOXfJbdIoXWR+2eFEW5Y80rvCDFXK2txVfr35TD+WavHyFU3D+UXzuTQ==
X-Received: by 2002:a05:6820:1689:b0:5eb:c72e:e29b with SMTP id 006d021491bc7-5ec6dbd8ff8mr9602776eaf.7.1730758973429;
        Mon, 04 Nov 2024 14:22:53 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ec7060762bsm2010315eaf.37.2024.11.04.14.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 14:22:52 -0800 (PST)
Date: Mon, 4 Nov 2024 16:21:15 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>, 
	Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v2 09/22] builtin/commit: fix leaking change data contents
Message-ID: <5jdz52uqizr4zigq7nefgbmchqgtj2tkgwm7gxrbzfhe6oojpf@qjhdgoi2qvgg>
References: <cover.1728624670.git.ps@pks.im>
 <cover.1729502823.git.ps@pks.im>
 <9f967dfe5d55ca7150bf3e118279388290f7d28c.1729502824.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f967dfe5d55ca7150bf3e118279388290f7d28c.1729502824.git.ps@pks.im>

On 24/10/21 11:28AM, Patrick Steinhardt wrote:
> While we free the worktree change data, we never free its contents. Fix
> this.

Ah, so this worktree change data was part of the string list and was
being freed, but it also had memory allocations itself that were not.
Makes sense :)

> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/commit.c                          | 9 ++++++++-
>  t/t7500-commit-template-squash-signoff.sh | 1 +
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 8db4e9df0c9..18a55bd1b91 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -728,6 +728,13 @@ static void prepare_amend_commit(struct commit *commit, struct strbuf *sb,
>  	repo_unuse_commit_buffer(the_repository, commit, buffer);
>  }
>  
> +static void change_data_free(void *util, const char *str UNUSED)
> +{
> +	struct wt_status_change_data *d = util;
> +	free(d->rename_source);
> +	free(d);
> +}
> +
>  static int prepare_to_commit(const char *index_file, const char *prefix,
>  			     struct commit *current_head,
>  			     struct wt_status *s,
> @@ -991,7 +998,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  		s->use_color = 0;
>  		committable = run_status(s->fp, index_file, prefix, 1, s);
>  		s->use_color = saved_color_setting;
> -		string_list_clear(&s->change, 1);
> +		string_list_clear_func(&s->change, change_data_free);
>  	} else {
>  		struct object_id oid;
>  		const char *parent = "HEAD";
> diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
> index 4dca8d97a77..379d3ed3413 100755
> --- a/t/t7500-commit-template-squash-signoff.sh
> +++ b/t/t7500-commit-template-squash-signoff.sh
> @@ -7,6 +7,7 @@ test_description='git commit
>  
>  Tests for template, signoff, squash and -F functions.'
>  
> +TEST_PASSES_SANITIZE_LEAK=true
>  . ./test-lib.sh
>  
>  . "$TEST_DIRECTORY"/lib-rebase.sh
> -- 
> 2.47.0.72.gef8ce8f3d4.dirty
> 
> 
