Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3E438382
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 18:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745348174; cv=none; b=FF1J49hB1VCsGjQAEHk9Iey6Rix1ls7uH6qfk0Xlhi+N0nFjftwSf4sfXcdF2NwxLb43ZWxVwbMf/TnrtN+lp1xhfpX68NsJx/Kj+Scex3ZvhyHpbvVJPV0etRsjZFpyQt2XCBQsX+FogWr+2Qprc3iXt9LtoLzEI//gofWVtgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745348174; c=relaxed/simple;
	bh=CwaAaalf7tQ39Q7EBVMgLn2CQYF3cYm5aZoUyAUPSIA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AjMa5mlo4WuLOypf+Ir4yz+FVkxPzcAqc7pDNA+43S5S/fPTW5wBjxLLyEKAITJ4O0Eogj50i5rbny2yzsjAFqSa4ijGronKHN+YRg7EHw/adp5eM/XIUs5EJp02owhDAftVZbZQ0RB1Pnot7Gw8bDzEcdBL+/HuS4BIZLQ/wr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+MRF6KD; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+MRF6KD"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5240b014f47so2125202e0c.1
        for <git@vger.kernel.org>; Tue, 22 Apr 2025 11:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745348172; x=1745952972; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LUFNZfMdSWHVyq0PhkQTU/6dpChmFpKwvHp2+7NfawA=;
        b=O+MRF6KDScbWDOBJrl5voe1MjpegTs3c/cpTLp/MnPQRR4d9GccLkqqIGlLUFQrqId
         GJDAja1N7CUzPQsBMOXwXwacpq9OX27XzIKGiJ9jEMWCGk3CsYUVfLP2cuhE3hQQg4sO
         4PcqfaEkU2+B7OG6gwR2SNw6XsFDtGrpZiwG9DBaTPR1yzYNdxdQRhUMv0TaX3ctvm0f
         0Lb1KQKuvr+Rv+t5wM3d9icW4T+nwvlxyJ7Ae15lShLBKSBTsYJMjylR8EV0Btv3vu5S
         OCreQD8PeE4iTYZCmO3F+4J4ldjR+8buPSpPsoAJXN4WvDgtXxfxCwYOlBmQDwwUKzc5
         kwiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745348172; x=1745952972;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LUFNZfMdSWHVyq0PhkQTU/6dpChmFpKwvHp2+7NfawA=;
        b=iJirHgxjGKDsrG/HsRoTABRIDNhVkZElPccOeVYV/yKHJvBDjIsg9qVjl9KlODT83U
         YdtkxCXr2G6GfOJOT822wAUJF/A2JpzdaX4U+89D3yGJhgqANt0eJ3xwXcYB2FXLTyeC
         HIG31mN0L7S8rCV0ax/yZEzdG7S36AQd6rfM3IJYmqP1oXQZ6ZoPINSqXK4AK+OTaIue
         4vhZfP10GCbOX41VglRzjojoGzadshiqjhjjBd4Fl5w5XZfq65kFb5Dl9Uxhttx7pwGc
         vY15auo5dIQuMEHNU37LthjsaL6Wv8EL2MYcicSZ4J+oi+8EMgsjNxanNJhI5tOwAfuy
         Na3A==
X-Gm-Message-State: AOJu0YwTIqMJiGYTkquoVvYRswtYRWrURuG2p9A4X1V5CrCt+67OW+6Y
	NqJAvuno6WxYpog2po+9udiMn5AGn5mDj9rY1X3icY0/OcoFZ7a01negfDPrvm1bdlmfJrzZG3s
	ibwyGKewx1+7AMBq99eM6yY9ZHO4=
X-Gm-Gg: ASbGncvWjJcafMcSe27Jj98SmpOFU0LnjYgCN2MIZ5gJ+uiSKQcHs9ItIXY3dqlx4fX
	nrAkG8xiGO+YQ78VhXZuLqQ4zxDBs6wfN5K2ffyiJSzNbYbFZPbc50O4SMIVY8qFcfYzVpXLicq
	yQxar8xAbpTFZbMREjLqBNRxUWdnksIikNaJ13WK6Nq4fj+QzbQNBc1rHs
X-Google-Smtp-Source: AGHT+IHG/Y7P2SN3gKi4IeBbOrGnu6fU/0LHP0BPVTBm9XYTsk1uBeh2q76zvAl0Vlfn8WhrYK+PHxYODmSqqa4cGWE=
X-Received: by 2002:a05:6102:298e:b0:4c4:dead:59a3 with SMTP id
 ada2fe7eead31-4cb800b75d1mr9984798137.2.1745348171681; Tue, 22 Apr 2025
 11:56:11 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Apr 2025 14:56:11 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Apr 2025 14:56:10 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <17c2eb4f-e291-4189-9846-0f42bdead01d@gmail.com>
References: <20250408-505-wire-up-sparse-via-meson-v1-0-17476e5cea3f@gmail.com>
 <20250420-505-wire-up-sparse-via-meson-v4-0-66e14134e822@gmail.com>
 <xmqqh62i6jli.fsf@gitster.g> <8b380da4-8d27-4efe-85fd-3bb599188fe9@gmail.com>
 <CAOLa=ZSR=7TEWLHa-wzBB4x+4+-BH3UC3G7s24Bc26JH63QKOA@mail.gmail.com> <17c2eb4f-e291-4189-9846-0f42bdead01d@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 22 Apr 2025 14:56:10 -0400
