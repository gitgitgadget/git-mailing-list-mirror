Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCB839B4A3
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 08:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776157085; cv=pass; b=W+umEF/futugIu2UCgPtXnNu0yTlfV3bXZqTQkzZujv0gRB1LDnmAOanoSWkmblayUca06eH7YiGSy/enT75cESW4aA82C5cgldQ1PyTQy+d80/k1y01sGPynS4r5+aCXxEVcujRCpiGzxFT6ahDRKsljPxqvpDG1zNC8DEI1S0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776157085; c=relaxed/simple;
	bh=YcsWHiMSSc8NuGQcUL0xWAo78Rj1mhOIlyFxIgiXB7o=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z2i/iwAmCkdfq6tWykYhw06yXWBblTZ2ssq9cSiS56rE5epOq5myJ5piuKWjbHF5gns6LJ2KQjaZ+TgMbUIgS+EtuNWr0/HhzXG4sk2JAwNod7alIn2YoddjB/kFfSqAsj19ITIIe3rEU/nkpzCVnJRxD0ryHVtTFmo9yz0tvz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AKIGU7FO; arc=pass smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKIGU7FO"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-6058a955e04so3206867137.0
        for <git@vger.kernel.org>; Tue, 14 Apr 2026 01:58:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776157083; cv=none;
        d=google.com; s=arc-20240605;
        b=BcWMHXJWoomKuqk07FEgiytXNaVXhYK8JI22YWjBQH2mBfuyQNXbl/XHWngbRNVqcV
         LgHzYMayArEW68OWll8O9Q/XV5VcYJ8T1MafSymn0Ha7uHycpnUb4S5CmypwZ3VXm4S1
         JVrrz3gyYYmtzdAfBhFynJrC7yuvRQZe2ws6co1s08ZMtpayRumUWSFL735i6c0breEl
         gayRz2DKfabRk06yGNLRTMvA+9UxWP6NRwt/0e6JpIbUyiXsB2rxdpQJxNIJRtz8DIwn
         umoPpoEdmduw6Zl4CkY+xS8x9pxOHKS2EaSH3IOqhmTiVfl66r/+ocn3RUdB98hyadTv
         PVvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=cgM10LQCqWk8cPmzWrj8KjO2aq3C1qxYpTuNgjBow38=;
        fh=vYxtVbkM3ooHDcj0iKCXcxMjFsQ1/dn2+oQEq1pxJ80=;
        b=k6H7maNk8TfDG38QUiJJ11t2BEd1BFWhF3Pq8a0qmpNgxav5Vi27UqGLu/cNCVoMUc
         KrxxP+Jct1TQqD7AMAOyYFPxKRac0n+BvxHOhw6mruFynF543fzkIW/3AVgYHk1uj8oc
         1AqhRAFrOmZ1CDSLl8YiojydkpgFSaUGyhLerO7KGgav1lkNeIEvi3Voreis4BDyiCXY
         n2JP1k0Hi10zlF4euQJK304eBWbtlNo8xSzxNwx0jC7AAKVucOmuI2427VpbABsXCJdT
         mpUalXMHwrmQkrq9j07F2Qtyw4soluK8ZvS6Hy5fN0kQykwY3ihNsCKgQgBpzd/nwFDc
         jbRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776157083; x=1776761883; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cgM10LQCqWk8cPmzWrj8KjO2aq3C1qxYpTuNgjBow38=;
        b=AKIGU7FOaNLqJ/dOEAV2zuIYOkeTtLYdKyCjcJF0ImkZkWwDvRufZTxdjNcrJxB0uH
         ijbUk7+kMnkclXs56w8vsCBuNQTTf3tQNWL9SB6+zc2x+N4HzdzemLV8GNHz/J7+OXHz
         mSkyPDtSOX99+wCuuCn+QWd6S9bhVGPASMATNYMtQlYrjE80OITplEDtJQ/fyb7FQCgE
         Ceh8x4SPw3lPgvfpdqqRZGJfMuYTv/aRCNGnw6LZ2FcrCZnZsEijtcrPuKbIlkUI95S+
         GBBUFg+p3J7MSZ8HA7yTBWBKWHDeN/NxxuB7tT1NLVQGjEegiRT9d8zY4J5BMYLugFdk
         Qq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776157083; x=1776761883;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cgM10LQCqWk8cPmzWrj8KjO2aq3C1qxYpTuNgjBow38=;
        b=O3QX4I8h8p7J4YdFIX8BkaRSsXXAcRRVKNhtObSU3lVQMYuzfKqLAlF+A73WsTP56T
         s6TugpqJwi6KOM7n2Vyd2ibgXUOzLI2Qg7woyIL0DEpuZkzIDHwr/R7qO9DFjfmu+I7z
         f2qYcwI++mTSu7BOgtApWZaJXckUuhexVX5C6ld+NA8eRrIYM3/RTbmWDixwwplYUdou
         eQgQS6cisj22t9KJuprlimwaeIUrEnZBIYX/YUiDjlKkOjIz0TnGkMUCn4xfZpAwVRtx
         AvyC413KEe2+NDnd9bu6J6JHS1MJ/Nf6fsCYjB9ieS9eQmlvtdM+aF83MCalFusg25go
         Mr5Q==
