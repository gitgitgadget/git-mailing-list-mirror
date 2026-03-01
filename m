Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E13028690
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 15:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772379279; cv=pass; b=sNaBN39YOzHp7c4e63kVFXz7PDakOMnQlKlUoE8c4Kf3RqA3gDdaORCZkNNFVW4vTQv9f/VFUlAP5uxfDQ0q5e+H/6ZEWbbxO0fduweqJKnDFNQcPIMqRUKUETMKqtYuZPg7O7ZoLLZhaNeYZmTJpPnb5g2sa+br+1PZeSHa0MU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772379279; c=relaxed/simple;
	bh=GgBpO1IGZoWxWX0EMwfzwtRCFtDBOO0xmcAbbSp3pIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XtnbEkhg/2oj/DtSMpIlN/SS3BsL6qCMj3DPipTeMI11QwhVNLTR4mI2R7qg+IrqdJauxzmj/YRWgUu3sM+XD+fATfMM2wthtCr9AWxmlI2GA8Z3ZJ5CySA0I8U5r/vnlwjxdBz/UvU4kyby5o7XZ9XlTbYS2Uj9qgcBNu0hSzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/rptxS2; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/rptxS2"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-797ab169454so33310507b3.3
        for <git@vger.kernel.org>; Sun, 01 Mar 2026 07:34:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772379277; cv=none;
        d=google.com; s=arc-20240605;
        b=K/inRUDN6z7qBHrXxyfrMvIdXDS4IR99qahf4qJdENKVfbFzvS/wJ6V67RFjRQPCpr
         erBS9SIrSdQ07zJAJJ38eDobDf5rrOKcr9QdItX0P2V/0m9Of4sWJAGEJwX1nZJ1Ij7Z
         Dsh/43tu7yhp9QnTr/P09ZbTqN125puR8PAQXNlhVhPmeVymfdctp3ldAq5DmFPKjMkF
         TRP5n2CxACnKoocywZRh5Xp+P2TCr8oajZ9VzErPF0jTqsaWsWqyKzPxUg6V+n3puPYt
         L3yycFYk4RGgE8vgV0PrLM77I3depQ+vPkYIWUW5weeBMNwmtfLBXBFj6oVVCuORRSjo
         NVaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PDj2l0U9rX8lKZiy1F5GA/xpxAjm/AExQb3nG3fViT4=;
        fh=hrjQYOLZnIyC6V3MOSSDBqRkT//BjJ+4fP6i3hldr8Q=;
        b=k5l+fBdk4QC1zYhOPJMgm6xPz9MD+EQVQ61Zhq7h/RhSBF0NV/PMBJI1ny25g3DPtk
         ab1ka2rX3JeAtv72+Pkld2Zb0GksSqCP62TbXbv3OiTYDCGR53Fs3sen9vXaPjLF4d67
         nf7DoKRoOlTAqLORieNS8btjrIMV38J78lGGmZ7s9oC97pPfboJBxwFdI1OOxvZp4FGW
         u94BPzQzv0FUb4vbkw8Tot/C3pLEUIUNB4AIxUd5PDLz/4yN38pkPJcVJ3DSAQD6sf4U
         LVRYFcFr5dfD/lK5OZOOpo6pJX7k+YBUV2A7+9Ht/JK43G6fLOlYYor5B/WqJiVUN6dc
         4RUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772379277; x=1772984077; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PDj2l0U9rX8lKZiy1F5GA/xpxAjm/AExQb3nG3fViT4=;
        b=e/rptxS2L4rs6qrIGsRUnZb6pVpXTOFT5z4st9AJL2ALiryWLO4xlxj+UMmF/dbUMS
         /5ogLNRG1IUOBUoYeIzBfqnvyLPrejS0DGhAZ1mtKm/Omea0czXTOXJlK6CBGRZnQ1NA
         3ysLOk6z0JDjoZEHCJPb6fGcb1R2uimOGavFxYKLECf0qq0jJtto6dWCjFQwqiOiKoZn
         NJxvL1c3/BNicDY2J24viNda+3+8J+jyMmkCoP0LK7jbYgZdMTxhtRVGQkD76jydhtf1
         g9zpUONqkrQzhrst6qP1S3aCVd7dXL6iAho+0sqbhNsQs0/iVZvIwtSVIUU36UsWjOHb
         vMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772379277; x=1772984077;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDj2l0U9rX8lKZiy1F5GA/xpxAjm/AExQb3nG3fViT4=;
        b=Hw64mCa5Nvg22LzwFaGKqjy54X5NFQKQhw3F3PpNOCgClh0DPz1zd41WMMYA11kBt+
         uoU8ZvC/xhwEG1DC9i6UknH9x/zH9yb/57j5wcXs1jSsvI+5UrKTGLUb0vR6K/ItnXni
         zAkrShtXqVmYgJh5f+TnEWBj8C0eE3+NbddNXslzm+dslbRel876L7iqrg/G7/MyeLtV
         7UO7TxSzlIEnsB0Kr4GALw0/g1J2R17vI3pAmVbKLgvtqIheDHr2tkFOlEqVxqVjqnaw
         UYo5Bz0tEP6zKB7Ku6Y0HFuRogzufsp8j5nj9x3/pVx/yCmnENgroB9j6aqOiB/uF5ss
         2xaQ==
