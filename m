Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5681F3BB0
	for <git@vger.kernel.org>; Sat,  8 Feb 2025 21:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739051815; cv=none; b=A+Sj/pZVNw6TbE8ANkv8ykM1l3BV4Y2yClixLCCUBGC1kgCFCLSCMJguazS9ScIKyT1Otdz5Dpql8GccHV+QowZlcJfdoqJ62CrXx6TBWHbi6T4VVYl7ey05On8owp5JLsDLiFt9Ab/PBqaFIje0iUXG4oPNNpG2BmWSdCwiXWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739051815; c=relaxed/simple;
	bh=VMhQgsQHttlNTTVsEHrLivhAJ6pFwlH8iIQp9o25T7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=sgEjDY31Jq7SHsxNELIA/cS7PD8QagqxHa+18WcYYVFqRQcObGKFqSu5QV1+9m1jZ0uyQ4/eh7U5ADlXL7KHpZtVvWdEjM9diFSJNHpQ10qjbgD6/hV4gIxHyIJazPEs2NqhZs4poeKhpKw6UHmWdD7Ia6p8cDNufW/DOu0U+pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPhnJDIV; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPhnJDIV"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3d04d767d3aso26205955ab.2
        for <git@vger.kernel.org>; Sat, 08 Feb 2025 13:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739051811; x=1739656611; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+TFTKFP+GM5rbP7MwPnJ1YwyRxsq5rkbC2z2bl3YoE=;
        b=aPhnJDIVCuSQ8RVDO68HOAv874bprzIeFp77TaOqJRoefHFmMt7j74iBIB957Zmkz0
         uDnpFR4CexO/+S5V8nRQnx42LFNSNU4Hue/uE2kl4PdWHpDJJzQGcWFg6K/BNZfWPMF0
         v49tPHDFcpyVrFf+o1Ts5Wg0MuaWdIpzwxuoCAauoGvuBxqxU7+Kx6dWjLNtmnoV4kfN
         97as+v1wYtsq1FjC+acGQSNxZZ38rgwPJGMmdW5sCEUoxRrfj+OXRrVSdLBqUm2FG5PT
         PxsYXu9MU3sUG4YKaKsbYRLGO+lZHvtiWv892nLWruhVFEgng68WyMnVH0eryFW4mJDN
         3I1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739051811; x=1739656611;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z+TFTKFP+GM5rbP7MwPnJ1YwyRxsq5rkbC2z2bl3YoE=;
        b=tGYLeAjIMzjRbX1dbKaLQrEvpchYsyFGG2qMBJYpprf2ToWaZRiod5cXGt4m5dLE38
         CnxdRlid5g/P5pDXGWduU3SM/ObinrGEFEaABctVKX//QuEym3+EFCsDzjmwkmkb7zVZ
         AEGVYSGGP86h+OJOWvA7jZOgm5Xhhe1Rwy6Kg4HocYitRzgJw57KwKw0+QSMnhMuv9lF
         0BEEFVPZgVT6KCSwvLuRX8XlTibSQ+5xz+H8w9nSkFH8u0sM7cq/SDBoXGJQ8oSU6RAB
         G5s5bPIIGFdqB9DiVPBu9u3UtGPYtoq6TfA0etlnViX/qHf/1KJUc+aWis59wmnf6Mpc
         aq8w==
X-Forwarded-Encrypted: i=1; AJvYcCV28/SfhAfxpjs8Z56nTRpqKPCZmrameh6MdNxWZLImAmErlRf3iVq7OTNgyajW6nH+duY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwebexHN1hsw1LpmqgRsjKn3PnG+2j4P+C7AdGpN7eUSecYasJD
	isoP72eruAQ4z4AUUg4XAw4xo52IyxbfTv40fO/ghwmVC7PHj/eeGxDI8r6uB3dkFA3qeHIAiPd
	OtByMfwRAWgVzgLTyikNqg01a3iks1pX5
X-Gm-Gg: ASbGncu4BR31B3OV27S3+HErZiGJ0EZiip/FevXDrdQ4U2p5LThUPsKoacVcxGtiGq0
	eHPTyIQjmFxNEa3XKMeMzu6JPGVpnQugzT1PoYPmprrkrtWFzvKCskA0pHhWSYPXHkIZ0VQLwsw
	==
