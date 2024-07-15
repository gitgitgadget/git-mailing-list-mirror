Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C571B15491
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 19:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721071883; cv=none; b=QdGhO43ydN7e7EiSx/jQVbH85rinKSkO48DVgxWbMPUeQmFnc1fA1pxETQL5vYhr8qVHzZvR6PR5pkJ+2wdk1WlWktw1s5FAgpWdasZ8+XIZUatSuRS7HqNcn1+inQKV79MQGJH3BALbgdwgkG5TQwiRGkPbZIczk4Xk0FTlpyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721071883; c=relaxed/simple;
	bh=plcYNW8s0NWH9xNYMsmad9I4G8k6feSyEnXo90fZ76A=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NnTZaMghkluGU4RcnIfqQme27OThkpGobehidOiB+AyaK8qx1pErsoFwvrXQQmlI/hNfN+TSdFcRhkjPq7E5s9JlM0fE42Orx3L6hXxcxievZB26AxUY+Vi/hdt719VEZQOlPR0DouVLmRvFvFjqUy2ZpZ3fXNAwOSp8nSlWaow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QtM7MmW1; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtM7MmW1"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5ce74defe42so1005137eaf.0
        for <git@vger.kernel.org>; Mon, 15 Jul 2024 12:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721071881; x=1721676681; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=aNdqkKuRFA0rEEBr329VGANuTx8/xi/eYo9aZAZf4Ws=;
        b=QtM7MmW1srVPuWRhikNQAMh1qpu4bWlhZzpzrPAeDYpyi2rXZzF6pgYboECKULRnxw
         /deyGrJfNcJijCCJpi0z1M5XguUY59FhUjNlCNRG6pXw9ruAnbjNsIxkPZhd3DD5WRTc
         GXbMUvoh8r5IOOgJe+NvSaDHsg4qajnup2M9xgP9sDxu8gwbzMpupE9SkYYBBKLOZwVE
         FUun64L+n0MXNJ/I47o9SkdVXFBow7M2CLnXA6zP5ClHihlz3w251uVCLDVy7vBqUN3r
         0QyqphWUPkykKkMWTlgxhv6AmJ2VdRkmbRYT3r07T/fzS1oHzA2Nm6g+rn0TPemJv3qy
         FcYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721071881; x=1721676681;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aNdqkKuRFA0rEEBr329VGANuTx8/xi/eYo9aZAZf4Ws=;
        b=Afls115p5HZIENa3kHebvgG+g1JA8JUbxXLUHl1HTlGD5XiXuc5g4M2XEX1pSfFasc
         gC3j2nte/kR9vdNxZZQnL3AehVd+6EQQOqrvb52Hrn7Pr2reL9jLTmUl9wqQ3Ia7R6Xh
         snZNFsX13QAxsmR3PY4eBa5uGeo/di8JQNyaT2d+ZWHd4RxVZo+jUYuyvK+Jd81M5aqB
         QmSaZU+DjFWiF12PD6cNX1nuzNMeT/RK7bYaX6g4iEyR9tvDOPlXf0ODwzxHLte6iPV2
         loaPDC+ujY7AbDLubmrhUrMIZJqkErZGjk7vhn69b31d15LWwcOV3xaY7mgatacVo540
         1Xxg==
X-Forwarded-Encrypted: i=1; AJvYcCWawyp5OKVcs91f5RbYPolVeJUujoond5dsXWpeGj5nbXU8zAOlYWw2erzwQJtAqdXzPe+Jz0iqL5Jt+eQ7viV2shbI
X-Gm-Message-State: AOJu0Yz2KUi9VCKUcFf+naBDZnQWNUKhfhzuMN9iYwSWnVuJHtpHXA2Q
	jL26mxvT3XaMp6jEd7e4LVdQdE1zD4EkkWnQNAg9acPZMxMKPJmHEV/6SdahM6z+9habfCJ3KCV
	1Ct7Wym5+pmiO9C7ws0K0TMbRsgtzc+3O
X-Google-Smtp-Source: AGHT+IE/bxoPQSijDhGneBTaHzLpUbObHrmfVOhN1YuP3jfatoT55HhuMsGF+oFvgifngTNqzxYm3HYqCuqt6LGdAl4=
X-Received: by 2002:a05:6870:fba9:b0:25e:b8c2:8367 with SMTP id
 586e51a60fabf-25eb8c29bd9mr16075377fac.11.1721071880758; Mon, 15 Jul 2024
 12:31:20 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Jul 2024 12:31:19 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqle224npf.fsf@gitster.g>
