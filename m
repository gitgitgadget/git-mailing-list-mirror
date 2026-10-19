Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792445681;
	b=AyIEi80tZNOB7g5clXptvt2NXaYdBB2l6su2tlA50+au3C4j2U53zpns7dHsooWIkPl4
	 BZSF25RGtA6jfyWZe2Cnl7wUmjK6rRY6z+bZN+rn5M2ynTsk5+NAAKpa/M45fZ1H8UidO
	 VsKNOfJ5w3eoDrsHO17OSr6ny9ccdp7DnqdzGWYuDdEIHGYcpei78acwle1JuuqhuxGgM
	 8SwKsXhbXL9q91T2Btn4JkA4n12Tt3MrmlaPTOANJFPXZxsegYOEGDhK8Wk7h0QH1sWzN
	 yFQu9ygK0Wtv5S0lmXO4mdGK9MOMoHybNCVyg0D6qwV05/eELhHzpCN825me4WTttnw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792445681;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Content-Type;
	bh=F352KnkhZtx7Onq2aw/nljBDNVCjqklCwk/pqXwRvR8=;
	b=wJh+8eeTbHBip1LLRsfJw7ZrAtwFfXzb82jEaX4dqPPKGSuAgGvw4hPTyQsq15LumXmk
	 cFkJMCzRMkO+mnKqEmsjRbUHyAUZwe/VKiOJCQU0jdBvcZDyl1B7fHaUwHmcEsolBNN/j
	 mLj8FG65R2sfQ2hFieB+R9r4QYb5vzrYvDCDEkzM+4ZUjPp1GbyF+D8FqKDB+DbU+aUBo
	 7LjRSGE5K9xoOYLQoMfcBK1x+uYonEV5PcxehEsPZ8M281pWQ8e/gQWWegm85yaUIKgPn
	 WuousZ+xtaKMRwaOb3jmjE44C8y1FLsSv4v7rr30Hj4e+TgbzGaFCbhWxHtc5URS4rw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Co2r7iRn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.172
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D440606A31A
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 21:34:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D440606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Co2r7iRn
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5e6b5794d26so90644e0c.1
        for <git@vger.kernel.org>; Mon, 19 Oct 2026 14:34:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792445680; cv=none;
        d=google.com; s=arc-20260327;
        b=VPRStLsluYeYHa3lrUy4iA0Cjde+32ad3ZQdiW6dkYfFiJCR7kFT6IeAo/ZfEUVoMq
         OZUtZU+PF4C+7XhSYllTkGVVuv0K8+bR417YEvlLtGhVpWGAiAGqkRN6D9ObZ8GxIBVG
         tQTId0Rsys6vvPkteJbAxS3cnySBc6F+fDnDAHNXvWi9ZVxpIQkHEZ/EPSvR40Zpf7Bc
         ta6KtBCpseexhKbA1b5yBeoM9xALfyQb32UoeOTdAvyD9yASfaFTRCeQZPsB6nMN7r4v
         goxUN84cnKtogfYnE5PFJM7neEhrshqCu1c6RVY8OTf1+tNum3+rrTqCZDzk3NExljnM
         5ASA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=F352KnkhZtx7Onq2aw/nljBDNVCjqklCwk/pqXwRvR8=;
        fh=D0o2y4KyK0wAy6G6HpEhzbejwOquFACa9HtAPftzrhA=;
        b=exnxJRCxx7ZFEX75TZ56oEMavyZ1IUssUyFr6VMTjTpUaklpMwtUI6bGumnag7lHcj
         uckms2ly9KItLXhb0idRjy4gMAAU+0KdRGLEcVvaECheqzoC1oNBbxRSesydOvMv8NQL
         Quq6gayojquMJV2jFMXiVOsxIl5gxXPf9UzMwnyHUZT5aALvMzktkl4s2UMdP82aKUSo
         ip5XtRAdlfyWp1O2C3vMfI0CogBfpWRAb6yzo2YlyLcmVg/jTSOAJobIt5PJE6YdXhEa
         3VmyY72Ff1vEJiDexVdN+B0e9NyYMrm+QjmWptg5tkO3zB2R/2dh8nQ33tUCTKu7HSFL
         mpQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792445680; x=1793050480; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F352KnkhZtx7Onq2aw/nljBDNVCjqklCwk/pqXwRvR8=;
        b=Co2r7iRnQlQAsiNBDNAVomYS5xmC8q9GFLLMHuCn3knh7Xb4A+IALFQBJCwXxOzuVy
         czron8z7e7/TFCNFx9iQsNfPYRgQeLFdYMvn83FShUzlvdov3YlHqR5VUTnVb/TSSYIm
         DGWGjnc6QeAiAz9pt89xwXAZFKy9kH9VlI5SlaP9YXcfQ8kVqdw/UcoCsRUJrX1ha02R
         awgLA0ZWckKRpl4Jk7jFs5OF0ukYyt+LmVObVBX/G0oVAn/I7anzuGjzyAIR+EHXeGiL
         4Zcf70DZuRbq1Ich1oIsax8j00zmAylLZ0WjejRNiAV7e/Y6lHS758qV7HSN/R+YKNBK
         qBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792445680; x=1793050480;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F352KnkhZtx7Onq2aw/nljBDNVCjqklCwk/pqXwRvR8=;
        b=txe2ArxYnw808LrtVawNUYmyTvi28rMxFgsnmJeALI2vAZMcKc/pBImZrwxrr/fJDO
         350D/3oaKZ0qJ1HMWfByHzB+ZqLMsfrGdVqALACWfMSKqjwHOEB74OptcgJFHDUkuaWV
         nuhAJlgekODlJaY+T++Mb5GLc1YYIb8mRI+yN36vJxzkAm2p0oOqS5Vv+VbatiFHI7Qs
         74qVDwGnXQbIYh+9Sn7lWeTgBj6ip5fL0dDFM1AMWHZmm68sPaxYI/h8AU2+Ho6tGFxG
         F04WriBQ2Lajd08QZuabXE8sOvlB+xCW2wzFlFDdHdr1s2ffgB7HTuQM+U8lsCiPcEHL
         OK2Q==
