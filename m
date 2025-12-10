Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5EE1D7E42
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 18:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765392325; cv=none; b=kpLTJHHrvR8rWo4YBQEDm/hitoMyd7RwO7zVz/vAAaiCdgJ4QdMI4H3aU6xnVUP8QmUP/V5Sbv1ZcltR+CdP0yui/jC9JUoeXGEjoBWRv3Lhp7eyf/pP/wkOs+TKVIjRyUTpvcG8XPGiY2ZFJHeKt9yK5MSaseWezpdV0NmPoT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765392325; c=relaxed/simple;
	bh=/Eqs0NYSeCu3q/dGw/Pnm4ZRMcFJhOHCjzBD0ZI/Kjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ko+tqGtbWB4pOa9+tm2H7V0sHBWNntY90eCvwa6O/c0OFW6M4PMsZCLyboFQAaoEq8voEAyP6YJXufgjK0afcx2grveVjibfFpnx0oxwytsoKQPRdKO7y5zhnPYPOGtaCESmoHdLxn+4CfjYcE2DBR9amN5wItApNQyXPaw9atE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kq8h1S7x; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kq8h1S7x"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-343f52d15efso154321a91.3
        for <git@vger.kernel.org>; Wed, 10 Dec 2025 10:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765392323; x=1765997123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tr81g52koJEAaIRE4PyDk5sbweHb35iKirenlWT4DJg=;
        b=kq8h1S7xlnLsIgBeLHm3hb29VYXk3Fa313xlYlzJjGT3VBB/ZLZgwjWgR5InfDWgwF
         SwNx02h6g/Bf5ry/z0VePO4hTkdgBtCH1P/evkI/bDnZcdBJoTdkgfE7IqVP6/Pqny1k
         hw0x4a30V6nIs1iFAb/P1faJTXwxSpVej6bq9gPDf2Sv3Bty3gf5J4doKdXWaIEM/DJe
         uf2qq8oU2n3i+n/Xef3sK2vvbdaPdECFxjEE4SfkYovUD7iJY8u9VSLT9DN6jnHyuorr
         EGxxfkMnBMd2eBzo06WNoOyDULhEXOOIbMi+Ta/xKSbxgngvTN+uxoNzBB7yi6L64oOi
         v7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765392323; x=1765997123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tr81g52koJEAaIRE4PyDk5sbweHb35iKirenlWT4DJg=;
        b=mu4g6nvavpX4Bx20wlwMjRVvoeRK+q18ohe2urpeXaL6QmY2xCILXZc1+2cllrdMvH
         HUrhgWWJolsy4MAtv260b2aG5D1RZC+SbKJ24s0vvxzSDIX2uy2OwRkU2iBIbkQKvJfW
         t0R9pl+NNx6MxnsS/0YCvn5x2pZ3WAGJRF2b+fQwo8Xw9c/54EjjE6hqsn051DQdTgkO
         ZOpvF0j3DMoLeMJVTW+xSXNQpzN8MDo/TkDWdlcyENK4o+TK2TnvVMgFfXaCOJAC4mrt
         rEPJi/x0HsH4jd/HODcmJnP2fIoeXCvndJaBNC0CI3mB4uMoFXBvni2Xyc568fME/c3F
         dpxg==
X-Forwarded-Encrypted: i=1; AJvYcCWHDBpq2YGAzngxG80rcRtLd5NoTcr320cBbSlW5ZnrIndz0tc2pzM1Ly0AVD71d+T5uCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPR6G0ZBOuCIGSzw0od782ZmIrFgmBUSNgfLXKe3cwWSaHFruI
	SSETGa9waaeDgD/l2HWE79skrgFA8wbNI2O/Qvy1195WILCQrGkr01Ty87hqshQKjSquE3ocLst
	8p3uq2+NDkQIPX9pfXZZDAReXdW6Uc7M=
X-Gm-Gg: AY/fxX5rCyhfKm/JgyhPC4SbG2LU7+FpfpM88XnPDfg0hrSSCoPtGavW0W+KHHeBF3r
	jz6ex1bdrh/dDK05NcApbI2zyiuGJcUChLQiC3tB54EA4iI/cqkJKq3t892Kh840BRDsJmAV2N8
	2/xftz3NI7/MExc3hFuOEvwlJr3SukAtUfCRTfd6lKRI7bKz3Q7u43rIJjVTAvXRXm3jya2/Uui
	Yt/kSdZjq6jLjyvWkMmPUwnWsuiCXg8jmpt3lkBSLTqMIR9vQcjCKILrp857p62tG4PXgHOQA4E
	2wEBOKIjzvZlgwlymF9Io3J5cQ==
