Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A1C499F27
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 22:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791585096; cv=pass; b=im9JrcBl1OjR9CgJ01liUW9mSkyIGygXOppM7KhzxzEvdqOQO8pw5ahpV/TWzHnlBri/dQODyOh6v1UH9JzwSz/Wiv1ljIB4pBHCjvd0EZLJTL7pFsRsIf8pzD+I8dUwyvzhVIvrU2rawkE8PKmoBwaDfhiOTsM1Ls5U0E0sCao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791585096; c=relaxed/simple;
	bh=CZqsdLAj5bgAolGeF5GS51YMt2PH22X9PxsHGBNOpJE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gqiUNPwOshl3PRRGFgZb+sieQbD2Z7NKwmSB6NLZbykhsWtp5cYuk5xTfoRE9eLAX0gfadJJvJOuwoFd28c62JJPZxjpJRpjCPs3fpgJzLQ211U9ixn6nmD0mcw5PWfVXtylnIYBGqT3Bas2keZf8lFDlqlfsEsroExMh4Onodo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4Jk22YQ; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4Jk22YQ"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-15943c9c005so288075c88.1
        for <git@vger.kernel.org>; Fri, 09 Oct 2026 15:31:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791585093; cv=none;
        d=google.com; s=arc-20260327;
        b=ICdzqmUGWqG/jd+gjewg2rsUDTiR1v8iC/IPrOVEnOO6C90z8XhUx6rmxenTmBbMNV
         x49o41bM6M/Ighb3bmNBtKJTQab1a6uk+zn3V06JV8RwY/bgJs+RKMsAAZ/gbAx/ti2W
         eJZj8cl6w/KhVHpL8xp+mMnxb0Ib613SDsrWEnYLKxmBv11XW2dqYE+OucgxbAtGafU3
         ikY9fzs9tM/Klz530wAbqYVb1c8AeFHlWdC7/Wj6LZi5BlZGFeKGDanJVJJVtA9Kg+mB
         go55MOsoA8zia9M8EbQ3DJu1Tmncy1bqNM6fJYg629gZXCW1Sn8FbObj0prLF3mf0bgt
         I6EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=It9rwYswnCMJk9Kxx9T0i+69+OcqMd849xY8BkUx5S0=;
        fh=2CapUlRxdfgtxOvNI63vJCeLHlyqqrQ0H6VoO0xt96E=;
        b=P9YIsf+GukT9pZbXy60T9M/SIPakKAAAZ/jvmmZLUbbvANJkv93/enxvhFr7rSKHud
         3KSw7J+yXkFv8UqDFpwvfP02bm6A7OIZigpuHIRfhV4p+8W5ugA8aDaGomCs95pAEdgF
         jcao1T9E+tiMWHeLq80NSfvDpDI4UAPSR0SEoSL0bJ/vXck8Mbgh5mAtOgEVhKI7uaE5
         bkiqvE0RXKWUvJa3lASd9Ze1dVuPQ56xpAhl9E9Zt4xHdZPQJRmKSjl6aRO1GfrGiuf1
         JtBl4xRnrdo9kQQCSKlE3g8R6udrStdpWBcfKEjlLmVwzYAYAlDHq8SWtqDtWWPQmj50
         3K3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791585093; x=1792189893; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=It9rwYswnCMJk9Kxx9T0i+69+OcqMd849xY8BkUx5S0=;
        b=H4Jk22YQ2wbOdjMq3fLxXUAL6Uhcyhd1wSMOOJp6HjS8NqeJt5DK7Zj0CRUbD67Xmr
         x+hmn5aeHxTN7khcjBVMRlfHcUed3O3h976L0tST3Mk0XRj2aWT50OJmxEexO24iO+so
         dER4U2eqK/rYuiv+N/NLQOfhEz8hyGlpoiH3KgzFpennOyV2pcVZ0xKP09JWzni4cgXE
         EGIgsxLFaYMIEGYQ4H1RDgC3ncPzknmYohh/mD0huwopIFpei1BfuR5BbdLhkDINf08S
         vzQM8EnL+AG17QWNT3BML3+EpSzi2nM8HmMFRPqA13lLnJ+RPSQS/6vBt+boJY+AZ3rZ
         zwDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791585093; x=1792189893;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=It9rwYswnCMJk9Kxx9T0i+69+OcqMd849xY8BkUx5S0=;
        b=JzXmK7dWqamb6RkWshRnTNwsA0rF1jSCujyhUsDDaZVj/0F+XhDdmna352HVfFiK1s
         ADbOt8dUp7oSBMlnKE2JdoJWpSmVQ8F2/UIrTYRsMUia5H8O8FFOaBhJAVkHhEVmmSr7
         grNu3wvW3CKxLD9ezcYZk4OeD0ODYBkz+ys7CTXvSrFxBfpg1B8KmCFOR1W1BmpS2Uz7
         OjwTEvhN9R/5xJ0Zw+16AIwO1bsEADhmL09OBT9Uvbe68/fAZ4t3UNrnIeMMHMv+S2pF
         5WWbJT01bBNi6K+X4lTrSIbyraCYJ3pA35ChVRLiNi3vKMPrAKTou8VROf6dvESm3w66
         CxsA==
