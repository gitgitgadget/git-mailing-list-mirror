Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04A539A06C
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 07:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789369940; cv=pass; b=t64xffG53LrUtZV2yexaQCz6OQQ+4c5tizxpIrWK4CUmrNl9SemHv1bDYA06dnvL7SjFIfMrSLf2Pcdsx7RU9r6gB1jmYKEmt3A6SbFXgtszXBQ6OvCy3Gv0B7ob+UadhB+FOq9WPITNM9XG2qUR55nNJ0ZFy0NitPdqzrboSoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789369940; c=relaxed/simple;
	bh=r4M7IWK90riSyqLUnA2n+FkD9UCrxTM6pKK3R+b3JD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IGnxq5SiXixkdSEoxdOY6bIvWLml98dU6OYc4pCxQdlYRI7c76G5ONR1AVk28L/9tp9WLM8NABlBEU1lTp1434gm0iLGYJfQHz7CaDtjRzEQq5UtZHW8KqUiU2H0aJqlOuk9hfxZiPh27RPCq5/tOcHH9nfiiyNFLkccAcflj+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com; spf=pass smtp.mailfrom=thomasbachem.com; dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b=BbeiC8hl; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b="BbeiC8hl"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-87f4e914a45so25530747b3.2
        for <git@vger.kernel.org>; Mon, 14 Sep 2026 00:12:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789369935; cv=none;
        d=google.com; s=arc-20260327;
        b=jRs0OTL92j491YgW1ID2h7zb41Mz34rCw9pKxFE1EiSQJneerbRBGxubp7tvzuY8TQ
         s0dB2uj97ajchFwqz8HAVOfzn7ZsQbMOIo31WhOzb8Y6tGHaQxd1eYynxdyh/U8nwkyq
         y4vCSeoFZo7Y95w+4M4cKUDJb6oP457PNhnb1O14b8QygHMdXHJvz9t5MAvmjbepVcYQ
         WJVypACSrDo1/+SF4xYXuX2iGZthufFhNEuDKDtWMBIPPdlQ5XBuQZLO1unIxGjyPYVm
         SEnARyzIRs0fNEROMJlgTU4GCUw9YO+eoqxj+yQKhtKWr+kGRIlohjzfaifYcj2Vqiuv
         kJaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=LWJ6BJdSwZxKhZ0kXGEDALFh1RD5K80ITzMYvd0HyTY=;
        fh=0futRCsuuruNF0YpbT0htzurjoYfr03ulKCYVbMNkHc=;
        b=ok9LGw0A47yZGt40xdIVnyTRdDQQ3mGcdTgcmeIeMtI8cqSKY7doI0IVkGhHHg0uoW
         pOODKuCJe39tZpMm6NRSIUXMz7gThflTwNHZ/UgwsDj2loTGj1g25790ZR1nFutKytMw
         s/p9PMzzY4Ms4rNIQaJhatg2VezGq0ydn/85taPh+V12cFmvu65N4Ys4yngMZtuptYzz
         WI3GoBNf8mVWlAv6rkZmzAWj+5vELfsGS9IgnchZB4y+yweqhNKUrMi6ZvS9v1RLJDiv
         /EphiTFRN3YLbUqbl36dcIEBpg3hsbDHgnmmrk540o2Uq0dbg+Do2jyvH/4ipA3a4ykY
         1/tA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thomasbachem.com; s=google; t=1789369935; x=1789974735; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LWJ6BJdSwZxKhZ0kXGEDALFh1RD5K80ITzMYvd0HyTY=;
        b=BbeiC8hlEZiNFMODA6ymvj9XQd7ngv2Wb3CRtfqTLAh8grUkWKPr30qXAh3k7yHjg2
         WCxBf8XLHN49mbZypMiDXJxBfGoQkyVzCUXveyE/tY/dGvRSCItDaM/zBoEr0m+zrq1F
         nyy4gQh52IZnO+xYyS/GmFvkVlaTqaTFoFmOULnVxutp2BvlRiTRcLb4T5I6+47p5v7E
         bL8OgQAgddwvyNkNnNTfz4TofroZ5NJZT4xxIXBNQzIxD3W0aQvnJbSlH9bly05w9M3H
         zlaAdRerW6Ulz9314jkUCm73/9IkB93hz9uDB9J6i0S4ojF1vxXgVcwSycm5gF3fQ1Zg
         W07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789369935; x=1789974735;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LWJ6BJdSwZxKhZ0kXGEDALFh1RD5K80ITzMYvd0HyTY=;
        b=Ij599b1bZryUxeALXqXqu9MXDq3hW6XxTqW5tqdNTpqWO9rqTznXFVXwS0IT5fgVOz
         GkUAZxgeOLR4FxDdYsyAZwyO06HZFtyAUyFr1+m3iIwn3TnhzAmCuhGf3+AysK7G8LLL
         rDI1CdfaxuxAaldLfQGL21uTDxuV2flAyDLumpmR5WpYHbd+s45FHb5YqNrYfuYoaLU/
         8gQ+sXldCbmfmT76YdXDGSgjapqEjkDvC18jh2IKuHsettqdp6TbDY6/yuZZLec1mz/u
         dX2HQcSel2RuikhLN+00p38WBtDC4cmCq43MeJkjYO6AUyCkvVme2dqEFxJ25CSx5QRq
         UU4g==
