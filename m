Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2F3341ABB
	for <git@vger.kernel.org>; Tue, 15 Sep 2026 04:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789447259; cv=pass; b=a8JmSSfamWtVq9d9544iwPg6wbegNqC2F3e4D57faN+Caa2mMy3W4nbLSDDg0w7JGQUElOtcULKHdS8fmXQaA7b6YNkoxLZdrD5y/cCxLjQxVvuJPzEz15pmZRaSNZ0lL8b3U0ahulLUoRKrY/ZjZWjzHRh4asFjLj5MIFoAfew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789447259; c=relaxed/simple;
	bh=mEZckEuZ7tPhOn7m3dDXCYBghgh/l3taOrz5ySSgE0U=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ucJ/fRlJBAUbmshzEG9+hC7j5n24WMV4bhgQaVMaUbocOSnabSOVg59MSnVvfEVANOLZPrBdzSFjiI1ZH2UiKC61xqEHyaBfi5mi76U9D1fBAR5YfG956AQ5lRUIcRaHfmakedDTkM5o9lS4w0hexNyt/YOEtipgDbg6XSif0wI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SY/9JT8z; arc=pass smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SY/9JT8z"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-97c7afa485bso2685831241.3
        for <git@vger.kernel.org>; Mon, 14 Sep 2026 21:40:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789447256; cv=none;
        d=google.com; s=arc-20260327;
        b=frznrw0oX27241P7CAYxSQ+SrykwfYSXXbN1xG849dAKCmBB2Yem1YXJJP20FxVNR1
         L8UqsK8dgeNjRhb0LQX2QVEpVdDLACiOIPc+JJTCSFZFSRPhgS3l1CKkRNfH0XAg1PwK
         sNIh2gnE6LBinkCiUZyA8lnIsr99dbwMezltongHOp0g+QGGdkLMwjModQWjNTk3NoeA
         kzauOP0UwRR/pmB8miKwEjCE3vHpJzwWUXI9IVdepnmESdAhTLUf0OT4TMHWJ89vBjMN
         7UndvT3h+9QCJii9b/LPnh17/xFXdcdBn76OMtUZWpNThpikHidEPhf7WVkFCdrWfVbt
         cmGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=cKnFO5dukc9UR3uVxDBnoCYWqflRmdPHqWphbm8qF/Y=;
        fh=i9MRMgCAz4QYEdjWXQGpuVfbh6PFwCGvaM+q2bEPlIA=;
        b=kI+jjZfolcrYtuUIFsNyMsjs4OrWZV0aMsFR9ELkJ+crMkjE6f2jY6weusB5HAS/N+
         InSzlAa4NAYYhqWe1NNdaaBs0i4FA1yLUw7rOnu53ec5yFxFUd1GZ86WwZyMNyRh7RV2
         THeGZnb+Q7cVjhEoSWDOuLQnd3iF0GTC8SLo6yltLCM5e9MosF19bRvedrInyipX+rwq
         qqcPPrh3Ose3yrviDwc+NyZbgjsYaT8B7xlIlQpVtufTFbPUE/lTVgWGQYbHnLiFAshj
         KMEakBvA7h1auapIcsHZ/zKPZRVL0XJAK7KOkkH+jcvcixyfNxItERlVLhfoGkEHCm3n
         R2Iw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789447256; x=1790052056; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cKnFO5dukc9UR3uVxDBnoCYWqflRmdPHqWphbm8qF/Y=;
        b=SY/9JT8z5/CnsWSY0qGLMtztiyPn2uNm/pCyHpJvSmQ8MTM4525a1tTtc//bCBg5Vr
         2j/IJMi8Ant0J6peRLh5WQJGvcgW34fIytZxUifxDlKWD7lW+XuI6QM//isqaVoFs3rR
         APFbvltBdRP+oDvrkmiGv46rwacTeapJD/71bNY+I2UzZHcC5Fd3GyfRK8Z5S4PWHUxh
         vEndTvw2q9QXai/X87sZ0NRaakn8i3OamPAJ7WJmoxrAeEVl4OVvA+wZFwcqLHQXJol4
         0ZFJMdOfEDi4fPKRvykdYVChuKjTgQVX3xiGFIfnVPJEAIJuP7+AyLepBG40eNHa971h
         PVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789447256; x=1790052056;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cKnFO5dukc9UR3uVxDBnoCYWqflRmdPHqWphbm8qF/Y=;
        b=J9iSPEsh7D0iVcFi/zwSauq3XtKkPciersRgDd0NyElZNGhg5+ZgyjMypsyyy/sOK+
         mSyoOhZTYEqPOcJ2ktOArzWxCK5Var/fduDl0tj7niTzbZstBe/4fEge8gXbDAsWdXEM
         fbNltO3YiXxL+EQ8aQfsy3eYxHCWHRYhk5VhKKSxm3Lk+T0EP8tWnKli5LgfUmVEGwXP
         ntXPdSm/JXFMds1rOvcdmCQMeqmk43VVyNv4jSLo0XrsIhalQB1+75/yRuL6JnoErEuF
         n3yFqbn3vrB55fy+R813j8I72XbvNwPqyav4bIsyLoG9G6BxwYO+/1q132KraDEc02mo
         rbdw==
