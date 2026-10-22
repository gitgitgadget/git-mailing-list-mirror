Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792673981;
	b=IVOLaNTiHLwJzpk3HV+yenaPJoKkbW+D1/kgO18FnmaqADYjwJtiTfwyKk0Wd293sA9u
	 ryYC4zafJ9bvweEJVeoJG4D0Kx3Exnz5gkFR2JvCKfAKAZpMzUk74VUjXK0kBjdPbSYZB
	 /bt2PCZ+6a2enRiWAwJAMBrPkl9oLw2NO5wkRmOfruHdMcJKNPsCNoAhNvLUEFXqMQQun
	 +iAvKAy/3yof9pnadIRRG5GNsMX/m34DqxviqJjrYI9IcnGIJTbwg8JGwJ+PBrKxDcqf4
	 r45j6Ru2OOw/4zctrQ2rMioyOBqIz5x09AZ1a6WT0IvxLbCRJI/+YLgH907YZEZFBNw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792673981;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=lK86BFcQ32/VvsgNxuKFvKBdMQltTYEIeKxalhOFohM=;
	b=M+pTpsZIjiHR6kdnNNJgsYHuJjadxIzLLJnGvtyhOzZqKiRZLSdO74iNbakcjsj5r1wa
	 4T+vDFw5Pc709ZI/4rOLG/BuiidTpxwVJZCT8TV82g3kpomGsKbAZm7htVhbXuzVaWfo1
	 AA2iQISRKQMK1B6MV6Q9WstekHo4F6Kz+sLg3WTcAYGR8byA53vjSQJXMo04uO1OEjnAB
	 8P0EWFszLykJIxorJcEou+BiELli9UDEqQZwQfe0wZ6CQIxRi0XbWYCdN2o9PtAmg87+f
	 U71uYtBkBzMP7CG0cVuzhwerFjSDppp3xYlLoSaAVVaXpeFAh8LrGB+wQcMpguIXG8A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IGzV3CTD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D98606A31A
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 12:59:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35D98606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IGzV3CTD
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ab752f6244so1427299a91.2
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 05:59:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792673980; cv=none;
        d=google.com; s=arc-20260327;
        b=FexDE3Q1tzoOLzcJHiH7X+VosBT6ADxIsBRzUOxx+yTSeUJ4Bxsw42tCXpdBuV7pg1
         8R7nd49wsuKvsjbW8t3KiRNUks3EBYJRXT1hLrcJ8akwDU++LYMaBoDjmqL2SeZb1/vY
         bSj71lP/NjHRYmuFcD/3ymiMbZey9XzcXR1pIIAdR7rQ9+ISGKW8gP6uOfoI4WT1239K
         WHDT8TSXTJLL6w52oVU/576VTaceXq5X63d3MjTXt8qZIGmpuW1FQJUCF6RnjFyNgGew
         Hp3JkeRhhLuGblJla5/rfAHeB3vlwn5KrtKlX4TMT5unoMav0P1Vmn/hcy2Fs4H7tbHK
         YPpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lK86BFcQ32/VvsgNxuKFvKBdMQltTYEIeKxalhOFohM=;
        fh=OXrnopiBLOS4qZx9exbteBMWlhav61Ygp11xop9DB9s=;
        b=O20Y73GfuENOE2TxyZIlxGN/+xZRAkNebnUG0aSI3kzPtEoiI7czKvP5cW8jjANvNf
         lNwWmGw9r8pV6QsDMQdSD9085UhfHM1ocZZY1UfEYcb/SiwBpvqph0R+NB2BKsGZ1d0b
         BsZTRCg/L45H7LIhwsBe/lv7nVJ1fHMdYwqKa7zZbdaGk4vbMzPj1SFz+KXmvB5dCVS7
         PvNbwl69px1//Ooy+24BHDALMk/KMsLQgSt7zq13qelRM25GQr/6Rig6CGLwBCrRU0fw
         Jt8fxAU2Gxb75wXQui+/pjMzu/BQv2bYYfI1GGkVyACiIV0gZ9Cm0uejxqDRfR9GxVJw
         WkTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792673980; x=1793278780; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lK86BFcQ32/VvsgNxuKFvKBdMQltTYEIeKxalhOFohM=;
        b=IGzV3CTDexuznqJNf5RRc/OW4hfwhMsXYRI4WprgQuJnEiET4am3+PFkxdCcP20lcV
         H1t5FG9g77PIw0bFdOpa5yK2CgSe2jZ3JXexU9RY0WsWPGtoypsvPqGGjpTSyglJ+CSk
         VXfMartprVj3mL43y4bewqi16bScWYpqp7Ec0u1+swFYDuliXRh4JFOeWGSKnctPoCVa
         jBHOOIT+VFTPoFymmJWbiYC4cenGDIS38fFTNv2zPk1HxpcpfjgCJJS02TcA6CXzuXyA
         VWKZHDhkM4nOpEicbVdhP34pbD2i+7+cyF1dYIRM1o36biUaNQ0Q/1hCysYLRwfYMMn3
         agzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792673980; x=1793278780;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lK86BFcQ32/VvsgNxuKFvKBdMQltTYEIeKxalhOFohM=;
        b=AcCqABrX7iQYayZUpUmk21OZ1dv3xof9p5gM/8picaX+kHmlm4syo6WOIB46h8itso
         xlVZL40UPs/YOuXMDd7N/AmuJk1yQQgY8EVAmGnkzMnLOlvoyebGyQb9i22ANiQAkBWY
         F2XQZ7TF+arB7SwnK0EbU5Q6H5r4e601zvPQeZmQlSc4xisL6qdhNQ3EScvKD7Vym3DU
         n8qeKa0oJDAXI9GYP+23Fc0PPVa8Mp49G9NUL75IL5kIrxPZ6MuxF/BrPdzBCNHBZTM0
         MVYmOVcLmfRvTQpdkgGYGz4oSdE7ljNHSxUkDGKIMFveBQzoYpw+VbmNitO4qdvAgjOU
         Of0w==
