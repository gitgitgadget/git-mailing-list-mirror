Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A16A17A597
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 10:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723717194; cv=none; b=dhzyFm/fgPUMtmZ/j7sCX5K6B/GjdEk5l9CrrR8M+8rgtn/L3XzcdNiN9/rJ59/pmC9yi2OgVjR4xau4/YnnMdpgTtgNE5UFytqMXe2QqAOyJ28yRDSWt64ocXBifDreiZ/SlKNnVe7h0Xd/ynfivBRgKn7/zxeaS4SxdK3cJoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723717194; c=relaxed/simple;
	bh=bXH/+JRWIlmrLH7tVtBv2nkQb4FlpftPq5uM3OhUk9w=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JnmFmViJ2HN8uZX6HRAAT7GgfLg1NH4ojIL4t08rD21DIsPsEqgCzV8MiiGm7bAIluI4+THVHS3pijV1jVyykzfQdkT/ODA6Bvw+R7FsAgRnHuMFx4+JNDuEfB22bcO3MVGp4fXbDBuszXQsiFP3bepsB2Rz32aav/aNAP0WDv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQuYpHlI; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQuYpHlI"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3db23a6085aso379584b6e.1
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 03:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723717191; x=1724321991; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dtb0m5KivFufqph7LNv+afFX8sba1gJNyLLyrnNHXVc=;
        b=CQuYpHlIbfhZnD0cXyGHV9rxtEyBSKL8yegn9fwaMX8xoRMm03qWn5XBwlRbCNxQcM
         HAX6fjSxxkVW1I9F9ZPa9UmTR05kfEueMx+3NwrjyL79Tw0unF5wYn3vB7u//nAGuz4j
         lIK/R3F1P7fsWAodaYfp4SVaqwXSo/MJqU2r1/xSjkDWVPZdwL0saRPGq5rpmpG79yEg
         LrYbEphpwvcK5rFkHUbPDRNugNIjlSMQvsKBaz+G2X8CFVyXCOvtH07Hz2T8RabtqkQZ
         WGv8PeC9E5UNnpIHR4KvUk0G76GkpFhnQOcqKl1LiLWz/63xdWgayjn8VyDTPbYuv0z6
         Mlog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723717191; x=1724321991;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dtb0m5KivFufqph7LNv+afFX8sba1gJNyLLyrnNHXVc=;
        b=airZ44vKWw2ctLauW9/yG5dCxAZ+1czGSZypAeIuAAdB3siHCVDPZ9pwKZ+pZJyiyC
         Cl6tSe/M6isMXDug5sbYWtFpXjIomlpJsV908lnAklornAZB6Md96vXWfFU3BPpJsZUv
         b9/wJpNUBC6uupL60W+NyJErcTdMFtD7S5OFOppuwpr5ly07vPBtT1dVigv8PLnimQfB
         JAI255yK2cb1PPmwlkgz7c+8KbUJpcJEP6VwM2UbSyYfM5+hpdBfFJoyQBvryhNaR98Q
         ip7rKaODlH3TSwG6qVKiAtOxkW5GrHTqG72NwpBKGsjd/R54QWYwGgKH0dwURD7M2vpC
         JFnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPZQVreYRaOCBTPnqgMZmiJkBmeGjMDhPP9v3nVEPT23IogEhMf+oCLp9WA07Ep7A2Y+JG8j2a0q6e+fW8bw4UR5BN
X-Gm-Message-State: AOJu0YxHGsgyFrZ1E6JXkDaxqsYn+LstrYfDrcs1IzjrhU9cJpepK9De
	/l3HJ0JZVnu1y5u+Hx9xtgNhaPIpFkjpAeZiv2c3x+QpHR8TODs2+hTMFYnn35I2+yIBlT20aAd
	4P+Vnt1DiRaUMQVivfgpkQDQhl3g=
X-Google-Smtp-Source: AGHT+IHDGHU0JMaDPtuc1GPifgKVyE1IEcMPb+kqDTPe6HWuNZqG7Uy0w7I4LuEMYLXjx2SLL3o58cwXx3d0/CY5PO4=
X-Received: by 2002:a05:6808:3086:b0:3d9:2e62:7065 with SMTP id
 5614622812f47-3dd31679528mr992020b6e.1.1723717191399; Thu, 15 Aug 2024
 03:19:51 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Aug 2024 03:19:50 -0700
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <ZrtrT1CPI4YUf5db@ArchLinux>
References: <ZrtrT1CPI4YUf5db@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 15 Aug 2024 03:19:50 -0700
Message-ID: <CAOLa=ZQVkmyVWAxyjrEQoEJ+gKJoJjfFqsDvr_A15FHGX1w=rQ@mail.gmail.com>
Subject: Re: [RFC] Implement ref content consistency check
To: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: multipart/mixed; boundary="000000000000e323e2061fb62e39"