X-Gm-Message-State: AFq9FYJKTSHWrQ5fZrR4sXJKAibqCTcqPQG/vjHkeOmSSQnmZqnQMeRJ
	YrM4EPC6OYjDV/7c2Q/eRIBX8OJsUwNzwtNnV0fqX9pwWma+MudXfZBkq3jzO2hboY3dmjbEDky
	87WEh7edoyUpe7HQK2mXwK5bkBLqEwaGKzA==
X-Gm-Gg: AYBFou0TuO0hhNETne5vmWluSXLEuLcY6Omz5Ko+p059mnARyzqFxy6FDVCApAohycl
	jvuZ5mZ2rNZHgCyM6H3WBeFwtUq0L7Ob5kW61t97gy/O9/bcidbAMCJ4rJz+SXI3a2kCzuH6L6d
	qOtVNZCaIowHHeLUnH+wQXjjtgzjXfRJsHH7Nk02DZ/4Y4cFcp2Mb+vP9wI9DlaZhXPPJDWgKZK
	YohNehdFajbw4VpAwjSsJdcWXyBDcKVH3XXBxHcj2GapPzUeXYD0adiqsihHVKQQNcw/I7+QplW
	5pr18KX3OaKmFF/hbsdrxmaeuXTCzS7HoRbsbPh5tmTAfKpY5y9epqbY1F1LO7cDULPwqngAqnU
	i8+tcVKssvrrjTBd4WfSMyd+klz7HRwKrwElMTgYOvllWQQ==
X-Received: by 2002:a05:7022:b0cd:b0:15a:9834:73c9 with SMTP id
 a92af1059eb24-16a6506a0d5mr3695285c88.40.1791585093378; Fri, 09 Oct 2026
 15:31:33 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 9 Oct 2026 18:31:29 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 9 Oct 2026 18:31:29 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <asjPWXAO3Cwpkerk@pks.im>
References: <20261009-799-shallow-fetch-with-tags-v1-1-379d61504af5@gmail.com> <asjPWXAO3Cwpkerk@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 9 Oct 2026 18:31:29 -0400
X-Gm-Features: AclHuK97z9T5W3fLAqV90sYG0dfKH_DN-yVYO75bxksRykFsizFh5Mnyz9Xni-M
Message-ID: <CAOLa=ZTBFox1K2rxzYT1x+rvJpiYiXLnjqkvummh=J-CFWY0vA@mail.gmail.com>
Subject: Re: [PATCH] fetch: commit references fetched before backfilling tags
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, =?UTF-8?Q?Mitja_Bezen=C5=A1ek?= <mitja.bezensek@login5.org>
Content-Type: multipart/mixed; boundary="00000000000013ff6a065d6fe9d0"

--00000000000013ff6a065d6fe9d0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Patrick Steinhardt <ps@pks.im> writes:

[snip]

>> Fix this by committing the previous batched update and initiating a new
>> one for backfilling tags. Also add a test which captures this regression=
.
>>
>> While this does make it a little slower than master, due to creation of
>> two transactions, It is still faster than not using batched updates:
>>
>> Benchmark 1: fetch: many refs (refformat =3D reftable, refcount =3D 1000=
0, revision =3D 0e358de64a9e014575d11ef884bfc9beb931e37f~1)
>>   Time (mean =C2=B1 =CF=83):      1.468 s =C2=B1  0.041 s    [User: 0.83=
9 s, System: 0.587 s]
>>   Range (min =E2=80=A6 max):    1.427 s =E2=80=A6  1.558 s    10 runs
>>
>> Benchmark 2: fetch: many refs (refformat =3D reftable, refcount =3D 1000=
0, revision =3D HEAD)
>>   Time (mean =C2=B1 =CF=83):      84.4 ms =C2=B1   1.7 ms    [User: 60.9=
 ms, System: 25.8 ms]
