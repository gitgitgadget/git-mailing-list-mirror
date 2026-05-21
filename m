Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A5E395AC7
	for <git@vger.kernel.org>; Thu, 21 May 2026 19:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779391047; cv=pass; b=cf10zXwSAhQZe3OxnA+S7aTqLr+twjCmoiPrnaY2Sju6OajBGVYElpkkMjCNAoVdSNPQRulK4k3ImoEJKxyVaMwXEe3Xbt2q63+nQz8ykybx74nA+0ioVox7GMKmWBgDn2wgr/eVeX3GxZNjhJscBm4xMPuXfRt8pKoO9Ykx0VQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779391047; c=relaxed/simple;
	bh=lPbbyOomagHhj02/g5K95xDLy3Sxc4pu5+6Av8cNJi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bjdcFh+IEAAFboAmJN/BER7rF/R6o84+W8ypIiGHSIoF3snS8iNkrbRhHzuq5Q5j3EDROlqAK5tKYXPf1gFEMuNaS1rnAQbHAT880wfeNtzQclqH0J46xRWcBzUAykbvbeWWxfr4x9phH4zN9FuAX5awioSUmKyQtrnkKcv7ZNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3DXW7Ue; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3DXW7Ue"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-bd56d108454so1256874466b.2
        for <git@vger.kernel.org>; Thu, 21 May 2026 12:17:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779391041; cv=none;
        d=google.com; s=arc-20240605;
        b=VDoEgS6nU7gOQ/z2wgpwTsKDwQrJ7W4cCzltUu0QYO5h3k4I+Hfg8r1KMZQAXXjU5H
         yx+hLHlPHU7eAt+9aEfVdiRHlivX4tnqSeDui+it8e0eiS22pj3HEuTRlCcy8ZsBzMHM
         ZbBvqQo77VxTWVao04C/uRWscaOG4eLnWaC6+MsgQYALMYmirbD2pg34wi29CnerXlk+
         yjWE+TMK2tpjLk63DntcIRvftkPxi3B0SgG/Eo0FXLSTMuwIRa/WSU5mK5WCoyNKRbPP
         /IOKC9YMQevMhkSspXw4FAh1VWK7yIJAiR9251ZBUJfdGigpPaRAWlQjEFtyELWgXZ5k
         tE2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lPbbyOomagHhj02/g5K95xDLy3Sxc4pu5+6Av8cNJi4=;
        fh=o3g/mmBpkwab2WBLkwfWhQL5AYY/8CdPQlkPvP7ZYK4=;
        b=KyY3lEF2qwgfnG+xJco/2kZU19oFangIplyYPkLsie9Ifhcp4cXmPMckAlgFbKtMYU
         H1MZYzS1dBJlk1PbJo6ZG3Sr7AyY6YucOFsuGCdveQtVXMqzoqBAdPiHZch/j+r5+d7W
         m1UMHQbXg0bSkZ9Fc2eLEcHb3eKjl/B1qm/1+K2WA96wAH6+gL+df/AG0anCxhuEiiKI
         GYENhpoHd8mxYFMUtTMzGDN59M7r+35sqd8bh+FJ4BIKg+LWXbeKW2ZxwsoqnDvdZ1JK
         /5qle3odUhz4YZTvRYzqyvnOUxUQhILmJefMw98IkdfUFXx4iRPmBkSY31PigoSt9Z6s
         J5mA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779391041; x=1779995841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lPbbyOomagHhj02/g5K95xDLy3Sxc4pu5+6Av8cNJi4=;
        b=k3DXW7Uem1mpte0PVPdaSQv9LZk+dfizmPxNPQG1RzPZqELt0tW71JXOzcgBHCuHPB
         zKmncIOoAn4NnNGIasAbYT1TeTDU3aGqw31wmhSfekNo+ygLFTg054ZjujV3Wulx/M1z
         k1hFxT/SyZtVat4KCPxfBjebXIKKnkjqomsgG8+lNM4eftUSWK7JmgqVKJAyT5rG8V3A
         7F8Lr42+yJMeP2krD7NZrjtVg+LVkYAJBCAZSkAZ0a33mYzYKFHio/Y/LHnEP2hj5shq
         /6/fQ4lKUftyp97AeDo70/d6tL/OCziysKOnm4b4UUtQEr8J26mV3wHWEY3Ea5NpPYwe
         NWug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779391041; x=1779995841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lPbbyOomagHhj02/g5K95xDLy3Sxc4pu5+6Av8cNJi4=;
        b=KlmF1JvHoSbnnPMYE0BGreuNCDHicO89xB/zvABknP9E8J8u26izX/WaUpLQwWjQ3q
         vxKbuTzD1Xnh47vlCQyAbOQbp3uOY40Btf9ZPgoot6knvjIEezcq0dmf3yni59+AYrus
         Wc7uIacd9yeUEHTKShpLRjABp3aMptdQbB0y0TJd9EsJg7ywvaAL9bRwwQ8ulBmb3yrA
         wDw6xFUaYXpqQMcv8BA7utRdiUYYOPDGDxavcw6nCrkKcHLP0GTxdonJ/GdP8HKOXfIN
         aYZfA9nF63k4BNSPSla8d7t9/X1FzSu1hkbwHdGjNBqmL3GpcOSLQmjCvUXRdloODUgB
         Tv7Q==