References: <20240711083043.1732288-1-karthik.188@gmail.com>
 <20240713134518.773053-1-karthik.188@gmail.com> <20240713134518.773053-9-karthik.188@gmail.com>
 <xmqqa5ilcngi.fsf@gitster.g> <CAOLa=ZTkYs_Wz2YM82Nm0yPJX8-hYV3WC-aMEqYNRoS+2ZpG3A@mail.gmail.com>
 <cccf899d-12c4-4046-a958-33374bb870c6@ramsayjones.plus.com>
 <CAOLa=ZQfhD21Anzd3wWwWcxji7tJydaiD7mrhReH5zLQdXBWng@mail.gmail.com>
 <xmqq7cdm90h7.fsf@gitster.g> <CAOLa=ZTjHKX3EMbVu1_bjdDez=3aODZQYY4npKrCY-7ZRXN1hQ@mail.gmail.com>
 <xmqqle224npf.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 15 Jul 2024 12:31:19 -0700
Message-ID: <CAOLa=ZQx4UKMfq7q2GMV6nYQGKeCj0dW_P4kG7yDTcdo--1HHQ@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] ci/style-check: add `RemoveBracesLLVM` to '.clang-format'
To: Junio C Hamano <gitster@pobox.com>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, chriscool@tuxfamily.org, 
	git@vger.kernel.org, jltobler@gmail.com, phillip.wood123@gmail.com
Content-Type: multipart/mixed; boundary="0000000000001600df061d4e46f5"

--0000000000001600df061d4e46f5
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Ah right. Let me summarise:
>> - Method 1: Inject the extra config to '.clang-format' in the CI's job.
>> This is the current method.
>> - Method 2: Create '.clang-format-ci' to use in the CI
>>   - Method 2.a: The new file contains '.clang-format' + CI specific
>>   rules.
>>   - Method 2.b: The new file simply contains the new rules and we inject
>>   the rest in the CI's job.
>>
>> I'd say methods '1' and '2.b' are similar, since they modify the tree on
>> the CI. So no real benefit of one over the other, no?
>
> Sorry, but I am not sure what you are trying to say, especially with
> 2.a and 2.b, your assumption on "the new file".  Is it tracked?
>

Yes. I was referring to a tracked file.

> Try running "git describe --dirty" and see if the command can tell
> the difference.  If you smudge .clang-format, which is a tracked
> file, it will be noticed.
>
> But you can use a temporary file and use --style=file:/... to point
> at it.  The temporary file can be an untracked and ignored file,
> just like any *.o files we would create during a build.  Then "git
> describe --dirty" would not complain that you are making the working
> tree dirty.
>
> The temporary file does not even have to be inside our working tree.

I feel stupid now. I completely didn't think of this and this solves
everything. Thanks for being explicit here. The temporary file
absolutely doesn't have to be in our working tree.

> If we know we can write into /tmp/clang-format-rules file, then the
> CI script can do something like
>
> 	{
> 		cat .clang-format
> 		echo echo "RemoveBracesLLVM: true"
> 	} >/tmp/clang-format-rules
> 	git clang-format --style=file:/tmp/clang-format-rules \
> 		 --diff --extensions c,h "$baseCommit"
>
> right?  Then "git status" would even say "there is no untracked
> cruft" (although I do not know we *need* to keep the working tree
> that clean, without untracked cruft).

Yes this is the best solution.

--0000000000001600df061d4e46f5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 86e357794c374386_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hVmVRWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNldlQy93TG1iYk82NVNXUjE4c2lDVlNsQ0xwTzFWWQprOXVnZzVDMk4x
OXU4OFR4L3IveEoxbFFkYVlUOUQ0eFJFOG55M1NNR1I2Ry9wdDJCeFA5NjkrelJpTFdmYXlWCmk3
cWhDNXNteWFocGNhNVJNcis3VGtZRTVCU2pYYm5zRk9WUC9ZbExWeWwyQXpPV3VBclZWTnR4Mmxp
dlU2d3UKektoNG1XMG5DQUVScVRqTmIyekxOeWFHODE5M20vZ0NhMnJkalBhcHNEUGcwaDZRUkZD
bGVsWEU4NTIyTE4yUQp0WHlLU1lXcWNtdkIyZ3htd053QlkyZXQ5OFNIdm9YQWxRYitnb0F1NVB0
WWRLZTJGV3cxTER0Q3BFTExYZ2daCkFFcStHblFUVldNQWFtNS96T3F6Mm5hNjBMWGU1cjUvS29l
dGlNN2YwQ0tPMkg1Q0VVdjhTekJjVzU3NFNVNG4KRlVNQmd0N2lnOUFHaFBmdVVjUE9EaVJlOC9u
QUEreVh6K1NYOVlQNDN3V1VrTWNRMUd5RzBOZjAwUDVtdTBBSApMbWlTSmVLRksxMWJ5MlVWUjU2
MWlicjBnRXZzeG51bThTR2xOb2hsTzFlODMzeTNSK0ltZTlPUXJYblBFc0k0CndrM3FEZllxd1dy
RTVYUFlYaFRrT2ZONlhCa3Q4dzhqMWdYZitVST0KPXlybzkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000001600df061d4e46f5--
