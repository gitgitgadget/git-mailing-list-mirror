Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794408541;
	b=3tCgEeOOotRB8+Zw77sd+EfIq5rU+lMQOWQnQeIBxSxexqCxt7XQuoBijOhffqKmDxjc
	 nA7Bx1zZmzrtPtTDRCIFPd1/WJE3GEeSFIKTehVm+B/EIQSS1AvREuOM35QPiS0ttmIw+
	 ddbs41zV2F1vhRScBrBcpjjWgAnlvSHmCWcb0KXZsasoEqDO4Hc3Ep6nLizInQfNub69u
	 SGrb7HVcBSSnuJ+vVffFg33GntyjAthIAmXCZGtJ13Xc6bN7biCD8FAlYNaKnyFOdMGc7
	 WhDFAvS/1kQwMgGLY2/Qldj3wZMNXMbI+ld+vu41K4Bu+tp6ZdrC+a+F2txIkAZv06w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794408541;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Content-Type;
	bh=Sjek61gHALc/nuFM6L09aMR//paHgjhO0inQHefqegQ=;
	b=t7fc+qLo7kMzlP/rvB7aBWnxdB7gCFmO83pkpMCQWoefvzUuEtu+53zc/3sJKR62YD6n
	 lhQxqisuA2ytyQJ6obIvDF8osIrqTulx2eQ3N9w4I+M+VIDXrrRKLlzAizoSKUJcA/lPH
	 NH1v2K8Xt6OYhPDk6pbmOXMzZSv6NMzmuGsrzkAegFXOqCYXZn5NdA/LfJppqxcWLrDAv
	 LfUPURFujsIk4sORHcXRQS9fSHYHmRLx2/N/xB4CKlYr3MyPTFbmksBgF0ol0gTRVrLoA
	 bOBZ/Dc2/3kYCEkvoV2g+Y0xJbMPVzpPhGM+lJ4RAruzndia7ci84BdXGZf+TKmU0mw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UsWKHnwa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.46
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C8E606A321
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 14:49:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83C8E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UsWKHnwa
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-7d2d18f1bf5so1633046137.0
        for <git@vger.kernel.org>; Wed, 11 Nov 2026 06:49:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794408540; cv=none;
        d=google.com; s=arc-20260327;
        b=gJ0wkah255tMkCdbPziIIfnBgU2ZA4jGYC2eGOo028KxeEz9vNAqkyfpNvQvGb6mkx
         nWCJQk9bvYFLxttk+xSAVqxBcJFt/W0adYvXcHR9N8fuBKBaI999aEnbxi3Rp9UQ/SzR
         0mSDWhGSEFi49KqSuDyVQ5W9vtk301nfOoW2+vessaurBWqGv7lGihQtL5vJUO30StXB
         rqlwifHZy7Z4QGF/qdOcMZmhwKWvbnkT0xIMsATjoyb3QRGsm32TT4uv/MlP7yh7Vmb+
         eDI3cfPMCkkT3wbyLv1+WfPwRlHVGTw931wE8HKJTb1qEBDj4ls4BMgYX0yXnZXtiqL7
         IEbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=Sjek61gHALc/nuFM6L09aMR//paHgjhO0inQHefqegQ=;
        fh=SCSQW2HxtgFdhZUl3ugy0ZUHSVqZvwTfRhy8N+cmYSQ=;
        b=GpcmnHvuUrfOvP7UgVuYUH9DP25/05H9RxLis1LxyXgE5J6DJSOIGGCSQVcUJ+lmL0
         rOYYGrYCxAkG/a+qTtquuHbAFGlPxxiFs5nWkRBiFGop+wccljtKw6uQi+Bj6tHg5KEs
         x3QCz6GhlNauAEYkdW5wt1TquxRDjJweQxBwWA5UBawxg9MjzGDxFHt7iK7aHvpx9LYi
         a1Vbqg++K9RwAs5g0M9IkAcyHc7d00jFL8oCue6WCtNIjXwFk7trctt31nqn0ONRvUSQ
         gcX/T8J+N5U8hGqYmY0/buLIWnSD3MPdUrrepV84wvNxwsvO6efbyCwbXy74a+oqcEH7
         +z7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794408540; x=1795013340; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sjek61gHALc/nuFM6L09aMR//paHgjhO0inQHefqegQ=;
        b=UsWKHnwa0bfYa0A03qgi/M8aT9uQMDhQmG7pfmuW8pjDNS2b0qde7VING48i1fNCqX
         +1nj9Vyb2fkdKakJclgIV4IKRq+utPS9uy7O+XKjOx0XaRPlm2Vqv5IQHiz1370uNXbq
         UQOy8gfT/+N7kJaC1+H0Z8lNd7PzLMZFY9l0M1tzoQdsAPPXGHB6yB9cu4jVvwmNNjeO
         6niz3GeQVWX4nhqneX5yFjT5YmWIGvjX5Ym8MCs6q0fr1IphmMaWKVMNF3SoghCeTLJh
         ZXkr/9VyEg8PCKrO65qT9L+Sxw3G/biczg/zBRqm28fOs67pSJhTkPpZOpscQWkFNqIT
         zLuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794408540; x=1795013340;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sjek61gHALc/nuFM6L09aMR//paHgjhO0inQHefqegQ=;
        b=RlEiCM3pXslHHyZ4XIgWmZ32kkVLXTfDN+xfX4YlcgBbxKhmlhSBk8DxBUGVT0KJcP
         tDtRNdKlwx5IllJnGxkp+IeIO8sWZHEdilOTxc6gj8yyOs8nloeuDR+fiOAlekRkKgjL
         hvJlZVKNsHqOxnDAgoSeCuMvO37UglEFtJGFD1WGGBr0n7KRrEg3SFn1KUd6ZiPuQlQ1
         ZbygyCmcCSlonO5hQlLT34mpecbKH86oXbwf1DOYqqOIEhHpmdWvyngWKO2UnmBW3OGy
         CLmOIme2RgTOJEphxTRgg8NDQxa44cSefQhvtsLbnYTOVQnKkt0wMXFjSAWp21Bbd16M
         nsNg==
