Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793051509;
	b=b5SVo6Q2qljzMY4AIrnCcHth4lVSnNf/G3X2BJrSGsko4vQss+nS7P8S9EzykLBt1QHe
	 cKoBwMDGSMaZD1AWZbBQ3JqKySptGyeJ1qvEHY+0Iivk2rIym8N2QtT5BGB1/YAUJcvM6
	 adFE3CxXqAcCYPsls9P+9uWJElD1E/dyNOXI2vFYtOubN3abBBLTKy1FpoSbZj64FLrre
	 HldDsKlJQoADFyPm5hQjJSi3A54QlMr2SJYXgmKp9P+N+cLENIsqC9As3bY+EQuvnIcig
	 EJGGmtnzoYOvXFbMP8DVtncHJ1Gs5235xi75EMakaPUEG0ThvRibNDGnfqxa5exZD5A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793051509;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=lidIlSZMVNOVidrkQ8cygFHtucNywqQIdiAYs/bcjT0=;
	b=XETLNqSESxP/EGrcAM2D5R8sLrUSSuybk1SCrA9TTBSiISmYB9ZR4sQeX23rFEWHJ1dK
	 1cLbdXg7aip9O0p260BYYo4goIdDnZex/jIw3LAGCrfyjQjSsRjCG3mhOZFp9+Jw+8aNS
	 qCROt7vQpSmguTkCLwZ7Y/nn/Icy7Qo6Vw7o5c/SB1gvVGG78MsqRnw19Fjg/UAbt5t10
	 P/2RzDqCgOAQBjIZOeV+yBmQ+sA9DOM/HOL79VWXiK6N95cPKBcP+uG12cNEqX8zbLqY5
	 RsiLzPA0oFea7sDgUbFMss3IaGJ/MXbrk644sn9EyZTOSRxb/TzeRqtubVkuTXL1tdQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=B4ODD+xX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.52
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC0F606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 21:51:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DC0F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=B4ODD+xX
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-7c3b75caad1so2173858137.0
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 14:51:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793051508; cv=none;
        d=google.com; s=arc-20260327;
        b=ezY04Pm4Y8fnRpSj6Flu5eRZANJ/eFi6Ewoqp9mQbEBr65YhnRkstq08X51n1wgL+t
         QC8PNWRRWUaGGKwwojw/b9ABAK2bdvE0S4TCl2SbQPau5XBn3OiOBe+VVEHbs2jb2U8G
         1muDiRUIX6IYGgH7mG/ep9y69oOdPGgJENCDBn3SRZtJO4+MGEwXfb0v3lm1/D6/nyq+
         lSPi6RCoq0lscuebHQSQcWZ0CUlzGHfB2S7SNrDqmIU4sx+RXGiujJ6Czz2M3q/1Glld
         lHZGOrDOOz57mfyzIZJ3abfA/LmndadGJ/mje4w0nXBv+OEyVjKDWtik1lHQv/7vZZiK
         W1ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=lidIlSZMVNOVidrkQ8cygFHtucNywqQIdiAYs/bcjT0=;
        fh=xJ/TRtph9JIo7uuZXyK91buRsnaecvbdNGjA+VFSY5Y=;
        b=UNEPfDpYbq/HeGPR2YgRBWEFoPDBgKlc1M/Vg/51G2LhQpDXRjpcnpz6ooxohlIuoU
         P6YTBUU8NAD0H02aFnu8aPKUn/bGiaZDE75ZgB4kVfLs7/pWNiAy7shsX9130x2EPQzH
         FA7oCg21fTigzJdTR7XUJvCmE7O/E0C/uSu3LkZB2rwhvHyc9VZxoHx1D1j7ygEWu8z5
         QdPvOudfOrfgtjAweiQvM9aomMmSaSVN9BeyNV70M07m/Y66M4cDXVZBkACfPdznyZ9U
         K7VrKp7LwxEBUVsju2nm7sE60ma7/V94htVkztv9Kkk3MtCN5orr5AJQJZe0zhfDrICj
         D1mw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793051508; x=1793656308; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lidIlSZMVNOVidrkQ8cygFHtucNywqQIdiAYs/bcjT0=;
        b=B4ODD+xXOd+AjYTUwEUToCBs7RJCxPbUPVeaE0zSS0Q22iWq0fj0FVXk+gxYgLf12O
         MSB11mbw1sInQYd9vQFDFSUwNIkKAk5s/zRiNUpLsRow/D7/HQaP/kPnk0wvyHH8hlyY
         BrWTH+rs8bGtg7jwCQEVyE0gXyIRmWI1CeH1f4hl6mfXP/DfYMOK+5CavKKUXNC9mck8
         YLMywo6W9tdnnCiiV8cwRLuHQLRz+1DU5Jg/snw23wulatNY85XV9Wm2oaQKeBb6YM6r
         88duepBDTVyNZ47FPLZX/PGqgJXYXzOB1CrFPSt4JHpdaxzuXSNw8oDW66EGHp6rYooa
         2Yng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793051508; x=1793656308;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lidIlSZMVNOVidrkQ8cygFHtucNywqQIdiAYs/bcjT0=;
        b=1WABB+GqKnmqCnRzkVMLI0rKLXtkR+40Fl4MDUclDYLnqc8yMGFHmawtVmi51SY6UF
         WrNSD29TPwLXxV8ioT++NRIddTo6W7whPSo4GTn3Y2bkSll8ppqswtMTXMNCHe/HW8on
         PRtOuf3yCsZ6VHIcThWh1frwKUmzYuD9UDwYHOz7uMmBh2Vf89rzP7B7RVRo140K7L0e
         zXPzDE/E1bLBnrdSEU+9fvUKX5KaQZhBX/OUREW5MFe6TWjgkg92yrUaLjeeqdbOV2MZ
         oUWz82jqdeqCh1ykhTg4axsLfAConvHQJFjyTC6ftzoo+XfjiKnQbA12tFFJLBqXriPo
         D9hA==
