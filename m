Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95214523792
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 17:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912290; cv=pass; b=qoa0yotvpiCjKWZ2GokAlpylNb6VR2DefMpKB8FH7K4VKN5UmeB+94c0i1MktuvBVdMJcVf2E7Gg5ypa9sWfLYDGPt3dwuTfa5RTaO+w+iCNS3p5+T7aCAfjrL0Umg9zEPRNJC+3gEzJcUBYJsaoTio61Yg6WVexX2bTGOILKKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912290; c=relaxed/simple;
	bh=V98pN2IQC4SOQ/oQaUGeD9qaURCJ3lsUgG8vslTiAC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AlzXYGBOOHDv9TXOdQdPIe/+2VW9kuNQFRIU7QuSB9Fr4CsAdOUzFzbLuzhZV6gWLbHJNfaBaNguQ1ZhvKLYpt7ZYjec1GEmtcumPSyv67NLw0QHhWaFnTGaEspbmQBt7O22BmrtTQkU981lxj6GaNRq/oQvXe5xGydo7utLi1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfFqLXGp; arc=pass smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfFqLXGp"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-7cbc729b88fso481341137.3
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 10:24:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791912288; cv=none;
        d=google.com; s=arc-20260327;
        b=R0LXX/HtwsxXgvRrs56RKDcsds5UkoDs3R4nareuMBUdck98jrXfROjRdNRgAuHY61
         +JvclP+qmxu7s118BFXYfS/i+K7LPC+Mam1YBsKcELIkKY7sRWHL6Z0OhAjVrUbrlsIv
         jPE9sad3eXPHEZ/v9wTPJQ1jHbby//vrD2d+9TnKUJ/SdLL+Miu905ahH55L0mjUD8dL
         XMHI61c9q92sm1tyk4aXXU5xaYLBsNGil+5ADpujMTsQHQj/D9nmqEwEfuYHhA54/Hjg
         zLxbHzlDAJy1PnBNYjzvOv9nMda5am4sK6zvjOakC9VKgg1wPIWyq9eXtnP6oj2R7yP8
         8GqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=V98pN2IQC4SOQ/oQaUGeD9qaURCJ3lsUgG8vslTiAC0=;
        fh=VV3oqeA/wKg8E/MQlaee9LdKyybTp/4JbgI2GUt/VRg=;
        b=P0mmPRT0Rk4KqlbBudVa2IgHAq/2yThBCUu7ZIWDdOvny4LNkLnBQeNkmlS39TWNIq
         Wn4ECToHcZh43bM5WQxk2l19lCI7bWhqp4K8zwyKX3aQ4faKgBuuBy7j+VS+TVfj5wRi
         1Uiu/eZ2pnYXLcIy/2DNxVA6zgLL//CpDFwCUZJSGaG4dbX9hjoLqbADWsgnveWe55Nl
         AdeQTLCV3MPzkBf1lbHL6ckNmx0160bcSmlZcPSr6tgY1qJocGxw5DpirramPf+0eTLy
         FFnCgSdNGXMJvcxJwI7Kiz+W6+0xfvbsIVXR65OTYJK3ASRS6W4UnoMLKgl78ooxHymW
         H/Ow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791912288; x=1792517088; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V98pN2IQC4SOQ/oQaUGeD9qaURCJ3lsUgG8vslTiAC0=;
        b=HfFqLXGpEjzcPvDFcgHv70a/yXqQ90b7CSyUPZ+w3HF90Xbw5iGPbypb9Q1LzEygMP
         wNQFNZjQsbiRdu+On5mY/E7lesDVBBGtJU2rSOnBV1VOyDaFlVRM57oYNYJzzXFVohe1
         qSC+TsA2Ez4+/we36CunmHfF6tJTollJXc8ZA1seqzNKKV0+hVAAt2fsdRa+nOhcsSPR
         F2S2O8UpciXAq5EITFppuztZEjDTMUQ/rbpUR92xUxSrI5O07TjvfvhkCtIXAilBLi4B
         uhQn6oHQ27WL6o3b8b7l3h2DE7WckmlCcNCph2QTrIS44iQU0ZxfDsadYZoI6MxFZLh9
         mR1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791912288; x=1792517088;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=V98pN2IQC4SOQ/oQaUGeD9qaURCJ3lsUgG8vslTiAC0=;
        b=eVFYjlm53bSNu7IQLXCgTNUUPq/6PdWgXHM4rWoy+9ZGl1XqPKrHXFuFYgPhIARloc
         ftJKALDXiRWv5xmoCpfnlIF/va2sYcCdqwY8npbjH+3bGTHeCA9gL4SwFLF1B6Qr3+1h
         PRjs4tNAeKixPKSbi7gvdhAajWZaNAnWFzfnmgE9OJbFe6FgLfd5CMSxVpHLb25Af58Q
         7adMSHYYnBTP2PulCyS4PrDZfk9xSh5XdI3lJ1nzgHoRD8pNYBJmdc3b2CXrFAqevo5y
         7Wuza7P4mn+z7/qymZVtEiM0fOpz2lP8tbHdEwoMZBG5vbaTRJyfXZmm4zAad9BlM3IS
         IPOw==
