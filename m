Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C5E39A06A
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 11:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791287831; cv=pass; b=eoA71peLE/YVGaIZUFG64WGqX+sgEy6zWAjRuv66CW4AaVJtPXesKpenDtdYwXLP/oDTNfEH//yz0sOk4l8h+vXDOzwPIt+Ucvcunm1rkFEuBx6d83bUkhs43ldu2xP+vDYtYuoDd875pAvDun5ICbFoR73fUr34C9XgXJXGncc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791287831; c=relaxed/simple;
	bh=IuHp9xILHBISk/CbPfPnuBe8nTiVSs61L/HHDUz1QFw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d+GRgvOE1x0Q8l1fsO7pZ06vodNDAYzG41KJPox1d61ZTi1saD3X1vsfc5AzoXITLKR0mnBNcW1JYIzHPFjrYiYcj5bmtBMHGWBQke/n4fK75NCxCWoqo371mq88iZ7BPGx0WdlZML446vC6+cpZ2D+EUzCCV1JnjmhLRSkjavs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=beSWMJXr; arc=pass smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="beSWMJXr"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5cdb9cb8019so1241008e0c.2
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 04:57:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791287828; cv=none;
        d=google.com; s=arc-20260327;
        b=aihpCf5VXsMK5zRmLMnFEN2+PeKg/u+CCs/QCLy51eRwMezxNvunl7qlmRcEn4hd0j
         ZHC2uP9Rv1CftEtd51CXbOfCEkW4XP/i0bUWLhFrSjfobWZ5ZkVOF5IPFE0Lyt/x+0IU
         XZEXX1JJ00yXXo8DQDmmz2XMrgaB1TjlEkUm4SPsApFCxpmpKbp87AishLDWTOtje4CV
         LpcTf0vW6hwPXrX+yhlMZWkbPJlCDp2w812wLCOhsxDZV5OOHGxtjW5/qzpWP/dGoDq+
         gSSAEmpvy0oUmcO6xcfPx5FWri0a+7cfEazJ49xWOT+6bJrzPUBcAlUonwFWumlysyzF
         wE6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=IuHp9xILHBISk/CbPfPnuBe8nTiVSs61L/HHDUz1QFw=;
        fh=4hRD6dug9K2dA8/Qy44rHfFMnlFofhUgf7dxeZXl9E8=;
        b=frLQ+YWBMX7sFEvppH8uhfd8mAF1HW8EsDjlqPpMP3caajplrqFOU7LsqvCRYZnSLI
         aToRBM0308NGhAT7hWT9EhjuNyj+8rombr/O7wLSkbLeDkISgIF3qjFfSgnGoQFE5R1/
         YZfYVbcErW7PIZBvG+QlxfoS8xjcVWgRZVNoLUetRDZstCpvVIdX/oN92eGWAyO6OAdV
         tw2HnbaEvJnwGOpqPgYLG3447VN7TB3FsEXD5lipQU+b6DwiRiUwLX40n7c5b0VG1ikG
         bK0YMR1mFRQtJU5y1pd4SALMFWOBvvvksZyCCb6VePm8wyckE7DEiJ7UxQaUi5C/uAWy
         FT/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791287828; x=1791892628; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IuHp9xILHBISk/CbPfPnuBe8nTiVSs61L/HHDUz1QFw=;
        b=beSWMJXrHFgDrxGMa5dhN2Rc0gXSCT9/iW/sElflS1VMu11DlgRY+Ida196WuuOB05
         QEUm7D+bBtOL8DWRooFkNnzZJiHuj+jBz2XgNoCGPWyrkljBEe+4hu7BJhMbqK1+PMJU
         sJs3XhBTZriW76/7DRZXR+uXGwxgKPn5NainmclKp5rQA1zGYtkvPHXrpOm1k224Xzdi
         WSuXSNLmu52zglAQEs+ojEBKagt/J0ctRPWye831929WrghDzobgrFFjz1op6twVP72t
         CTBS2ZUaRX9z4LoSI15MslUbMTfGtnEntA5vp9qocKRfHgNtCa4TVjCgYw9WoEicG+H/
         tCsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791287828; x=1791892628;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IuHp9xILHBISk/CbPfPnuBe8nTiVSs61L/HHDUz1QFw=;
        b=QiqzCtNNrB87cjA+33qBEkWKMfXPHI1mbXoeLhYt+7klFPNZY0MxeLaROL4LhzeNog
         twKLLvs0KtoK5any8yFbLKZexa3RK7gF9z+c1x+ZhsP7IDGmEk+mAyhC9U05LQD4r6h7
         IiiTIyVPyW6kqEclD9T6ceJeFGgUUYh+wR9t2/o0ikNouZdyuER4ZRUHgR3kBygPJFTv
         ihLNxZl9K40x8wXys5Efkcfsq6v6FyEEVzB56PeauMIUvIJq7CTTzeljW6Hx9XBfzAoA
         GEaC3BtN/fl63yL01o/3sZk7YFaGjA61XtLwg7bEwSOrGWR0MzFrUMwyqyipZpBhSlPV
         fBlA==
