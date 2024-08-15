Received: from sonic322-26.consmr.mail.bf2.yahoo.com (sonic322-26.consmr.mail.bf2.yahoo.com [74.6.132.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF295A0F5
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 19:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.132.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723751745; cv=none; b=W7tZmLUWlF1nbWK8ap1LmZyrLJSwVPzxjbIxNpq408J8INhRBy4Qx/CTn1SiCLiWeDV6G74zA3jNvtBasu1dbu1JURaWNynTjOoCUQjv60HU52yPtAJx+JgNXrDqE9cv92eVzP4YOmeoO0s9sc2mCmqqE5yomRERwf8y+nRS8DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723751745; c=relaxed/simple;
	bh=EoeY8GVTElyelmv7xJvFk7uXRjGl2Qs8dEIIsk6WIvM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=o2SXBtOqpzK2PEDpy328oJRKCYdEPFw1aIlYiAj6N6fRMzIiW76JWTz48rRaASOOkgz5hi2TgFlmumE30EfaXPhkdwYs8srERPHR/rmtTCeSK3xmnylGCyOhN3hqpbzndFrN0CUWMjNmhXgD/BQdq0zb4g/Wr7LHfbI6kPMIvbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=OVJrnN8M; arc=none smtp.client-ip=74.6.132.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="OVJrnN8M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1723751736; bh=EoeY8GVTElyelmv7xJvFk7uXRjGl2Qs8dEIIsk6WIvM=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=OVJrnN8MZmS7a6cQSUyiJJNjseGa6jVXYZCSoFhJ2k/+Sz+WrwEIrGrARiwbe6Qqi3zGvOwQkEKtSfJNO4982hH/9i3iW61f5tDOtDNPyhXYADY8MeFy4qg4snrNm8p0XW8YbtL93tcjHUkG2/cb1rDG4iml7zdUEUlUvWAzx040KQ2d2KU3DqXJtdOGo5G1n99n/dwP5OyKUYU5OhDjuQcMwukeJZKyaY4CaLANa4Ont7YlXyi857mKc2Rnkkieh/CjVXVJWTdLdA7FSTovH/zb5hTtrb3b6I0KykTLmjLZJUGyQ6IK9onFgqNEPE97rsElxkmuWMobRqTz8D4OuQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1723751736; bh=dmjL45/GsVErKOWTniI5CsrF8YgKvuGqId/3F7fjoXN=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=aRCTXZWuJeEUDCAqN3N1IJ0JmYLFtmhEiNGRe7N+/qnGa1c+WaKUbowctJDEDTqpicl/a4677F/0WbPxW3vhmm/b5/Rcp41jJi2aDZLzfM9Iy0c2o0U58Ec3ua9VuE2OmQxDyLXlbVPjO8A0Wd3gDnM0WBckwqqxgDG8mWnA5L20yjSzbbxDgFm9LxkJL+eZqNjj+Kssw3yvdMfyNwAz84pwF9QjJxRaiiY9lgn1SRVaEhBVN7BdN3hCd1iz97N6sRpoToNXZ1OwB4xuB787DMHwMV3OIDB24ysssnM6wimv106u0FIxqLdMl5Dv5ijqZbAz6Onl70p//xu9XMehQg==
X-YMail-OSG: SPg2BhwVM1mTP79MHTO8j1ZbbJ1GoWP0WskAmbOzXJF6VDRazNSCagzoaFWh01_
 K3cJ4eINLoH0xcZMOlBn1NzLseK72RuqzKrZPTZI5XdVsY5DaSTZWQzpIbDf3Tm6DUYwRqON5CUv
 ypeQhCtCWW3RikVYZFeSx65RrrfeuJetovNbzeRYF9g54V.i8E7rfzSl3839EK9C23.B5fxj99Ef
 mNfjJUpGXQusb5tK25CqwsOlOens_WxqX9VDMfrtpPYmtIKiiNc5fXLyEhiOwtmaRFb.7t7JW7H5
 YG1UV9ZOTAgxSfxGr2K0ZEeAi_eaYGvdKrR5osRXmJM2fxaHbCJKRju7M6ve.CbhvdD12NbDv4Ya
 InJjt1dtrZSc8arbEYobEfFyuO.sQvWNy3GQRfu4VWliJEuVeW4fhYcXhLyfQW8XwokZqj88D0dk
 xnMWUjUelrep1Ag97iUCjaouIlLTUrIaLdj.iPBuRtc5fIvp3AU1l8HtcsHk4Zjxk9i4iSBxU.RH
 s7KYQpAMhGUsVQa4hpEgPapjn9LaqVH_SGF48IoawhYGXFhEqBRF25coGhWDqAAQvIGxPLmURvBj
 Vbz8.XnvsxZygb78KMYrNkitLyz8SgEPjg3jG22c.TIpVM64wCawtAE8Vv3s_0Gb58WBvJJbdcuS
 n_cyHsKlHRImAO8DqzL76Tn9U7AkBsfTHU495XRCh5piMZdotjm1EriHw7N4rJSbaTLEMKwtHB93
 v4orWZ2Hvjl68s9QRRVKYt818wkZCr2CgpksW7d87iQsjRZ0d7fJ.kYuep4DUVoeIDQBUFKfdLvy
 dyuFd.19GvAjZnO2nrGQBx8TtPA2UzqZWTXO7Vumhp.E7YrgDr1eft5co880uBoXOVhuDauViHDD
 q0th44kq0xuVg_JLsHXEZbvz9VQMG8Umjed2Mn7W76vgJWeVq5eIGzHlvFlu4gug1oiDLDCtAwsR
 xyer7Rk7nxtwPeh8YlvNnKecOCDsMNT3XCbKpJfVIURGo38avNyWgbHFK3r_4bSoiHvCBYr1Bbxf
 NB38oYDlTqZn3UXgr2EZnnzzFnEQ.tuvsaaOKaGnpEIiPiRYviIGnJwYXBhLUMI4dTee3j7a6mEE
 CF_obcSpsWH5TDz8GIhvwG89YtbTZ3Mb4xZ2YCT68ik08_5WAdfNYqjyMh7A58XcWkgTz9mAGNK7
 F3AIoCJlAJlDTxTkwNRBD04V6llRq19Gvze0Ko7paSuHW2GTc_ZcxxRBgOoM8AkdQYNNdSpk2elo
 NdouoA0OtDhCQd8jIi7oB4wmDog4IdnR_ex.Wk51UTqfRy5VKVnuJSDw0JVGN5vVLqNgFMTGNU0f
 t_PrTGYdwNEJm_QUJJPkHbaI.Jyu06dlWNWxO6JiXByZe9P1FotRfHSm5DIO9.Xi28bWusn01LNI
 oLq.HbpfP6NH48LUDQBFuE_bix6aN56Sz581O5BjF624oZ6U1prPvTj3ahpZMYcVCHH62JLmnGYL
 ppkSdGFd1u5l9zd4Kv9NRJvRH.tZ5vQ6IKpZ72mvTjDtPEagXV7YnkrYbXSoEBYevBME2g.g_jfL
 4VoCV2rn4ptNSpA3xD4x2ETRlT8HwhF_7hq7QkQh.Dn7KTXeBT9JFSlxzrq1ezQEAQc4PDh5lNup
 tTtFEqJCoJYyaTmxSBx3wME8ulmN1kweHPxMi6uwlv8RKzs9dMoN7M3CcSBbX3Uh3O6PcwOr_YKg
 CyEmACVLxhcJFrm63HBux7qF8ZLwT6s3jQCwbQ7NZHM2AFLNEJD1o9VfV0aEwtC326pqQ4qAchIv
 aSJ.CN4HST5I5xJPZc43LDDNXoXPigVR30tzdhDa7i586SMO5OMR6jPnDVEeVjnOl9fUbNAHY7j8
 1V8sP.UdzGYgpwuGtA0ztifesCG_vnL7VXviY2gJUaRQuImAgWIlJWaBxh1qINyhonEWW5h3cY3W
 2WMyn4rI0Xtgmva.7nWl.HNizqeDkjGTVQBW.o71PJz78dhO7gB68dFQ.K03Y4uY3sV8LWkRv4aW
 kHOAgYAUeo0nF7v5YtYquOmvNCWI825oe.vK.XR7J25LALlO4kkrEanbZ3c.JmPUyQ8s6UZEEJlO
 TMly2_YxJc3E3dbEug_zKJGw0W2Nho4coEm2khZnuTbQFcGn1PUk81C97zBw3U1ztvwVSGqNtuMn
 hEh6opaFlvI8Ng7NomA1Nmbfq6MiIrr.uV.8yQo0T_sSMyNguJnZEBpKbsiOTg7LgDCQ7uvv3Zsz
 ZejKjo6bByBVQRa3oRb6jxmqq355hQQuS5cC5ehvid_PDFCyiNWAtWtvGrn4-
X-Sonic-MF: <avihpit@yahoo.com>
X-Sonic-ID: 4ce2cecd-c057-43de-b3e6-e5f9fc246fc6
Received: from sonic.gate.mail.ne1.yahoo.com by sonic322.consmr.mail.bf2.yahoo.com with HTTP; Thu, 15 Aug 2024 19:55:36 +0000
Date: Thu, 15 Aug 2024 19:53:48 +0000 (UTC)
From: avih <avihpit@yahoo.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>, 
	"git@vger.kernel.org" <git@vger.kernel.org>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>
Message-ID: <2093707499.4382922.1723751628640@mail.yahoo.com>
In-Reply-To: <xmqqv801sil5.fsf@gitster.g>
References: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com> <pull.1750.v2.git.git.1723727653.gitgitgadget@gmail.com> <4f77b7eb7f1110e47201b8c97c34a0cbcd14e24f.1723727653.git.gitgitgadget@gmail.com> <xmqqmsldu4iu.fsf@gitster.g> <1228065843.3779090.1723743313433@mail.yahoo.com> <xmqqv801sil5.fsf@gitster.g>
Subject: Re: [PATCH v2 5/8] git-prompt: add some missing quotes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.22544 YMailNorrin

 On Thursday, August 15, 2024 at 10:15:53 PM GMT+3, Junio C Hamano <gitster=
@pobox.com> wrote:

> Fair enough.=C2=A0 My "we would prefer to treat $? exactly the same way
> as no" still stands.=C2=A0 If the user did IFS=3Do, "no" would be broken.
>
>>=C2=A0=C2=A0=C2=A0 As the commit message notes, this is unlikely to fix t=
hings in
>>=C2=A0=C2=A0=C2=A0 practice, but it will fix things with weird IFS values=
.
>
>
> Yes, so I'd prefer to see us being consistent.=C2=A0 If we quote "$?" to
> protect ourselves from crazy folks who set insane values to $IFS, we
> should quote "no" the same way, no?

OK, I see what you mean. But IFS-split doesn't happen on literal
shell input (i.e. script source). It only happens on parts which
get expanded with parameter or arithmetic expansion or command
substitution. To quote from POSIX (2024):

=C2=A0 After parameter expansion (2.6.2), command substitution (2.6.3),
=C2=A0 and arithmetic expansion (2.6.4), if the shell variable IFS
=C2=A0 (see 2.5.3 Shell Variables ) is set and its value is not empty,
=C2=A0 or if IFS is unset, the shell shall scan each field containing
=C2=A0 results of expansions and substitutions that did not occur in
=C2=A0 double-quotes for field splitting; zero, one or multiple fields
=C2=A0 can result.

So 'IFS=3Dn; reply=3Dno; echo no; local x=3Dno' work regardless of IFS,
because there's no expansion, and IFS is not involved.

But 'IFS=3Dn; reply=3Dno; echo $reply; local x=3D$reply' will be affected
when unquoted $reply expands as argument to "echo" (or "local"), and
then gets split by "n", so it would echo "o" (" o" because reasons).
Fixed with quotes: IFS=3Dn; reply=3Dno; echo "$reply"; local x=3D"$reply"

Both can even be adjacent: 'IFS=3Dn reply=3Dno; echo no $reply'
would echo "no=C2=A0 o" in all shells, because the literal `no' is
unaffected, but the expanded $reply is affacted.

So $? is the same as $reply in this regards - it expands to some
value, so IFS gets involved, so it needs quotes. But a literal `no'
works the same regardless if quoted or not.

Worth noting in our context is that zsh doesn't do IFS word-split
by default on parameter expansion like $x, but does split the output
of command substitution $(cmd....), and code in git-prompt.sh is
expected to work in zsh as well (like it always did).
