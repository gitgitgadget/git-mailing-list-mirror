Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD63C146D75
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 09:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719307191; cv=none; b=KWAYOSh7qv4YZZgqRH4spu281cVxTFjNlZcudXmrnsk0G5oTBK6pZhImwmGsbLsmuzVPWlg9L0msdGYbTSfBeflviW34/gLGt1RgLQFBZsQKj1cy49BIg1thnwnKvqtC4ocPfmdYbg87PRPlGRukSdspXuRqgVkPIU0OJ2XOagA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719307191; c=relaxed/simple;
	bh=ajuQPKF01h7SwLltz+QOmRr1V674Vv2pPMumvbW0Lcc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PAfGxnh2JxCSIPSdeb+jV6bMnqGsX/TAtVW7plGamQ5jjBHmvbK6fORXceJ3tFTkdhnqpO7vhldyB13oS7uiCzb0+sPqEAXqTWau/do0ZlVwrtw0qBJrq8V5t31wui69PT9hZpKgpg4+6XJlQnaF+Y8RXSXRfokeTdnAV26NK3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHFCIpU3; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHFCIpU3"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2598a57b2c1so2538271fac.0
        for <git@vger.kernel.org>; Tue, 25 Jun 2024 02:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719307189; x=1719911989; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=BxsipAM+xBgwEZqO/2S6fsbes6ecYek+/lj8ZEUz5Ls=;
        b=ZHFCIpU3r8u9ranircCBHBNcM/dsMvSD34/ZoVHy7EZJJIximac5VrwRF+uJv4k8pz
         M8hCImO0nPuVYz7c6hdqc1VvEm/6KsqcSKeaBAP2lcfuF3SszbG7gBgW58J5LRvKorp7
         pCG3EYW7+yXhBE0BnUItf3NoqckOOjK5sRfWgVgNUbQIRc+DwiiocVZOZrpyfNBuILqq
         Hpf+TgG21oBcj6RgklpNhZT+4+uKNhzKG1tN4/0q6JguVFEG5nxBYvRTMu1qKatUbwBs
         5bJxa2atHqROwkkBTZIeMrcNiBA5i/bQ3XISkbHfWuSQIl8YlrjvkaGunegn22hhQTQw
         StWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719307189; x=1719911989;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BxsipAM+xBgwEZqO/2S6fsbes6ecYek+/lj8ZEUz5Ls=;
        b=I4wDzdKyqM8eLxuNCgwZjCWcfVXxLHwl5tfnWS051Wcl+FtYfEC31cbYbfQtim2kL8
         7Gsl7RhQsYKbxCfIwoON1x26MXfDfPEjZESsdyJKEFOk9luKJfUii8f6S0+w1sHZUSJN
         hXbZ7ypLIs5cT+/rxmvCjDv2v/Mco0UWjZ9lGCX+UEolA4R8SsiVsveNXEOSfyq/Fq4/
         AdFO0UfFeBYMyYwH3B7b/uIJlAStxIimu3DMTwlQK5K2d28K/evLuwiDjCnMVa69oa5f
         WT7IfJ3mwjZTsv082Lw9ltVp+3PkF7U8X/hnnPKeE+RZs+9I9wkS6lwkv3fmjbhFHhtH
         nOPw==
X-Forwarded-Encrypted: i=1; AJvYcCWmh2M+oDthk//ui4U3GUn8+baPABOOZwf9Yh5kXh+aWgEEMuut82ZuRPvXFcSP96CDRI3019/67OHzgXShtvRBGWLe
X-Gm-Message-State: AOJu0YzvhOK8kYzssstP/lJ/Rha39FyhcL9dEOgoYZPWsC2zZYnFBVPW
	1uXRJ5d38tYj2vCxXhStxZBLtN0Fx6grk1XXZPoQL+sqT3Rfb5oHgHXNd34NMihs4Kk7WEpUtdt
	M3GP50IM46UahOmtp1N3FP3EvSfA=
X-Google-Smtp-Source: AGHT+IG03mmmhMYNKc6tzEPC+dWDzQXZCLJdK7/Y09iZcPWSEQVVZc1Z9V3nIdpCH2B1d6+d21iuY93xBv+AyWZ/Ep0=
X-Received: by 2002:a05:6870:470c:b0:254:9570:e5aa with SMTP id
 586e51a60fabf-25d06ef5925mr7642713fac.57.1719307188702; Tue, 25 Jun 2024
 02:19:48 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 25 Jun 2024 04:19:47 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20240621115708.3626-10-chandrapratap3519@gmail.com>
