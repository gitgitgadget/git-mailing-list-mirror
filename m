Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955DC3630B4
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 22:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772750545; cv=pass; b=dPysn2Sc4RhiJ49LraEajT/MxG6PFo+6hsp2IIudJgMyznoBvSiBp3GstwokyTiBuwj+7Y+dfGNbKKWNAPyrfjEfUXxCmzEw5h5Jgh16R/mOiBBx3G5bPcpUvpbVu3urm9Kwrq9RjWzPat2W0l8oUMEn4CkcjnRzKkveBQav1+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772750545; c=relaxed/simple;
	bh=9wAQa0ZbQEQe5lVtkdKE2JGOA/4LNGPL8GQ689M7jVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KnBQahHm4dIY7oJFdc/Y2+7CqtYSQiWYZZ6pt2vRxPeLC2ZZA7oHkKXuygd0ev+9YQa/RMcDtYQfys7PQ1tdMEhq1OL2TT8zOvz0f2hCe/xIPBW2+Byg3HdYpjl1eOdHqLrPYD82FDQfvCeR7/pyK/d9O99pIHR6mxnkGlfe7Sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RDeot2NB; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDeot2NB"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5069df1de6fso72334121cf.3
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 14:42:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772750543; cv=none;
        d=google.com; s=arc-20240605;
        b=iUFRH7Wf26jB9FrwDs301rQt0YujeEzquM6BRIw57LcSlfTrB+t+IHduLD4hlsQZpT
         915LU9ri0LizY+X3sgX9LwUvWBqOmE9UuyH5sZVSVDNVVUFgFWrTWRlmzxDOnYjVXxBW
         TiXGV7QZ8sqjwFoYmIRLSoFASBKwbNhF008FGV5Q+iKmDi6uJmekhH4f/uQTTh2fIIa6
         k3qq70G26O/TfP2b4h/IUjEpBxCqO8R1Zz5ZJShAsQZv9st6vNpMskLUo695aFnCT1Ls
         DtCUjGz/pd1WGNGuVw4l48JAyRccri6KYZyrmAF+gvU3JTp7GPH4QlknwEmV+KC01agv
         g9lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=X/PCf7tqNR5nxj+vhYKuaFwbKoIGRs76esjpcJ8tz74=;
        fh=DrFh3ZY4JSGpCRrI66Zn0C89tZda5/LKlaa3dRUi0m8=;
        b=WegQ+FyHnkh5/VYs489pWINbNzvvGAY2f2tPak4ZL7jbaQD7DjtqhlnMaqrjuQg4dE
         5Jg2AMaurqHYz92flcYW6QBf4touL2i4C3D2RIwrK2tXvIK5QTtsGyi/pqXsdg8AtWA9
         k5RjuHzcAYADog1RCc1IO39Fy9JOYm2wjZx/kSgttZefj/JaYNbtfj9YdBxtAYxo9hxl
         GaUDrbwHmlAdReH6VT+LKay7SFCCFwjW3yHySCln4dF8oMmytOf9Br74JeBX0GGEe5XE
         UjOixKw3XnJXijimmtwgHnPF4rG08M9iB0i8BZpXvyNf7GiSGCYbgRV2Eq9PJHdk3kUg
         P5Lg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772750543; x=1773355343; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X/PCf7tqNR5nxj+vhYKuaFwbKoIGRs76esjpcJ8tz74=;
        b=RDeot2NBOwNkiuCYWorS3bCjova+7m7WKJwHg8NRnqVLayLjT9VH+8g2t/lsru+6IP
         JyRRVJW7PeSrfINcZ6/Gw9ppLF5u1kKm/gfDyfXNZ29BzfOKbTX3lPJy+7fnY6Q4YgvO
         IVi1SR2hcnVoicAQFxzjS/5t1ZQb0RCEMdtRegp9ttTjreKaiTbe9Fmk/wMBWRmXJsXP
         T+QHhNPglkwkThaTxtI7btaubHiUQKSkJyWdKe9QOaogs/9Zdd/1IWPKzLZxRBgR1wXc
         D2w3Jiem3tqNhzEmRy7nvhb+8acF9ElRFxS1axTItVd4rgB3xDGIKrXOS2seObWRD2mU
         AhSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772750543; x=1773355343;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/PCf7tqNR5nxj+vhYKuaFwbKoIGRs76esjpcJ8tz74=;
        b=ammm1pPzgd0/fgtQybJOJv7KoypPFUXFDTfld02ypBw6DfNlnfg0dJBEge5ZwsBvfr
         wviJpswzlrvKTlVCmN/V2p3MGwBogbxAjhL3VsvM/aW2KRajb321tpVDHEUKwKvakubA
         q8urqOBdadq3YYUMlC0gCrhjhrciZ+1MoTqKs6kPWX2nrgFw7DvdZFz/qYq7cPsY9xBS
         ybBhXaoHNErWo5PkbCLGZ6BtvSnJR5nSS6BphBKBeCXoGhvvHQVjTNN2EXC363R+m51w
         AktrLyHxV9R2Ade2uWJXexytw6IubQrr3rNnVNzL3FOpogslhZ16aITky759F0TnBsyY
         8KOA==
