Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F37171AF
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 10:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719915214; cv=none; b=n7rrMExvzUq+xE/R2fKbxeoGu4wZf0a603udAkj5KTgmIhg+RZEFrqaL5ctlICThyqTn+V1BhHq8AQC8naBgkQ6SxHKWEfEOH1ybn2gVJ/gqzXB8+LkcNa5/vztj/Jy4BlevsgVygsbcGnUvaM/Y8P6vnz+4wExENWxjUo6U2JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719915214; c=relaxed/simple;
	bh=jMkVRBeTWaGfVdyhRqcJE6qaQZGNNl1x2YDR5nkFidI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZDvFA6Z6Uex7XdHN4/1VxiAXrOBdDecmTGySWZ+Bz/wrDVaK4jx6P1s35LvkQtf+8gbjF1pq4GhB5jmZFfI1WSJdM4sDgPKdtLsy3QNBBJ4gkpxzc5sDN1VPAI0gqJ0RnCdZ/2XNzYpKFxt8zeGbqVcOCG3wnLW/Z0IHvc4kWX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHL/y5rU; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHL/y5rU"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-25cc6962c24so1890273fac.3
        for <git@vger.kernel.org>; Tue, 02 Jul 2024 03:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719915212; x=1720520012; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=29HUVb/PkfZpiKKuvRHRklDKgP+uLRD10yl1N9Uug8c=;
        b=SHL/y5rUMK9+05Len1CQ4IWjUJGQdvkZTpbIY+qxj1ZQxGDFyrxXhU655BPLPDWdC2
         ZFkFhnSUBI76JrXtbEuk0hDI8ePmdscgoFj2FLTo9g7uaa3XMGmMW9O4ndbLY1kaY8Dg
         Tp6h8Ff8geuc47SWO+0xyeB8NZCw8HwieuMT1DF5q6u/kS20vp2J4mCzNwTQzsplHGuG
         GsDzW0ve9rrqO0R34vYYVNk1mX9lWXMcKwZPFxysUVXhx1lkFoBbObCXAskrxzAnDqAZ
         mZQ59gwqx8gLvNGE/JY9hYQpMoXivmD/JT62dgzC3Y6eXCfUFI2fuekKfUeyGA0TtXCi
         9t4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719915212; x=1720520012;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=29HUVb/PkfZpiKKuvRHRklDKgP+uLRD10yl1N9Uug8c=;
        b=VLYPkECAn9wa4AA8KD9YPMmFwfMrcQp0pHhu31tVJMhRhY6aNyfwys9PQ8zKNnqfcm
         fqO1msRlbI6+daNUYee1j9lMzbchJ0QJirlvKgtQEnj5LhOTA0AEr8LyQnY3CcL0Hi+x
         L3G3M+hInCHoN8iJByDJH1Un9sR1pgW72vYGqGNEfKb26velW1XCeIgqdxNa+II98mKS
         agZw1YShRGljpOTqRjiie67/k40SvoeGGBuWUiKZBxz0oxLTh4M6qsUIXFWHXTVmyrq+
         dFyOgIAhYgVVtZDkaPCrog0iDAKz+nOPjRix7lWuTCcNbfqtAgdtrZBmMwoxrfI8jLgF
         eegA==
X-Forwarded-Encrypted: i=1; AJvYcCWCrAVEMEklTFp5X7NEOVjA7rXkrY66XATfApwjkYLc6LF0TRu/5l6QJ9zOTpTpQUCGvKN0ID631XNSLsPzyb6G65jO
X-Gm-Message-State: AOJu0YxvIpnfFkvMBumrdj+pBhdXGpe0uaR0h3feTtr6VgXP3xHI2m5q
	soF/zgu7xDzqwCTNFzYzARGs/RIjJ3b1VO0xc+/0CkVJOZyCDoiKGZsWwG+sk3M0iHOUG21f/Ip
	bZOErjyt6tn+jtFAhohMoqdIJ4WzrIByD
