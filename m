Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D35A1A29F
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 17:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A19111
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 10:22:02 -0700 (PDT)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-66d0ea3e5b8so47756d6.0
        for <git@vger.kernel.org>; Wed, 25 Oct 2023 10:22:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698254522; x=1698859322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xx90c2Gl7YuWXFZGf6E1taOrrZBwDubiuZC5UPnEu20=;
        b=Qpz056XoSoRGnkXW8Be05/C1StNPr8Tuji1OAPoYw0VOVzvusrjr+pEAi8xJ9hsr4P
         HSv6bFtKcVuGIroZjODSdtTfs8EEu2SnoSWRBQzDWu9vBB2BiF+pUYAG07jBdsg3RQN9
         nVwoopi49v45LyfiK2lQKqJF8Txc9DaJjFOxVs2pGIokWmVTNQ/gAuK1mQ02YOuI+VNj
         0RkepjFw0lzMJDCTN5cMLGipGhj75/oyBKbWTQ3UQMh3P2FbbeLcDAHqk9E/5Xp5hvdA
         Q9qccHb30TwoygzQfdNCQccwRvmgV92KtpgNitRBOf7z9wBH1AXPBCNjTpwDIgT2V7lt
         OIjA==
X-Gm-Message-State: AOJu0YxdjVVy5iBiRwSqRevWBdMdvA7Q9u9TlL1idNV+EcSbv8jfDubz
	HnNTMmgKVV+4gLhu3VcV5iHzvNXl/y5GKTnQ8zP42BHp
X-Google-Smtp-Source: AGHT+IFpcqa7tvPS8jU4DrgF7skEKc/DTaSQy/i1m4tpHpYXWf47Fz5/UBZiuV21CJi91N/oF2PqDqHXRggYqlHCt4I=
X-Received: by 2002:a05:6214:29ef:b0:66d:373f:32d4 with SMTP id
 jv15-20020a05621429ef00b0066d373f32d4mr16076100qvb.16.1698254521822; Wed, 25
 Oct 2023 10:22:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1697736516.git.me@ttaylorr.com> <cover.1698101088.git.me@ttaylorr.com>
 <d8cf8e4395375f88fe4e1ade2b79a3be6ce5fb12.1698101088.git.me@ttaylorr.com>
 <ZTjKjkRMkmCuxDU1@tanuki> <ZTk3zoncT6nvV3aQ@nand.local>
In-Reply-To: <ZTk3zoncT6nvV3aQ@nand.local>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 25 Oct 2023 13:21:50 -0400
Message-ID: <CAPig+cTjQe6FWo98LxvDS=s3dOs33SUUJa=x-bkyWHNBMx+XFw@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] bulk-checkin: introduce `index_blob_bulk_checkin_incore()`
To: Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, Elijah Newren <newren@gmail.com>, 
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 11:44=E2=80=AFAM Taylor Blau <me@ttaylorr.com> wrot=
e:
> On Wed, Oct 25, 2023 at 09:58:06AM +0200, Patrick Steinhardt wrote:
> > On Mon, Oct 23, 2023 at 06:45:01PM -0400, Taylor Blau wrote:
> > > In order to support streaming from a location in memory, we must
> > > implement a new kind of bulk_checkin_source that does just that. Thes=
e
> > > implementation in spread out across:
> >
> > Nit: the commit message is a bit off here. Probably not worth a reroll
> > though.
>
> Your eyes are definitely mine, because I'm not seeing where the commit
> message is off! But hopefully since you already don't think it's worth a
> reroll, and I'm not even sure what the issue is that we can just leave
> it ;-).

Perhaps:

    s/implementation in/implementations are/