X-Forwarded-Encrypted: i=1; AKwUvBzdKA9eELoPyZvpl5s8qp4gw5vU3skxLbU4A2nordWB84plb1XlWWm5OTKvm8opwmgPmpQ=@vger.kernel.org
X-Gm-Message-State: AFuF++k5rxMle7dbPR3LFHdYVdgcye8cU8GuRROZZyV03pPl15jwX22D
	x+twIE9iMOD/8+4LTYqQ0w7S+gmbs4iLMvwFbazXJNQ6F9FtElfDswE+dfD6vdmGaInWhTxEcYg
	1HjzjUWfc26umPoQeGIfBT/RoLpReVMeFmA==
X-Gm-Gg: AYBFou331uX78sUQbJHiVEZugJC1UnvNYve2xq4lasHJD0iCGFE0uCtW+UFpq2Lg8Np
	WJo3gbPWBvBZpJAESEDmYUWehADx1VIRO+wtOCTtzniVdsse2Ub9FmNQxfeoOIt/UlQxbyTWcEn
	wW+c2uEBUPQkt86pZuZF+FScK2srNhcTq53YmssQ8aGH93ZgctId3ktW7Gg8cpL3tvUXCcWvlVB
	1PA07He73Mk7Dae1537sMIOLtL1rJ/PdoHzZcja8GPGsT5uO6ejfTPUx3RhwIj4qr8qqjLUsfFu
	lLFv8e2hnuQ5xtx4IEvp1KXkZJBvJt470dN4HvvThQMd2SBWBUfxkBo/FwZvuqAtZDB0qYzlQRJ
	mkpTnds80Oh0b
X-Received: by 2002:a05:6102:6a93:b0:79e:2d57:6225 with SMTP id
 ada2fe7eead31-79e2d57892emr300515137.2.1789447256279; Mon, 14 Sep 2026
 21:40:56 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Sep 2026 00:40:55 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Sep 2026 00:40:55 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <cf14416f224f48475dfc9f79d8ec62756b9fdedf.1789328612.git.jltobler@gmail.com>
References: <cover.1789328612.git.jltobler@gmail.com> <cf14416f224f48475dfc9f79d8ec62756b9fdedf.1789328612.git.jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 15 Sep 2026 00:40:55 -0400
X-Gm-Features: AcwNN1VfqG22e6DJHLlgVpDfFPGeVq6aEUx_bTRKp23lMsuGcmb5aU05rwKGtRo
Message-ID: <CAOLa=ZQBo5ZyHtx4yLvjJXzJYgGieeuX2g0mycPKOPt+VqJ93Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] object-file: lift ODB reprepare out of packfile flush
To: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im
Content-Type: multipart/mixed; boundary="0000000000000e25a9065b7e286d"

--0000000000000e25a9065b7e286d
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

