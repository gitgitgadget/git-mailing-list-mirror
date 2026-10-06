Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3E1388E5B
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 20:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791318451; cv=pass; b=InKwda3KGC5pOybNmInM1IbYcNR61FrMXHbvEs1TMKl2ZCz4ZWM44jM72MxKFPHQQ660KHqn1Jj2s5fgKjxxAE6wFOw4DXGqyWVnu355x/TVWk8/bYL8kz9RLoD74oGSabgj5AX0B+tFUjuJHyFLKBXbE5OtQsJQHrlnQbp1Mzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791318451; c=relaxed/simple;
	bh=GpbUWEzN0dPBZQ3FIUP/6bnuT5dg/h37e7CScQDGBow=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=nTA+mivm0h99wMur/35kR3RsYbo/ft1zuzhNmf0ZdXGExKHTN6nn9Gm1/2wAI7CvFFVrS2nKBfY7u74joF0vIzXjxrn3gWAW36i4xkb8EzEYcNHbdy3E0wsvTgBuFJFygIDIWf1o6cyTWqO3MeBRrQVYmDEcfrzYVGP2DivlLLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HxWO5oBy; arc=pass smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxWO5oBy"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-98076bb236eso537503241.0
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 13:27:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791318449; cv=none;
        d=google.com; s=arc-20260327;
        b=B70pEYX6PQ2e6B1gfMrdKIbLpBVRjpPP6EdZYypzJVgApShY6YioUWLXuJUjXePqhp
         esKkjhbrbi6gsmTl6jsfBb23L0KO4cgvsM1TaGyc7JnSjB1/vTpPtzli/6XfjFPtFkr/
         2rGH0/sNfyGKPjRci+2eHxfQUXOHcYvKO65ZCa/nuL6SPdBY5V1ESG4hEY2NE6rMcFi7
         DOFe/USCOKxqKHwauTRP13msH622MDnUhffjOle10K6xB75a80cEJCqXSE/JiYW41K7U
         ZAdM06bgFQvVLh0EBHYpxFjj+8uIjWvJUQ0yllFv8CSzVEatRs+6MsiV6F+gSbXIGTVA
         HEEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=GpbUWEzN0dPBZQ3FIUP/6bnuT5dg/h37e7CScQDGBow=;
        fh=jtgE51wPZMyrw4IlX8IzlnMZfRYUlqk9Z9x9bMB7qFY=;
        b=FTbivLpYjEgxRX/2So2GoUxtSHkZXzXYQ6Rt9G+5BlI7k5cuzbFH28ULS8ZpsnRFml
         Dutu/ot8LiqpKnmqICWxT7tet2u9pG/YoEPozKRC44/U1fO2D6RhXc8F6EC7P6H148PQ
         zukOv5vsaSWBHRo2LmzEAz1a6YRub9KJrJSyS50iJ/g/92OiXNE73sn/MU1s9SeJVvE0
         O0+PUK9Sbs1qKobj24SNfL+5OwqUeq989XYwkrqeoZgo7dmhzGnUKSnHEqUE+SyrPouD
         NyQyC8tPtDWxyMUd6Z7Xz26zxFN/kagHfNEl9uMi0k+Jwa1/DS58ottBq9mbLxA6FPlR
         S4Xg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791318449; x=1791923249; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GpbUWEzN0dPBZQ3FIUP/6bnuT5dg/h37e7CScQDGBow=;
        b=HxWO5oByIXKKa6ryH1xo9UCfk82Nm81udjS6WVcFMuHHQbdyRsf6lDvHemXuoA+Dis
         epLp8Z9VUn7eqzxjc5BUm5uxj0ZzFsTmuyPepXJiWJ4DdlaZreAlxJKbaWcrzyLzJNeE
         oNWKhN8mlsMI/r65HB5hyloGOTp7/0cI9NFjL5/kjqN9BwXuqT5ly8XSsz8LBfA+YTao
         eBrE1x6Em2q86iRkGxqBeIHe9vm0EFOl/qUHmJfPW34EvAWYzWu0W6HZaGmn/OMiieTp
         ddcCn8LgCDCLhTz4kcjnfU6QsxjuzFwN6XGYinL1h+s023tDxAcTYPlTzrd7Vv5OSq3j
         iOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791318449; x=1791923249;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GpbUWEzN0dPBZQ3FIUP/6bnuT5dg/h37e7CScQDGBow=;
        b=LDSX6n4VUFRPkwoXtPcIbw1mOq3Mtb0WSslKZl3BEGMGyGgiEU11EJJfKKCFmMmsKa
         1NGCK7buSXAUl2eK26OAWeEufR1qqlhpAPpVSO/53Pxu0VGCe7cer7h8WjgAv4CFrFew
         0JGT86bc3WEqzS8SsfgzRmHeQ80NEZ71pAx0pMhwLJado1p+8J80gQks8N4vQBrYR7T8
         QqTmDWfO12adr0+fs3HyQU7waMnmZoL2VrhcajJTmFUhpYmz+JNJIwj7ZVvnwN4ZXYA5
         QeyBIeWmyMD2R0QPlNLbIfxKZlrYiMjm4ByuKjgsfte6XR4swtW4yYOIsrR/MkgW1tnt
         FtsA==
X-Forwarded-Encrypted: i=1; AKwUvByhbKGdWwEk8XDvot8GX3IjsUnohgtqiVJDanuP3NmrKldicI9Mc3OcFn1dqW6xJXzr6EM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIXnoIKFvoG7ue/67YEE21NRL0ubcw2kO9ab6iFLbrPQJj0MhRN
	iJTHyKdnF/ARKqtjvpIusBuncIRpoHkP2goM3TTCzAc/iGLB5oR/pLRhZ0dkbAsHzi13b8RYyBM
	g5hVZAHHd0aL0Q7xmRfQzZTywL0v7tLs=