X-Forwarded-Encrypted: i=1; AKwUvBxtrom+/b0Xlq84kiE349v8Smievaz/FFduPxdTH5f3BnzxCNKyASJoe3GtdeL8xhJJjus=@vger.kernel.org
X-Gm-Message-State: AFq9FYKmn7G7wImy7m4149wmYX+my7GJtLMjrZ4T5vh+Fya4wJcM+vRX
	j+GDugaO0lnshxo2KWS01HV0yVFZ4cTo3Ov1AgSOuzFc/BrAJZltLmaMK7pGN4jYF8B6jkDlkd2
	kgv0jtP8RuXx0sUFiHQclTD+OkliLrXSntA==
X-Gm-Gg: AYBFou3Q7z3nziCU/tHUWTA1mrWI5qGN/aUKzA0upq8JBIhdBMOrBLL70WSne0diCsm
	OIsWuBQAnE3IyFgL56xbbRAwLe+bzgLF82CxNaXtRpHrkcTHJUiR88tLj6d/yeI/r4IqVFWq7q2
	5fDpox07HodD2RbNLBwOgfmDZC+jvPdzz/o6oHFRYJwA7nl9IweGpHor9akRvLb0zjakiVw5Dfl
	hIX0U/oggCuX8EPe7r4VO2Xni0W97mtuj1aqLPgGrXywVnsFGo4VkP3JCo1TLtlaDxxfAn08Qdq
	ucHM3zltq2sFFI4P2MW6vQayjPXkhQD87sPbwllz44BgaC4zcsEaOrIMy/rOYDDGtV18oiXWa9/
	FkEtojhEqwKgYQ5LAmfzNH8karR8vDqVs2Iln4CLAmFCH0g==
X-Received: by 2002:a05:6122:12ad:b0:5d4:3376:f42b with SMTP id
 71dfb90a1353d-5eadcbbf88amr79428e0c.4.1792445680263; Mon, 19 Oct 2026
 14:34:40 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 17:34:39 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 17:34:39 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20261019-b4-pks-odb-extension-v1-3-143a5963b77f@pks.im>
References: <20261019-b4-pks-odb-extension-v1-0-143a5963b77f@pks.im> <20261019-b4-pks-odb-extension-v1-3-143a5963b77f@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 19 Oct 2026 17:34:39 -0400
X-Gm-Features: AclHuK8xMwunP0OrV7XxwratiPYguA2znjS3vHi7nccZPTHba5UUhthIzFssFHI
Message-ID: <CAOLa=ZTbYQvnKBodYm4Bmk7Veb=tt6oDJwWqb+AfXdiuLxcdrA@mail.gmail.com>
Subject: Re: [PATCH 3/7] setup: allow overriding object storage format via environment
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000000d46da065e384853"