--000000000000e323e2061fb62e39
Content-Type: text/plain; charset="UTF-8"

shejialuo <shejialuo@gmail.com> writes:

> Hi All:
>
> We have already set up the infrastructure of the ref consistency.
> However, we have only add ref name check when establishing the
> infrastructure in below:
>
>   https://lore.kernel.org/git/ZrSqMmD-quQ18a9F@ArchLinux.localdomain/
>
> Actually, we already have a patch here which has already implemented the
> ref content consistency check. But during the review process, we have
> encountered some problems. The intention of this RFC is to make sure
> what content we should check and also to what extend.
>
> I conclude the following info:
>
> 1. For the regular ref which has a trailing garbage, we should warn the
> user. This is the most simplest situation, we could reply on
> "parse_loose_ref_content" to do this.
> 2. For the symref, we could also rely on "parse_loose_ref_content" to
> get the "pointee", and check the location of the "pointee", check the
> name of the "pointee" and the file type of the "pointee".
> 3. FOr the symbolic ref, we could follow the idea of 2.
>

Just to understand clearly, when you're talking about 'symbolic ref' you
are referring to symbolic links?

I ask because, as per our documentation in
'Documentation/git-symbolic-ref.txt':

  In the past, `.git/HEAD` was a symbolic link pointing at
  `refs/heads/master`.  When we wanted to switch to another branch, we
  did `ln -sf refs/heads/newbranch .git/HEAD`, and when we wanted to
  find out which branch we are on, we did `readlink .git/HEAD`. But
  symbolic links are not entirely portable, so they are now deprecated
  and symbolic refs (as described above) are used by default.

> But Patrick gives a question here:
>
>> In case the ref ends with a newline, should we check that the next
>> character is `\0`? Otherwise, it may contain multiple lines, which is
>> not allowed for a normal ref.
>>
>> Also, shouldn't the ref always end with a newline?
>
> For symref, I guess we have no spec here. From my experiments, a symref
> could have a newline or no newline, even multiple newlines. And also
> symref could have multiple spaces. But the following is a bad symref
>
>   ref: refs/heads/main garbage
>
> I think we should fully discuss what we should check here. Thus I will
> implement the code.
>

Agreed, in refs/files-backend.c:create_symref_lock, we write symrefs as
"ref: %s\n" so it makes sense to validate that there is nothing extra.

--000000000000e323e2061fb62e39
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: bed8d83a47bba0f8_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hOTFrSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNTBQQy85WE1RV3JQYTlkbUhSRWVzVk9zRkxlT2dEcgpxVE44R20rUGhx
ZUZJc2dsclVnUy9iNzNDTG1vQ0lGZm5HeUVpVmNhanlrSTBlV1JVMzRFVzZOeDlMQjdNMWdGCkxh
VEtvQkxaeGMxZzkzRVdoK2FYMkx3bzZLRG1PaWxmSTlJallPTU1ab0JrWG5JQzRCYXdtR29wWjda
ck9tVG4KbFVXU0hQZElpdUhlY1VzYzNsZS9BaUlhS2Z0bVBRRHdoVHE2RW0rZDJaVmhrWm8wK1pN
dkxvVU8rSkxFVXRUNApiUmVBUVFpamhFbm5lRk8xTVB6YmFLdXhLTGdTZkNnSmR6VTYraG5zaXBz
YmpVeS94a0tEOWVVUGtDL1oxVllrCm8zYWdQL1Q3SVFDb2lWNDg4V1RtMFZDNEMzQWVDSGhwUXlR
anFSRnR6ck56bC92MlluanM2NDNhK3hKQXV4WTYKM0p4U0VyTVBRSktjV0k1dGY2Y0RkeFBZMjFp
NmdnSmxXSSt2VVEycWNJQXBqcCtwSWlDK3JKVkpaTktqak1STwo5My8wMVYyUDREbysxM3Uxa283
REJDQXhMMTB3eFdqNmZLQmwra1VEK2VZWmh3T3hDQlRyVVhSVmlIeFF3bFhjClp1elhsem1FTzlQ
cmgwZnNsYkJoWDErbW5IMC93WTZkOTZ3ZXB3VT0KPWtDaTYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000e323e2061fb62e39--