X-Gm-Gg: AYBFou2I65fR8UZHRSNMBcjtZ4ENBmp57b954HctcnMPFdfzSCrGXuic3VGR0LaBGek
	2NJ2tj1QOi4PRvcVBu1sLsaoF5XlSp7iWYn8x9xOkGFQnwMbfceyCa3+DDTm9ptLxvbWwPLgnRM
	ol9L6e46zWigdFA2QZMGdmeRhuxJwbqSeub84ZnM1NK76Oy9eVLT/YO6XKGGw9ENb0cZWxz0CMu
	oIGQtU2It9WZt2IIGJYSp1eMqW6iBbGZBPDUyuvPIDiXlt/9JupJeTnPO1GF/C/qhW6atHJpisG
	be+5YIqBupEluyuOjdd7aUyVzfF1lIoOcqKs140OWO5xoJVOleceHNmmefuRQ8BOLc1upGAyJXU
	jRJR1d//8SYdBcHyhQUSTuZ+9/vVHetkr8IkCikrBKg0O6A==
X-Received: by 2002:a05:6102:4414:b0:7a1:88cc:6787 with SMTP id
 ada2fe7eead31-7c879e06c23mr880882137.12.1791318448516; Tue, 06 Oct 2026
 13:27:28 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 6 Oct 2026 20:27:27 +0000
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 6 Oct 2026 20:27:27 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAOLa=ZT7tOCBtd3hHfXgkFaqgMgCt99HquD=hZ7WB0g3PbErKg@mail.gmail.com>
References: <20261002-pks-odb-move-alternates-v1-0-8a63507b88c4@pks.im>
 <20261002-pks-odb-move-alternates-v1-8-8a63507b88c4@pks.im> <CAOLa=ZT7tOCBtd3hHfXgkFaqgMgCt99HquD=hZ7WB0g3PbErKg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 6 Oct 2026 20:27:27 +0000
X-Gm-Features: AclHuK_InbLbeiQgVwSip9M1c8dVvPR1q7yRP1tQGeMTqFgciJBOFq5RgOytTlw
Message-ID: <CAOLa=ZSXdYjfX3Q=e9CTq6d7bLReZZD9QECUWYKqe3RJFttUCA@mail.gmail.com>
Subject: Re: [PATCH 08/13] tmp-objdir: manage quarantine as an object directory
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000d362aa065d31d3c2"

--000000000000d362aa065d31d3c2
Content-Type: text/plain; charset="UTF-8"

Karthik Nayak <karthik.188@gmail.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> When creating a quarantine directory via the "tmp-objdir" subsystem we
>> create a new "files" backend that new objects part of the transaction
>> can be written to. In a future commit though we'll move handling of
>> alternates into the "files" backend, and as part of that it will no
>> longer be possible for us to have multiple sources attached to a single
>> object database.
>
> I understand the moving of the alternates to the files source, I didn't
> grasp the need for removal of multiples sources from the object
> database. Wouldn't it hypothetically make sense to have different
> sources which use different strategies based on the type of objects?
>

I see this is explained further down in 12/13, so ignore this!

>> In a preceding commit, we have prepared the "files" backend to be able
>> to handle multiple object directories. We don't use that mechanism for
>> alternates yet, but will start doing so in a subsequent commit. But with
>> that infrastructure ready we can already migrate tmp-objdirs over to use
>> this new mechanism.
>>
>> Adapt the subsystem so we create a `struct odb_files_dir` instead of a
>> new "files" source.
>>
>> Signed-off-by: Patrick Steinhardt <ps@pks.im>
>
> [snip]
>
> The changes themselves look good to me!

--000000000000d362aa065d31d3c2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b783259cd85c4040_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yRldhMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md3ZTQy85L2ltZFRtWHIrUS8yajVBV0FoWC9mWEFFZQpYYlNwTjBKeWtO
UmhJeW5OUXpueW5HaGovemwzdzA4dTNnd2hQWThQYURmdlFKQndxUEpGWEx6YWh2N2cwSWRPCmtD
ekgybGU3WVZ5d2cxcjB5SERLRnJqaUpYWVUvZ0JqRHBUUXhia2NabFdNbW4rZGVtU0J3MmZYMkU2
SmNDaUYKUHdYUVhmSzc2ek1zeWQ4MlBqaSt0RTNqMmRueXVLZ1RTSDdiNkdsNFVTZkRzRFVkejJx
OHBtMkY1cHV0ODByNwp6bmU5S21ua0VhS1FDOHZwaFpSWEE3MmllOEhTQ055S2lyNHozY2pnQWNN
MjBmL0NWU0k0N08wa3E3RDZJVHk0ClhjL1orbm1lUXlLNHhKS09BSFZKOEJVU1NEcVY1VkE3cDQr
eURtRjNsMGxtNVlCV0IySmRlSll2clcxbSswZDgKd0JhcFAxRkMzSVJCaitIRERsaURDMnRBZXRt
elRmUDQzRkhwVjh3NGMzSE9lZk93U1Q5clVPUEFtbXZoZUF2NgpJNVF4ZjJhaWR3TGhIZUtRV2xn
ZENjclRKd1Nyd1pkMVNDSWdSRUFYbnk1N2w2cWFOUlpPbStIT0pPd3prRjNoCjdBNEZjMlFrMDBO
Zkhrc3JsVlhkc3FNU2lmZ1l0d3dLUzUraDZCMD0KPW9sVVgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000d362aa065d31d3c2--