X-Forwarded-Encrypted: i=1; AL+hErFgBhb74r5+F7j7tvcw+8509WPmEA0Wh/0iR+9g/eN+7HZfFWhwHE2CJ6+lejQNOMUTocs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+9nLzfZ3KnDjpELFMRg6brN6tyB+Z3fkSml7momYVWkBevDxzz
	WPCNBGAKcHGDZvqv6+SdQAl0EmaOSoMF6OJLOYNXX0HA/OahdmURmPGKuVj49k0rRButUQjYr6T
	4VAI/LcuQpOmUo1lG5QB4SgoeT+X6rfg=
X-Gm-Gg: AYBFou3bC1PdyX/hyodSEbtvqjCWn7IrA1nvMOHYusdwJ1qhy6GrBvXJliMoTcIzvzw
	iUFJGBx+zOHv2Xcy5pu9il8n77s/0EnqcH8VeZGU4KOPhxQw6UG867YRPV54F+tneQ0+IQoO6hi
	CUkhTv6J/aejDwYsUGePS2wVYFisq5YODKMcJnDy9O3T/DT3lCPLMIP2xGxlrnPJ20eY2falTW/
	cQdV2rS6O7Tii1VqyJciP1oIANEcALZ+p98Whsfy009lDVIcZNDhJPXUps1LLJon0tU45dvqcTK
	AcHFufaDou+EpHtWBdTgECTqMnaGczTC3yxjB7klAsgOm/QKl2+It/yb64T3XRizOCK9SDzs66M
	RtwW+qJSGogeDORCBNOlZxdeY4VSfNK54w4xwd0Ex7RnQZ5GPvSKnYkJDOymbMJnXYkaZ2vXUHx
	GltkwYX7oIVD15Yi+7AdZSv991+BA=
X-Received: by 2002:a05:6102:3f8f:b0:7a8:10eb:96ce with SMTP id
 ada2fe7eead31-7d4eff7be70mr924104137.4.1794408540310; Wed, 11 Nov 2026
 06:49:00 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Nov 2026 06:48:58 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20261110002251.2007617-3-jltobler@gmail.com>
References: <20261110002251.2007617-1-jltobler@gmail.com> <20261110002251.2007617-3-jltobler@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Wed, 11 Nov 2026 06:48:58 -0800
X-Gm-Features: AclHuK-Q0mEU41egpv_G6qLyMW31eZXbEuJykx_EY0z1Uf4VXf9au0jV0OgkKUY
Message-ID: <CAOLa=ZRp=JeAGhN3m6-RCos3F82__6Wzt2UsKvUjqHSHUg6o_Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] object-file: only flush batched fsync writes when enabled
To: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000a0c2900660014b80"

