Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAC83E7BA7
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 12:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784205636; cv=pass; b=L7RbMhaCTnnGnba5vJ/vwU26o9I2nUcTnCNGyXbQdsbn1M2oIBAQwiLRCQOlQ4+bDT4QD6YmoS0Uub7brwOCzaxC6jnNqdu8PGflZ9WDQTgVlYTEQswaM2M8OAgPMg6v6T//yryJfx/aueF2mc5JhWSuACT6kB8BSqMfZOuUkDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784205636; c=relaxed/simple;
	bh=YiupM1VtmY2w/TmiOFsB43NMbJM+PLwq1Ud574QAZSM=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jLxuqRxOwbl6CBxM7ScCuKsOfDd0rtektFgZUOafrcV3srIv0BJoj+/Y2EWtOxqcc/1uZYlInYKNyNHkSUwiGtLtojE9YMGm821G+IE8KQ+8ig6UgLCouNkopGjGFq8xyYePE8lDFSvTFWSSeNz6A1lkwVXmrs8wQU3rhjsB6HI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=SJhNK+S2; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="SJhNK+S2"
ARC-Seal: i=1; a=rsa-sha256; t=1784205629; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BNyPn77MVykNJsoQol2B0u3Rt0YZZ6CHKFNzGr+EJHUBUpJxkdBMQ7N3njrok4nmWMr9PvEfkpLEd9MWCooeOjtUXNDTcmX2x9hviqiJ9nKyRSLKzfuKj9yXMOcmXJX15gzFGpU4A2HheroJeWyILDcgHGh4SRO7UvF79SeFwuo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1784205629; h=Content-Type:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=FJgMsg886D0Kdd4gAng3xAa9B5cka2uPJT6fXy2H+W4=; 
	b=mdzjdJGo9ItVeZK9gEOobaEST+puWbi5AfGNNJr8PD6Ie1Y59rzX+FyBWVacMwMk43xKE3MESaOD2wV2IDpovio/Vy4qoPZLMMVPWX1rr4Ru6QF55Ia9HHJtjqrwdoMkKioXl1yhOlm6ZaO2WZfVGTkDrF0vmDWu4y4nAM3SfKM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784205629;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Subject:Subject:In-Reply-To:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To:Cc;
	bh=FJgMsg886D0Kdd4gAng3xAa9B5cka2uPJT6fXy2H+W4=;
	b=SJhNK+S26pcz+i/kzjjLZx6tMsCyH01xQnylJlpLyO5WhWYq55zby51nSZyGUqCD
	A1sFCLRLFii+o2MuAZtNSdNosDp1h2npG28e4IphXbJNTPRUTDJb7VsYT22sw+OVYIl
	sIGSGM9MQSJxE+KNResxzJMQ4vn0ui9gK227osf0=
Received: by mx.zohomail.com with SMTPS id 1784205627619686.9484037679333;
	Thu, 16 Jul 2026 05:40:27 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] submodule--helper: avoid use of %zu for now
In-Reply-To: <xmqq4ii0ko9t.fsf@gitster.g>
References: <xmqq4ii0ko9t.fsf@gitster.g>
Date: Thu, 16 Jul 2026 15:40:24 +0300
Message-ID: <87a4rrxg3r.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Wed, 15 Jul 2026, Junio C Hamano <gitster@pobox.com> wrote:
> Since d7d850e2b9 (CodingGuidelines: mention C99 features we can't
> use, 2022-10-10), our CodingGuidelines document has explicitly
> forbidden the use of '%z' and '%zu' printf() format specifiers,
> even though C99 does support them.  However, a new instance crept
> in via 82c36fa0a9 (submodule: hash the submodule name for the
> gitdir path, 2026-01-12).
>
> We could claim that this is an unintentional weather balloon that
> nobody has complained about for the past six months since Git 2.54,
> proving that it is now safe to use these format specifiers.  But
> (1) it is probably too early to make that claim, as distributions
> often stick to a stale version for several releases, and (2) it is
> unlikely that a failure in this code path would manifest as a
> major user-visible breakage that would trigger a failure report to
> percolate down to us.
>
> Instead, let's stick to the established workaround recommended by
> our CodingGuidelines, which is to cast the value to (uintmax_t) and
> format it with PRIuMAX, at least for now.  Even if we eventually
> perform a bulk update using a Coccinelle script to transition to %z
> and %zu in the future, adding one more instance to the pile that
> will need such a conversion is hardly a tragedy.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/submodule--helper.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git i/builtin/submodule--helper.c w/builtin/submodule--helper.c
> index 1cc82a134d..92e38106c1 100644
> --- i/builtin/submodule--helper.c
> +++ w/builtin/submodule--helper.c
> @@ -549,7 +549,8 @@ static void create_default_gitdir_config(const char *submodule_name)
>  	}
>  
>  	/* Case 2.4: If all the above failed, try a hash of the name as a last resort */
> -	header_len = snprintf(header, sizeof(header), "blob %zu", strlen(submodule_name));
> +	header_len = snprintf(header, sizeof(header),
> +			      "blob %"PRIuMAX, (uintmax_t)strlen(submodule_name));
>  	the_hash_algo->init_fn(&ctx);
>  	the_hash_algo->update_fn(&ctx, header, header_len);
>  	the_hash_algo->update_fn(&ctx, "\0", 1);


LGTM and sorry for not following the guideline. :)