X-Forwarded-Encrypted: i=1; AKwUvBweyJMbxo3hDqjLTwUBmhr+3aAWCO7HM36xa2Qcs2w+S3a8nF6Rw5cAVfPh8aH78M02flg=@vger.kernel.org
X-Gm-Message-State: AFq9FYI+upeK85pbTLl+A7Fdk3zgMpGpK/+DkKdIRG+MbCP6ZLK9ch1O
	cvRgVRxRoWJixog+3kf77z1YY+l10ryNHBPRH6VZDdmmgiy40itjEIrleDknYhoacnKgfq6wwxS
	i2jzOl1ZHD/FGrs5IXBo1tCXbFU1WH9Y00g==
X-Gm-Gg: AYBFou1qGvMN3/FWrerigTa+quIsFu7/s0ByAizCkm4mniZD0Oton8lSgjaCNEPSrti
	lTqwuUUeuX3W+9aox82V+AFBW0h87AZp0PbnWHnDPlp5HlkJHNmUVT9IeXi0nM2l09P1RpzPeOL
	pAzlTiewmX4LW3MZM3c0x254pdD906akz79sQLQ0RZHeUSApHwb/h81P0xpJPhPKCNHrQiu84nt
	V+WVjG7q2LSaPZ4BhzjkA74kwmu2YOzrboA2NFlvX3cWQxv3Hji91S5rs4v5mIY5O9YKDwnn93t
	jhSM+Kb0C+G62O0jWG8nXPXqLXUMuRh0kCsES6nHMbVX+0kcspKCjmWvQxHjfkv7F+oGrx2rv4z
	trn6qb7bI0crZdgnYW5+Y6aaqYEGlygkqHEqX9r5OXzHOCNA0TKE0mMSRJ+r+yHBKMHPTrnl9jo
	uyFej4g3NDlsHmsy8oCIUUwTxy4GY=
X-Received: by 2002:a05:6102:50a5:b0:7a5:391c:37ac with SMTP id
 ada2fe7eead31-7ce5cc37a69mr3031494137.10.1793051508110; Mon, 26 Oct 2026
 14:51:48 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 14:51:47 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 14:51:47 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20261021182528.3055494-4-jltobler@gmail.com>
References: <20261020132900.1208343-1-jltobler@gmail.com> <20261021182528.3055494-1-jltobler@gmail.com>
 <20261021182528.3055494-4-jltobler@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 26 Oct 2026 14:51:47 -0700
