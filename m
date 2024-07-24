Received: from sonic312-21.consmr.mail.bf2.yahoo.com (sonic312-21.consmr.mail.bf2.yahoo.com [74.6.128.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF7A15FA74
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 17:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.128.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721842207; cv=none; b=Xsd4p19alLenDFYeRHX0TCG0Spd1GTlkkoEyWM0E68WkTgBQRTJJa2ESxBve+uSOkmW4hj8nsHvUVMdnfZeydnHo3KHJnwSLyrx90KeVbskiS0V4wMmll0/CG290QXOQ5xqZDtWW2fCqzF8W6yRxVle2WjHbUcj7cBVpUHgGhjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721842207; c=relaxed/simple;
	bh=OgPOI410ogwMlr/enMV7brhQsC9wlIob4nz5gNGosFw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=cSJzpw6QNFnNBgxqHqLZuS1mpVtVL762zSCYUVWg0WyPHIFmJZpw+yT3kZ/+ebvviF84Ht+LkaSH/ffjbaUW5d3OfkNNHoAow9MozUMjpDh2vObUq7yTJrPVGyCFK+DpbFn5sLDhxUBfjDUYKDpXfn7ldMQSl/NA/OFVrbvU1Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=n3RAVL1y; arc=none smtp.client-ip=74.6.128.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="n3RAVL1y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1721842205; bh=OgPOI410ogwMlr/enMV7brhQsC9wlIob4nz5gNGosFw=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=n3RAVL1yh4vKU1v52rOCcZ+hi/x/i9JO2dv4za1Rtjaz+v6IFC1tD8xbI9bAeIE+9mpMxl0VDwHZrld5Jqu86QP/M/cKwexzDwQ3Os9ZXRzi7GEN5RzPSgI69UbdarTG36/i/NWWtyc7G47uHydIcZP7gstqjul4wDiGFhsVTlx3owbEVfI/DD1ymxkdShy34Yg4tU2p2fL4raT5oWtze4MAzHzLbWuinR7NnW603xNqgCvj+xZVOuOowTzCMQNKdytFbGl949x6HPM7B7d7wRLO5t9KR3+Tp/p9fr9SRsQIDBgbkU0WOZvprPm01QXXkM1DIGTRd2+YNb8GEyy2tQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1721842205; bh=Ys4DOGkqE+FxPnSl9/0ciHsg8CJOqDv0beQRt37FPur=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=JnGF5y5kYGLRt4eP5mLD7QEc90MPMvAYDYBIpZPupZRHQXFJ80q2lKIVPXF7Dc2+zEBGnMmE7iZE1/YExxSmE/PQMy5DNT1gqm98H4TKOIMLyEez4axRu/1jB5Be0+kXZTNMAw6E1Rqb808t3DoYUhsQaZCejJ4da7y6iD2iaT5TtgrBi4TT29jWk3p9HMucOW4czMQVIXuSippi6B57apaTgR4KT3kS3v1uDMNBodK3t8ixtZMFdmPSCwh3Q/l3CygrCAwJFTrAB2yFIa5IbtRSxwdWocCTDb/vTrywJpov6DPdlQkwGI78U8rpzP0LKuxoULGkD308309pg4m9DA==
X-YMail-OSG: okgwnesVM1lU4yHArhk7pxXhJCZkWl.lKrdH1p8l2gCbJY_9Q7encL_Kh51aQur
 pjSs7.R5R5Qj8vik_Q9DgfC7g0YFeHNNlUb.nDmpM6D9c7YfXQAk.RJd.42Q8nNEDWQnZDMPo8w9
 VhVx9a.7ZWbdD7ClZu2Axu2D.YYricUwba5CUQSqfW44l7qD71tcu9jYX6s411iPwjEyzNfNOwR8
 vcr1jK6oWNVm7fA4U.nWwW0KzBxKxtd5iNO.7gROjwVY9sQdhawhw2zmwmao.rLwdNAFM053TEYy
 g89rkV7ad3Gk4imRiHbC9tqoYBp65rDTp.JJzq5_CS4vbOBE33akA_Jj5SWZJV.iDuWnij0elAye
 cMljM2F7Hdc9qNsz.dO4u3EYZUMH31YzBoqmc.1ILueULjRTWk1LVNJlNIkUo8aPPccFTuXYgAaZ
 IQtnNCveymky4NunkPqngSJKnVFWChfpgeBvHB0fB2XlFqoS63dj9K02hCDnWTUgCe9i0Dd.WhV.
 522LkpOyymCiz5TfDCTZblISVqz8fmKxx49oVZG7fj1NVXKzZqDzyPOxVJDBPZpQbEQ.2eJfn7OJ
 9DktwqqvFP0i9d.6NDygJJfCs0IqB48Q10BTUfBBZUJUtkrLWe7.img2LoZDTbraQh9BKwimfrfw
 nJs1Jg7ulgCisWWdVKBM3z4dyIOa0nukp7llNMjxxJpGisgoNDo_ssAz7bruhDiqIkFHgztqIxIf
 HZwgcWFS9ZD3EgkE.Khe6QQvU5pZnk9AVoE4Y465vN5kwGQ6q92yETR8IC6KugT.MBfHRn.Yy2Mi
 IAn84CNkF2DbuxO.aaNzeE_11ZnvUiWhkQavLLwVJR7sdD1cXdtzuf_hM.G.FCOAbO60QPJU0pk.
 tAoSl4nREXWJtBHyO07SPCAlX49FSOZFRteWpg9CRvy7cVqyUvi6vkzsvFrPHlAaSc.l_XJ8FUF4
 vehCa23Yq.LZZHRQp.hN5DP47d2lZFLbqZkQnu.C17hIydsTl_PiUBYQgU9DsSze0qPDR3UEXePS
 890a4e3Ip9beIIvKVaTVO6uoQciDbOzX9l4LtxmJg.gVapf.KWhst4evVvAHL0O_Ft48J_XxUsUq
 7owpiTl7764p4PnmGyT0J_EevpDN1kNcTcGjwpoYq0PBIZbXVgVWgGFGrWJZ9fwZi90z5e5OqOPW
 t0aFgRCfLmxJoWUr0zbQALUG_u1zvoPTuKfnuIH7Zs_e_KLk.N7b5mndjkdR0xhnJAktY3lMpJFI
 TCkLyrhQNeHxrBY3eHYhy7jY9RQxfdI6B.1YG7X_l6.36F7ztFyHRNoSZXGqVvaDjtMYlecf8Hkt
 7TcTQNJduDSZrvTMitBkyjFcq_ioMpBVnQZ9mu7JO3wcSsvdoLVhxHk9aeO_mETu8a1wzEYYJt4I
 PEAQOiEADj13IrNhF1_N8xCbEWiftu5kwOC4DBsu6IWwtdP8miForLUiT9bYe8t3J0Oo8tQew..9
 o6Qn9Hhy33HJ5EweEU4krFCWabn8iwH5jkgsO6U0Z0GgZJMSp5cscvkOpE5VPT_sG6KlU.UOfiLm
 F8nMBXzc_0I9xODpI9D.Hm.TJudAHBCIZ1g7F3g1IYmch9zVN_SOMb0Q2aVswkRdNjnspeB3KKYE
 uYzGNRTDsGq7208AeNiovC4AoCf2JMflPw7AsvTzVv9UuTyChSf7kFq6XcuEeIkMipSh01nnjJDE
 f.UF3KPiDxNUWVtdnG5kYctCZQ45XG.I5t66bUYScpvNw8Am9DmkNbWddrd0sklKJiw50Jz_TddE
 gxQ3KsoMoM0onFiBlyWxaYOjL2xAXTk9Mtv2Gee.vvk9ZTo88UE6_ItqCRieThvFbku4Y505SfzK
 _dP4mpnuX8gw.I8xfMMvzlUJ.BqZiKpxbCiG_eOFG_Uj6aiHCxE3iWTgnapqRqwd5oETGJc6oiHB
 TFe0GaNURSVSzaOM1W2Vaz9qgeW9Qom_ThLQkQYfvJEeqkFgAeXQFPDrqvU2H6YeEhnYUc5hYL6I
 l_2nkRV7.7AF.FSk7ZMGyq2RZEPLsioOzBWjCJ_bW8PR4mQGlZt27c8ZQE28FKv__7cbXi2n3uMM
 OsWfIXH.vmv_9m819_eFo8uea8AKDOA343KpLsJztDnAKgfKY8fViHkJm_jhR.ChlElyg1ei9p9a
 sqq_OvYLLjzywQvx8L7XAQ915zlEnnqfF6qIzOCDtEnEXf0HzZKPkWiebZ6FkYXld5ovbckGMfhL
 kdkcE7jMFp1E-
X-Sonic-MF: <avihpit@yahoo.com>
X-Sonic-ID: d8eabc9a-590a-4955-b6c1-3c770bb1f3b1
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.bf2.yahoo.com with HTTP; Wed, 24 Jul 2024 17:30:05 +0000
Date: Wed, 24 Jul 2024 17:08:03 +0000 (UTC)
From: avih <avihpit@yahoo.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Avi Halachmi via GitGitGadget <gitgitgadget@gmail.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, 
	"git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <2104161937.2499137.1721840883913@mail.yahoo.com>
In-Reply-To: <xmqq7cdazu4a.fsf@gitster.g>
References: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com> <ZqAzpYuTrK6L-uyN@tapette.crustytoothpaste.net> <992128710.1986532.1721788902932@mail.yahoo.com> <xmqq7cdazu4a.fsf@gitster.g>
Subject: Re: [PATCH 0/8] git-prompt: support more shells
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.22501 YMailNorrin

 On Wednesday, July 24, 2024 at 06:29:12 PM GMT+3, Junio C Hamano <gitster@=
pobox.com> wrote:
>
> It is a bit more nuanced than that, though.=C2=A0 Here is what we say:
>
> - Even though "local" is not part of POSIX, we make heavy use of it
>=C2=A0=C2=A0 in our test suite.=C2=A0 We do not use it in scripted Porcela=
ins, and
>=C2=A0=C2=A0 hopefully nobody starts using "local" before all shells that =
matter
>=C2=A0=C2=A0 support it (notably, ksh from AT&T Research does not support =
it yet).
>
> For the purpose of git-prompt, I think it should be OK ...
> to declare that we now support shells
> other than bash and zsh as long as they are reasonably POSIX and
> support "local" that is dynamic.

I have to admit I missed "in our test suite".
Right, so no "local" in Porcelains, but yes in the test suite.

But yes, agreed, because it supports so many more shells.
The commit "git-prompt: ta-da! document.." does document it.

> (without
> "local", it is harder, if not impossible, to clobber end-user's
> shell variable namespace with various temporaries we need to use
> during prompt computation)

It actually is technically possible with git-prompt.sh, with 1 LOC.
See the "anecdote" at end of the same "ta-da!" commit message which
does exactly that. Though for obvious reason we can't really do that.

> Do we know what kind of "local" is ksh93 adding?=C2=A0 The same as their
> "typeset" that is not dynamic?=C2=A0 That is so different from what other=
s
> do and scripts expect to be all that useful, I am afraid.

I would think it has to be similar enough to other shells, or else it
creates a compatibility nightmare IMO. But that's a guess.

Somewhat off topic, so apologies if this shouldn't be here:

As for the Porcelains, I have to assume that it can be unpleasant
to maintain big scripts without "local". Would there be an interest
in adding a facility with the same semantics as "local", but posix
compliant (and also posix-ish shells), for use in Porcelains?

It's not a drop-in replacement, but the syntax is reasonable IMO:

=C2=A0=C2=A0=C2=A0 locals myfunc x y
=C2=A0=C2=A0=C2=A0 _myfunc () {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo "$? $1 $2"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D1 y=3D2
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 33
=C2=A0=C2=A0=C2=A0 }

=C2=A0=C2=A0=C2=A0 x=3Dx; unset y
=C2=A0=C2=A0=C2=A0 (exit 42) || myfunc foo bar
=C2=A0=C2=A0=C2=A0 echo "$? $x ${y-unset}"

Prints:
=C2=A0=C2=A0=C2=A0 42 foo bar
=C2=A0=C2=A0=C2=A0 33 x unset

"locals myfunc x y" creates a wrapper function "myfunc" which saves
the state of $x and $y, calls _myfunc "$@", then restores the state
(and propagates the initial and final $? appropriately). Recursion is
supported, the wrapper doesn't create additional variables, and no
subshells are used at the wrapper (also not at "locals").

The implementation of "locals" is small (10-20 LOC), but we can't
expect scripts to embed it, so it would need to be sourced (dot).

If there is interest in such thing, let me know, and I can submit
a patch (independent of this patchset) to adds such file which
can then be sourced by other scripts in order to use "locals".

Unrelated, and it might not mean much, but I did want to thank you
for maintaining git all those years.