> When flushing a packfile via `flush_packfile_transaction()`,
> `odb_reprepare()` is invoked so the written packfile becomes visible in
> the current process. In a subsequent commit, repreparing the ODB is
> slightly deferred when committing a "files" ODB transaction.
>
> Lift ODB reprepare out of `flush_packfile_transaction()` and instead
> require callers to explicitly invoke `odb_reprepare()` if required.
>
> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---
>  object-file.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/object-file.c b/object-file.c
> index a4cbf8b081df..0f123b79fad1 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -857,8 +857,6 @@ static void flush_packfile_transaction(struct odb_transaction_files *transaction
>  	memset(state, 0, sizeof(*state));
>
>  	strbuf_release(&packname);
> -	/* Make objects we just wrote available to ourselves */
> -	odb_reprepare(repo->objects);
>  }
>
>  /*
> @@ -909,8 +907,10 @@ static int odb_transaction_files_write_object_stream(struct odb_transaction *bas
>  	 * to zlib compression and is sufficient for this check.
>  	 */
>  	if (state->nr_written && pack_size_limit_cfg &&
> -	    pack_size_limit_cfg < state->offset + stream->size)
> +	    pack_size_limit_cfg < state->offset + stream->size) {
>  		flush_packfile_transaction(transaction);
> +		odb_reprepare(transaction->base.source->odb);
> +	}
>
>  	CALLOC_ARRAY(idx, 1);
>  	prepare_packfile_transaction(transaction);
> @@ -1260,6 +1260,7 @@ static int odb_transaction_files_commit(struct odb_transaction *base)
>  {
>  	struct odb_transaction_files *transaction =
>  		container_of(base, struct odb_transaction_files, base);
> +	int have_packfile = !!transaction->packfile.f;
>
>  	if (transaction->objdir) {
>  		struct strbuf temp_path = STRBUF_INIT;
> @@ -1293,6 +1294,9 @@ static int odb_transaction_files_commit(struct odb_transaction *base)
>
>  	flush_packfile_transaction(transaction);
>

Earlier this would unconditionally call `odb_reprepare()` within, now we
only call if needed. Which makes sense. Would it also make sense to only
call `flush_packfile_transaction(transaction)` if we have a packfile?

> +	if (have_packfile)
> +		odb_reprepare(transaction->base.source->odb);
> +
>  	return 0;
>  }
>
> --
> 2.55.0

--0000000000000e25a9065b7e286d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b2be84651c1a7ccd_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xb3pFRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN0FwQy85UTBGWmM2SmZHRjBaUTNaWUVuNjRqTWFWYQpVZk54R0ZHcXYz
aXRxeHQwSmtBbXBoYzZOMXpid2hHa3RuMVVXd3ljTGljcGh6TmJDVVdxUjA3NXg4aWdPTmlOCmJz
VVFZcGtQUFZCTTlsaGtLOEdZN2ZaQ3RuM1JGSU9TMld3T0NkN2N2V1hKNHI5Um13VGhDdXI1STNt
Q1Z5SEUKZmYvajVrK0dYRXpjSHR1RlBYcStONXkrWm1WWTllRTZSdEthNHIwSFZhRG1nMm5oam1v
Q2pTVHBFa1I0Rmt3VQpwbmM1YU5weitQa1JNSzAwMDhOZkhMUjRHcnFJMHdCVVZETjlkOUt0Vmxm
dnhPdTF6cVZsL1hTczBlZ21BZmRRCkhKSGdnejdIZ2xrZ0xwTlhDZStTMmFzOTNPTlpCQU51R05B
WTdTM0tqUXo4WGZOV2tGVWxYaUREWTRzcHhMakYKbThKbG9wWTErYTVydHdlRThtZUpPajEwcFB4
MlpwOHZqbVBxMzhoZm83c1VsN3FBYTE3dWV2L2psdFlSdGVsRAozQmdxZlZhalRGZ1VNSmtrc0pY
RWtzSGlCSHdMMEhOWjJ5dlIyemNKTDN4c2FXM0dkeXNxVmc5aGpERDAvK2tOCkFQbldFbGJMejFj
NEtRaUtvM2lJemhrZHRmS2lJdDJZck1jLzVPcz0KPTVPa3oKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000e25a9065b7e286d--