X-Forwarded-Encrypted: i=1; AJvYcCVIyahI2lR8a/5uEA9eT6X95YXwYakRb8m8pYb02sdUJiNvNhEjJ9dDZSkn2bDwtcG3Omc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFSwc8BiGaNOQljFK1wo47Bak8AaxUreqRYEX9tI2TKeHfiV8E
	ddGPbW6DDDLJZp+YGMo9iO2CmNT6/r/zwH/bwerhz9xnV/fCq+tpb7/V5041EKIwVztpTY/max1
	eO6UrADL6BYDCQss1LoXiYWHTIjvFFw==
X-Gm-Gg: ATEYQzy6bFVW97+sBVVeBnLm98Xc2JKMWiSTu+DvnSASs1vW1JO8hGHRrlpVVSBgYex
	H06jYBMwOJCXI8ALXEVTFllzByK3ImjGK+vjDQB5BMDBsa2MzO49+nPFaP/DFxpkXYHd3zh52fx
	QNx0mx8xFyfqfsYpYDiZIEJDWlIgeiThnlOBc90UaKyIQwRewYMazRgeIUBQr87efmQ69x0eW91
	gKgxEeo8TBgmgGX7bVwVSvYWST4jHIXe0RK5gU1Hq3v/VVNLApY6/NTpvFr+0DlKPEUIcDR5ZYA
	2RKfHu8DUTtaB/7NAuRekchHpQtDeKnoyupf
X-Received: by 2002:a05:622a:1649:b0:503:2f21:6355 with SMTP id
 d75a77b69052e-508f492c8efmr800601cf.34.1772750543580; Thu, 05 Mar 2026
 14:42:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPig+cTHyB2sbBOELPb2=B5sU69OzSPU0JVn0p=2qMp=0=8vEg@mail.gmail.com>
 <20260305090602.22436-1-francescopaparatto@gmail.com> <xmqq5x7a3x9w.fsf@gitster.g>
In-Reply-To: <xmqq5x7a3x9w.fsf@gitster.g>
From: Francesco Paparatto <francescopaparatto@gmail.com>
Date: Thu, 5 Mar 2026 23:42:12 +0100
X-Gm-Features: AaiRm533gVp9taLaweigG0XnWfBoE1BHNPBXr4_sIdJWjTfgdlUQpVZ4p0hua4Y
Message-ID: <CAEaT9_-h2MEshMHoyoW9kWQgt_EfQJXcxWSn+cXTSL4mKME=5w@mail.gmail.com>
Subject: Re: [PATCH v2] t3310: avoid hiding failures from rev-parse in command substitutions
To: Junio C Hamano <gitster@pobox.com>
Cc: sunshine@sunshineco.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Hmph, did I suggest this?  I know Eric had comments on a previous
> round, and the improvements in this patch seems to be influenced a
> lot stronger by his input than whatever I may have said.

Sorry about the Suggested-by line. I added it because of your earlier
comment here:

    https://public-inbox.org/git/xmqqv7fioueg.fsf@gitster.g/

but you're right that the concrete changes in this version were mostly
influenced by Eric's review, so I'll drop that trailer.

> On top of what commit is this patch designed to apply?

This patch is based on top of:

    b3ec5aec2367262f464a33d6eab7a9f49fd413f1
    ("t3310: replace test -f/-d with test_path_is_file/test_path_is_dir")

I'll reroll and send a v3 of the patch shortly.

Thanks,
Francesco