X-Gm-Message-State: AFq9FYKJ2oyB8GvJNtmkig2UX81DsJbA3gWUDUOTs75AVi5Whbm7WPe6
	09q7c8o/SdMd0ehKkvx4u2NIyAuimdJ4XTdkSZ/DnbbkF0Owutv+f2HQbmEtCUhKXfyA/LpS88m
	NcCiCXAF3IpNiw8Na2ljxCi8bS0zFFss=
X-Gm-Gg: AYBFou064ZYel9+bGDU4CvyiQ6JOtYdJL+JD15WbWkGIQMKUhpepmV0t/yA6kBkJZ8X
	lHlOIdXxjMq+MDwXZUk7k5J76ntp6qOqDc7HB77M4aF+q+R4hHtMvnfJZnhgIfgit2g9EG9fhzs
	/PwCA8tQ/cIlXMgTDhsPiyiGYvpHyxZqcOZW+KuEGYPTFAwEwnh8ZPZAxO2w3xIi3DhxQslHeb7
	8FErmeIRkt19+ZUpZRYy+hyCEcOJP0fim/w2m6fIO+3dcfWBzQ+u0X3iGV+TAMR3Ldv9+L46eJX
	tqSgsoyCBMjqMqxTAFo9xN5P7gIkuHnEKEAHZSf25vvMTonojraCgzqRe5WkjKdzlLcsfN2bVLQ
	lhMEqEgJ+pfjcVV1pXYBIAFgxNqJsqoeu/64yrzYOGuvuB06+GDjgszXMK+czqMJ5AVbSzrriut
	WLzJnEqww+2jQ2F1bo0+hhlXp1kxm4I9h/6q1yd28EFT7mTHrjclvCUGvyvhUhlilijA==
X-Received: by 2002:a17:90b:2710:b0:3ac:ffb8:183b with SMTP id
 98e67ed59e1d1-3ad8708f0bbmr4076111a91.51.1792673980525; Thu, 22 Oct 2026
 05:59:40 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com> <pull.2425.v3.git.git.1792585717.gitgitgadget@gmail.com>
In-Reply-To: <pull.2425.v3.git.git.1792585717.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 22 Oct 2026 08:59:28 -0400
X-Gm-Features: AclHuK94JLzmO3M_37_Qbri7psmr1fIMKLUUNmeO2qJ_mtCAtD4K91B1CmUmgt8
Message-ID: <CALnO6CCpjhGoc+MOikVqtfRr2CJV-ayuLGZhEmwLXHEGML7yAw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] branch: let --delete-merged find squash merged branches
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	Jasper Mayone <me@jaspermayone.com>, Harald Nordgren <haraldnordgren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 8:28=E2=80=AFAM Harald Nordgren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> Branches merged on GitHub with "Squash and merge" or "Rebase and merge" a=
re
> never deleted by git branch --delete-merged, because their tips are not
> reachable from the upstream. This treats such a branch as merged when som=
e
> upstream commit contains all of its changes, and names that commit in the
> output:
>
> Deleted branch topic (was 1a2b3c4, landed as 9f8e7d6).
>
>
> This series finds the first upstream commit since the fork point that has
> the branch's version of every file the branch changed, comparing only obj=
ect
> ids. With --squashed, a file that upstream also changed counts when mergi=
ng
> the branch's version into upstream's leaves it unchanged. Timed on my clo=
ne
> with 65 branches, this takes 0.5s.

> Harald Nordgren (3):
>   branch: move the deleteMerged opt-out check into a helper
>   branch: let --delete-merged find rebase merged branches
>   branch: add --squashed to find squash merged branches

I hope you'll have a moment to consider my reply in
<https://lore.kernel.org/git/CALnO6CAsCvJRywkw0WpO1nEhL+yU2-r_4Z2AHdJch1m=
=3DNK8=3DTA@mail.gmail.com/T/#m5244d4a2781578b3058c4cef272a2014291ab85e>
wrt the CLI. Perhaps a modifier in --delete-merged's value would be
better than another --option that modifies how it behaves?
