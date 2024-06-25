Received: from sonic302-20.consmr.mail.ne1.yahoo.com (sonic302-20.consmr.mail.ne1.yahoo.com [66.163.186.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC03113A416
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 04:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719289779; cv=none; b=ppc53vFas8fJ7PRBo0M0aDnshtiVyvGN6jvqu5BvW2Ggx4rLY2pccTlZVWF/XTkqJbRQvnnBfOWRkINeaEgqB/lingjdtuTFr4XXyMNIg62cuOGbRPkcy3vAweD5wGJsWbO8wuoj0tgBbGFSGd82IQsdCx4tbXkfsQsKOTJDlG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719289779; c=relaxed/simple;
	bh=SbKqC47YEiLphLQ+D7Tt0Qsas1WuiKLdVeIo2pVYuLU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Csqe9vE977Pyk4zftgPt37khFjdeykvmEN3CdBNkPgsFoHKRoEIDX5V4sZYPgSfImlM/6to79Og+bH+Cq+XqcnZN5J8VRA21fAYxSOBL5AoWTgz9BU18/9dQNb54CRFVZzvbLpEyaROBZ8XqJBddVZbVK/R+7tyq2u3giyvEgDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=YmckefAy; arc=none smtp.client-ip=66.163.186.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="YmckefAy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1719289771; bh=SbKqC47YEiLphLQ+D7Tt0Qsas1WuiKLdVeIo2pVYuLU=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=YmckefAyvi2gfhxXu+NBUiaGOGbdJRDrDwWhv2uMzYXnqkm7crd60cm0ZqR2dqK559k6MfZbUaMxaXBWkj3LBNsgjw0AW73wuKsWWL/CtUkTEstWuFjFU2zu1azzra+ibrOLMGLJQw1fyNqtmj74ZHwgKp6jlSV9Xk+2sHinaiEKHEbWtthlVWpHfbLpC1LL1MvgQU936RN8PZTVCcaF0hJ9/gBOaeD3iewmIciE1WDEvjvkU7ELtnk+1MkuZBJHP4omxOCBee4dMfE1j9Hl5lGMMKHHzNhe2GcohxuGNL3gIcneWKIxjEKKZZ/XxrAxiL4fmgzj00B0OkbOrotrxQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1719289771; bh=GvEZhuhZARnBFcpuOa5/hE8vrHOccDzoB7qnWW2cm0t=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=tbDPRz2l2NMocXiq//gsG/mTUinlo8LKXLpp+leWboibHMxzbYh02fI37q6bmebsAht8XV6yhybywfSl5BwvfvwrafEE2Smm0a0ck4/uhJBnP/Cbcp6CDHwdFsi1Xcz3y8L42hYkz2fRsPRu3Q9vnbuSR4TsQuA+x5NLd6m0pUJSeZ6tbJWE4oAHMho5wQnnIpfMeO6zltpm239C3WiOpdXe2xQcoKyTLWLxobvdb3m/oGtsafT1R6vlnkDAJCflhLVnnxpS3a5N8LKXVltCRiXyM/O2G1goBzXnuYS7T6RPhrGUSfvjBAzMhc6+LoE+2ZQcpue+tkgZDyw7d9yO5Q==
X-YMail-OSG: vW4zqp4VM1m_3.1GFEeZXYpA2fq66VIP_K2homzXpbBKLKQyNawkLXgny2n0g8e
 hPEL.NzntxzMjIsZ8Ttj6.eh7IkSkD6IxgJr5xdltpQBaAh5KRZOu_8j78MAmeRX0T3brlX3XlTz
 eW3MSwgxdw4inMVhUsawfsRhjdkUPbTlz9wHi7XpswW9A13DfwlmV9OhzqlnBu6.eLEKblAgoGza
 F.ZtjN32eoaGaG870qOjCVEahHg3tdfc.mPMs3Ivl9bjik03MwigrRvQzJflrGrsfdIu4maXYVYb
 URyBi9Q2PnbRfepGQIazjOSocm9nSmk7b2kPKV5fvhkcl82jczNuTQ9rFcjY.j6Lkswo39xR_998
 9oHy4yVOc0rbmLvuZNQFOFYkAftnyWnTntSf5unmWkgv3Ta40Mqn5e8N8Ma5xkK5J9XcFmrxHaOY
 2VNZWTxhk19Ws8a7dZwGhtzgHahZber.VTxwjDlA62V5CId_BHSnomwAwuqmcUzeX6W4QbmN0xfR
 Wu1lcSD39Bf0LIXEt6tqJ5DmpyTkQQD2QoxJLZOA31_r.k1N4jPAgOYU9FnegjxjvcV8KBfUo3kp
 6sQKALJyahLoEVkmpVXu_EKs1x4b1FuRlPpMn7JN8tEPMebtzw84wxcbZBU0d2ciXoS0GdOeB8us
 SiXZbbivGrvUZqtoVm7GxyrIx.kWw0HNvCpd5uSQ6.jtLPyPPAiyLuvomtkhaRbDHeOcDsvEhl0o
 FhTS4hW5MnPdDN7hgwf67OMdCtJ7HdvBnWXa08e6lSUhp1ZVl1RTa5748bq_6YIdKbyL0O4tkbQC
 tKI6sBdRA7hz.8OVwGksdoTFyiQTMG6BAF8pWieYubsxhirkMF56SJGjy22KWb7b1yCG11rWWkkL
 1cTSMAyASA0krmr29FcSLTwRxpTKudhICxuQwp0lbf6NXqJgqdIKezFBPQa44W925nt5Ep.kMjKw
 mQIr_IZATXzyra.frFirlRmpYKkFiIiIfsyntyA2qSbNywk5ACvli2eQYArZaD63VyneZA_h8W4_
 PkgaAbGRsoeiTUtRi6GgycwW8Noy4pU_vFH6O0CusxdaU29SLWdfrJkbptF4B2xC2zIXXXtFuVn8
 jDVO9QWRCmCPQUfQKDHu59CHIhlkfqhriFgr3_IhH0FNn88xdhKfUKdT3ELJciK5DVVoGpnW22Wg
 3ARMC1tujS93cV7E8VKsivwQsWSq.KReH_ye9tEoo2vj0nGXFSAUa9LI4EOfRjrfhq_GnrlJlCy2
 iGH6lDz7EsZlLTk65DwbkCk6vbp.ot03nvqTlME2_rvo6hY_dQ8aJR561MEh9_t4IDPAo.XTjLDB
 uzTZgUVRMJ0yh.5OkoEXYArgm7zYY9onexo5KYQzU6WVMGHZ1KehgMJVuIkrPXT1EZUjUXKxM1_A
 .Xe0pgl0iw5pijmofdzOA1.KaJsoahweyYHD94yVnCW9WArr3trtJH8u6vMxo1SvGD7CwG6Cu320
 Gf2xC1gFb6F_p7JFD6BUMPZ96byUwxKrKvtsXpE0oHS3fGjjD6ygrRli61VFzdluOKgdYtsKIEE4
 g5Lq.ueo5IAGMWecaxsQlBDRKwr5AuTqTPZyGu3XYZdXjzMdG2xfCF5YAg_QIKpHIgtJ6xHGauh5
 .gN5XY77mO1rG3uU2TUKwoXfkKnoZlQvDMxuEOJP3D_3UFXiaSgd_3f.b4ca3ZRSbtiNlnNp9HI9
 XqQeXr26J_nW7pULFPaQ8EAUlp1n8Oq_ku7X6aggwAVVTeGUmVc05vTB0uGnyl9j0f8TXQBe6YaG
 NVZ2X_1YrTb4U6me0Rw2OEOHPdkAIpxLlXs5KJTPb2r9oT5Fjw0wCTiaI4XXYKPW7rU42jNzjZbQ
 t3Qwa8ZWCfFSEgYCjGJhkmBRklg1zlC5wqFDzCf0_UGV_zVnNGF6bFAe4_Nc4DY869icITP7Gf0U
 5XGQrYpaQYemvmm8xo3dfXaSzYZR5gOAYLRwrG4zFw1N43F0RYR8Y9gAFJN_wm_EV16sl0YjI5.F
 jVr67ChLg6x2mhlv.ufsAE90Wx8o6XMY9pTFtw2NtYTe__vWi3NfBFdMBWlWfF9nz0eovBgaFry7
 FMqilAujj8gZkkTQNv4aKga0zV4q7jF._a73rEmVKkJ9B2JQBCRtFJYctWWaz7U5QqUSsIqDNeSb
 xchAuaLWiRnZijnqJVa.yMK01VciJAzRL0vZ5HZSB5izmcUDUQ4_PgrTkcwGP_1jGh4Vu_9dh54.
 WVRyahnf3CRNphjRjurNNmYHnD__oNzf4rhqQkx5Q_orFYQSI1suO6T9P6Q--
X-Sonic-MF: <gofronm@yahoo.com>
X-Sonic-ID: 61380ded-7778-4a86-a70b-9b517f95bca2
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Tue, 25 Jun 2024 04:29:31 +0000
Date: Tue, 25 Jun 2024 04:29:25 +0000 (UTC)
From: Michael Gofron <gofronm@yahoo.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <1824627947.974283.1719289765885@mail.yahoo.com>
In-Reply-To: <156587144.9842852.1719288870477@mail.yahoo.com>
References: <968676664.8436621.1718941871973.ref@mail.yahoo.com> <968676664.8436621.1718941871973@mail.yahoo.com> <CAP8UFD2mX+6f0TX4M2YKGC0v4rqR-Ng6syJzBDdtDZX93HF7zQ@mail.gmail.com> <1323275190.8859033.1719006830207@mail.yahoo.com> <156587144.9842852.1719288870477@mail.yahoo.com>
Subject: Re: Git bisect skip
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.22407 YMailNorrin

To add to that I had another question:=C2=A0

1. Is there a way to preview the next commit that bisect would pick if it w=
ere a good commit, a bad commit, or a skipped commit?=C2=A0

-Thank you






On Tuesday, June 25, 2024 at 01:14:30 PM GMT+9, Michael Gofron <gofronm@yah=
oo.com> wrote:=20





I ended up testing out the filepath exclusion with a test repo I'd set up w=
ith mock data.=C2=A0

I have two more questions regarding bisect:

1. Is there a way to specify regex with regard to the filepath spec? So I c=
ould specify something like `git bisect start bad_commit good_commit ':!*.m=
d'` to avoid changes that only happen in `.md` documentation files? I had t=
ested locally in my git test repo I'd set up and couldn't seem to find a wa=
y filter changes with a regex or file extensions rather than specific paths=
.=C2=A0
2. Is there a way to check the contents of files and exclude based off a sc=
ript if the file was changed in a particular way? In my case, I had been th=
inking if a file only added comments to avoid testing that specific commit.

-Thank you
Michael Gofron






On Saturday, June 22, 2024 at 06:53:50 AM GMT+9, Michael Gofron <gofronm@ya=
hoo.com> wrote:=20





Thank you. This was very detailed.=C2=A0

Another question I have is does the exclude filepath include commits which =
have changes in the excluded filepaths and in the included filepaths?=C2=A0

I noticed for instance I could specify to include and exclude changes to ce=
rtain files with a format like the following:=C2=A0

`git bisect start bad_commit good_commit -- 'mobile/' ':!mobile/tests.yaml'=
 ':!mobile/GeneratedSources``

The includes filepath is any changes in `mobile` and the exclude is changes=
 in `mobile/tests.yaml` and `mobile/GeneratedSources`.=C2=A0

In the prior example, I'd like to ignore commits where the only changes are=
 in `mobile/tests.yaml` and/or `mobile/GeneratedSources`. If there were a c=
hange in `mobile/tests.yaml` and a change in say `mobile/highly_important_f=
ragile_code.swift` would it include that in the bisect?=C2=A0

-Thank you
Michael Gofron






On Friday, June 21, 2024 at 04:38:05 PM GMT+9, Christian Couder <christian.=
couder@gmail.com> wrote:=20





Hi,

On Fri, Jun 21, 2024 at 6:01=E2=80=AFAM Michael Gofron <gofronm@yahoo.com> =
wrote:
>
> Hello,
>
> My question is can using `git bisect skip` cause a bisect to be indetermi=
nate and/or fail if the commits that are skipped couldn't have caused the i=
ssue?

If some skipped commits haven't caused the issue but they are direct
ancestors of the commit that caused the issue, then git bisect might
not be able to tell which one among those commits and the commit that
caused the issue is the actual commit that caused the issue.

For example if there is the following history:

G1-S1-G2-G3-S2-S3-B1-S4-S5-B2-B3-S6

(where G* are "good" commits, S* are skipped commits and B* are "bad"
commits) then git bisect will not be able to determine which one is
the first bad commit between S2, S3 and B1.

> Consider if my commits are like this:
>
> 1P - 2P - 3B - 4P - 5P - 6B - 7B - 8F - 9F.
> P for "Pass", B for "Broken", and F for "Fail".
> Broken commits are commits that we can't create a build for but wouldn't =
cause the issue.
> Failing commits are failing because of a bug.

Similarly as the case above, I would say that git bisect will not be
able to determine which one is the first bad between 6B, 7B and 8F.

> In this case, 8F caused the bug.
> If you tell git bisect that 1P is good and 9F is bad, bisect picks a comm=
it between the known newest Good commit (1P) and the known oldest Bad commi=
t (9F).

Yeah, it should pick one in the middle, so likely 4P, 5P or 6B.

> 1P -- 2P - 3B - 4P - 5P - 6B - 7B - 8F - 9F
> G=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 B
>=C2=A0 =C2=A0 =C2=A0 <------------------------------>
> Perhaps 4P. That builds and passes, so it marks that as Good.
>
> If it then goes to 6B which is a Broken commit and we do `git bisect skip=
` what happens next? It seems from the code it uses a psuedo random number =
generator with bias to determine the next commit.

Yeah, because it tries to avoid testing broken commits that are likely
to be around the broken commit it already picked, while at the same
time it tries to be efficient which means to pick a commit near the
middle of the range of commits left.


> Would it ever get in a state where it can't determine the commit that cau=
sed the issue even if these broken commits would never cause an issue?


It can't know that the broken commits that are direct ancestors of a
"bad" (or "failed" commit as you call them) would never cause the
issue, so it should eventually say that it can't determine which
commit is the first bad commit among 6B, 7B and 8F.

If you are sure that some broken commits don't have the issue you can
mark them as "good" to help git bisect which should then be able to
find the first "bad" commit.

Best,
Christian.

