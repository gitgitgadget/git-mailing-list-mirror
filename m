Received: from sonic322-9.consmr.mail.ne1.yahoo.com (sonic322-9.consmr.mail.ne1.yahoo.com [66.163.189.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC9013C9BD
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 04:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719290703; cv=none; b=sHYU+HufjVd2P5eZFiR6C2CgWfFyanHgRPyAB05qJvSOOfo78HOepRhLZ7syal5x0t8OnA5rxkGnG/1DzVVaJikaQ12YWzqIouSdb5lwF/9IDgUKgr2hWIEuBuZOA/uicCCJgeWXyvf+pN+5Q8B9IpoiJs0NY2xMkCE75Q8rIXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719290703; c=relaxed/simple;
	bh=8fOZB4FsGVnPfB6dORxmMEtK2x5FJLFBeR+wtCvwNVo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=RRotN+stQaGx4YYtaTBK3Npb3Xl08fXTkEIP2J+MCocf8oOMAk3GC4iTCRwjbIGorKUT3o2YRj9xgDJobD6CHwsXVMhS/aJzw7FPU/TIuRWDFoaeu8xoQmDYeku0Sdd9aEN2cO3BLRh8rPTl8dK1LGKEVT3Z3hxIMkW5biLJnns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=BrzKAXdL; arc=none smtp.client-ip=66.163.189.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="BrzKAXdL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1719290695; bh=8fOZB4FsGVnPfB6dORxmMEtK2x5FJLFBeR+wtCvwNVo=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=BrzKAXdLYo75YOwVddncY8yAQONA++hJSuvd78YIRCj6wPtLxEOV5/Z9yTzVm2ZToAqh52BK1xF7NM/Y6b5K5dLWv76aUbvAKyKA3ip16+i6/piRWhdWubCFAmWXfq39L67TPGKFavJbsVg4mdqRQ9tOtDJ84imgZ0v5vUXnE1rkb4vH9+cm9NOx2S8bLoj0r0Slkbi9Vf3prPsnfO+Y3OGPn7BQYjmK2vlTZJ1KU+3bLptsJWuGW2eH6XW0mJWNeo1rZHq+Lfqu+N0lEd4jHX0L0GdtyzdfLnIRK43fcLQYLWfYqWERsGQNyQjwydOjVqV5jzxw6q/gcgLVVHFokw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1719290695; bh=SGjMGIs5WjKJ+xrmJpmpbEpUD/D7fyc/1O15Q5lvmoe=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=LV4c8Txr8RFG3t53aZs0ZryBG8ahss3Wt9Y9MoL86JjpKq1YnRDU0wdSnGosNktmT8u3DLKnc4aemqjSZ9BO2jim6PQTSFhajN3r1lLT1evSeEQEEKej5gUDYmpefPko2W7KTao65XkhvomroJGZz5XWr9ff/UlCEBYPcTDi8mf8G+GXI4K/53ZGLS1qxcnI3VafbTqlqFjCLE/tmFw/Vbucr3c5Sua0XKCPs5Yi9c9MmgYOrOjZBmYtjwUB7qiBljXQyDZ4FRdqK9/RZLDtmvSswaeQfIFkM+/uoFpMz+VFX1HZPjzkojpourAEcMLgGylmtCQ6YK7/5uwQcsGROg==
X-YMail-OSG: e9peCNYVM1nubyHEWYxozQi29aMqGXhy1tQjTc16IEBHaoIN3nXcArqdteGZRNV
 s.mAz7jdvDC5lMfkoLfSS3YDvnO86OG_C2xX5BMVa8HB38RjOK9ph_RCEBc6CtgbwWdt9Pf21mCk
 Vk4TFMxC2QI.oJbVgnGvlBI43jnaKxp9M4.1ujaBErLwN4p_1MjfM0RFSrCzM3BOh6anSr5_ii_8
 TNoAWt1yBLO7SX3YV7sG_HqbUrqEBvOK7P4eP8RjbTj6eNbKYFoJyh.rtVFuK4cFNvihO..0BbW3
 vF3G0H4i.plaDPfRU0pViyx099crCtDehPu2y39DPJdMVFwReTUUtQ64B8Vzt_CvPYZb8gV14NUs
 GZcsBUHP9tTcejkl0BJ2YKEOzAF20.JzlTu3sRkr88tc4yRM2jHtiKWZZU3zTkMRz6ztK04euA1n
 KSKCxC8jahkF1mi9cPUS527qeTIwSBDsx6kJvy3w74var6L6l9X7ajYKZR_lmmjF8geiW0NZM9f5
 uv5pp56int5Oddqcty6kq0TrxylFOs00O4ckqjw8SQqLuXB8AIRzBcZfKgjw.WMVomSeez7TOXzH
 qm3sggsepH79SY6pYGN.9efU4J5m6NmSYdwO9qao.Sk._vjYZtkYI.fbCS4aCxP7JVHrYJRJFqtF
 VlhvNNXcc.W5t_Wm7NdTZR6LF9WTir5H5419odaZri539STSbUlWCmnvtczacILkBvnNauQAsU.C
 WcC3BCktQcA4knlNMpDndIXdtyyH1g_PUBRGGPo.A0kS4WnYMRvAT7d5cbP2olYQr4tx3lBxaxW_
 1zNr676U7JAjra0x.KOsj0RspjOmQc9NhNXQsGdLgmH1UFhzivGu4Skx4YCx.8ZfTN1v43u8zCEZ
 KlYz09iNJrn_EIEmjLB74oeSb25haxMSImU8hOTFELVBCEv8ttuyJhG9X2psQBQpcsMEZyNOfNe5
 yxw8hDFTIr7_1s4Bf8DPle1DFMZJrZHVPBwQUC50f3zgCP5AoMC8j5UBGrKxDuy2rR9YbG3CrrRt
 BlpEw6Nskieqf9jUSu4r7kpS8tr9JC3CrxJ.Mchx3Fu_Dz6RH43bMfleK6Z1G0raIhNpO1vqW97r
 h5rR3ItuZyq43mcU1KFHzctJ.TPaqRAlJdWvcOwNNTts7Hk9qS5WfEeICwTNryOBVUG7eTsDI6Vb
 FkqGdUWUC056gkqseUJifzya.pBxjpyn_w1MMEDbvRQtPICkaWiE5.0SOyavBUtA_oYP7ixULURS
 lZ3dbU365zovoXvWqgVM8PygFBtbevckrTU.tiotWkmax4HeJbv9ojnjgn14bHNXZd0vMAKp0usu
 VfLYHWYYtRSUl0LtH3s9QrMSFFYnTn0ym9oHAQk5xUikMD3lS3hVIFb3_vqIhUb.w73G0vRTAwQn
 O0Xj8dS8uD8jcgyFjLAriLc6ckVW_1qL.b.EZ76IQP50A7yMKjTUwM20CwnftWRiitMaurZ97fwM
 Bb_7zLHSGn7Libxft.Q3QIysXz0twX.0oeTW5FgfwH6HgBsPyhB.jXsiht12HUYsq_w5nxh5gE9z
 ukDMFsYuoeTHejk491NFEZCQGo7lg50LDO527jvX8qaQiTuxTzK4c4FRheU9IkVjLaTFTM1_NMWs
 bZOUhSQc0t9SRD3S1wvRmfAad1asDyf9Jk4.4EKu3lIS4XptqmAxVJhiJYtAw3Shv9YaKVxodztY
 hmQXYZMYxrLpB35rDM6_nVy4QqQPI2yP6j2fd3hnR5Txrjo3RBeiUQ56oAsGumAnye2aIU9Tu8el
 lF.VIvINGndbamYbgzHGTrOoQaURbc_rjhBnkZz5uGWfxawekOyJ03DjG5HEsgSmIXRrHufTLG4e
 Y3WHSp_nIWe8XJv8gEp1AaXcf3bHIBTh1NzzJ5UxR2rg8ZzbEzHL6laSgNOgbH0.FQsr4ZFFPakY
 efJTPxOxjB_H7cHWhARBK6_8b0ChUdvv8plD9D0tsSt60mv_K43ycST1L62ttbBEf2W7jABSOTcd
 z9i_xRmY7osNWfoGUv1jLvRKXwM3PYRIoGWCpfdtuXmVrzukZCGGPAplUOZMTSmLy4l.7HlxIIi5
 FK2U2wEBP4beFD4.rKCq4xoY_iqi5hfrFICW4tov9fsA97hUilQCv5oCufgIsU012b25TJFPeFhY
 IfTHIBjExOB5mSGzdPUWpEoA1sWd_3FZEPejtPSZfLwQcvhayJ_jA8AxnqPNWFG9m46JIh6HPl.U
 KbJwmk8vVoBcRz098V9w5SSZK_A5fGfGXbsO0mzk8XMsW2hUhoFQb
X-Sonic-MF: <gofronm@yahoo.com>
X-Sonic-ID: 23e694bf-efe2-4845-8abc-dba466f11059
Received: from sonic.gate.mail.ne1.yahoo.com by sonic322.consmr.mail.ne1.yahoo.com with HTTP; Tue, 25 Jun 2024 04:44:55 +0000
Date: Tue, 25 Jun 2024 04:14:30 +0000 (UTC)
From: Michael Gofron <gofronm@yahoo.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <156587144.9842852.1719288870477@mail.yahoo.com>
In-Reply-To: <1323275190.8859033.1719006830207@mail.yahoo.com>
References: <968676664.8436621.1718941871973.ref@mail.yahoo.com> <968676664.8436621.1718941871973@mail.yahoo.com> <CAP8UFD2mX+6f0TX4M2YKGC0v4rqR-Ng6syJzBDdtDZX93HF7zQ@mail.gmail.com> <1323275190.8859033.1719006830207@mail.yahoo.com>
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