References: <20240621060018.12795-1-chandrapratap3519@gmail.com>
 <20240621115708.3626-1-chandrapratap3519@gmail.com> <20240621115708.3626-10-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 25 Jun 2024 04:19:47 -0500
Message-ID: <CAOLa=ZRTwCvuRFCrHoK9f+zaKqz-Bb2HNAqpD_1y3tPYgrvatA@mail.gmail.com>
Subject: Re: [PATCH 09/11] t-reftable-record: add index tests for reftable_record_is_deletion()
To: Chandra Pratap <chandrapratap3519@gmail.com>, git@vger.kernel.org
Cc: karthik188@gmail.com, Patrick Steinhardt <ps@pks.im>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="0000000000003e2e42061bb36681"

--0000000000003e2e42061bb36681
Content-Type: text/plain; charset="UTF-8"

Chandra Pratap <chandrapratap3519@gmail.com> writes:

> reftable_record_is_deletion() is a function defined in
> reftable/record.{c, h} that determines whether a record is of
> type deletion or not. In the current testing setup, this function

Nit: 'In the current testing setup' holds true for the series, but on a
commit level, this statement needs to be modified with each tackled
type.

> is left untested for all the four record types (ref, log, obj, index).
>
> Add tests for this function in the case of index records.
> Note that since index records cannot be of type deletion, this function
> must always return '0' when called on an index record.
>
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
> ---
>  t/unit-tests/t-reftable-record.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
> index 766431ca67..99ebfafe0b 100644
> --- a/t/unit-tests/t-reftable-record.c
> +++ b/t/unit-tests/t-reftable-record.c
> @@ -477,6 +477,7 @@ static void test_reftable_index_record_roundtrip(void)
>  	reftable_record_key(&in, &key);
>  	test_copy(&in);
>
> +	check(!reftable_record_is_deletion(&in));
>  	check(!strbuf_cmp(&key, &in.u.idx.last_key));
>  	n = reftable_record_encode(&in, dest, GIT_SHA1_RAWSZ);
>  	check_int(n, >, 0);
> --
> 2.45.2.404.g9eaef5822c

--0000000000003e2e42061bb36681
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 446933abeeab9a3f_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aNmk3RVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMm9BREFDa1I2cXlJajRDYlV2TlRSRDIwR3hhOWRJUApPZ0d5R2Z6Q2li
VG50dlg3ZW5QUUsrMVF2cHBZUWpjanJZTklOUUhKVHp1UFVaMUszeXRCSWVZMmJOQS9HYXllCitv
dEIwbGJMNnF4TDk5MlpmU1ZFZy9PeUVhR3VnRURwWGRVaC9BS09BMUJKVitaNEQ1WkxRbUo5MkdJ
UU9MKzMKQkNwMXY0c0JZYURJUHA0cTNBaDNwdmFmZUg3YlhNZTJrMkdKbW10VWs0LzZ5b3RwZkdX
bmF1K0diM0F4ZGFEcQoyQTVXVmdvOEhzR1JFdmN6VmwxZVlVV2xIQUJYbVlFTS9SSmxvQWlKYk1F
MkkrN3c0MEdET2lhRVFZNExZekZsCitXNGhSS0lLTnE5T2gvamN6K05iTGJycHhzLzlRTXdxeksv
OE9MTUc3TkR5ZlFuOVVsSjJ5eThCQUp4NXFJTW0KcEJaTGliRVlRL3pWdERCSEhHajAwZXRoVGVy
eHg5ektjQ0d5K3FocWVHUE9UNDFCeHphSG01emlsUzN3MUg5SgpZYTZHTTJSOGhteWowbXF0LzR0
dGtwZ2xlcHdobDRiNkNiOXNwa1Erb0xXN0R5UW9jb0JxU3BtSXpGOGUrNjY0CmxWaWNjRC9SNFAv
R2h3c0NzT2l5L1BJWk0xZ2F3dGdKVExiNUhWQT0KPWhDcUsKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000003e2e42061bb36681--
