Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B27125B9
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 21:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729112715; cv=none; b=bQEsw3N1IrUjA3ELyq55TQdXm5uS7jvFRCBSA0yNreMZn3HQoex8+sUuEtUs++60pGCm/+q3aOEIKMZ6eoGXCTjQGEo86i6jF2HiUDmF6psY1WffR4lxkyGb7C/3a3dNsVcoh0yO0DT4Fe/tfOGl5ElI36L2ripcYSBGYEZghYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729112715; c=relaxed/simple;
	bh=ZXJ4yP+n3IQsDd2YPppWukHX9cSfkVs16gI/Hp+HwL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBiji0+I9qkY0EZ+H444yo/h3FYMDmmskXcT/QtPuXLTAGH7Q9kMnalSCHucwBkbxIZDDuNVvB8m1ckNOVF39aJecDjpBYC+BrlP4KMH1Scgr1QdakOi/xbx7WljjDHsTcc1lytMkGmSvvElAUlxxWp9GMOcQr/rdhgwjHJqKE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=0FBPezsZ; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="0FBPezsZ"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6e396a69062so3179367b3.0
        for <git@vger.kernel.org>; Wed, 16 Oct 2024 14:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729112713; x=1729717513; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wb/eoj6xvBIIkQyhbo8nGbUfT7NyZY6aLlWwYM9/A9A=;
        b=0FBPezsZh3243yLF3gLPbN/J93+T2430D4SATFMpqWI+N1p/pRHTd4SH2IwHEpjWwz
         Ba8+s4vKRkyC5RWMM6gnRyyYKY5Lxqud0SFonk6WmGc1I02q9qjcLv74xAcNKpyrN7aX
         2dSDf4AYpPJB0MIc0GiLqmsWvU4xWr5Yi6rHoyaljdyuL2YeJ9Z63rDZpkFeu3/bCIOw
         F0zdR9m1WKjqlDn/L7Ct0JnpHP5i4iCCES0mtxXxzld805MamNKc29apzA9wHivHcHqf
         YeWyPdArM746J/omXJRKeEp72RzqbFkRLNfw37Z7k232fh1oV+UQ4kW8iJOXE9AlLz2e
         MmYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729112713; x=1729717513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wb/eoj6xvBIIkQyhbo8nGbUfT7NyZY6aLlWwYM9/A9A=;
        b=Ymv2lXgLKxmqqvviPE4xwuZqPMCZFjnzgN8y090KGjZ+aM3SxJa9xw/IxvGccKEqzr
         u6vF6J47rpkv5gohe5SJ+rTJP0soBD70jSNFOPd1e4NakT8MAkmqzesbUK2wQ6xfy+xL
         0pOcsgms8AtfM5SJiVBMoB6Qj9W/nea0IXmvepfepBTHFon4idiBJShwCfuNmFNr3Bg7
         HbW/k4Rk7xUnGeNZQ531ZKiBpTz7z6CuKeUm7N213Zve2yHmD1Jz0HlrHPr5r/3jZsFP
         kKsHWKGkCcWLlEwXV6svLQ4Ib65gbmKH/jm4BSTQelL+0UCHHUhedKRbTgmBJH1a72/B
         4uTQ==
X-Gm-Message-State: AOJu0Yzj0C0bxnP1r6x9I8SgaF3LwuY9YKEu/alza2sop1tizF1d2Hie
	3dGB/xbF8iwxEee2h9NKMbL23gzi9cu1XTFF1NVEMAnjxsLWLBAV7R2XMDdWAKo=
X-Google-Smtp-Source: AGHT+IH5pJh7g+g+QZJNG8e6Mrp2OIfJ3ANrSkyotu5kzYI/3yOT4k8HjpruLdjOl3ZzVM2cblNbbg==
X-Received: by 2002:a05:690c:3308:b0:6a9:4fdd:94e5 with SMTP id 00721157ae682-6e3479b990amr130222437b3.13.1729112713087;
        Wed, 16 Oct 2024 14:05:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e3c5ae2c58sm8578027b3.10.2024.10.16.14.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 14:05:12 -0700 (PDT)
Date: Wed, 16 Oct 2024 17:05:10 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, karthik.188@gmail.com
Subject: Re: [PATCH v8 0/6] set-head/fetch remote/HEAD updates, small change
 from v7
Message-ID: <ZxAqhqHwomsRq2Ck@nand.local>
References: <20241012230428.3259229-1-bence@ferdinandy.com>
 <20241014225431.1394565-1-bence@ferdinandy.com>
 <Zw8IKyPkG0Hr6/5t@nand.local>
 <D4X2ZZAT5LKS.1FZ375SIMBV2F@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D4X2ZZAT5LKS.1FZ375SIMBV2F@ferdinandy.com>

On Wed, Oct 16, 2024 at 10:18:44AM +0200, Bence Ferdinandy wrote:
>
> On Wed Oct 16, 2024 at 02:26, Taylor Blau <me@ttaylorr.com> wrote:
> > On Tue, Oct 15, 2024 at 12:53:09AM +0200, Bence Ferdinandy wrote:
> >> Bence Ferdinandy (6):
> >>   refs: atomically record overwritten ref in update_symref
> >>   remote set-head: add new variable for readability
> >>   remote set-head: better output for --auto
> >>   refs: add TRANSACTION_CREATE_EXISTS error
> >>   refs: add create_only option to refs_update_symref
> >>   fetch: set remote/HEAD if it does not exist
> >
> > I integrated this new round into my copy of 'seen' today and noticed
> > some test breakage in t5505 here:
> >
> >     https://github.com/ttaylorr/git/actions/runs/11356267070
> >
> > I'm going to temporarily eject this topic out of 'seen' until we can get
> > an analysis of what's going on here.
>
> Thanks for the heads up! I see that indeed the failing output is different than
> what I have locally (e.g. no "apis/HEAD -> apis/main" in any of the test files
> I have). On the other hand I can't reproduce it so I will need some help with
> this I think.

I similarly could not reproduce it (I ran 'make test' on this topic
before integrating it into 'seen', and it passed, otherwise I wouldn't
have picked it up).

I am not sure what the differences are. The 'ci' directory has some more
bits on how the various suites are run, and the '.github/workflows'
directory has some more bits still.

Thanks,
Taylor
