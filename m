Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10985B1E0
	for <git@vger.kernel.org>; Sun, 30 Jun 2024 16:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719764670; cv=none; b=oexUllXnwoRWArsumjM1wUoIu8X0NGuiwT+H0FEquTFlOwwndCLR0Gh6Ppi67GZPuSk5wjJWdA3JJGb0+3EIRviPhu79JQFxPPkHvVEOytht2RYPat6b1sqSu8cHe6wp+ooL7gecnnDfffYZLSCxnAvigFbZegVxhsPOCqX8s54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719764670; c=relaxed/simple;
	bh=IUmDVLCa8FR2acbyx9/9ZkpaUEQzu9aSIY+qv3k7CzU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EMQaAzDlYBLj0hqe+Lg4CwFSRILwXhD2eeXXr5Dl52Lypck9yfYS5pO9KHwCBqdl5jyh/VX6O5pwam/3VT7KZvsPvl3iq8oWNj4nTp0o6JzTBvMthXLGamfg9Lt5PYkqgxhN9R9F4i2kH0nxliDxoXvbToAHLpa/H2z1XBC1E3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KevoMXFe; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KevoMXFe"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-701f0cb8486so1388621a34.1
        for <git@vger.kernel.org>; Sun, 30 Jun 2024 09:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719764667; x=1720369467; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Ujvd9XQgiNsj6S9hcfJqTyQtejo2KKVFjfEgPXycWQ=;
        b=KevoMXFeN6NxmfM4oJs14k/EHMLQ6v0aCKvqTVKJH81DhzroEsyqXK2L7Dyv11ilZe
         9X+mJ4qGOc2c/wPBSOes1NjeQnNFVqKNleu4aNvnO+Kiuqx+NaNvoZ+l90fnRspvO/Bq
         okYycjGf7td1DRvKMHUry1QR4/dsjgh4Y+wSVQ0NvTjsDJViuMnsgoZgnA0/dEydlGKA
         cNz8Iz73MzrfL0F+bXoPaxFvYlGVNS8yBSdOeqxWgz8Dr4ige7s+Ja/idqLtPCuZHJXU
         X6tEhy3gh6LjVPKPuTWPVe9MuwCKb4z37v2ofkgvE03+xEgh1Fh8IEdVr5Tj7fwAnkXz
         oa1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719764667; x=1720369467;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Ujvd9XQgiNsj6S9hcfJqTyQtejo2KKVFjfEgPXycWQ=;
        b=iRYHj5H2C2StycGhrdH6puxL4anjQoCZ6eFr4X83r7oB3UDEe+8eSOKCl7M0sTHAqg
         6ReNwiOp4ZXPzYRApQcXfw4W8DWUEbMUGeHexLo/DFDsPJj/puRl2BvOF6XCqUEskDns
         GQb8hJnxJJDlSVg49x/zCjHDk7B4yBwuAgD83y0dpy3k6nMJ7I4f6xDGFwzysOOFSbQk
         i3wjBfU0Siv3cbBdE0ex5yltOaYAxNUVaCtUupw8X+3SnwJl5Ho1S1lzCaGlpEla1AYr
         qbAeaNkBe+lCh9LOWS7VDHmYcDvPeaoOiwXkG2JCfZ/yNhiTaTUfonlYMyILcC3YbYEN
         5Nmg==
X-Forwarded-Encrypted: i=1; AJvYcCUFGgeakVWWX2tEpoSk1M1VTknQXOVS6IxbvdvQsye1J6ZcjxDNcgN9q9BFfH5eVFwMxcaTB9c+WUB5tRZ8fGtBtewz
X-Gm-Message-State: AOJu0YwYCw8gYyW87Kc8SvUjC0PFBU7HlmcUU6TXHd0blW6e59wbdYsm
	DjOhlkZXf7HN0MsbVP9sO3sGmlTa72W1wgqmaOYBtFZtPgfJrDCu67iTYbq1/9d0fLTP04O0/hB
	58etLq3gKNPSP23uarbPOfpWTxoCAigl7
X-Google-Smtp-Source: AGHT+IFEJku6++2i041xwuzFGTFG32BLduZPRGfLqH5DTX5GIzVFoyVJ5GQwN+uCxOvy4Ll1xJRQfHTfiJs7vKURPEs=
X-Received: by 2002:a05:6870:a11d:b0:25d:7d7d:c96a with SMTP id
 586e51a60fabf-25db252388cmr1868794fac.16.1719764667495; Sun, 30 Jun 2024
 09:24:27 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 30 Jun 2024 12:24:26 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20240628063625.4092-2-chandrapratap3519@gmail.com>
