Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3350053F6AE
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 15:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791993584; cv=none; b=c/UKqzMYAQ/fYfCozGqXif8BogxofRu5T3Vl1OPU6fClVGItYYWPjpcUmurb56GvzPs2L8BCshg8LmBT6QCep0nvKB7toTq/zy3HSz5U2V1MVLJ1pBhzv1odnCfjvSPrgPm7kC5+i8jCX+1zQF/Y0WpwctC1O8L453OAEjJV4Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791993584; c=relaxed/simple;
	bh=wYtAoh19jpXPFxEnD1Sv5+vHW/jSSeeqyyzeMTK5By4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQ4ZaK+jrTbH0IGMf+f/BYNWvH+9BftSahaHCbZaZ6O6gZ/vte/THgenGvJ7QFLywuVOK5FOctgf8dYT9IPJ9Nxjhdw3MM3wnLKME0RGjiBIDHTk1h2z1AmU2dBd0gmT++snz7CJdEbyf1z9CB7zft/CJagqyQZDNeePYQZXbAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYMEATe1; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYMEATe1"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-825b40f8a26so2104522a34.1
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 08:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791993582; x=1792598382; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zGdgEEoPjBa0NViHo2K2s6Mp12+nzLQPjVJ+mCqKbcU=;
        b=YYMEATe1abfK9N3GJTYyg0t/2HSY0wjjZaBSit5yk6F0hJedhaSOjC+08Jjucbda6+
         E1buE3JtUQ2BiE1laQV6PCWDLbefRvrm09fUjNSbNJlNMMaBXeYIVzaSBgAhr1veVMX9
         vKn6xg1nANjjZeW44w3j0D4HsQXwE+B27jr8k+p3clsTWMxZnKld213cY3necCTKM5wy
         PqCvbawwJSAwokUzgrqSXr2H4ZXw992Qa3OxX05ZNzRAFa5lhqLLDIY7iIWUk7hU3jBD
         Hln0AlSBN+4lUR0nzcYoXR0wQjBvczpvhtNioNE4eXk8CrNlKDB7kzVaJlsAhKqMXovb
         E8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791993582; x=1792598382;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zGdgEEoPjBa0NViHo2K2s6Mp12+nzLQPjVJ+mCqKbcU=;
        b=dKt6tQxnH6wiTRuLIIqQzzL6BC5rhFDVCBMKHxG6gBRtjL0xPz7SMV24fhP0l0BIRg
         Erehj3SWZ/zqvr96ZQZKsueAZjVSR2NlueZWcBXpyFO1WZ2ETdup7KeJR6977b5o9Z2q
         4aZt9d4CweJXtbZRqCd7mnMhoLRaD/PLo/f7Ek1QUGIzMUM4PMGJj9CaJAiEnK2YZfzI
         34X2n3MXbZ2QQnLdCsaRw5KfBNnJcxy2nIxji98W7lqfG2sci4NjROHcAxqpc3nfNeRn
         xg5kmwkHGinlifYACWbF1PJL/fXsRTGbPaipx4aim47m8sNhFxPBz12gE+z2Kz6IZhDO
         Hv7Q==
X-Gm-Message-State: AFq9FYKifazusQcHQLyyK9BoJq98wOOmFcQ9vU4NsI1wfDj1+YW9cKvA
	N6aK3p/A+f3AaqHfJ7gxGtGyXkx18gqqRRVNYUu9TPqjCcqQGFODRZGumGry5w==
X-Gm-Gg: AYBFou2wW+Wg4x03W4AgQjUCxfJHwbJbtl4lysS5+W/fX4sBIZYzRcfxbzFyvvkj2KO
	WmTSucBnBZVw6/prnis8GkpKYjKyIUFFfqZDkMlh1Zd0HzPzyP9HYYmVmdJt/3F7bEO2H17AudL
	Uzm6TX+tMS81buHOxE+yd6lv0Csv/5LW8Rfa/AQ2B0F4d0KvuawBwVdx7kNOGHTFQ/LUufuirt8
	+JJ4pmkOazwMvhKe0sCeR4ZbECJQHdn0ZdFUkJFh4b6x5UEfErwGJZgsYiq0N7zrP45ZwXx9bJH
	LjJlVzC8T8Id5VUgrneG9uqgUbtRkUqyglDbi5Z2vlrfsNUFrF5kRKiUsroqPNRZoiwvpRiEg6s
	HwuPI4B2CZ6vdm44Ijn8N5DumwI/UXS4bvA0l+ggHNvY+0WQiNzDxASVSTXLXGvorDmDW0rzAS3
	aoOkaLjFuqieDxVu/tYW4govJNBOXE5R99hsLabYGAdrXyylVj4B4ExJhWltH95ZoEdRcJHBMCJ
	pzLs7I4iW6OHApq2SyBNIU=