X-Forwarded-Encrypted: i=1; AFNElJ8gC7CCG3s3mAG9CoNVQo5BKGtnIiC8nr3EhSFXWxtvmTZZqNZwNT3U1aZEh1XWjhtvC6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGu9e7HkvAk0DqrzUtT6/eH9ZMJSkCygPmX4XeVLRIMxGOiKsD
	xOtKdCTYQdIhk9sF5dXbc+uK/NSauK21oz3/qRm6RQ4xwmBkIzOVUgM92euDRny258I2NCTNqw7
	dwmO0J13qo4cfuSMcLiXKM+KF2cttqdw=
X-Gm-Gg: AeBDieu6WqiP8UGXqaNvSAVI1p6oBqRdtJwqlwT9zvwcgAxLpxi1ruX3S/fZMLxpBN8
	66Coag/yt8uk7RLNki84jbWs/uNgASgAmes++gR/N8srBdJwgW6+gIEidzPagDekiT3vWuWMZnw
	ln9pOz06Ru54sY9NQrrnR3HV3++GyGDYqJLo+CAcXzQz4pooT7GsetPWPts1Q8h6izcGkjGyUwD
	jiVMfppbigM3mW45DJAqL9PKjKlMzANQ9w6S0NBEK1mpdc/2fR7/9s8jz6SWN3q37RQCbwPuq8I
	FAkxPS8C0gzayiOc74u/ifQm2oq/3YjqVrEGiU6YVw5OYKpGZ0rC
X-Received: by 2002:a05:6102:4403:b0:602:8894:b76c with SMTP id
 ada2fe7eead31-60a09146276mr5030066137.5.1776157083321; Tue, 14 Apr 2026
 01:58:03 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Apr 2026 01:58:02 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Apr 2026 01:58:02 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260324123750.157143-4-belkid98@gmail.com>
References: <20260324123750.157143-1-belkid98@gmail.com> <20260324123750.157143-4-belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 14 Apr 2026 01:58:02 -0700
X-Gm-Features: AQROBzC2ktx8x-GlMskuDRJlDA8cAZUl4cn_2DSCveT5DN7TPskHTvudlFqkPmU
Message-ID: <CAOLa=ZRexa+uYj=F2++=vijBb760MgjdTwq3REPpxcwk02caHg@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] environment: move `zlib_compression_level` into repo_config_values
To: Olamide Caleb Bello <belkid98@gmail.com>, git@vger.kernel.org
Cc: phillip.wood123@gmail.com, gitster@pobox.com, christian.couder@gmail.com, 
	usmanakinyemi202@gmail.com, kaartic.sivaraam@gmail.com, me@ttaylorr.com
Content-Type: multipart/mixed; boundary="0000000000000461db064f67ccdb"

--0000000000000461db064f67ccdb
Content-Type: text/plain; charset="UTF-8"

Olamide Caleb Bello <belkid98@gmail.com> writes:

> The `zlib_compression_level` configuration is currently stored in the
> global variable `zlib_compression_level`, which makes it shared across
> repository instances within a single process.
>
> Store it instead in `repo_config_values` so the value is associated
> with the repository from which it was read. This preserves existing
> behavior while avoiding cross-repository state leakage and continues
> the effort to reduce reliance on global configuration state.
>
> Update all references to use repo_config_values().
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
> ---
>  builtin/index-pack.c | 3 ++-
>  diff.c               | 3 ++-
>  environment.c        | 6 +++---
>  environment.h        | 2 +-
>  http-push.c          | 3 ++-
>  object-file.c        | 3 ++-
>  6 files changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index b67fb0256c..dd82eed76f 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -1416,8 +1416,9 @@ static int write_compressed(struct hashfile *f, void *in, unsigned int size)
>  	git_zstream stream;
>  	int status;
>  	unsigned char outbuf[4096];
> +	struct repo_config_values *cfg = repo_config_values(the_repository);
>
> -	git_deflate_init(&stream, zlib_compression_level);
> +	git_deflate_init(&stream, cfg->zlib_compression_level);
>  	stream.next_in = in;
>  	stream.avail_in = size;
>
> diff --git a/diff.c b/diff.c
> index 501648a5c4..4bc0297873 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -3365,8 +3365,9 @@ static unsigned char *deflate_it(char *data,
>  	int bound;
>  	unsigned char *deflated;
>  	git_zstream stream;
> +	struct repo_config_values *cfg = repo_config_values(the_repository);
>
> -	git_deflate_init(&stream, zlib_compression_level);
> +	git_deflate_init(&stream, cfg->zlib_compression_level);
>  	bound = git_deflate_bound(&stream, size);
>  	deflated = xmalloc(bound);
>  	stream.next_out = deflated;
> diff --git a/environment.c b/environment.c
> index 8542ac3141..5b0e88b65c 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -52,7 +52,6 @@ char *git_commit_encoding;
>  char *git_log_output_encoding;
>  char *apply_default_whitespace;
>  char *apply_default_ignorewhitespace;
> -int zlib_compression_level = Z_BEST_SPEED;
>  int pack_compression_level = Z_DEFAULT_COMPRESSION;
>  int fsync_object_files = -1;
>  int use_fsync = -1;
> @@ -377,7 +376,7 @@ int git_default_core_config(const char *var, const char *value,
>  			level = Z_DEFAULT_COMPRESSION;
>  		else if (level < 0 || level > Z_BEST_COMPRESSION)
>  			die(_("bad zlib compression level %d"), level);
> -		zlib_compression_level = level;
> +		cfg->zlib_compression_level = level;
>  		zlib_compression_seen = 1;
>  		return 0;
>  	}
> @@ -389,7 +388,7 @@ int git_default_core_config(const char *var, const char *value,
>  		else if (level < 0 || level > Z_BEST_COMPRESSION)
>  			die(_("bad zlib compression level %d"), level);
>  		if (!zlib_compression_seen)
> -			zlib_compression_level = level;
> +			cfg->zlib_compression_level = level;
>  		if (!pack_compression_seen)
>  			pack_compression_level = level;
>  		return 0;
> @@ -721,4 +720,5 @@ void repo_config_values_init(struct repo_config_values *cfg)
>  	cfg->branch_track = BRANCH_TRACK_REMOTE;
>  	cfg->trust_ctime = 1;
>  	cfg->check_stat = 1;
> +	cfg->zlib_compression_level = Z_BEST_SPEED;
>  }
> diff --git a/environment.h b/environment.h
> index 1d3e2e4f23..93201620af 100644
> --- a/environment.h
> +++ b/environment.h
> @@ -93,6 +93,7 @@ struct repo_config_values {
>  	int apply_sparse_checkout;
>  	int trust_ctime;
>  	int check_stat;
> +	int zlib_compression_level;

Nit: applies to existing values too:
1. Perhaps it would be nicer if these were sorted alphabetically, I
assume we'll add a lot more fields here.
2. Have a comment stating the purpose of the variable?

The patch looks good to me otherwise.

--0000000000000461db064f67ccdb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 5a588e124600ae04_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1uZUFaY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNEYrQy85TVBUYXlrVjVpanN0L1duU0tiU2p4bGlRQwp0MHdlSFp3N3Zr
VjEvWW1lU1RpYlR3YnVKNFVJS28zMUVNN3VwckFkMXM0WnFpTytrd3JURWNza2NlQjJSdXRSClVi
MWt5VGx0Zm0yREJyN3lsNFcvT0Vua3Jkd3M5eWVVVlFwVzUvUUprdnNTQVJSWWJGY293RFNwbDF5
WHdlNS8KTENUbmNMSXkzNkc3ZHlkOUVxVysvRHlFN0QzM0VpYyt1WlF4bVdFSXBPRWJuR3RGME5l
dUlHV1RHN2poeTErcApOMlVrVExZZjhnSzJKdzRyQmFuRVFPbEZIRDJxMm4vUnVQRVJOeXFQQWkz
SUcwNjAvMGZzNTFxWEpyZ25BdHFVCmpxS0d2ZlJ5dGo2ZVFlaWs1V05vbWFENGlrZWZkcHZ5TUZK
WUpBRkl5TnFra3VYSWdjQmdaek9qVi93cjNqSmwKYjZpL0RtaDN0elhGWWdwSzdkWDduL2xIeFFV
dDFDaStaWGoxT3BJMzlFV2R6TU1qbkpScHNDYU1tbnRTQXNWQwoyeFY5N0lhcXI3WWhiQzh3dmt0
clU4a2wyMEJmVkw0TDNMdzVPNmlsSmNLSzJLRkFtdWJQcTgyRkRkWWM1OTNzCk5PZXZxWndSUk4w
b0pTQVJzaGl6dGJwMjNsYUcreW82d1hISUFsYz0KPVJFcjQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000461db064f67ccdb--