--0000000000000d46da065e384853
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The ref storage format configured via "extensions.refStorage" can be
> overridden with the GIT_REF_STORAGE_FORMAT environment variable.
> Introduce the GIT_OBJECT_STORAGE_FORMAT environment variable that
> overrides "extensions.objectStorage" in the same way.

[snip]

> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index c7c464d3a2..5e7c25e42c 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -869,6 +869,32 @@ test_expect_success DEFAULT_REPO_FORMAT 'extensions.objectStorage with unknown b
>  	test_grep "invalid value for ${SQ}extensions.objectstorage${SQ}: ${SQ}garbage://payload${SQ}" err
>  '
>
> +test_expect_success DEFAULT_REPO_FORMAT 'GIT_OBJECT_STORAGE_FORMAT overrides extensions.objectStorage' '
> +	test_when_finished "rm -rf objstorage" &&
> +	git init objstorage &&
> +	(
> +		cd objstorage &&
> +		git config set core.repositoryformatversion 1 &&
> +		git config set extensions.objectStorage files://objs &&

This commit does test the payload for the files backend. I do wonder if
we can make a matrix for tests

   {config, env} x
   {valid backend, invalid backend} x
   {valid relative path, valid absolute path, invalid path}

> +		mkdir .git/objs .git/other &&
> +
> +		echo content >file &&
> +		oid=$(git hash-object -w file) &&
> +		test_path_is_file .git/objs/$(test_oid_to_path "$oid") &&
> +		git cat-file -e "$oid" &&
> +
> +		test_must_fail env GIT_OBJECT_STORAGE_FORMAT=files://other git cat-file -e "$oid" &&
> +		GIT_OBJECT_STORAGE_FORMAT=files://other git hash-object -w file &&
> +		test_path_is_file .git/other/$(test_oid_to_path "$oid") &&
> +
> +		cat >expect <<-EOF &&
> +		fatal: unknown object storage format: ${SQ}garbage${SQ}
> +		EOF
> +		test_must_fail env GIT_OBJECT_STORAGE_FORMAT=garbage git rev-parse 2>err &&
> +		test_cmp expect err
> +	)
> +'
> +
>  test_expect_success MINGW 'core.hidedotfiles = false' '
>  	git config --global core.hidedotfiles false &&
>  	rm -rf newdir &&
>
> --
> 2.56.0.269.g68944adf51.dirty

--0000000000000d46da065e384853
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 3be9d14b4b682bdb_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yV2pPMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMUxzQy80eWh4d3N0S2RmV3FJTlNuK1U0N3FmejJJQgpkUkxscys3UmxY
Y0YwYmZWQjJ2R2RWeENNcFA1bTZBTHBqLzRjT1NWaXNnUk11RmFzK3NNYzY0Sk5JSmlsdzF2Cm83
SklWQ2FrNW8yeTY2YnJESGNyTHJnN3ZKSWUxSUp2emlTVWt6RFZaTE9zalBUN1JVdWZwQUl4Zlh1
WWd5Q3oKU2xaWE10enJBTjBzUkhwSWNXa1hGdVMvb0FiOEp2Q2QyYlM0bUt2bkFLK0NEbWp1L3ZQ
bW5TdDdqalhBTEwxNApyQ2tZWmd4RVFIc0tXMi9EVEtCYUR2V2hTaE1TN0kyanNOL0dGWUVlaEd6
NXlrUERxR0hIbVZkNFRQU2JHTmNQCi9tVTc4VWZYVmdKckZkSE9GclROdlVTcE1zbklFVVdCUnJ2
c3NVaXkrMUhIcTJsaGJLTmYvNWlqNEh3OTQxL00KTUtPa2RzMkFMakdha3krZXJEK0NpeGRSOWUx
OUpzZzV1V096dVBSVGJYRjF3bVZIcXkyVC9ram1nTGl1NklzNgpTYU03NmEzMStDcmNlaVdyejlv
dG1hS1RTMEtnK0FWT2FUMmpKZmJCSVB5eGtES2xiUEtvZkJKZElSTHhCZ011CjZQNmROMHd2M0Fw
VWtjYm1pc2RsUWczNEIxYVV6TlRySXp4bC8wRT0KPVUycXQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000d46da065e384853--
