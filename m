Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34333559E1
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 18:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781721707; cv=none; b=k3oIJUXvc/ut8tPymqIpaILddGCBIDltYuO1Pmy+Pr83ZOPuR85h7Em/Vt++5Vnoi+exmtgDt2TavP0EHp9A7zIoIcLmbZLBxHPOfTgR13L8Usrlmn3woxWtrcFjhsFj7rg4sdQQ8bhQWInvbUnUgLUlxjBP8P5qygAn1rdhUiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781721707; c=relaxed/simple;
	bh=AUQK4HC45m4tSHpOE479L7t8cKDZDlnhLWBci5YzENo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CV3L9IYooW3cNDVEz9nzvCimKnfflKh/dQ4qb32lulHYAbh3UvJ5iq5Z1DR3BXFUIcf6nXbqMb1rJv8i0jxvBuE0N2nr0gT29rtBqej1NDFCYpcr84mauJDXgOzcmtzoohxsLzxWidUA5dWp49zX28sKh03IuTYPaLKAkdg78ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HlsxqP+v; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HlsxqP+v"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7e71dd64ea2so44446a34.3
        for <git@vger.kernel.org>; Wed, 17 Jun 2026 11:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781721705; x=1782326505; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WDq4epGJ8xyJ21CjP71JfnipidJ36m7hyBlvn/EJZsM=;
        b=HlsxqP+vGrEJO7kyrzX3T69t4wm9Gg4J4ITfm+Tw++xZP5HHIYRFj8FEXDiLNh/iMb
         TXr66Jc1TM+XhZUG0zADLQZrragfZFkPgOImn/PNj+UootpiWNDrgobyWitBK131Bf65
         siRb0bpBs/03HT0f/C9E/UbllCrYB4I81UuXduatiZuTew6vbT9VVMGPOq1K9Omt66cB
         SuMnaTEkM9pSkF1gUonV5HQZvDpcGWPWNhBJ9mp7cXWXQz3uCVvSirTtkyV3suqzg+Nl
         PZ03eix7MfzXY41C5A81aygyihH+aJanvDZrXiNMxGiz4ZMLFDO+qlqaY3mCxUXnqSSM
         xr2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781721705; x=1782326505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WDq4epGJ8xyJ21CjP71JfnipidJ36m7hyBlvn/EJZsM=;
        b=JxbZQ+WfxEo0QGihhbaBv45LBMo+6PjA8+3hySXO4cGucBmtNgY1tpF31nv+f1xiWK
         JNNjmymo1f8RffXZMMjdP8qg2KmnlFLv5waH5GrLtfNnjIlSpjLKqgHxoN4+hy3Dzy2d
         KyvWvG2WDgPPLUmciJzfBFXgwjM9wHovodIOuvhBp5W0vjNrdNl6faNOL2ZgeEfMDEzi
         qq/Gs5ajLfllCG8S+ILy7G7joMUmvvUGHdO/tgdVURZ+LO5IK27LRlJnBNfRia78o5Wy
         pS0OSX0uxcOn47sRafzKA1JNqIt6Cta17HPZBpMib8m4aVGMGdLWrt149T8WX0yPkqZ4
         IeOg==
X-Gm-Message-State: AOJu0YxIsqlvNWcoC+moHmIOr9dXdFGH+9jMoEkulbxdX0SlmMewvRn8
	FdIahl0h+6nbJCSg7X98V4G9KjJ2W/MietOPCVZBlqyc0K5SQ0fnPCk4dGTxlw==
X-Gm-Gg: Acq92OGFO5UszPPbnSAF2zG6mcAzfMQ0u33RQQdanORIJNHDMbPsc0tquq9+pS4wygv
	ePHVTtQpum5ZFc88lMgqBSZr14B7qRl1qGv+8VX3uLawaqI7siFAzszeZ0w4ggh2mJamsLXtg7W
	aZdTxZ8q4H9ZFemhpNOsyBrN+zHgpbUnwt2y8sPI6levoumpa3lTFxDOmtLVHTR2u9ULPhxnB8n
	RTfDpR0QVe8K9Wd1nVwr55KEWLGutWZImsAdlLhlYr/+WyCXjU6NqF8f9StopwHMfUg3PYVN9yD
	Nj7E+BwJW5PzjokTG6kZD03S6T8oqIr12aDmdXvJbU3XDAmxFDrpX7tgdt7QDrhX6cQ4IKdzZKp
	qOqmd6+QdVniWHQwaXW8pRYauSl5/7Fkmffs5ikc9kuCf3xEIdpahSTHkrk7GY3AtglovdA5igN
	kkpXGJ/A==
X-Received: by 2002:a05:6830:2e11:b0:7e6:c819:22e9 with SMTP id 46e09a7af769-7e91c1a6202mr294363a34.17.1781721704740;
        Wed, 17 Jun 2026 11:41:44 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f6fb9a4sm10411039a34.27.2026.06.17.11.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 11:41:43 -0700 (PDT)
Date: Wed, 17 Jun 2026 13:41:40 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 7/8] refs: fix recursing `get_main_ref_store()` with
 "onbranch" config
Message-ID: <ajLoiCS2mXP49eAJ@denethor>
References: <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-0-f4854aa99859@pks.im>
 <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-7-f4854aa99859@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-7-f4854aa99859@pks.im>

On 26/06/15 03:56PM, Patrick Steinhardt wrote:
[snip]
> diff --git a/refs.c b/refs.c
> index d3caa9a633..e69b9b8ac8 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2351,15 +2351,31 @@ void ref_store_release(struct ref_store *ref_store)
>  
>  struct ref_store *get_main_ref_store(struct repository *r)
>  {
> +	enum ref_storage_format format;
> +
>  	if (r->refs_private)
>  		return r->refs_private;
>  
>  	if (!r->gitdir)
>  		BUG("attempting to get main_ref_store outside of repository");
>  
> -	r->refs_private = ref_store_init(r, r->ref_storage_format,
> -					 r->gitdir, REF_STORE_ALL_CAPS);
> +	/*
> +	 * When constructing the reference backend we'll end up reading the Git
> +	 * configuration. This means we'll also try to evaluate "onbranch"
> +	 * conditions.
> +	 *
> +	 * We cannot read branches when constructing the refdb, so it is not
> +	 * possible to evaluate those conditions in the first place. To gate
> +	 * their evaluation we check whether or not the reference storage
> +	 * format has been configured -- we thus have to temporarily set it to
> +	 * UNKNOWN here so that we don't end up recursing.
> +	 */
> +	format = r->ref_storage_format;
> +	r->ref_storage_format = REF_STORAGE_FORMAT_UNKNOWN;

Is this really the best signal to indicate that a repository ref store
has not been initialized? Temporarily setting the storage format to
REF_STORAGE_FORMAT_UNKNOWN feels rather awkward and suggests to me that
`include_by_branch()` probably shouldn't be using it to begin with if
its not reliable.

-Justin