X-Google-Smtp-Source: AGHT+IG9YZntcZk8MQxZW680m8jrS0V4ZMu03KEQQMKZjkdbfzDpLueFd/mWmfSixlrQf+pptfdUnNqAuX2WuyTiLRk=
X-Received: by 2002:a05:6e02:3421:b0:3cf:f9e0:f4ae with SMTP id
 e9e14a558f8ab-3d13dea61f1mr69099185ab.6.1739051811543; Sat, 08 Feb 2025
 13:56:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z6QCX1QZxxwC7RVQ@tapette.crustytoothpaste.net>
 <CABPp-BFZ3oyKiryKMPph+nfokC=sFa7wn1wdas863273bzy7pA@mail.gmail.com>
 <20250206134006.GC30202@raven.inka.de> <20250206200418.GD30202@raven.inka.de>
 <CAPx1Gvc2piLT=p+dvzcJPTMDQAAjQfz__O4KiRWs-fOMg8dpTw@mail.gmail.com>
 <20250207104510.GE30202@raven.inka.de> <CAPx1GvcyaZqYK+SvgtfsajqtkMty1jOcVAtwfmam-LpOjyd0jw@mail.gmail.com>
 <CABPp-BFnx2m75jsa3_kTPet97HY+xwb_6JmPiKM5+OARPy=mGA@mail.gmail.com>
 <20250207203248.GG30202@raven.inka.de> <CABPp-BFGUa_DRBe1WLVfCOKh53+F15KxW_c_OZAMwZCxuAQCiw@mail.gmail.com>
 <20250208205709.GH30202@raven.inka.de>
In-Reply-To: <20250208205709.GH30202@raven.inka.de>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 8 Feb 2025 13:56:40 -0800
X-Gm-Features: AWEUYZl2veqLN1gYsUqrGj2vsVCThVcvB1qHuFacoDsqhQYtgUo_NRUBjiPfMxI
Message-ID: <CABPp-BGQ0pc=AZ0fdXcqDbhMLbm2xBvi71g0mXAVDagz19NkEg@mail.gmail.com>
Subject: Re: renormalize histroy with smudge/clean-filter
To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 8, 2025 at 12:58=E2=80=AFPM Josef Wolf <jw@raven.inka.de> wrote=
:
>
> On Fri, Feb 07, 2025 at 04:23:45PM -0800, Elijah Newren wrote:
[...]
> > [1] The renormalize option to the merge machinery ensures that new
> > blobs produced by the merge have normalized content, and avoid
> > conflicts when the only differences between files are normalization
> > ones.  This option does not ensure that new trees only reference new
> > content nor that they only reference normalized content; _any_
> > pre-existing blobs in the repository are fair game for new trees to
> > reference.
>
> OK.
>
> But then, non-normalized content should go through the clean-filter befor=
e it
> is handed over to diff/merge when filtering is active.

Not quite; if the diff/merge doesn't need to look at the content of
the file to resolve the merge (i.e. the merge can simply use the
file's already known hash as the resolution), then, since that content
isn't read it shouldn't go through any filters.

Whenever you merge two trees, only the files modified on both sides
need to be inspected; the rest can be resolved without looking at
their content.

> > As per the manual: "renormalize...This runs a virtual
> > check-out and check-in of all three stages of a file when resolving a
> > three-way merge..."  So, the existing behavior of the renormalize
> > option to rebase/cherry-pick/merge is correct.
>
> A virtual check-out and check-in should result in smudge+clean. Running t=
his
> on smudged content results in smudge+smudge+clean. Which by definition is
> equivalent to a simple clean. No conflicts shoud happen, then.
>
> So the _description_ looks correct. But where do the conflicts coming fro=
m?
>
> > It may not be what you want
>
> I don't see how the description matches actual behaviour

The description says "This runs a virtual check-out and check-in of
all three stages of a file when resolving a three-way merge..."

So, when a file needs a three-way merge to be resolved, then the
virtual check-out and check-in is done.  When no three-way merge is
needed for a file, no virtual check-out and check-in is done.

Perhaps the documentation would be clearer if it read:

           renormalize
               This runs a virtual check-out and check-in of all three stag=
es
               of any file which needs a three-way merge.

?