X-Gm-Message-State: AFq9FYK9e7QzqiMqac+LTCR8bCAHB/jqo0PdrBJJbx8CZ8ngqyjz9lzU
	mlezKNhC9PB67j30mi4uGV+uqXV1gPjfyGrJko8GRiHL0UgeoZZ/DiVFeITLKjccBwTtkSkNOv6
	72sGQwKUxmhqtsyyiVLOPPvrChFfIunUsj6YvHNY=
X-Gm-Gg: AYBFou1sS2fp8Q2pNpFZ34ymRSzx8vgSeaWh2OkihG5VT5lrDtN/E2Bkdf0A0V/yuT6
	+sfJelDQI7QuwV2EllATxVFZMKQ5LzaX8++0JdCTguXASQHVpN4QBrdouq8/bxE9/HF1sn0xuRt
	bVdJj98PoPIwziOS5bNzBi0XfZS4VhS/E9V7nuKkCbVdvifzErNv9rYXBdKLnbICPa0M2B+xIUB
	OSJKRVMHymhmC1CROwSzZKT80E5LFy/VnT+S5mfDOtxa39hpFyz8EIIu9vyacch1QSF/Yy8v4Ud
	yclIaPF4Cg/HVTyM8aVmCZ6UhWh7T6ZZECJ0vNK6ml+brjym0AUg1FQDQVuPH9MA5phJ
X-Received: by 2002:a05:6102:5121:b0:7c3:6466:3155 with SMTP id
 ada2fe7eead31-7cb375fcf5cmr3197416137.33.1791912288317; Tue, 13 Oct 2026
 10:24:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANHmUQTa8tLpHjZZ=Fp0m=X5Tb+uFuCcRobX7x05gKamXAgrqQ@mail.gmail.com>
 <CAPSxiM_36hf1r33GQyEMEkCAs5yeEWr2J+gFfgk=rx_-DoTv3g@mail.gmail.com> <CAPSxiM9eQY8oQVnpiNRqXK8SNqSMy3YcDwkV07Mh1wJzb-n4fg@mail.gmail.com>
In-Reply-To: <CAPSxiM9eQY8oQVnpiNRqXK8SNqSMy3YcDwkV07Mh1wJzb-n4fg@mail.gmail.com>
From: Shashank S <shashu8660@gmail.com>
Date: Tue, 13 Oct 2026 22:54:37 +0530
X-Gm-Features: AclHuK8RAOuSon0XI8B0Y-Z5ydQwxsGFdzzWC3OWbMYVlwTWQ1v9ljday91HcZY
Message-ID: <CANHmUQTm_4b125eFAwvCkqnNEu386P=z_Fh4rMjuyh0kSshWoQ@mail.gmail.com>
Subject: Re: "[Outreachy]" Intent to work on t0081 : replacing basic shell
 test command to test_path_is_*
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Got it. I will make sure to CC the mentors when I submit the actual patch.

On Tue, 13 Oct 2026 at 19:35, Usman Akinyemi <usmanakinyemi202@gmail.com> wrote:
>
> > >
> > > I'm shashank s , an Outreachy applicant for December 2026 cohort.
> Next time, I will advise you to try to cc the mentors. So, they can
> see your patches.
> >
>
> Thanks.