X-Gm-Message-State: AFq9FYKaErhfeS2NDPHEkktzZCPkvf3e6ZwM8x8PqsUFZg+NTp1bm1xm
	F7CqF7DJ10LmV/oWuyniQACMlmpgwrj2ChR6K4jIC0a9ZH9VOpzXegFjAq0YP2zF4c1mgFtRfpD
	hvLpMeMWrL+jk1xm5OaDQ3BMUYjyC+T6sIA==
X-Gm-Gg: AYBFou3B9+swx3PpCoW+lzce2WXtcjoIvgMYbKoC19IcUPFmkBe9Q+bpyHifS3hiKyV
	MQP8qoP9U+G7xYNWwR9gfZfk3e7OpwFbN/KOFVFaVjXVttuCWj2WoV/BVVGG6T1/jcMgpY0LZFA
	0v1TwZSbCH2oE1k9OvHR6LI4ECCpC+QwwT/KDE09HQ3+NAD35diyQzhqAP+libuVrwp9lNfcakh
	vuyc/j/mSwmQWcMZ8TbTDPJuJVjh3uoeFgLOo/YACzBmXUxQmEtbkX4GPQ2jWq+K22x4xpQmgMu
	GgMwQEJxsfjnJyaRH6w3B7mkZW4YZlYiNF+oUUMz+Rkx0vjIbukgu4GKaeIpQP1l+sIgEZ1pVHL
	V/Jj8XqBmmTdjZB8hYd7tVAegC7DihJfafIwF6ttg2nvH5w==
X-Received: by 2002:a05:6102:3713:b0:7c3:6caf:bdc6 with SMTP id
 ada2fe7eead31-7c36cafc094mr2169609137.21.1791287828176; Tue, 06 Oct 2026
 04:57:08 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 6 Oct 2026 04:57:06 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 6 Oct 2026 04:57:06 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <asSM12B35oka08Nu@pks.im>
References: <20261005-pks-repo-ref-storage-format-v1-1-819a181572a9@pks.im>
 <CAOLa=ZTNNY_XuixqZ96TK0zFfDpWvxSupxVGOnH1VGXK4KF_0w@mail.gmail.com> <asSM12B35oka08Nu@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 6 Oct 2026 04:57:06 -0700
X-Gm-Features: AclHuK-JV5wjQ83Z-X1ImNOC9pdA79AMwOt9HTELQTuE8PPBX0M_kFrj28rpXzI
Message-ID: <CAOLa=ZTULXyr0+rdByroEjs1ncjjt3w66z7enOprJ=7gPY64JQ@mail.gmail.com>
Subject: Re: [PATCH] builtin/repo: rename "references.format" to "references.storageFormat"
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000b08dd9065d2ab263"

--000000000000b08dd9065d2ab263
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Oct 05, 2026 at 03:11:19PM +0000, Karthik Nayak wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>>
>> > As part of 2f28db44d5 (Merge branch 'ps/ref-storage-format', 2026-10-01)
>> > we have adapt all sites that used to say "reference format" to instead
>> > say "reference storage format".
>> >
>> > One missed spot though was in git-repo(1), where we still print the
>> > "references.format" key. Fix that oversight by renaming the key to
>> > "references.storageFormat".
>>
>> The patch looks good, but this does break backward compatibility. But
>> since the command it marked as experimental, this should be okay.
>
> Right, I should've probably mentioned this as part of the commit
> message. We could for a while carry both keys of course. But given that
> it's marked as experimental I think it's okay to break the format and
> drop the old key.
>
> Thanks!
>
> Patrick

Yeah, all good, no need to iterate just for that I think.

--000000000000b08dd9065d2ab263
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 58d71dbe366105a5_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yRTRnNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM01LQy85WXZZbmdsK1NJUWRseHZONVB2bm5TUGFodgoyTGJsK1B5OE9p
OVB5L1prWUdOY2VGRWlyVEdydXUvYXpBaTZ3ZG41eC80VnFGYzQyQS82VFh0aWxYTG1idjRpClNC
SC95aVhlL1NXZlROekJ0R3ZYY0krUjZQWUZmdVdqVElmMElUOXdvUWl0NzZ1ZHhDNDJ1QlErUUly
eEhYcEgKNFJlUGpUbjY3RG5vNjdYbC9PTytLRUppQWFlU1FvbGZNT2hCTEEyZ3JwMVhjU05hQjZ2
aTVIZWkyM3BKVWZHNQptcWdtT21VNThLN2lEQzN4dEliRWV3eUppRVM5aGVycXlRK2dLK0pnSzBa
NzNCS2NIbXN6b0FOSUhjVGU5djJMCktVVmxYV0VpS2tqSS80RDhOSjZlTmJzOXJURGZhSmJXSXg1
SkJXRnJqd0E0UjhJU0Q0UXRDWUlPelArQUJMMWkKaVh1WGJyU2NOcDNYbE9yQ3p3TzhGRTBKYXdV
dmV5SEJDejIrM2k1YVJFTnBIOEl1a3drZXR6VVZDaHYrZnhFWgpOWGc2SEZHQU5HdXJJZnhIaktS
SmdmLzVDN3JNR3lOWmlCaWZZZVoyNnVFY1RIZE5QTkhSSWhBVFlXZ0hQSTBYCmlJdE9jSnlBaXNp
clFSMHlxaEJNMUJ5WmVQa0M4L1BFckwzbUtNdz0KPWVqQkIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000b08dd9065d2ab263--