X-Received: by 2002:a05:6808:199b:b0:4b9:a88b:888b with SMTP id 5614622812f47-50c532f3672mr19743047b6e.33.1791993581899;
        Wed, 14 Oct 2026 08:59:41 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-50c0c5fe7d0sm17033617b6e.2.2026.10.14.08.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 08:59:41 -0700 (PDT)
Date: Wed, 14 Oct 2026 10:59:38 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Wolfgang Kritzinger <wkritzinger@atlassian.com>
Subject: Re: [PATCH v2 5/6] odb: don't try re-fetching corrupt objects
Message-ID: <as-jctNq5uxGRAx9@denethor>
References: <20261014-pks-odb-files-alternates-cleanups-v2-0-fed9b2caa3be@pks.im>
 <20261014-pks-odb-files-alternates-cleanups-v2-5-fed9b2caa3be@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014-pks-odb-files-alternates-cleanups-v2-5-fed9b2caa3be@pks.im>

On 26/10/14 10:53AM, Patrick Steinhardt wrote:
> When we failed reading an object in a repository with a promisor remote
> we try to fetch it from the promisor and then re-read it. This logic
> kicks in not only when the object couldn't be found, but also in the
> case where it could be found but the object is corrupt. It feels dubious
> though to just paper over corruption and proceed as if nothing has
> happened, happily fetching data from the promisor.

Agreed. If we know the object is corrupt, it makes sense to stop early
and report the finding.

> Adapt the code so that we only fetch objects in case they are missing.
> 
> Suggested-by: Justin Tobler <jltobler@gmail.com>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb.c | 28 ++++++++--------------------
>  1 file changed, 8 insertions(+), 20 deletions(-)
> 
> diff --git a/odb.c b/odb.c
> index 095183aec0..2c93a9490c 100644
> --- a/odb.c
> +++ b/odb.c
> @@ -265,7 +265,6 @@ static enum odb_read_status do_oid_object_info_extended(struct object_database *
>  	struct strbuf corrupt_err = STRBUF_INIT;
>  	const struct object_id *real = oid;
>  	enum odb_read_status ret;
> -	bool corrupt = false;
>  
>  	if (flags & OBJECT_INFO_LOOKUP_REPLACE)
>  		real = lookup_replace_object(odb->repo, oid);
> @@ -278,38 +277,27 @@ static enum odb_read_status do_oid_object_info_extended(struct object_database *
>  
>  	ret = odb_source_read_object_info(odb->source, real, oi, flags,
>  					  &corrupt_err);
> -	if (!ret)
> -		goto out;
> -	if (ret != ODB_READ_NOT_FOUND)
> -		corrupt = true;
> -
> -	/* Try to fetch the missing object from a promisor remote. */
> -	if (odb->repo->fetch_if_missing && repo_has_promisor_remote(odb->repo) &&
> -	    !(flags & OBJECT_INFO_SKIP_FETCH_OBJECT)) {
> +	if (ret == ODB_READ_NOT_FOUND &&
> +	    odb->repo->fetch_if_missing &&
> +	    !(flags & OBJECT_INFO_SKIP_FETCH_OBJECT) &&
> +	    repo_has_promisor_remote(odb->repo)) {

Ok, now we only try to fetch a missing object specifically if it was
ODB_READ_NOT_FOUND in the first lookup. This means we now skip this
logic if the object is corrupt. This makes more sense to me and looks
good.

> +		/* Try to fetch the missing object from a promisor remote. */
>  		promisor_remote_get_direct(odb->repo, real, 1);
> -
>  		ret = odb_source_read_object_info(odb->source, real, oi, flags,
> -						  corrupt_err.len ? NULL : &corrupt_err);
> -		if (!ret)
> -			goto out;
> -		if (ret != ODB_READ_NOT_FOUND)
> -			corrupt = true;
> +						  &corrupt_err);
>  	}
>  
> -	if (flags & OBJECT_INFO_DIE_IF_CORRUPT) {
> +	if (ret < 0 && (flags & OBJECT_INFO_DIE_IF_CORRUPT)) {
>  		if ((flags & OBJECT_INFO_LOOKUP_REPLACE) && !oideq(real, oid))
>  			die(_("replacement %s not found for %s"),
>  			    oid_to_hex(real), oid_to_hex(oid));
> -		if (corrupt) {
> +		if (ret != ODB_READ_NOT_FOUND) {
>  			if (corrupt_err.len)
>  				die("%s", corrupt_err.buf);
>  			die(_("object %s is corrupt"), oid_to_hex(real));
>  		}
>  	}
>  
> -	ret = corrupt ? ODB_READ_ERROR : ODB_READ_NOT_FOUND;
> -
> -out:

The remainder of this patch is functionally identical and looks good.

-Justin
