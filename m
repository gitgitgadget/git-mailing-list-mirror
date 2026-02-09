Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5ED1378814
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 12:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770641606; cv=pass; b=m4aSc58fQoS9+btSEl7BDkwRqfBU9PVaarQ/d8ze3BSxG6d/CLU5vp4ZrRnI3/VTn+rqhy4AEOHbiyWtAIyYzfi22Jp0Qu+SPAlfBC1qvxhMku1r9HLvqsBnEGoBK0MI8omORrVXH1StpdnhDPcycDw6dzd91H1pGvzqSMHwhtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770641606; c=relaxed/simple;
	bh=CjFerk0TFnvItNAxIiPJF/W6u3JQYXTZcpIZ70u5lwA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ASGkHbZ1rkEF3JlX1WnhUVbMiPMX7i22WdUXBbfvlYS2u8IBHTREju0MhLceWX0kASqUIUwfuTNV+3WpZBOEUWznQ3WDWL7RedR68Tt6hYy7F1QMwUBMpOiG9aJAWtTfz1kmoloJb0Dckm+s5UN5/RRoyBNTY+DdjLUJBua6bSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZKUGY2b1; arc=pass smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKUGY2b1"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5636b2fde95so954851e0c.1
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 04:53:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770641605; cv=none;
        d=google.com; s=arc-20240605;
        b=dyxX9XBq/45J2hsKdCpxgP7UlKyr382Fwwk0rGvYBMgmophJ+h62MTWFevK921y+O3
         LYsiUaJJ9qtSRVpkuR4R7y2gRiMWty3UPpQHSSQgyOYhKuflr2rjaF+BTqLT9cv7yMAe
         mRy1rfMw/I67ebvqFMacDCNpfx1w3NEzAD2lXi/RdtSPRiWVXiNkekraeonik9Rg2bLw
         x2AY7OkWgjJkBiiZbr3GPetwtFtvuc2UgIse7NrQpDhcHNsdYBdsvPxoGVbxwR+jc4XJ
         I9Z4pFLp67t59IiMXXafTg393momTUH860imn4rscaQp+HOnS3x3669PsoUPslnIYeQY
         ITDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=UiFlof4DlJAb0mMt+QxqCFbWOkNkfoITqDqWSNBe0+k=;
        fh=BAAT8bCJLIlrBBeJp2AoJJoiiM/MhVeWVRRlpSQQL8M=;
        b=b6JJKb79ZD7cFl7CZut05qRKXPfVuNkkfxftXyel4ZL1KXIZGlgX/jWQeAMiZH6iNH
         HFO8GaJV9heX+2H1esyya6uqt05lH9Rp0ccqu1u629vFmxYIivxXt4q/T+oF1wlhCiNe
         irBBIqX2vlueg/sDhgLHHKtkLrVTOuzvvcfsJ6o8/pdG+iap/5deRKAEG+loXfDAgow9
         Ei4ybHZTPUpmOVP7y+CCELqStWkwIJxylY5p1sdzrIzeuYxVhMUTrsQT57buKnggaA60
         hyrnTEFj858nOyDLRanKER1NY1dJa6xQCJZP34ipza6PABrNtJ0UNcKPwde+3m6Uxl2l
         Q7hw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770641605; x=1771246405; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=UiFlof4DlJAb0mMt+QxqCFbWOkNkfoITqDqWSNBe0+k=;
        b=ZKUGY2b1w5UKuOAI5n0IiDUggnTO2HWuUQVWAgcSdeK30/bGuv+Enl85fROKFPrg37
         977QMxbvnqkKiw5cf6SHiPKdhH63iXD7AN7peyKJsGQeVyr4L3u/rFuuAUjJ4cXPiLWo
         Bk8kgr/TnER1aPSBl0N0wi57Gk0wiwhtqWHoQWwaqM7D/wBumE7R7AeM/FbLA6stAxcf
         nIzucdb1FiV/411oZknN1uLdDgayzuuWXQR0aRKVnkJeXYb+vLjkGEDfvrYytcnqG55j
         muGzEb9MG/DPUJlxOWXlNj+0boxJ8A3Qo/0vdjcpp+fomnNuxxGliTv5jqgy+kb4x3IU
         uTkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770641605; x=1771246405;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UiFlof4DlJAb0mMt+QxqCFbWOkNkfoITqDqWSNBe0+k=;
        b=GDuPM0PkEZ7Blxb9QnYrOCb9ZF2DYwKmELtg1Y+KnvX7AiucdVlOi72GoguTeT+p6Q
         kZ69YSKZ86Rkb7V6z6zdNWVa91Zk1vCUbnQMkzXSj3jNDtMdvELaAkmPZtv5b1NTek13
         P4vzOSeoY8FpCNOFQv6zTeKxwZmBWsOX78BPQ9fUCSSIEvz0Un5f1r12lj2xgzv/lmjz
         J77q4bWQeVqpIDIjRGrH42HVC6qH3fR1Xij9wtM9+V46IdXGGXq/zVLq+yFFyvmMzl6B
         IIEXkne/xym9mzNByZ4BsItBsOQvKgoRP44RUjKVoFMRNQDxUWkvbnBwr5tcVtnNHGmX
         to7g==