X-Gm-Features: ATxdqUGi1a5LQyAGkvGhii4LWXh3bJMPSOSh33aLhWvrFmCTAnoSZB6tNlqTPXE
Message-ID: <CAOLa=ZSi5FuhpaAiGn5OydLUXhkWC9VrkOvXKwTeP=9S2uhKgQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] meson: add corresponding target for Makefile's hdr-check
To: Phillip Wood <phillip.wood123@gmail.com>, phillip.wood@dunelm.org.uk, 
	Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, toon@iotcl.com, ps@pks.im
Content-Type: multipart/mixed; boundary="000000000000c877ff06336289fe"

--000000000000c877ff06336289fe
Content-Type: text/plain; charset="UTF-8"

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Karthik
>
> On 21/04/2025 16:33, Karthik Nayak wrote:
>
> Thanks for putting this together, I've left a couple of code comments below.
>
>>      Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>>
>> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
>> index 37541f3d10..a09fcf4d72 100644
>> --- a/.github/workflows/main.yml
>> +++ b/.github/workflows/main.yml
>> @@ -414,6 +414,16 @@ jobs:
>>       - name: prepare libc6 for actions
>>         if: matrix.vector.jobname == 'linux32'
>>         run: apt -q update && apt -q -y install libc6-amd64 lib64stdc++6
>> +    - name: install git in container
>> +      run: |
>> +        if [ -f /etc/alpine-release ]; then
>> +          apk update && apk add --no-cache git
>> +        elif [ -f /etc/almalinux-release ] || [ -f /etc/redhat-release ]; then
>> +           dnf -y install git
>> +        else
>> +          apt -q update && apt -q -y install git
>> +        fi
>> +        git config --global --add safe.directory "$GITHUB_WORKSPACE"
>
> I'd be tempted to check for which package manager to use by using
> `command -v`. That way the only distribution specific knowledge we need
> is the package manager and we don't have to worry about the names of the
> various release files in /etc.
>
> 	if command -v git
> 	then
> 		: nothing to do
> 	elif command -v apk
> 	then
> 		apk add git
> 	elif command -v dnf
> 	then
> 		dnf -y install git
> 	else
> 		apt-get -q -y install git
> 	fi
>
> The commands above omit anything that updates the package cache as we do
> that anyway in install-dependencies.sh and we only really care about
> getting some version of git installed here. It also uses apt-get to
> match what we do in install-dependencies.sh
>

Seems like this is a no-go, since apt-get fails [1] without first
updating the package cache. So I'm going to do that for all the
commands, which should also ensure that the package cache update in
'install-dependencies.sh' is mostly a no-op.

[1]: https://github.com/gitgitgadget/git/actions/runs/14598683520/job/40951070359?pr=1905

> I also wonder if we should ditch the checkout action and use something like
>
>      git clone --depth=1 --single-branch ${GITHUB_REF_NAME} \
> 	${GITHUB_SERVER_URL}/${GITHUB_REPOSITORY}.git
>
> so that we know we will be building from a git repository.
>
> Best Wishes
>
> Phillip

--000000000000c877ff06336289fe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d42408f847823e19_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1nSDVra1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOEpaQy85RW8waitET0ZDZEpmRzJGZjErcStnK2NCTQpIcVMyK01XVWZ6
QUhMQnhYSEtTVFVwYW5rcmFCNkZ3anNtUDZ0REhDSUROM0NnbmJQbkM0NlkyOWZzVVUzeVd4ClQ0
dnh1VldKdWZuaS9semlaWEN6RTZsWE4wSndxQXFXZDFIRDlFNUhZTnpJNUg2cFo1WklwRVhXMzJO
ZDNORG0KSXRSMjdLRVgzTXQzVENJU2NPdXJubTBMbzlhTUVZbC9SbmVScnc1OTBTejhjZ2xrUkJM
QUNrbzR4eVdMZm5QdApCTTNMR1FxT3Y3Skl1Q2p1UGhpM1o2MTVsZ0YrTE55ZEVrRnVPNElzbGVp
Ymp5TUxuT05XdFFmUlZCWUhKZTdjCk1jVzJGeDN0SG1qaFhJMkk5NEU0SkVzU2tsamkva1llWW5H
VC9JZW83enc4K0VMd2dQc1RGVUlWdjhFNm9IdmgKcVBYcGp4R3ppRVJoMHVVWTRUbmc1L2FoTWxx
aThVWTcvOFFJZ3JBRmx0MmdodlorUk02ekI3MHM0OG5hKy80RgpOQ0dFVy9MUmRmd2ttQytZRnJh
b2Y0UmRVYmZjWUlIdVM1dGMvSWZTdzJBRUl2RTE4WEg3SGlDUFNtK0ZvZFFmCkE5S1orNDYwMmpD
YmZWdTVrM00zVTlTR0N5UjROQ3VjS3dDUzJBUT0KPVlIcGYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c877ff06336289fe--
