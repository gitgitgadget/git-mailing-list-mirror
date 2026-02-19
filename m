Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B382FD7DA
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 23:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771544969; cv=pass; b=hMRKyz4lu/5kdar+rJjGjr7WaMpnDvVxCbOfohIB/LTnfgvdQsrBMKVo8/LLJAWHTfMp6f+V4L2hVum53ifBqKN1Tvno8kvVrO8293qY0XMItzf2CH4ntkRnaAj3mUp4XpZtkY5+7dSmTAPWMLIyPiosQTj+bIkwqUZS/flkOro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771544969; c=relaxed/simple;
	bh=pY3/8LDvRugkd6M9/u0v7KjG9MAtiaSsdJRoLKUl6z8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OqL/NRhmU+cNoyKQhspzXwyHFA9V3Eno9Lt67+mr2fVrq+lrwHgpOhb7NWstLF5EBAgxF8S1Btpn6Hbuhj0EWejkENUwo/ehO35JrDr2vFVecsE/qTTmmCWzfHgYp+F+xQxw0i8g6nsQO/4kSM8E4sQvIWRJFhGLa9PpZY5Ycm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2b86a9613d8so62613eec.2
        for <git@vger.kernel.org>; Thu, 19 Feb 2026 15:49:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771544967; cv=none;
        d=google.com; s=arc-20240605;
        b=RzG5lfFFv+14LIA1eaVBoDwZmcxe/CMINF0AOtWjb8/Wt1IK+ZyGl9gJ/MUkHpi2n1
         kBh8NZzOTX3mt4e6zacSxL11YElrbZgnO/D6N10TkXBGXuMbpn8uslOfm4JNWQoJUQex
         5HhIVt3Pe0zpTonoFo+M2C8yFoVtop+UhU6QL4xf4h8Ci71JNWXUS1nW+epZW6Zr3ikv
         wuW7H5cbLYCyF6CAogcVa33PgtrC2gNIIXMUOz+uOSBGEHw6q+WlkBpSdFGyxNGc8oe+
         zYORPxK8sNqutR+TS8F9rH/Ne9vOUSvfv6mKtp3NZBgyP/OJkofvtUTg7HoVYDwLPwF4
         rZjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=lHNx4XyfMZX+drKnrieRjNgj+50CKfev8QNNbaGGbk0=;
        fh=ixUb2l2hrASaZJ+AYipvdfT+QE47GqYCY6tByYLgH5k=;
        b=Xx5w/Af7/oc5gO1+9s+c6GSNa9ls8YR/iKCXYgRM/ncYx9cx8qlVBvxHo6JXcQMrqE
         2RXx9EJUO8lTxquIZn+ClOtRDYEbJeuwxaf7iZP3FjL+A2KlklOgAZPcCRIv/TI4lNOu
         Fv4dSFoJHObO2VOawLv05cs/VIC5glcQ0oNUCrCYoywoTZUnrQ/iUOp3ujVmS3H58buJ
         Ips5xrM3U5SulcmF3LNASaJWbcVIe+KQJXNfEtSJSpG3kRhMkKpjTM5ckSSAiuGDjKHe
         DU3g9RpTmiLIV/W1uPmM0M2bpYiJ2Bzf8RY04MXJ9ogfk6K6aMVN7gKl4rmsn2DK5WFz
         V6WA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771544967; x=1772149767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lHNx4XyfMZX+drKnrieRjNgj+50CKfev8QNNbaGGbk0=;
        b=enf7NFO1BXG6XXU8T/HB2rXUbilYz7muCyymqfmYFGtrPKuLzarv14H5AE32kYK32c
         FAdG7cG4zRtV4d0QP8JCqJeQ47O5fx1TrSz0z/0qp5f9zbRUWSZYBwKgp+jntShtQdKs
         03JKzEy3qfXcqaveFJzGQmRnFVtatwvR8dJ8c3rxnP+pcvElwtT4+fzpUY7RFDusm86m
         I/H76zp9gfCwo8n8nFKSmEMT2R0xH3bKavu4IdlEYDJAYkPrvVH7nOdvFkjn8rTll0yr
         1LNOW6mP6HrUU+PaAGoRGGlMRO35c/PO9iMiTmB6Uw+SOnYtp78KXwADnupM8s6ycJeA
         8mTA==
X-Gm-Message-State: AOJu0YxBi++ucQROksfDx2jQynZl7ouvUBbcHIb7sBI7FGe++Gl9Yp6v
	TQpKQIXZ6kWVxj8EvSo1PfasnjDBsdtMhXWl7YdoNhBzlVCBsydUGKIrfvTxIPLnUdK+nc2mvD5
	obE1hsXOgEF/L+aunhHNmDbP39vSFlyAyNLCUBnM=
X-Gm-Gg: AZuq6aIfiX3I2+FFoK2mmPrCrFE15dBkcOtyRzrFJC8PWuqY5nSHy+kFEKBYc/q2Bf9
	vxV5xYl2ghUAgUSu1LwdGD2zQzS+sU8wZp+W4TADwgOdsMFA1KL3AeF+WDMuT5/V+cQgiRWUFFl
	YD3VzMgNH6AqDh3jJrOB+YijxrxolUh+7oHdmaVQIqAYsgWLNMVP+gQmFcf5wdY0bGVwOIhN2El
	hGwaowNiVbGR7cr2bZksjwDsjkUDw9bHbLFG28zeHeLl85YYcGBYSlJomGRoqP1sKOM56sH0bUg
	jCRz3hxjOS3tiFQq0h6Ya0STlHyiDrZT7OQyAK9fUw==
X-Received: by 2002:a05:7300:e10f:b0:2ba:7526:f74d with SMTP id
 5a478bee46e88-2bab9eea972mr5034110eec.0.1771544966709; Thu, 19 Feb 2026
 15:49:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218-b4-pks-ci-msvc-iconv-fixes-v3-0-08c1ff3ffc9a@pks.im> <20260218-b4-pks-ci-msvc-iconv-fixes-v3-4-08c1ff3ffc9a@pks.im>
In-Reply-To: <20260218-b4-pks-ci-msvc-iconv-fixes-v3-4-08c1ff3ffc9a@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 19 Feb 2026 18:49:14 -0500
X-Gm-Features: AaiRm52EQj2AoEsLlepH6jZdDuoBTKfQerL06831qmMNAny_Vmm15xw4UzzDgO8
Message-ID: <CAPig+cTk_j3qiib1E5McMUPTVY5f36Pq=_8giR_2SKfthY10+g@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] t5550: add ICONV prereq to tests that use "$HTTPD_URL/error"
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 18, 2026 at 4:17=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> We've got a bunch of tests in t5550 that connect to "$HTTPD_URL/error"
> to ensure that error messages are proprely forwarded. This URL executes

s/proprely/properly/

> the "t/lib-httpd/error.sh" script, which in turn depends on the iconv(1)
> executable to reencode the message.
>
> This executable may not exist on platforms, which will make the tests
> fail. Guard them with the ICONV prereq to fix such failures.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
> @@ -339,32 +339,32 @@ test_expect_success 'fetch can handle previously-fe=
tched .idx files' '
>  test_expect_success 'did not use upload-pack service' '
> -       ! grep "/git-upload-pack" "$HTTPD_ROOT_PATH/access.log"
> +       ! test_grep "/git-upload-pack" "$HTTPD_ROOT_PATH/access.log"
>  '

You want to be using `test_grep !` here rather than `! test_grep`, don't yo=
u?

Same comment applies to several other tests touched by this patch.