X-Gm-Message-State: AOJu0YwhcycDIzI6SFTTnnj2RKlRKjb1EqLVTf4HpI8xvLkwO18DAKEz
	PMH87qfxBFgQXRJ7n5OInFtcyT1wKicwreLaZv/QOM/GArkhiOQW3HgF8hp0BrfCFmcFHb8HLfE
	/pwBHNFv3o4Kj/jMrJ97RGicPTtWWB+o=
X-Gm-Gg: AZuq6aJL/7awO3kM0Pj2S5wPUDEoAkjDqkYSxlwJyB6OG7lHqEphHh9sLLbPUIFWcQ0
	aDIa589wQo+uIJvqffwnzBxiqXo+cMyAP+MQX6dkAXf1VpvSBE95sj/ITKE229174tHORVx0u7l
	wj6GBL1TLBXBhDA1JLpQg/PQ3sZJFZTRnUSXJwUOI5Xq5UGHrSNtJqOhbVEnpnnXtW6RzPTg+rO
	zfuHdxazkMdebQSdhFjLCiaMDyq0tA19uYUNyrVjjc3EN0j4TQ9LWYlMdFyyoZdbSBN1b7PLZbE
	PBLd7Cca0AwEAbJxuARZXb+Z7fNXMXAF0j/zns8C
X-Received: by 2002:a05:6122:4f94:b0:566:2711:d8ab with SMTP id
 71dfb90a1353d-56705ecb9e1mr2878544e0c.6.1770641604971; Mon, 09 Feb 2026
 04:53:24 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Feb 2026 04:53:24 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Feb 2026 04:53:24 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aYX7z_nUc4xJC8Qs@pks.im>
References: <20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com>
 <20260202-kn-alternate-ref-dir-v4-0-3b30430411e3@gmail.com> <aYX7z_nUc4xJC8Qs@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 9 Feb 2026 04:53:24 -0800
X-Gm-Features: AZwV_QgBMNSaMPS2usnVOAOAzFrp3BnJTwVPehSv20Lkx62x_qL3YKvt7oP07eA
Message-ID: <CAOLa=ZQVi+zFT7ru0tuEm3a-8wr0cAfB_L1F_wEv1+HCkgDxmg@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] refs: allow setting the reference directory
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Type: multipart/mixed; boundary="000000000000e3b3d8064a639f11"

--000000000000e3b3d8064a639f11
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Feb 02, 2026 at 01:26:29PM +0100, Karthik Nayak wrote:
>> Changes in v4:
>> - Mostly re-wrote the code to also support worktree. Now, the existing
>>   backends will store worktree references in 'ref_dir/worktrees/wt_id'
>>   and add corresponding stubs in 'git_dir/worktrees/wt_id'.
>> - We also support relative paths in the reference directories. These
>>   relative paths are resolved relative to the GIT_DIR.
>> - Link to v3: https://patch.msgid.link/20251201-kn-alternate-ref-dir-v3-0-c11b946bc2fa@gmail.com
>
> I've got some of comments, but almost all of them are just nits. I quite
> like the way this is shaping up.
>
> Thanks!
>
> Patrick

Thanks for the review. Appreciate it.

--000000000000e3b3d8064a639f11
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c8db9722591bb6f7_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tSjJNSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM1V0Qy85ME9DRkZ3eWx0dmU3YkcxTnBXSGdBMWZoYgo3Y0tnZVFPQThr
b1ppRkNwN0tuU2Zjc3lrWno5c3hONnM3OXRpN3JDOG0rVjZkUHFsYWlPNmV0Q2xnVlBtRmJOCjJv
VDZlenB6OVRFaWhhUU9pZ0VRb0VqbWMxaDh1Zk9xZGo3eHBjNnYxV1YvU3h1RmxEMlU4SVhUdDU2
TFp3QUQKN1NSUHVlcittQmQrR0pUbnY4ZWdlMWc3YVFmb1dQQlQxZmZqY2NZdTdlVjM1Q2NvSlBy
REp3anlqZ2x1NEJKOAp0ZG12V25WSVp6TkdtZjA5dnhVTkZvME9qaE9oK2hhVTBNalg4cFlUR3dq
NCthRmtWN242dU02Snh2RUpYZ2xNCi9jWmg3T3FXVUZ0TW9iTjVXOXpqN2pvUmV6NzgrbWZBT2hC
Q3prT2JRbDk2OVlNbzVtdGtaaTNpc0tmcHZkd2IKa1QyR2ZpOVNaWTZ6b1ZCNXRGWThISXVBQjgz
bUhSVmpubWxyWW5EZS9QZkw2d0NYTmUwVzFnVmw1UXVpMlJMeQpSUlVzdloxclFvblJYZFFLNDlL
bDMvYmVSOUVtQmdpMEJ4c0FET2xyTXNBMmlvcmJGTUpmSFYzK2V5M1dFRVFWCjAyUFdSSk9yU2hQ
S3VjaGxaSFE5NkpremVBUlY2a0IrQU9PWGtBbz0KPWlTRUgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000e3b3d8064a639f11--