--000000000000a0c2900660014b80
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

> When committing an ODB transaction for the "files" backend, a full
> hardware flush is issued against a temporary file before the staged
> objects are migrated into the main object database. This flush acts as a
> barrier for objects that have been written with batched fsync, where
> `odb_transaction_files_fsync()` only issues a writeout request for each
> object instead of fully syncing it.
>

Does `fsync(fd)` even guarantee syncing of previous writes?

> The flush is issued whenever the transaction has a temporary object
> directory though, regardless of whether batched fsync is actually
> enabled. For transactions configured for git-receive-pack(1), the
> temporary object directory is always created, so the flush is also
> performed when objects are synced individually or not synced at all. In
> those cases there are no pending writeout requests and the flush is
> unnecessary. Only issue the flush when batched fsync is enabled
> accordingly.
>
> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---
>  object-file.c | 43 +++++++++++++++++++++++++------------------
>  1 file changed, 25 insertions(+), 18 deletions(-)
>
> diff --git a/object-file.c b/object-file.c
> index 201d9d6490..da189111bd 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1330,6 +1330,29 @@ static int write_pack_lockfiles(struct odb_transaction_files *transaction)
>  	return ret;
>  }
>
> +static void flush_batched_fsync(struct repository *repo)
> +{
> +	struct strbuf temp_path = STRBUF_INIT;
> +	struct tempfile *temp;
> +
> +	/*
> +	 * Issue a full hardware flush against a temporary file to ensure
> +	 * that all objects are durable before any renames occur. The code in
> +	 * odb_transaction_files_fsync has already issued a writeout
> +	 * request, but it has not flushed any writeback cache in the storage
> +	 * hardware or any filesystem logs. This fsync call acts as a barrier
> +	 * to ensure that the data in each new object file is durable before
> +	 * the final name is visible.
> +	 */

Nit: This could become a function comment, since it now describes the
function well.

> +	strbuf_addf(&temp_path, "%s/bulk_fsync_XXXXXX",
> +		    repo_get_object_directory(repo));
> +	temp = xmks_tempfile(temp_path.buf);
> +	fsync_or_die(get_tempfile_fd(temp), get_tempfile_path(temp));
> +
> +	strbuf_release(&temp_path);
> +	delete_tempfile(&temp);
> +}
> +

[snip]

--000000000000a0c2900660014b80
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: bdff0af1a7501691_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yMGdGZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM2NKREFDQUpuK0tnZFYzTGNScEUxdURrSzhxR3BmagpvSmRKazNLOUI4
bWRoM3QwVE1xLzhsUnZ2dXRzMXJ1c3ZscnNSWkF0WHc1UDNSaC9rM2xJVTFGTXV0M0VEZFRHCjlm
enZBajRLanZXRS9GQXBpZjlxcytDTWcwaDNiekl4VlJwTVhxUTRZZ2dyKzl5ZzIzUHQzK2E5RWVo
SWdqMGcKc21FWXlvQVJvWmxhWVcxU2pjNUFCTUphRmN2dithNEZ1dFdlUjlVRjBuUEJTby9VRWtu
VisyVFZ1UnJIelhSZwpyM1hOMkRCWEdpenZvM2hKUmRabW56MmNydHhZNHpnbzNXN2xvSXJISG1P
RFl3NnVDYW43WGJQVGJBSWpQeW56Cks5Nkl0czBPTE5NNkIwaHJtYUt4emJmMVZaV0pQQzJyWGlt
UVZOZ2JjRkJyUTBFNjhPYy9ZZnppWjRHSkg0YW0KbFpFS3FqbWMvSWUwSHMvaFhYdzRMczZYUzZN
TWxLeEtqanlLa2FEbzdjVkJXR3Y4T3FvT25ZZ1k1ZDNPdDh6VQo2OVhrNFhQejExampKL0RSZTRN
WTZ0QVlYSFB1eHJYU1NqVUlMNUVGTE5jb3ZYb3ZJSmdkQmcxRHplc2E2NWxMCmNkSFIramNheWJk
MUtCTVZQS0JHeHZvaFhzRFdpNlN3eHg0eEg3TT0KPTU5MkEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a0c2900660014b80--
