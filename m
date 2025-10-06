Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C3C223DED
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 12:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759752329; cv=none; b=InVfweKxFxSgaL0YqEk7O8OoaHjiWfqLTR4ggw7rJxTXMTxbA+yCGL/tidxYrWOi+EVIbJLGuNWNf5tEJToyOpDytTGa+5C1AeWhP/RHTczHT4Hx/dH+ypVX1bjB35jutBh8vIsL4TSRmOrUTvoB8o1kV1Rl4yt5U2zhNqw387Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759752329; c=relaxed/simple;
	bh=iKg2dEHkSm/6evUuMBMClU9d757mOK1WJniER+PHYWM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I8nCKfJTmfWrnDJaf3lu2udOmyjwOgCeDxKBKHAIKLyCw/sLKMFesZb3WsD8EJP+6Ho7VFFGSP1RIwsdGn6oIl4P3FU+t41M8fATr7uGvL4gE1ByvYBFTC2hw/Z0CtD4xrYZE9ByE3dmAutHRiwVGxV8fx+SjoMrc+Q66s442IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aV4p3vk7; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aV4p3vk7"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-8e261568020so854413241.1
        for <git@vger.kernel.org>; Mon, 06 Oct 2025 05:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759752326; x=1760357126; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wth2V6fJZ9S8P3yhh3w+Qq1TQdvh92Zbm+9oRevwYnc=;
        b=aV4p3vk7qdhCIctpc/0LRlRlENDul8M6Vv/nsjQBxSPOOZqMBxupCFtvkC8VTvCfBk
         iIYcB0e/GYJVIIbfvm/X6WhaEnyB5gmhWiryvgA0Z06youJQnvSjFdGFmUNFs4n7p85q
         q1bhxRZulOUmCZVguJ2Nl6Te4dTDUlPzABT2oucDKwYdlinobnML8JTKDc18Edau9WeW
         vDIe3QDu7bsh3qA+BikLe0NjQOW1yzh0T77JbyAjLao9y5UB/xooUtyql0bgUsdA61XS
         KWu8JWylHru25LrU8Ah8lFHrl9phMQGpqhbcC3ONq4h6fsn98XxHyQ4UfCRW9sSJ1lZq
         tU4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759752326; x=1760357126;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wth2V6fJZ9S8P3yhh3w+Qq1TQdvh92Zbm+9oRevwYnc=;
        b=A+zPZgU/GyzJ5VrFDvSPyx0xv65ZHtGVLRobrdocHs+8+9UFw4IQRCoN7lLrf9JBaa
         1azAowwFsjNGHJhjR4S17f1ZdMQL5D0lX72P5hNxA2+WoP4bGE20RuMSFQKsHslMPDOU
         O9VCuOXdug/C0vWV6/RxHFMqSatOlxJqbs4wgQHjVG3B7uKLeEdocSYbKd3b2xVwf7W2
         0KqJVfltsxBEOgqnFgmo4Sb7ExnvMlGBE4VOlTF9nnr4zO8lDwMRo2dLSyG467u5y5Ko
         2wAS5kRgyhQj7RJokhXKK+Vj47eLOKK5YXYa+PMTLXsRJk90WqYBnRro292tF76KhNWX
         8rsA==
X-Gm-Message-State: AOJu0YxcroSP9C9kGhNR0gsEnEP1AALrA1MEbRLW9FjOkJsa78ZaIUgE
	//ECskX0OHoOxAnz5ZwaInyRbIk2oT+CWp3xo+PNtz0Z8PCc4SFdGtMetd22C8cVSO+uN32SNi8
	HWIp2jOQDYMwrZfAS5dcXXscrcbKQbzzMU99k
X-Gm-Gg: ASbGncsu2nWfc2Sr8ejy7zO6ypkxMJ1VDxuf8VVBtZzfORjFBoQIRLbcMrh/0uxwuoJ
	YZpCiVY4mBrAkgoo+3nBdlCrY4Jk254y3e7VVj4lTT61N8M4Sdmom1vwdaNli0sMdUEVwAXAqR7
	OpuJ0trqB4OlJBKAd/+Rd5EIXMLqitapWurYPO3rT/6WHWfzv/GzB5amqrMefWLU5dv11kxUm5k
	jTbfD8YEVSFOhQWfS84LKWk2kaBs2nAguAaPD0V
X-Google-Smtp-Source: AGHT+IFoc/HUuLPlckjaBelL9RKnGFaZLXzeT3Yt1/cC4+GQ9iYVhEeBoH7RaxGcjBJyNnb5J30KYFnT4JtVLgnhpuQ=
X-Received: by 2002:a05:6122:32c5:b0:54a:92f1:f9e4 with SMTP id
 71dfb90a1353d-5524ea0edb6mr3635186e0c.9.1759752326485; Mon, 06 Oct 2025
 05:05:26 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Oct 2025 05:05:25 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Oct 2025 05:05:25 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aN5lrhCLQFnw7qUB@pks.im>
References: <20250926-228-reftable-introduce-consistency-checks-v4-0-c96fd8551c0d@gmail.com>
 <20250926-228-reftable-introduce-consistency-checks-v4-7-c96fd8551c0d@gmail.com>
 <aN5lrhCLQFnw7qUB@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 6 Oct 2025 05:05:25 -0700