X-Google-Smtp-Source: AGHT+IG64ZIQPQS8ZD8Uy1dZ0MYQhe666cxExT1of0QGhVzASG5nBELtyuUIAf6ptiE6e6GfLmm+ZviFyDefl+30/3o=
X-Received: by 2002:a17:90b:3b41:b0:340:4abf:391d with SMTP id
 98e67ed59e1d1-34a7282bb0emr3315278a91.16.1765392322951; Wed, 10 Dec 2025
 10:45:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
 <CANiSa6gXbrZaMLVq-AAg38sm+7qgzn4w98WWowLtUHA2P+BdLw@mail.gmail.com>
 <aKs3tqjE510MF0T-@pks.im> <aMsWL2cSoytbmRjA@szeder.dev> <4m6rmefbv4hftclimitz5rp6yapswjtnjsxymrsdkuan4jbg3u@dm5jzdiq5cxz>
 <bc01706e-b9cc-4cd4-953a-971a3ccd6c79@gmail.com> <paqf2ko6kcm5qdcqxqz57qu6gjw3vf6boabjsryeugfnlzzb7z@4dzqo6jug6l2>
 <CANiSa6hwaQ2zLsvw=uiJNgfVYAVp2RyQtgVeTevZ5NO5p2Xmgg@mail.gmail.com> <CABPp-BEs_Q5eGYugogm=Msu-acS3uTj5Oo0xTUnWay9OXBKqXg@mail.gmail.com>
In-Reply-To: <CABPp-BEs_Q5eGYugogm=Msu-acS3uTj5Oo0xTUnWay9OXBKqXg@mail.gmail.com>
From: Martin von Zweigbergk <martinvonz@gmail.com>
Date: Wed, 10 Dec 2025 10:45:11 -0800
X-Gm-Features: AQt7F2rnAOCCiQwdKpMzfHgIZzPzjR6u1lyJm9X2E7z3K8Ub_FzuEW9gwSrSLBc
Message-ID: <CANiSa6gxA5SVBALvkYzpMJUrHTW8OJ+fFLkAmM53fJ1GdbUsbQ@mail.gmail.com>
Subject: Re: [PATCH RFC 00/11] Introduce git-history(1) command for easy
 history editing
To: Elijah Newren <newren@gmail.com>
Cc: Matthias Beyer <mail@beyermatthias.de>, phillip.wood@dunelm.org.uk, 
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025 at 10:27=E2=80=AFAM Elijah Newren <newren@gmail.com> w=
rote:
>
> On Wed, Dec 10, 2025 at 8:52=E2=80=AFAM Martin von Zweigbergk
> <martinvonz@gmail.com> wrote:
> >
> > On Wed, Dec 10, 2025 at 2:38=E2=80=AFAM Matthias Beyer <mail@beyermatth=
ias.de> wrote:
> > >
> > > Am Wed, Dec 10, 2025 at 09:58:13AM +0000, schrieb Phillip Wood:
> > > > Hi Matthias
> > > >
> > > > On 03/12/2025 18:18, Matthias Beyer wrote:
> > > > > Am Wed, Sep 17, 2025 at 10:12:31PM +0200, schrieb SZEDER G=C3=A1b=
or:
> > > > >
> > > > > > Let's suppose I have this piece of history, I'm on 'branch2', a=
nd I
> > > > > > drop commit B.  Which commits will be rewritten and which branc=
hes
> > > > > > will be repointed?
> > > > > >
> > > > > >     A---B---C---D   branch1
> > > > > >              \   \
> > > > > >               \   E---F   branch2
> > > > > >                \       \
> > > > > >                 \       G---H---I   branch3
> > > > > >                  \
> > > > > >                   J---K---L   branch4
> > > > > >
> > > > >
> > > > > Just speaking as a user here, but my expectation in this scenario=
 would
> > > > > be that rewriting B would be denied by default here, as branch{1.=
.4}
> > > > > would be rewritten although I am at branch2.
> > > > >
> > > > > In the scenario at hand, I would expect that I can only rewrite G=
, H, I
> > > > > while on branch 3 and J, K, L while on branch4 (without passing s=
ome
> > > > > extra flags for "yes, please also rewrite the other branches").
> > > >
> > > > Is that because you have branches that you don't want to rewrite be=
cause
> > > > they've been merged upstream or is there another reason?
> >
> > I think that's a common reason even if it's not Matthias's reason.
> > Perhaps one way of doing it would be to have a configurable set of ref
> > patterns that are considered immutable. That's similar to what jj
> > does, though we use a more general language for selecting revisions
> > for it (https://docs.jj-vcs.dev/latest/config/#set-of-immutable-commits=
).
> > I think that has been well received. As you might expect, the set of
> > immutable revisions are respected by all commands.
>
> I like the idea of a set of immutable revisions...but wouldn't that
> result in the request to drop commit B in the graph above being met
> with an error rather than with a single branch being rewritten?

If branch1 (or any of those branches, really) is configured as
immutable, then yes. But it's desirable to prevent rewriting or
dropping B in that case, right?