X-Gm-Message-State: AOJu0YwK419c0bYiD6y8OAQ8xPnDArPYNZiS5p7Btq16J6bV1biZwcnp
	3PsYikn2n78qZsQH1zW2rYHsFyO22agowPEjh+H7KgV4V71yPzUzt8XWeQX++Z4yEJMhzzMod6w
	IsvSP0IMb9tN7QVScT0yudZP+wazhacA=
X-Gm-Gg: ATEYQzzH+Dcx38weaBhxUxXg1vfKbGOsKyALYkTnZXd2P/pSJTxNLq23GUvZBQpsLfA
	ZFyC0/z0D/vRF/AoaEnykYXfybHOQWNwsVYouGfw9h+zGyV6mwxOv3HjtdKEBumpDZBhW7vkYv2
	A+0Zdd+SsRRrGvxTp84+/sd+QbJ3iUH+eZoBT/iPcJBJICHqERsxGrzTH2W9mfmwD3yOu2d+f21
	P2eFV5UQfqJnZYba++sdjtNCet5BX3pLl2gmkR6NAjZ/cEuRu7igLyxDTCXS/XDN++/l/Q6koj4
	RstIiuEw7K6senuAPE661tUSAM96aSriZL10u8U=
X-Received: by 2002:a05:690c:7207:b0:794:e839:ad75 with SMTP id
 00721157ae682-798855d3bcdmr89138057b3.42.1772379277197; Sun, 01 Mar 2026
 07:34:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPvEtrfYtEvsxbsD2Q378R3e84DwHPPCSgaa1pQugrwchj9h8g@mail.gmail.com>
 <735eb76e-44a9-4f79-b769-23a3a07437ae@gmail.com>
In-Reply-To: <735eb76e-44a9-4f79-b769-23a3a07437ae@gmail.com>
From: Amisha Chhajed <amishhhaaaa@gmail.com>
Date: Sun, 1 Mar 2026 21:04:25 +0530
X-Gm-Features: AaiRm53D9NJEt5tPBB0LzNzmZaUo_vXTMbtV9RMws0vx0-1sZ2Gyxu1JUZLoLgE
Message-ID: <CAPvEtrd=tJ_QuAvyTm2cdmTevwn_Cwv0tQjVpaUzRS6dxggqJw@mail.gmail.com>
Subject: Re: [GSOC] Discuss and Introduction: Improve disk space recovery for
 partial clones
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org, karthik nayak <karthik.188@gmail.com>, 
	"jltobler@gmail.com" <jltobler@gmail.com>, Siddharth Asthana <siddharthasthana31@gmail.com>, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, christian.couder@gmail.com
Content-Type: text/plain; charset="UTF-8"

> I think this is a noble goal. Removing blobs that you don't expect to
> need again would be valuable.

Thank you!

> I think you will have a larger impact if you focus on _old_ blobs that
> were maybe necessary for a previous checkout of an old commit but the
> paths have been updated in more recent checkouts so those blobs are
> unlikely to be needed again other than for history queries.

Thank you for the insight!

> You should keep in mind that some tools automatically populate stale
> data (such as VS Code running 'git blame' in the background of every
> open file) and so you want to consider how any decision you make here
> may lead to _increased_ resource usage by redownloading data you
> removed.
>
> These are just things to think about. It's an interesting space to
> help users save disk.

I thought about making the command user-driven, which is when the user
wants to free up space they can run something like 'git evict
--older-than=30.days'
or 'git evict --outside-cone' and such similar commands, that way they
can remove
exactly what they intend to remove in case of commits and blobs.
I would love to hear opinions on if the command would look better like this or
automatic like git maintenance, like a background task.

Thank you again, I really appreciate it.
-- 
Thanks,
Amisha