X-Gm-Message-State: AFuF++lbbHx/vfYoQmWLktDoCzFYg3n7etRUrW7dnYkt0UOjaD1EhPL4
	zNefCwcbXgaZhEU5kBcRppy7ZOM9woKEkpIm7TnaY928MfvnPUkChwTC/QnlcBwnGdiKjLc6D8B
	IlfyOxZqjUB8bBjqq17ZITAFx8tdQRX5wroVmSN8S4Q==
X-Gm-Gg: AYBFou1A8XyZNbEuOEX1038zgAC2kwbuBPOiLA+YKRgps5dKGJaZ/e5f0hg2EIiX5vh
	3gT/k/40XzFwRcfRVsQf53rMDM36lx9/QvEe+Z6C/wM11B8O1LE5P3XnppE7ANV33nfJ7h0WIaY
	9scco93l1hKgxNCXIf7DKP+eC5nwlhc8fmieO5XRdmv/c0iWqWjmSeUMuLB5qLjVBdwj+rtP5MK
	sWnCjrQgJaPq94DP1ShbGQGpYnx2Puckv4z5+ujsFr47DUCyoyPSjXbard2w6YSod5ZK7NWJ153
	kgav0pRPLyzLX5D9weBDEBCOcGcBwSBNqqfz0A9YgjKBGImK/Jsn/1D4l4uEhka5cw8qAbdilC2
	NpLio93B6cdl+veUdQ3Gs0YYTrIT1+G77HGoIkoCkGjQ=
X-Received: by 2002:a05:690c:112:b0:871:cdc:eaa5 with SMTP id
 00721157ae682-88d1e07c7e2mr3186077b3.1.1789369935437; Mon, 14 Sep 2026
 00:12:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2217.git.1788508426.gitgitgadget@gmail.com>
 <pull.2217.v4.git.1788942331.gitgitgadget@gmail.com> <b7b97262f27782f3271369115496c67f9774b8b2.1788942331.git.gitgitgadget@gmail.com>
 <aqOvAttPrhUIP_7U@pks.im>
In-Reply-To: <aqOvAttPrhUIP_7U@pks.im>
From: Thomas Bachem <mail@thomasbachem.com>
Date: Mon, 14 Sep 2026 09:12:04 +0200
X-Gm-Features: AcwNN1UfP3hTsC4nTlydPOUEguOdY_ubBNpBGXTS-zdiGkeiVR0UUidaZDkVOu4
Message-ID: <CAA0xjtr+GiweJL7K0g=Wg0D=Surm906Q2Z==Jh8ROGnc1=TYPg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] rebase, cherry-pick, revert: run auto maintenance
 when done
To: ps@pks.im
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk, gitster@pobox.com, 
	johannes.schindelin@gmx.de, phillip.wood123@gmail.com, 
	kristofferhaugsbakk@fastmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Patrick,

On 11/09/2026 09:34, Patrick Steinhardt wrote:
> Nit: this is not necessarily specific to "-c key=value", and your later
> patches in fact add sites where that is not the source. Proposal:
>
>   Append a config option to the buffer that can be exported via the
>   GIT_CONFIG_PARAMETERS environment variable, which allows us to
>   propagate configuration across Git processes. The format of the
>   variable is a space-separated list of quoted "'<key>'='<value>'"
>   pairs.

Taken. I'll keep one sentence after it on what a NULL value does,
since the function accepts one: it appends 'key'= with nothing after
the equals sign, which git reads back as true.

Thanks,
Thomas