References: <20240621060018.12795-1-chandrapratap3519@gmail.com>
 <20240628063625.4092-1-chandrapratap3519@gmail.com> <20240628063625.4092-2-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 30 Jun 2024 12:24:26 -0400
Message-ID: <CAOLa=ZSrSnOaOf02f-+BsZi79=+t-AAuMdieqH_jAi3j19tdtw@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] t: move reftable/record_test.c to the unit
 testing framework
To: Chandra Pratap <chandrapratap3519@gmail.com>, git@vger.kernel.org
Cc: karthik188@gmail.com, Patrick Steinhardt <ps@pks.im>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="0000000000001a982b061c1deafc"

--0000000000001a982b061c1deafc
Content-Type: text/plain; charset="UTF-8"

Chandra Pratap <chandrapratap3519@gmail.com> writes:

[snip]

> @@ -369,14 +357,15 @@ static void test_reftable_index_record_roundtrip(void)
>  	strbuf_release(&in.u.idx.last_key);
>  }
>
> -int record_test_main(int argc, const char *argv[])
> +int cmd_main(int argc, const char *argv[])
>  {
> -	RUN_TEST(test_reftable_log_record_equal);
> -	RUN_TEST(test_reftable_log_record_roundtrip);
> -	RUN_TEST(test_reftable_ref_record_roundtrip);
> -	RUN_TEST(test_varint_roundtrip);
> -	RUN_TEST(test_key_roundtrip);
> -	RUN_TEST(test_reftable_obj_record_roundtrip);
> -	RUN_TEST(test_reftable_index_record_roundtrip);
> -	return 0;
> +	TEST(test_reftable_log_record_equal(), "reftable_log_record_equal works");
> +	TEST(test_reftable_log_record_roundtrip(), "record operations work on log record");
> +	TEST(test_reftable_ref_record_roundtrip(), "record operations work on ref record");
> +	TEST(test_varint_roundtrip(), "put_var_int and get_var_int work");
> +	TEST(test_key_roundtrip(), "reftable_encode_key and reftable_decode_key work");
> +	TEST(test_reftable_obj_record_roundtrip(), "record operations work on obj record");
> +	TEST(test_reftable_index_record_roundtrip(), "record operations work on index record");
> +
> +	return test_done();
>  }
> --
> 2.45.2.404.g9eaef5822c

I think it would be nice to be consistent with the naming of the tests
with other unit-tests as mentioned in the previous version too [1].

[1]: https://lore.kernel.org/r/CAOLa=ZSmnMLMoKKWMiM7M4Jw8CJ0Jvrs0oMLy18FHaLv_6s6yA@mail.gmail.com

--0000000000001a982b061c1deafc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 25a4aa64016d3480_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hQmhyZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMFB1Qy80KyswRTZOQ3BqSnFrbXBYSEs1UDdZK2VQVAoxdDZtR2pNZlh0
dlFVY3I1N2xQNXpodGZHY0xvZDFtVlg3TTM5ajVkQU14bHJ4NjRwT2lvaEozZ2huMHVXcUVTCi80
RmFMK2pFQ29KWWE3cGdGS1pzbzBWUTNWcE1EODlOMXoxNFA2ck05M3lpaldvNDluTy8rNVVqeit0
M2ZvSXMKS2Y2RFRlLytHdkkzcndDdVhld2Q0aTE2OG5kOU9GaWZKdFFIbmhNbzA3NTd0eTJmV3NN
N21ybDlMOXFHemF1bgo1cTl4QXlSblJhdW5ESnRtNWIvWVpRMUpMVmZhTDUvMGlQM3hOdjdlazNL
dERVSG5iYndmTUltYUpaVHRubXR5CnNPL3lURnNpalpRZE8wQ1F4LzAyWFhIQldXanB5MGZwMStS
dVp1ZkJxSHIxWFFBUE1sRnBRSUlydkU5ZE5jQkMKcTdINVNmVDJudHJrRFA1YzE3NWdwOHE2RVF1
OTh2c0VwelF0YUd3TU1rTjFVb0N0WDJlcnNSbWFSTndaNW85QgpIejJNTExHNmNORHNKSksxR0p6
SFFhanM5UHR0RnVINDAzMElSZWIxQm8ySjQvdHFLTGtkUkRUYjAwNmxVblBRCnI3ejZyQmNobTgv
bjgrVktqaU01emFpUWtlQ3p0MHJLb0hxNzB3ST0KPUorRloKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000001a982b061c1deafc--
