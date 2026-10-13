Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533D8473C83
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 20:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791924705; cv=none; b=UsdDXbjrAQMi52zDAp7OwmYAvI6swvBK2L3YvTFX1gYP3wzKuD/ImuObTIju7Lc83YoAs8bOAeK6oDqgWoCNgwNfvyekTRjEGWAXWQRfdPUVEYoDji7hPyXkOOTguL5pMbNTGF/6LArQJCsWIPTuKh9MmfiTPCMQnvZWleBrGkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791924705; c=relaxed/simple;
	bh=tbO9gfK+Dg47phH/qFMgGWG6CJx0WeY3D6L7EkE/3vQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cf6tYep/B51GuB2ayrMC55v8Utxe3XSgM68wLuXAei5t8bHsTeoXQBtdRr4xd+O95dTRsuUpk0swr0ZgdFrDNmeJRBBfjehpNpBKwZ2BKUrmILpd1CfItqFpJpMiyLidIB/gu++R4HsojyISpPzTm3R1o34cnLJFlYDbtamzHKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hIl/KUOZ; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIl/KUOZ"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6dd4f3f696aso1694282eaf.1
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 13:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791924702; x=1792529502; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BxjEQGx287AYag2TXU9usoN/qKPCgN2jqKvYjrOjtGk=;
        b=hIl/KUOZPhMDoVGHIWbvfIszR5OriAQfvaRVlWDM98H2Xg21ENnj0zCB1ATDByIGmj
         3XoTsMoLVBTMURGBUicb5dT278xfVsAM4Ac/z2tRB5uEt24uuVf+qEqwU0fYmqVI1CCW
         ROJoewOqAOnJzzkOCIdgux3S+Zhynhkl5C9L4h5IsNJRhTlZQ3UCX1GuP/BCMMkzxBc4
         sFk5N7XxSjZnuJRbiX8RQ4iZwDCKZHE6LR+Qg7sE+YdLdoaaBRaKqZ6WOlFXlUf610S3
         e5+VCoLG2waPnJJHYFAqxjuWTwJsSHiXXFzI9Y3AzyTVFwZFfaxj5jFAJCQkYct+WoC8
         iOHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791924702; x=1792529502;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BxjEQGx287AYag2TXU9usoN/qKPCgN2jqKvYjrOjtGk=;
        b=un9N0pB11j5OiydrV/1SAwonc2AmnvpK78d/ln5tKoCzZBqn7rxhhv4hXpIzjGUI4O
         UMpjj4r7v4fZYzrJeo6AtpclrRbvVkqt9v77RzDBYlas8dR7nN/35WFLy8EHG5B9LfeM
         5w5SvkYBSi6PfhXc/2LWzb5O8BXKLl3gxL/Vo+GczHB5q3viYUT8RcpFISnzaKnnAXrj
         tBiXuDoOrrXmA7CLZD5OeZDP7QzGHpZh/M2bed19oKhRtaCVW1OCywSbeueJrf46TfES
         ngpJEXhrbCUXbyL+LiurgBRxMN+rgsq6/nFxK+ZU8XVeTxN3/d8Zfqkaymw9Y5Wkf/xe
         rp1Q==
X-Gm-Message-State: AFq9FYIDbdmDhcNWwX1WQ59Zhx1OP0ZL4XYR6o3ErJ9qg7mlowNqL6PI
	NpGnj7wIkwY6uHm14Y97YVPmRDg6JJcIjT51G2eMVJE6R9czVNEsRZYpU5TyfA==
X-Gm-Gg: AYBFou2/i5eNMw1kJP3j2W0xhAqbIfBwAH5Riy4ocWmXje1bjMZhHCyu9wuDrnc2aOV
	/tMhrW6/eLBq0FxmzcRSaXGx8PtWcs6NU+gFeVCHBmg5CYz0lsT+kYoLCGWDniGsUW7jY4XK2V9
	RROdoNXD3p6fPkFYRLydZ+jTQVP3z++KeH0P781dwGiRgS9/tzF7EiY3woRGksG9b2bPSfDWPCc
	a8san1U2lzbqm0+AZe+iw6NJIEIji/Um/tdmOdxdv4N/7IXFFkf5cU9YVk7hWLjyZRAOh84qCOo
	5x8wGT7UqqT1TRj9ztlKepubD8RdRdTsO9mv+KMzX4hxV4/H0mwKO/dJJYO04Y462c2UM5t8Z8l
	QU3C2OXFMfC1h/SXBWIDQjps9dLuQZwAVuDjzQI9wpgX4V3ryDE1mJAUd8sdfsuiLYKb8O2+444
	xn9oAjFHBO2Bv8DGe/aBPeIDKaeUZnNnguUWunrGAOedhyeGZkbxs5PU2HVbHNCHCgKXv9rGUu6
	+0OoSXNw0Xf77Zz6XuLl1o=
X-Received: by 2002:a05:6820:6ae6:b0:6d8:4e2e:9971 with SMTP id 006d021491bc7-6ef10b7a5e1mr8701047eaf.71.1791924701936;
        Tue, 13 Oct 2026 13:51:41 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6fba22b94e2sm898708eaf.8.2026.10.13.13.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 13:51:41 -0700 (PDT)
Date: Tue, 13 Oct 2026 15:51:40 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Wolfgang Kritzinger <wkritzinger@atlassian.com>
Subject: Re: [PATCH 2/5] odb/source-files: fix performance when streaming
 objects with alternates
Message-ID: <as6Y9mSZ-oZL2gcE@denethor>
References: <20261013-pks-odb-files-alternates-cleanups-v1-0-b7030ff2b26f@pks.im>
 <20261013-pks-odb-files-alternates-cleanups-v1-2-b7030ff2b26f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013-pks-odb-files-alternates-cleanups-v1-2-b7030ff2b26f@pks.im>

On 26/10/13 09:36AM, Patrick Steinhardt wrote:
> This patch is essentially the equivalent to the preceding patch, but for
> streaming objects instead of just reading them directly.
> 
> Exercising performance is a bit more complicated here as streaming only
> really kicks in for large objects. Furthermore, I expect that the impact
> is not as big as with the last commit, either, because for large objects
> the time to stat the file will probably be dwarfed by the time it takes
> to read the object itself.
> 
> But even though this is probably not as impactful, it makes sense anyway
> to do this change to align behaviour across both of these functions.

I agree that this change is probably not as impactful, but unifying the
behavior makes sense to me and doesn't really have any draw backs. I
think this is a good change.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb/source-files.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/odb/source-files.c b/odb/source-files.c
> index 9268f5aa9a..54235821d5 100644
> --- a/odb/source-files.c
> +++ b/odb/source-files.c
> @@ -462,8 +462,10 @@ static int odb_source_files_read_object_stream(struct odb_stream **out,
>  	struct odb_source_files *files = odb_source_files_downcast(source);
>  
>  	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next)
> -		if (!odb_source_read_object_stream(out, &dir->packed->base, oid) ||
> -		    !odb_source_read_object_stream(out, &dir->loose->base, oid))
> +		if (!odb_source_read_object_stream(out, &dir->packed->base, oid))
> +			return 0;
> +	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next)
> +		if (!odb_source_read_object_stream(out, &dir->loose->base, oid))

Just like the last patch, each source looks through its packfiles first
before looking at loose objects. Looks good.

-Justin
