Received: from mail-ed2-f32.google.com (mail-ed2-f32.google.com [74.125.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914FC41CB5A
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 12:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791115453; cv=pass; b=m/10oTofHZfI+F3ajPXXh0Uk06u4AqIbptizq7CA5u+299EIlvkm6uriF8fl5A0vvUCY50krTw7+rLMCNhqXm3hLfuYotEKU4FWFbJBV6RlIxaRP7Bl1vkQ33vxMpbBHybLE++bhk5FLDYicJqMIxWIKX6IrHHcQwVkGdr/s3Zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791115453; c=relaxed/simple;
	bh=78aOREXWJJpQF7BEmKY0WR6YhZnvDgd2+7fOGhwh+30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d+001Mi8joQ63PT5559S/2DBinpHlGo0CmobShNWNDIAOZsohmW56OsKKWt4+LubYycgxq7VzmqhjDLGePwjvh102p+oU3r2iZ1f1a9Xc6Fe3M93Qf9MtUdpUOEuZlk4AZfOznCOZ6POpGmyLUNJUDaw0APOow1r04wbH26nPDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r1I9T6v/; arc=pass smtp.client-ip=74.125.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r1I9T6v/"
Received: by mail-ed2-f32.google.com with SMTP id 4fb4d7f45d1cf-6acb8b78d6cso1227655a12.2
        for <git@vger.kernel.org>; Sun, 04 Oct 2026 05:04:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791115450; cv=none;
        d=google.com; s=arc-20260327;
        b=gahJ8QFJ6UD4wteD3oaJ1lla3aaW360jwuNQ2SqCWJB1HgUt2YjHIDD2S4rfD0DVcH
         LTvRummw+5sOHKYCTBVLb+f+frdv9eKF9V8eV5Pmtf0SVd42XpYKzqw7TRiYprc+JZ6v
         xCTSnS4FmyCYWKC7tWWvPNmPKgFjC7QqGmxsoOkpN4foxF9BlDc/PVedhxH1P+gf1xxh
         /qjjh+B8JsfQVTvjdg7TxWv4xFMgtGZQuQMSF3goRO8xLFVhGS9Spt+dnxAxSJj+JKuq
         ZmvHruImwPK2/uDooqiZTl/xOn9GLTlTwXLjONV2C9jylIl5hDYwNnPt7aRUrvX3XmWZ
         2PXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P8gDCapjWIKpMa9N6CCe92AETYADW1jmtIhiCpg0s0E=;
        fh=gX7qFyBfDgNYi1OHt1R2bTXWAuBPCKKyf1zXh+nGqrk=;
        b=NOI6uZgypxr8/HxtcT5wGGDmbQhdlmzgioIoxl4bmxo82DDjjDSnHR+tcUeEMSs5fJ
         0gXgxCHHDSowuPBycJ5Nwh2YRE37DdLDJ/LZtaBWj8Kh9Lo49Vy7OlYjBQOMnBzF7jNX
         8+FS+ftIhvcJcGPSOqlcwhN6p3BBFCQK8ncE2at8RvvVBZgva/ecANzE3OV1WZa2y9wa
         Ol2iOzEzXtWNU7R9lZ8sr3946eT0JyX4sg4fd/Mxj67UC/bZdJlpcoaZU1yW2ShTi3r1
         EXdr3nr2MT/TcIZglgkgjyvhAEn6zUSOhm+GK9ogWSxcldZ/Oi3kqRLA6OeiSTPtoJD0
         QFeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791115450; x=1791720250; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P8gDCapjWIKpMa9N6CCe92AETYADW1jmtIhiCpg0s0E=;
        b=r1I9T6v/l7aQvzp+o1TnNpBil8bWOiYRzT+vA2yiGoU9w2M9neb4bYIuxh+6y9zecA
         pjjeEQHWDQBcRMhHEBb0c2YWj9BtirwngaUXhC4ktha3aVrkkAGG+A0giR9KNjMjdMg0
         bZOvJIRBXO+DLiceG8GprFmL6YVbZJsdwtOafJhgY2/JWJFeph23fW9CTtsTdF6Z4pXa
         eY2LjhM49pw1kcIT1x5K/44imSmzfucHi8lleS3y5wCWji8iwznplXg9fDJsStaMqnuW
         tdkXgnizEiZESyAiKZChl62P6H1Ik13l4U0Pf7RfozmpFG18hH0Qzq8/D6jSInlkTrbO
         xpVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791115450; x=1791720250;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P8gDCapjWIKpMa9N6CCe92AETYADW1jmtIhiCpg0s0E=;
        b=eWV764uShsyowmkHNF6IRmFzQCbbn68GIjbjc4l6KwX56+AZbF9nNmdYBPCPpzCvlv
         2sXwly2oclkdqwfR5FfF7kHS2EKY/s7nkBWiXgcsvAnXpEIxF9+hHEBtOQDCK2eEjaPt
         f0rIh6Y0zQGVjlQFs4My1U6OXHgOCL/V6uEsdlRgXOokfwueoGE/PnKfMikGK98MOw8F
         3l+dey2EkYWM5z2EjcWJZCq60ILsSt3pd/f3rg1OdOV5sbI9YCF1J+R/rJZjXhYttCN+
         Q2ucK78flKww22MnyvxQcdBlfBp7sdB/KhSEDpGiwzuC0aprc1BK5U9i0NWYdTcXDg/U
         IQnw==
X-Forwarded-Encrypted: i=1; AKwUvByj/izSKUGkbHoyZnHs4S8KvZGXmu2R5/bFJVT/Aciu71fyKYScGJG2qB5VhsqCDob2rv8=@vger.kernel.org
X-Gm-Message-State: AFq9FYI04v+0++klLyuEwWQ+E1BWTNLCWGFGUJ/dO3T07kfoLGSWYJNp
	hkOkcm57HbV/IEpBSBAFsP982mwW4LvmuKOWt8z10bq9XoYBs6Y9VqSWzq14dPsHLTUMwA7HxLo
	wVSR6PCAPcqhezBJz6x/KcgrGAGAvdLI=
X-Gm-Gg: AYBFou0TGYLBP8RKZU8RtfX5vB2FbuWigCVoSYuagmVo+7oPBAsOFFVvSscukqhJYqc
	6ARH+iBnvtsgvHWxDIHZbRxl2XnllLaVJRiyZrBaBjs8w6Fv3255jGDpgKyu6WGtA0kDNQtPXp5
	JL5M5QqrshRX9KA+O7V07q397ImUH/padYt1zq6Odge1z0R07TrT/Q4h+Zi0mxxUBl/h3Xa4Pc5
	WDdWInkWH57gnxhkldIdZCTLge3v9FcmdSd1Ulz9VpK8X/kdwlNVe/1T6o3JPp+HkwOepZQ0zDi
	acKVWd9GjkYnjwR8cfg3HDvZmvmssV3mYvSf3d8rQ9nhAKoIw+tLFBY=
X-Received: by 2002:a05:6402:210e:b0:6a9:a1a1:60fe with SMTP id
 4fb4d7f45d1cf-6af9e03dca9mr6995529a12.3.1791115449549; Sun, 04 Oct 2026
 05:04:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2419.git.git.1790362443893.gitgitgadget@gmail.com>
 <pull.2419.v5.git.git.1791015117.gitgitgadget@gmail.com> <3587bf44-1b3b-422f-a926-f8481104dfd8@gmail.com>
In-Reply-To: <3587bf44-1b3b-422f-a926-f8481104dfd8@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Sun, 4 Oct 2026 14:03:31 +0200
X-Gm-Features: AclHuK9LhZ5zUBzUy2lrykH1QM6_1AS6kWt2kAY-vgpidB0kdmr_S1ZYUS9l3nc
Message-ID: <CAHwyqnWU0z7wHxDnxdoviOBenYJogB7k4GLo2jdO7_M_hSMZWQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] ci: link failure and leak annotations to the test script
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Ben Knoble <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 3, 2026 at 3:03=E2=80=AFPM Phillip Wood <phillip.wood123@gmail.=
com> wrote:
>
> Hi Harald
>
> On 03/10/2026 09:11, Harald Nordgren via GitGitGadget wrote:
> > Link failure and leak annotations in CI to the test script, so both can=
 be
> > found from the job summary.
> >
> > V5 CI Job where failures and leaks are reported:
> > https://github.com/git/git/actions/runs/36979818141/job/110752027863?pr=
=3D2426
>
> There does not appear to be any output relating to leaks in that job.
> The first patch hasn't changed so I'm not sure why that is.
>
> > Changes in v5:
> >
> >   * Removed % escaping entirely, verified on CI that it isn't needed. E=
very
> >     existing test description that uses % renders correctly unescaped.
> >   * Rewrote the file/line commit message with a concrete example (faile=
d:
> >     t1060.17 partial clone of corrupted repository).
>
> You have added
>
>
>      When a test fails, GitHub shows an annotation naming it, for
>      example:
>
>          failed: t1060.17 partial clone of corrupted repository
>
> which shows an example of the current output without the filename or
> line annotations. There is no example of what that output changes to, so
> there is no way for someone reading that message to see what has
> actually changed. After spending some time clicking around in Github I
> think what that patch changes is not the test output of individual jobs
> which you linked to above, but what is displayed on the summary page at
>
> https://github.com/git/git/actions/runs/36979818141?pr=3D2426
>
> That page shows a list of annotations with links to the changes in the
> failed test file. That is a useful improvement but how you expected
> someone reading the commit message to understand what had changed when
> you did not give an example of the new output, and the changes are on a
> different page to the one you linked to in the cover letter is beyond
> me. I'm pretty exasperated that I've had to spend time messing about on
> Github trying to see what has changed because you could not provide a
> link and write a couple of sentences explaining it. After asking what
> this change did in v3 you replied that the commit message wasn't clear
> without explaining what the change actually did. When I asked what the
> change did in practical terms in response to v4 I got no reply. As you
> already know reviewer time is short on this list, so please, when
> someone asks a question answer it rather than replying with an obtuse
> comment or simply ignoring it and sending another patch.
>
> Both these patches are useful improvements, but trying to get an
> explanation of what they did has been like trying getting blood out of a
> stone.

I don't understand why this tone is necessary at all.

Yes, I should clarify that it affects the summary.

But I posted a comment regarding the regression you brought up in your
following message, so we should decide what we want before
progressing. The point of this whole topic was to make the leak
reporting less bad, everything else was a bonus.


Harald