X-Gm-Features: AclHuK-E1r0DuiPhDgMcxCAC4iUaMrXerRlFucS1lycAl57K0itTRbfqkuMwcrA
Message-ID: <CAOLa=ZSSwWTncnn99nRTfrKLCYF_DDbhHjNjcrsTggKUCoXJpw@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] object-file: explicitly write ".keep" lockfile
To: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im
Content-Type: multipart/mixed; boundary="000000000000349885065ec5566a"

--000000000000349885065ec5566a
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

[snip]

> diff --git a/object-file.c b/object-file.c
> index 210984f825..74a31760bc 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1424,34 +1464,57 @@ static int odb_transaction_files_write_pack(struct odb_transaction *base,
>  			return -1;
>  		}
>
> -		/*
> -		 * The lockfile filepath is expected to be the final location of
> -		 * the ".keep" file after being migrated to the main ODB source.
> -		 * This ensures the lockfile can be found and removed later
> -		 * after the ODB transaction has been committed.
> -		 */
> -		lockfile = index_pack_lockfile(base->source, child.out, NULL);
> -		if (lockfile) {
> -			ALLOC_GROW(transaction->pack_lockfiles,
> -				   transaction->pack_lockfiles_nr + 1,
> -				   transaction->pack_lockfiles_alloc);
> -			transaction->pack_lockfiles[transaction->pack_lockfiles_nr++] =
> -				register_tempfile(lockfile);
> -			free(lockfile);
> -		}
> +		ret = read_index_pack_report(repo, child.out, &pack_name, NULL);
> +
>  		close(child.out);
>
>  		status = finish_command(&child);
>  		if (status) {
>  			strbuf_addstr(err_msg, "index-pack abnormal exit");
> -			return -1;
> +			goto out;
> +		}
> +
> +		if (ret) {
> +			strbuf_addstr(err_msg, "index-pack failed to report pack name");
> +			goto out;
>  		}
>
> +		strbuf_addf(&keep_msg, "receive-pack %"PRIuMAX" on %s",
> +			    (uintmax_t)getpid(), hostname);
> +
> +		if (write_pack_lockfile(transaction->quarantine, pack_name.buf,
> +					keep_msg.buf)) {
> +			strbuf_addstr(err_msg, "lockfile write failed");
> +			goto out;

Shouldn't we also set `ret = -1` here?

> +		}
> +

[snip]

--000000000000349885065ec5566a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 120d888977635746_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yZnkzQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNDkxQy80eStSeitaOFZzZnNRN0FFdVJZcGxGZlFpRApLb2JQeEZ5VVl3
RG1sdEg0NnhxUHhRQkptVFpvOGxGdVVud290eGlmNU5hV1p3cUZBK0dPRUZOb3pSTDNiSGJDCloy
VWQ4WjJZd0lZdzc3dkExMnJZSXhodjcxZlRDMnNrTnBiVkw3cDdYNmpWTHcvTTVYMW5hd2RmZnNm
SnpRWWQKT3ZicVhhcHBYU1BpNUQvcWxnOTR5K1F1R0xpczBCQUc2cTUrY0RxcXJtMlVyMlRDSG1C
bXUyV1I1enpUc09WMQpCK0tadFZvejIzbWVwNXdYdTFoWFlScVRoOVVBMWwvbkJGOUtFT0hDbWYv
NENwRlZJNnp0YTZDTmdHVDNYWENFCnF0ZWVRZkhkVGJYREo1cE8zMDVGNGs2SU5OYWxFbkZzQ2xz
MUY3d3ZOTGltWmc3THMvYXM1T3JTb0FsM0FWOE8KLzlEcmp0QmNUZG56cHNrSm5wTzlRWncxcVlG
SEVYNHlFMi9pcC83d2FDVEVid050bUxwamhBZHpvakhJaXRHcQpiU3JUY0NFZVN6RFJwMlpEVW54
RGZIdU5UZmpMZGpFeEw0SXFKdjVmWXcrMnNkQVlXU0JENjAvRnlnV2l4b3I1CllGM3lRMm9pNmlH
NmN0Y1RINTNsM3FYYk8zUzBFTEplVDVURzVKQT0KPVlGYnYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000349885065ec5566a--