X-Gm-Features: AS18NWBE4_vTAHLd-NUOGCNBOyhJmA498OHMio0p2c3FwQLIz8pCCQh5HsSFTsQ
Message-ID: <CAOLa=ZRU01MQCLwWx4zEZNRtqNBvUJnMo8euE+J86q2a9adSwA@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] refs/reftable: add fsck check for checking the
 table name
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com, shejialuo@gmail.com
Content-Type: multipart/mixed; boundary="000000000000506c1706407c44d0"

--000000000000506c1706407c44d0
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Sep 26, 2025 at 09:25:50AM +0200, Karthik Nayak wrote:
>> diff --git a/t/t0614-reftable-fsck.sh b/t/t0614-reftable-fsck.sh
>> new file mode 100755
>> index 0000000000..250d244e66
>> --- /dev/null
>> +++ b/t/t0614-reftable-fsck.sh
>> @@ -0,0 +1,38 @@
>> +#!/bin/sh
>> +
>> +test_description='Test reftable backend consistency check'
>> +
>> +GIT_TEST_DEFAULT_REF_FORMAT=reftable
>> +export GIT_TEST_DEFAULT_REF_FORMAT
>> +
>> +. ./test-lib.sh
>> +
>> +for TABLE_NAME in "foo-bar-e4d12d59.ref" \
>> +	"0x00000000zzzz-0x00000000zzzz-e4d12d59.ref" \
>> +	"0x000000000001-0x000000000002-e4d12d59.abc" \
>> +	"0x000000000001-0x000000000002-e4d12d59.refabc"; do
>> +	test_expect_success "table name $TABLE_NAME should be checked" '
>> +		test_when_finished "rm -rf repo" &&
>> +		git init repo &&
>> +		(
>> +			cd repo &&
>> +			git commit --allow-empty -m initial &&
>> +
>> +			git refs verify 2>err &&
>> +			test_must_be_empty err &&
>> +
>> +			EXISTING_TABLE=$(head -n1 .git/reftable/tables.list) &&
>> +			mv ".git/reftable/$EXISTING_TABLE" ".git/reftable/$TABLE_NAME" &&
>> +			sed "s/${EXISTING_TABLE}/${TABLE_NAME}/g" .git/reftable/tables.list > tables.list &&
>> +			mv tables.list .git/reftable/tables.list &&
>> +
>> +			git refs verify 2>err &&
>> +			cat >expect <<-EOF &&
>> +			warning: ${TABLE_NAME}: badReftableTableName: invalid reftable table name
>> +			EOF
>> +			test_cmp expect err
>> +		)
>> +	'
>> +done
>> +
>> +test_done
>
> Nit: we don't have any test that verifies that `git refs verify` doesn't
> complain with a well-formed stack.

The above test does run `git refs verify` on the repository before
modifying the 'tables.list' file. Do you mean a stack with > 1 tables? I
think that would be worthwhile. Let me do that.

>
> Other than that this series looks good to me, thanks! I think we might
> want to have one final reroll, but once that's out I think this should
> be ready to be merged down.
>
> Patrick

Really appreciate the quick and thorough reviews.

Thanks,
Karthik

--000000000000506c1706407c44d0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 38ac2a5cafd17128_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qanNJTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM1hKREFDQWFxRkE3UWNqRUthUWZmbXRYQUQ2RU1XdApWODV5djFhNVht
NmsxQlBPeXd3eWFTenFxRmZ5ODU4eGdwZHJGVXhHaWJHZ1lNbE04ODhsOEFUbUtZN2RjbG9ICmVq
SEdxS1hwblY5TlpYRUUxUjlobnVadUhIMU9TaWUzN1NNOWk5cmxrT1pLNnkxYjcwNTcvSFVKTXpZ
MmNRblgKTWhGc0lJVTZpVGFLQjl3dGtDbFpSTys2aVFySXpuQnNDR1dMY09ZODVPQ3BBZjdOSjRP
Q3hKWTY2dTZBbmZzQwpTMzBxOVJPVHpUbDNrajdIa0hsNXNXdFB2cFNYcWdxZXFIaFByamc3TG1T
NGt5d2Y2Z1NsVW5YSzN3QlBLL1QrCmVwUTY1NW5XNHhjUzhyR2doT1BjSFlMZjcwOERKZmRqRzVl
QlJ4V2RMYmxISVBwY1NpL1BtVTRpbi9GOUd2RkcKOUVmMVhNelAxUjJMZGNIT3luc3R5djJ1Q3JC
MzdRZmVYMlZlUTR5VzNGRFJFTnMyVDROdlEyY2Yva2ExRWxURgpReWJMSmdhU3loRnBoekU2ODhI
Kzc4SnVqNFBnZXFQYkk3Z1YvRXpleGR3U3BVd0dtL1kwMDFYOGw2aTJ0V0hDCjBOUW5seVh1bnM2
SmhtajhISzlFdm1YQ3hJNzhVOURmRXJ2V0JrND0KPWs0TmkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000506c1706407c44d0--