X-Forwarded-Encrypted: i=1; AFNElJ8Qt9YcRgHbNPCQ9UZok0A6Wj/QtLqBApZpaiFQGuTW8rJajoimJpWIds3s6MYZjUtmZK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXY7eEjNadiJ2W+iipTd6OomOwzm8Ss7lJghAv7fCca7BR13Sf
	/ZVtNs/Fuyb0Nf7HJ2h9tg6aufB6PGTU6+OQVfvVPdmos5wdUr9AWeHa9N55PsYrd+oGyVvueXI
	mIcMNjw7nXr5NkxQyW+vvRwRpO1ObEZk=
X-Gm-Gg: Acq92OGYyakWjHUXokPIa6Z51rJrgp0ubSRLJYtpzcTl1axegA2PV6SjN/K+CKLpgm1
	B1BWtdjLIY2TLaYkEG0qOtt43gf4r7tNOT6K5jqYbsKDNQr8EwsTYbrYLkBTJzGlWjrnGUgL/ho
	Tm2zNT/s6IjdL+us3ZMIyouCXQPxOVyJWINCaPL+oqxp2m1ByAd9nmZ2dyEJ5aTn9qRfTRmBT4l
	M3M0/XBsHVVvJQVhIp1wQ5DmzkBkrYmUqqASroW2U1mGMrJC6tzFHY+Aihlm1YqEol0Ojz8v8OX
	AQbj8vM=
X-Received: by 2002:a17:906:8a54:b0:bd5:2c56:71a2 with SMTP id
 a640c23a62f3a-bdd263c7cf9mr20713366b.36.1779391040789; Thu, 21 May 2026
 12:17:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2285.v8.git.git.1778605658.gitgitgadget@gmail.com>
 <pull.2285.v9.git.git.1778700883.gitgitgadget@gmail.com> <f87e96e99d64c48bd92afecf3a6a819d36e56f6c.1778700883.git.gitgitgadget@gmail.com>
 <6501a3d5-a5ec-421b-8526-ee7d4ae5ea98@gmail.com> <f1d15d08-6fee-479f-8ed0-34efd256d8dc@gmail.com>
In-Reply-To: <f1d15d08-6fee-479f-8ed0-34efd256d8dc@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Thu, 21 May 2026 21:16:44 +0200
X-Gm-Features: AVHnY4JX_oAKq6xjDFR4Ng-Ww8uoCEJhL3GbjfxzlH919Z_I1dJ5ZEgTJ9x7ulM
Message-ID: <CAHwyqnVhhwT80Ao+7QLUAsTnUJaN5vE=ZiaxeqF3rYxxiD_Qww@mail.gmail.com>
Subject: Re: [PATCH v9 3/5] branch: add --prune-merged <remote>
To: phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> While we want to clean up topic branches, we want to avoid cleaning up
> branches like "master" which follow an upstream branch and therefore
> look like they've been merged straight after they've been pulled. So I
> think as well as checking that the local branch is merged into its
> upstream branch, we want to check that the local branch is not pushed to
> the upstream branch i.e. that branch@{upstream} !=3D branch@{push}.

This one I handle already by letting the default branch be guarded.


Harald

On Thu, May 21, 2026 at 11:46=E2=80=AFAM Phillip Wood <phillip.wood123@gmai=
l.com> wrote:
>
> Hi Harald
>
> A couple more thoughts ...
>
> On 18/05/2026 16:27, Phillip Wood wrote:
> > On 13/05/2026 20:34, Harald Nordgren via GitGitGadget wrote:
> >> From: Harald Nordgren <haraldnordgren@gmail.com>
> >>
> >> Delete the local branches that --forked <remote> would list, but
> >> only those whose tip is reachable from their configured upstream
> >> remote-tracking branch (branch.<name>.merge): the work has already
> >> landed on the upstream it tracks, so the local copy is no longer
> >> needed.
>
> While we want to clean up topic branches, we want to avoid cleaning up
> branches like "master" which follow an upstream branch and therefore
> look like they've been merged straight after they've been pulled. So I
> think as well as checking that the local branch is merged into its
> upstream branch, we want to check that the local branch is not pushed to
> the upstream branch i.e. that branch@{upstream} !=3D branch@{push}. That
> should also avoid deleting newly created topic branches that match their
> upstream (I think that's probably less likely to happen in practice as
> I'd expect the branch to be checked out and therefore protected against
> deletion).
>
> Also as this is a destructive operation (there is no way to restore a
> deleted branch and its reflog) it would be good to have a --dry-run optio=
n.
>
> Thanks
>
> Phillip
>
