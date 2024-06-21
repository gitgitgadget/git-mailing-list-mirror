Received: from sonic322-56.consmr.mail.ne1.yahoo.com (sonic322-56.consmr.mail.ne1.yahoo.com [66.163.189.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E385317D888
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 22:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719007443; cv=none; b=m5JbEWfe0OPrHZiziEwYCLBNKDVcxkeZiQOIRWIyajOBUGFOmu2WvcVInuKALW8XbUuKufgGlv+V34uLLHuPdXYJuefFYavl+sEWOdVCdyYWjSe76Nek61ScetVoKg02uYrInP61xWPoXYPRG/5rpPnh1KEZFJ3Pf48v6yei6YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719007443; c=relaxed/simple;
	bh=bQ9JnFbUoOtfdr6ZlzILJM0I5kXzTiHygkhwOVS8O24=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=lvJCRi3+Plb/N2RdHcMRqB2K4UtWBuXOXJdWfUILEWEvrSK+yEmYWEASkKN3NO9ImTfgywSmSAFB9ED5+a6vOAN7ssoa869xHCToET/PXjjToSeg2A6fF7Sy1K64rXID0b/3bVQDzLS9Is3KprqQpfs3vZa7LyVtLlwfBu6RxPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=JNRsNXm+; arc=none smtp.client-ip=66.163.189.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="JNRsNXm+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1719007441; bh=bQ9JnFbUoOtfdr6ZlzILJM0I5kXzTiHygkhwOVS8O24=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=JNRsNXm+NTpJkABQBMnnn4TJUdP+5Mqbb5L7PyWw7SjVGLFqIsvJLkb3Da1XpkiOhNGnYbgxT41kQMFccNKLId6+Wo/e9uc4SrsheluRfmGgQv4F+mJTNncMOVGNXDN35UMgEGGo7ouf1P/rBwfqZxZ8doGk1SilfqZTUp9UI1im5DoQIV5xDviusuA0QOMeVi9qKC5QBHhQdoAjC82YHrb/phmRVe+i22fObKZw8g7sFCAuHz5kB6a1v0khTsy71NQT2rfL+Y0X7Wd4ewFo0YeAgwhwryHAZSPOUr05YjVTp/oZoDtrgtZP8cSWlgrvlnRtf2uSXolPY1c0kS3/fA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1719007441; bh=8Snd5BQiWt8Ue6yrJESopmOFqN42LG18SXTlCteCyH+=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=D9azYBqQd9Eu91zxSGGtU4LaMBDIkvGiIYsuLZuZaDfFtxxKEIQuQGV1ftPsVEffHokmuGlPlsz2zQTiMy7cF+Z8ouXCy881pSafhZsHgD69NkDvTJa86rTYQX+msEuUpY+WXYfgd3J/dQsfLR739yirLUvZwq2mhGi5elv0CsMoyXQlBDkfoXLtqRJdbLux6SxovGPs6B1AJumPkL3G022hD8Y36+37VUIzWRNmR9oeHIJI9HxKf00zd32IZyl1fBGdz3r3qhqQzxGKYJzGtjXUn6jdwtt7popkbzCtiMGbkc9PLk6bPYWt7IqIq+Zqt1neAA3rE8NqjJeg//kprw==
X-YMail-OSG: cws3RwYVM1nqkvUnMYI5Y7UM54r874.1tBw8o.1m7iVB6uXQQoS6z4oYmoFvq7I
 K3hZdv_99nso2V3gfj7Erm_96H.3Zq62AekSK4rXalQY7V0daPoZBxK9mOSVDda8XExT8dBNdXeW
 Osv_9COTaXWnGpU2JlyqiuQ4aRRewi.0EMnjv2i3evRSBsp_iJQtzHBUmT5oAeCb8zUfZkkd11fs
 qwFaP3Uw7rwX.6LkH4O2MyecPhYSS4Q5MBHTlti1Xg6ywB.pwUdNu3gqiA7MMy_LOqAnO1O2ZR3V
 6GVQNLZOJf52XHYeSM6LZ_4qkw_IwZ2OuYtwI8ZlgnE..OuVXWc6ns3lEPwal3RKkQTHhSz.8oei
 QdyzQebr4r8b3NnWBaKQoV9jrO0JmxV4Vvz0d.KY9ypK7uGfKnpyvsx.3j1SxhE6MoSpUYgBMXVH
 KT3SOrGtV5KhWMpdtDag88WfxVLuUC7LMuBZAVSZaa7EsZaisE.GAfikW6hudcFamID_sps931NG
 CMTbq5A07RCGbotmqZ3ibBrU1qjiopTwH.WsyW_85XTynpzvMubW5i2hJR00gw.p9jkpKWfqAHJE
 G3iy6.KkGMzg6.emd4yYJJeFCK1MxqZFOXf18HrdzDuEBQPlm4csOK98I3iKdddtfTJPTV9PDOp1
 1AUyecMougYjhq6JO07SmskR57hiWkQ52E9yYOw6_ahkO9JiviCvFBBIRSBzTPX3Hmx374iHDlnS
 nC2AkHfFX4Uwld.W7_X2L2OytjDxadjVUL9EtVSq5WZjhipAq3wOAkCskTNz24586iIjnhZYOT3v
 XXlDEcZayZjTwppuwL_HNdQx9URIoH6zg9FhQzXenYsXmkVRdgq5ZZWCJJafDEO4COWwtNdGt35u
 altOxocg4ueOzQVBDT55oSFrXCL84_5YkvdQbHrRCLggHOevSZPIIRzEZACTlouoNT0lX0bcm7hI
 Eo6nfjCY9Cjb31hSLNkmIQ0BLRdeBhQsXMCmi4vy1_eOkELpebOATH8KRP9knGG5oj3zoBLsBmPU
 YpTT8_N64w074lWENGoor.UeAw5IAiBt8LpWC9XWUPa1bJSi60v0vyNTp7RIjzaoRRNfvdCDpme0
 nBz07akZ.Xo8ZFr7C4gMm1JK49x7vqaKfhzTYnfvMXigKou9ekYd7Qp1J.G3AhXDieUqjupAz6qy
 vPbWT4e1S_roEuh8Kbpr5i97bWzffkiuruovXx2QRBidVHFylieNRIy_TxuIm6zjapiATdBXMJC8
 Oom57jzJmttSbr83swDG4hwyMBvK8UbALAy7MTSEtSbmRllfRtvV5q15utPN__mknTNRbZ9TS3L4
 GTbxAUVqZkXO2m5ZfMexZTdpPsTC7ScD5DiyBH.a_CbLGPPF1ZIv3REpd2Z_SNeEOnsgc9qHghnK
 7fCZsVncFh9.0mkpaznWMXVIGJHgk_Gj8x92Zx2fGgQcBWH.lqYN4cw2naCXMkohvdBqlpOKORJN
 yB7E8oOJAclhhgy8nsmiCP.UUElw1wn95ZnX3POoGiJHL.rmAOVSXf4OJm9vjAFcYUnY2rMH1Kdv
 fUuVU_H4M8masGPKMNLzQA2Qfcnj56OlVPyeiLZ5xk69RURr0Hw.VWYsCCYGDJ_WPymc1Xu6jrVU
 sq54BOxIcrldJ9cURVSMvhIbCzOurweDFGk3JOcA5Gu9R0W.z04sb0QxF2On6I72YKx0FoQeAu9E
 hsBPG3I_Je.mjeMsJGF7P5XIZrI_kwUrQS12Ag58hl0UrBO6woeAZRus7w8pkew0.EJsFv1uJKZr
 U563dzjH_zdVGAMXakVTcdwu2tJxzsD7a3VuDb1KtQ_kw0HTVThNXikpinHoqx63Vnob4S0dEzRH
 c0t6_VRx6vwsLXAEcHNlUiyR0Gcdjht9AEqO6GNxJk2XR_h0js9Ckr35_wz3l8lgHnybKuNykgiw
 HHp9h1B7gZmCsTj.SyOFzoYzcCR1FhPF2gComDj3J93WdCvCe0Ur8m2zG2A_AWQh3oydigPyuwrp
 U1nrCQ6YSqqCXDUmfZCLD1BCvW5Wg5Kk8ULg030cZ1oTJ9pYOqleY91CxtiAb_6bM6LR47_WrcBz
 NnSX_yIBxNlYzCdk.1NaBKUpmsRxRzOWVJKA2kim1a9LnzuR7ejIDD4PUBfwysddGdGDywbjppS0
 KX0mIv1xU8eGiZutysd9_zqvpiSz7tJdVTwf21fJYN1G6A.8WTBHcQOIwEK9s4v.Ny22A.RKcAub
 NDF.OvVSTKzlijeOzxDg2EcrI7LkJwVszfFXuAmoV8zRqwM79Me_mrXnA8g--
X-Sonic-MF: <gofronm@yahoo.com>
X-Sonic-ID: c99154d2-fe18-43c6-afe3-87851ce7977f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic322.consmr.mail.ne1.yahoo.com with HTTP; Fri, 21 Jun 2024 22:04:01 +0000
Date: Fri, 21 Jun 2024 21:53:50 +0000 (UTC)
From: Michael Gofron <gofronm@yahoo.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <1323275190.8859033.1719006830207@mail.yahoo.com>
In-Reply-To: <CAP8UFD2mX+6f0TX4M2YKGC0v4rqR-Ng6syJzBDdtDZX93HF7zQ@mail.gmail.com>
References: <968676664.8436621.1718941871973.ref@mail.yahoo.com> <968676664.8436621.1718941871973@mail.yahoo.com> <CAP8UFD2mX+6f0TX4M2YKGC0v4rqR-Ng6syJzBDdtDZX93HF7zQ@mail.gmail.com>
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