X-Google-Smtp-Source: AGHT+IFqo2C1LtJXpAJkW9zi7pde7FT4F66GQYwBKB+/2hSkb65u61YoDW/ctkdUVr+WjNC1B/Vtlh7eF/SNevyLins=
X-Received: by 2002:a05:6871:24de:b0:25d:ff1b:3793 with SMTP id
 586e51a60fabf-25dff1b5532mr232125fac.35.1719915211507; Tue, 02 Jul 2024
 03:13:31 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 2 Jul 2024 10:13:30 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqle2lvsmz.fsf@gitster.g>
References: <xmqqpls3zhc2.fsf@gitster.g> <20240626190801.68472-1-abhijeet.nkt@gmail.com>
 <03628ece-4f47-40d5-a926-acce684a21e5@gmail.com> <xmqqfrsyv155.fsf@gitster.g>
 <CAOLa=ZS359bMtUd+ktvJgHsiG-0=VVdGWYA2mKCNjc_1BrzcvQ@mail.gmail.com> <xmqqle2lvsmz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 2 Jul 2024 10:13:30 +0000
Message-ID: <CAOLa=ZR-g4G0FaxnQjjkOST-zeRxBXXK1gpJ=P3xdbi_9eN_rg@mail.gmail.com>
Subject: Re: [PATCH v7] describe: refresh the index when 'broken' flag is used
To: Junio C Hamano <gitster@pobox.com>
Cc: Abhijeet Sonar <abhijeet.nkt@gmail.com>, git@vger.kernel.org, 
	Paul Millar <paul.millar@desy.de>, Phillip Wood <phillip.wood123@gmail.com>, 
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>
Content-Type: multipart/mixed; boundary="00000000000039e656061c40f748"

--00000000000039e656061c40f748
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> This explains for why 'broken' must use a subprocess, but there is
>> nothing stopping 'dirty' from also using a subprocess, right? It
>> currently uses an in-process index refresh but it _could_ be a
>> subprocess too.
>
> Correct, except that it does not make sense to do any and all things
> that you _could_ do.  So...

Well, In this context, I think there is some merit though. There are two
blocks of code `--broken` and `--dirty` one after the other which both
need to refresh the index. With this patch, 'broken' will use a child
process to do so while 'dirty' will use `refresh_index(...)`. To someone
reading the code it would seem a bit confusing. I agree there is no
merit in using a child process in 'dirty' by itself. But I also think we
should leave a comment there for readers to understand the distinction.

--00000000000039e656061c40f748
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: a597e59fba5fda59_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hRDBzY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meExRQy80azlnMkxzakxBRFdRSStRRHZ1Sm4yNkJENgpCLzY3ZzlvT2Vn
ekluWk9nNExGQzFnZ0lLUmJOajRDcVczUUdBcWlMS0doUHVNc1FWS2VVMTNnUW90WkpiRFR4CkhU
QSt0RGZkZjV5RVNtZVh6NU9zQk9BSWQrL21zL0VRb2Z1ZlRHNkdVZWdzVTlNdHR0d2hqRExQdndV
YklyemQKR2x2a3Y4VThSRERQWlRTOFEzOW5Kcmg5YUdtbHVnUEtnRnBSVlUxN1RBaUg2YVJQZ2kz
VFl3UXkrb0tpd045eQpLTGw0WjRtYytLSFJGbHRZUW9UZ1F1endoUGR1NGNrTSttSUFqVmlwTExY
MW14TlFaWUoxQ1pkVDhKVkRKeXhmCmhuRGRuR242Y3MyaXNZU0kxbWYreWpiVTdIUnc1alVsTFc0
M2djWWdjb0ZLb0dKclpUdmE4V0Fnb01vK2h4bWwKai9uZFpzc1l0bnVNY2RWb1dpMk8yZHVweUxK
b3l4ZXUxTkdVKytnWWFRYWhtVktWYzh1aUM0bDFQQ2x3VlhKMApVYnFUTTl5T3dLMmdJZlpJVVpw
bFNhM3ZZQWdQSitMNDF3U3RIU3VjS2hsaEJPVEkwenRjNEZrYWtkVndpcjFOCmkzaDRTSE5ubTc2
S1VOT0xhb1ZNRDJCTXA1b1lOaTc5Nk1xd1E5RT0KPXZyaTgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000039e656061c40f748--