>>   Range (min =E2=80=A6 max):    81.4 ms =E2=80=A6  88.6 ms    29 runs
>>
>> Summary
>>   fetch: many refs (refformat =3D reftable, refcount =3D 10000, revision=
 =3D HEAD) ran
>>    17.38 =C2=B1 0.61 times faster than fetch: many refs (refformat =3D r=
eftable, refcount =3D 10000, revision =3D 0e358de64a9e014575d11ef884bfc9beb=
931e37f~1)
>
> I was expecting to also see HEAD~ here to back up your claim that this
> is a bit slower than master.

I had it and removed it thinking it was too much information. Will add
it back in.

[snip]

>> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
>> index 300bd5396d..81865c1ecc 100755
>> --- a/t/t5510-fetch.sh
>> +++ b/t/t5510-fetch.sh
>> @@ -1942,6 +1942,23 @@ test_expect_success "backfill tags when providing=
 a refspec" '
>>  	test_cmp expect actual
>>  '
>>
>> +test_expect_success 'shallow fetch does not fetch objects again for tag=
s' '
>> +	test_when_finished rm -rf source target trace &&
>> +
>> +	git init source &&
>> +	test_commit_bulk -C source 10 &&
>> +	git -C source tag -a tag -m tag HEAD~2 &&
>> +	HEAD_OID=3D$(git -C source rev-parse HEAD) &&
>> +
>> +	git init target &&
>> +	git -C target remote add origin ../source &&
>> +	GIT_TEST_PROTOCOL_VERSION=3D2 GIT_TRACE_PACKET=3D$(pwd)/trace \
>> +		git -C target fetch --depth 5 origin &&
>> +
>> +	test $(grep -c "fetch> command=3Dfetch" trace) -gt 2 &&
>> +	test $(grep -c "fetch> have $HEAD_OID" trace) -eq 2
>> +'
>
> You don't really verify that we don't re-fetch objects, you only verify
> that we provide "have" lines to the remote side. Which is ultimately the
> same, but in a bit more of a roundabout way.
>
> Thanks!
>
> Patrick

Ah, that's what I wanted and realized the trace only says 'packfile'
without listing whats in it.

Now I realize I could just check the repo with `cat-file`. Let me do
that and clean this up.

--00000000000013ff6a065d6fe9d0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b7251cb281f424c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ySmF6OFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL1EwQy80eDNxZmVVTklMMzJiUGZkRUVWSGd0L09IZApTNDdCRHJPR1Bs
empOVjZkbHJOcXVyaGpiUHVuWm1NazB2V1gyVDlWU3N0cTJXdWxQK3ZLUHp3dXF2WlpFUVpsCldh
SEI1RFFreEZQT0wwUlZhY24xM0dLMlpDbVZqSEZPaTZhVzdQYlFNaDNqWGlDRzhic1k5TVpRanNw
NjRtL3MKeFdJa1BFVURyQVZvWDNMUlQrZy9lUVFRdHJXRkJFUURLSnFkRUw0WVdXUExWb3E5MC9t
cElXc05MOFFXZlA4bQptaFMxTldqZUUrcGZIeG1hWUxlTDVHNlBoUDRGSWt2Vnd6T0tpVkZQcGFj
SzdyWUh1ajFCZXhJTEtoYmRGdGg3CktnQit4TTBEZk5RQ29WUkZNNGQ3TUZiN09oU2JTYXd1Ykgv
am1DNSt5VXNoMW1hZHBoZzhydm93cml4YkJzSlEKTmR2NmNSdW1kUXVaS2phQW1DQU9HNDkwUldT
cWt6WVJkK1ZUR2k1TDZVZk9iZUJsY0FGK0xNQUFzSU9jK2FpdQpneTN0ZjVRbU1GWTNMNlloVFJZ
ZHJMOGdoSHRRUVQwS0QzOE5hczF6V0dDNUt3dUZOSHMzOEV2WEVHUXlRZmZsCmtEUnJtSTU0REo2
NDc1WFFYMVdtVnJjSjFCVU1NUlpKUFcxRlM3WT0KPXJWNDQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000013ff6a065d6fe9d0--
