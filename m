Received: from sonic307-1.consmr.mail.bf2.yahoo.com (sonic307-1.consmr.mail.bf2.yahoo.com [74.6.134.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29411A4F04
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 11:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.134.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723809425; cv=none; b=JRUxbGfsKcvLaqke/N/vZkwas5njD7U7JfsVRrU3PIEmzOUmqP8GJkli6CHuVvx7IF5eT2ebFs7aQEUp8cXW7WI6q96VvAO9Xjupf/1D87KzBsVgoYNXklxQITsWa8N8YAADvD9QYg6OYHVDfYJm6P2KmYqu7XnbQ5kUcoqZWL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723809425; c=relaxed/simple;
	bh=u2/Q0wc74Eglr0Lw/jLOObYlm6u8DqEDcjCL/vgZnEI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=quVX2cUyctuRw7z8z9wqv+itunwXet4Um6aog6OyYwgUJE+lSeEX5if6ZmCmR1oQ5s+emDKavK+yub4jAN3d0Elsd98zwUOj9WAI7gnZ5csyv5k/kzTRtat7inClagceLYhTAsVYfZwUxdBku0Ca4hxDmPdhemgoN/qFsrNL38Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=bvZ7TgxH; arc=none smtp.client-ip=74.6.134.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="bvZ7TgxH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1723809422; bh=u2/Q0wc74Eglr0Lw/jLOObYlm6u8DqEDcjCL/vgZnEI=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=bvZ7TgxHJFMNcrs+k6ImAFYhK/UYf7FFj0jsRfwJHSo7xFtDCeZPXqcyimglgJXZwEu2FbU88eJ2crWxQq28+YILTgXlEXcvfX/J2yJJAbRupeGkgiZCEKguQJB+lN/GunPYmVJvAwS/TZ63mNwqFBUHocs1zMi0o3PLKZ50jzN28yw40yFfskKdBp/q/8RxueoqdG3Rostu/wXaKv9E/ppm1TbaTw4Q8J9ugtihSuovVVYXGwadzuToGic0U2gKkI5AEvNlBk4B8m9DzSGKnnUjMyMn/WTipf8f2RlPP6/yvhPVyTqrKT1z7QfuY6hbHFrFC/CZjvujEP0kzVfiNw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1723809422; bh=Kz7j1tgN8eIedkBnvweHOTJLX4fepMzeZJamTaaKPq9=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=FVjNpgbnh+8N1/FwuKJtwLanIoLOe2G6sucVxW7cEjdiBdhsNQAvpzTio8g5vRJKmbpQhtY0HqPu7ukj44E5Z09HyOGBJhKDUcWpmOIqmaD5UbhlubNu4vccm62MNZRaDBN50c87YkAudup9A2OkUn59nQE/B33ChegptJfsmnUxhXvtxebdrmvlSOUGpExm6rwtiYCe6XxjEttE5FFbGrWuWD/3ehQHeW1ntJogY3zko9I6AaCEnNICaLP5z4BIiWsuPEqDH8FDl5auPkOjVm5+uXwlPcFGcRQ42f2MqUZrQ7LlgIsuNxvZP/ulHlkmOBqzu+MykhwpL1kc/t0kBg==
X-YMail-OSG: ec.J7_IVM1lbumHhegadsjRc9AH4wBLsNGwckjaEylWQAS95.FP2hvuO9otvgy8
 swlGvjUSo.zaIwVPD7ViIX0buIRUcGp8rOPBR0sb9rtH8s7aWACkUXjSciMB.U9rLZ..81Iz69yS
 hUbYQA1BfYfdITLeQ8YNxcmt40SCanbPw1vWqjAc_9QDIQhuhi0RzStLCsPfX2GQ0gA1PIUsJGjf
 2Wx2s_DL6ANP8dqPBq5BAMAp4K8G9uRpWgLRpwXOs0DfpSF3TKwpHNZoRuc6nWXtJIciGYAN0wyP
 H.78kdIhlI8X5peGCqci8dbmgqrtModhp.1jC4p_mY_EIcQ4RgwwzWavrQpncez1EBY0JSDd2gED
 fO9b6oZj4ltH7aFrBK48B1Wt1rGENA_ItIE91gHqxYwLcwEgVjHqBFnYqnpmDjuLYL0UdKSOtFDP
 2DoL_OamLx_hg9CwTbj9U42B.bcFq7Ek.cwOBk7LIHyW.T4V_5yMi7lZEXBMskr2jL1jo5BHH5wp
 F6jWxnxYfuPtxPHgVT5dp1PhqWEdJMqpKisP9iQN3R_6yImbSLS4IOusOoJhJHOtpRPy8Uei1iHA
 .X9e2zR6jY6bEzAyOg0Lk2neiYYiN0kX_h14YCLcnzuKijhw_fY.d47obtVdh_Jg69N9SvOdUk0m
 AmIDAUA9f8L8uxu2y8RPlWtidWZve0cowTQKyYlkEKu4CS9524X.eff7vmH7_dlxx8MEthWSL9i0
 TBavpIwSRdnXWl9Nb_ok51LcCb3sa4exmJFDuPI6Rgp.geEq.SA4cuJZRr4pvzisjB.PMGDAdMhT
 OJ4mcVss4zFyzO1XniN9361O.mMnbeAsNk7v_0AD4lPvN18HKhnMBWGFx1QgoXPpd1RJqQDM.rGj
 U4oAo2OQWkJqm7BgiHC3pkq6siAoG94VChsvs.Q2jTmCYitmJ97yVaFuuAZqLCMAFvjeq2JXXXCu
 baAj2NQt6POnN.vqOuiVfiHzv83xBGwDJOdu_yJ1IrKhJ73ZYAHyZZ_nzvj0_aF93Q3hUgfk3ZD0
 OLIJ4vO0Z5ry9peD3gO5eacBqbs9R4NuAxxuvWS89.kjz5z3Qo_8Wf3Q2o38mN7OK_rsdykNWZir
 _XVQDj9G_eemAf2DTWPuPN0xI02uWWkA5I9fJEwbeyB7L3jgUiQuy_QQKRcj80pIpgOd06RUDBIT
 v.G75th2SE1qAiDh_Vj9eFZ16KzjI1iGpni5u25v0IGk5W9YEyoOQelmSIy.NMxdUrE_mLsukoT4
 y2H3C0HkqfTrRo_N4.zmjoE0tWsYruZkLsRJDllHUMMWXg_P8KUbT1bIsm9ttm46xnrpB6AX8z1G
 qH5nMEmgQsS3mDdGCsO0lxT3zqPyy5ZKqiCJrSIhYSyLBe9IjL9FQGUr1sufVPUx_z5l7vI5yYIJ
 XrGKsRlTFM2JUA7MqKOysdYEOJ5iN3.WtwpIV.HOpixrQycsSD_4autTpcYmvsVriyjQoaeJeClc
 izuMRVLmDXbtuEoVXY_CkHFYp5myT35LoeA8sCTjjlD.R5HIbgCsHEGz58MvYFV4jAFgLK6JkRpj
 G12QmpyQxcB8GI9JdKEf6AHOCOsF_Ns9sPTo516foK97mCNRdWYVfNJ6c9DzIhjjcFaHUpSpGnPK
 xU5TPcA0NqifkwFCwy2lR3MKxLIPiXAxPN4ZZQwN9_89eKudsAAO_dGDJrh2e.Da47udga1xkhgx
 2o.EwjYbbs2opnpM6rozxCY6UMYBustOJqxk3SqJqg20i4ZIeC00cBm6hCD7V4drhTSCSLhmZNSa
 jLnoKHkbXFmgpahgHyw9QziNb1lMMM.KMgzwNP3QTDoC.LQdZQIxPM_jQ4ul4pdIcHM2FNjvfqf2
 ZO8QvfLzoX3_TDoNKZH683qwoKPYkx9c_.6TAZZa8uMSe6arZiH1zXZeMPAjVFEd0hqKfu3gTQ1u
 njVWpyScs2wJmYhVXtxR9fJ96xRM9soyXnRfTimye6_zTGr9QrTDQEzJa_inTcEp.BuwJl3iO71Q
 GXnjKCFdkVxmRPJVjJeDdu1f.p1muurrPlD1baL5RksprwREj3lgE6N7sukQtraskkMqNbp0TNnu
 UMcoxhewj6TuPFA7aPAskc04ydbsXnRmKw96uBBgVHyvtvuYncV9B0ydd1j8tMbO_Eqh6THgqYCJ
 bWLCirFalS0Qpl1IK.xObZ6pN5.MOnOub6QjWQwrTlm6pesRheDj4Ji61MJry3FCNB9OBMuOuKBs
 J4qtD9W1UD8nt_Qgd8UmhQELVSAwjkFrRYQ--
X-Sonic-MF: <avihpit@yahoo.com>
X-Sonic-ID: 20750778-123c-4556-9a6b-330689cea211
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.bf2.yahoo.com with HTTP; Fri, 16 Aug 2024 11:57:02 +0000
Date: Fri, 16 Aug 2024 11:35:33 +0000 (UTC)
From: avih <avihpit@yahoo.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>, 
	"git@vger.kernel.org" <git@vger.kernel.org>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>
Message-ID: <701460728.4505561.1723808133505@mail.yahoo.com>
In-Reply-To: <Zr8vWCKrddYpABIr@tanuki>
References: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com> <pull.1750.v2.git.git.1723727653.gitgitgadget@gmail.com> <7e994eae7bc3dfa021262410c801ddb124ce24f1.1723727653.git.gitgitgadget@gmail.com> <Zr8Swsn3H2ebB7g6@tanuki> <1677713578.1741123.1723802016957@mail.yahoo.com> <Zr8vWCKrddYpABIr@tanuki>
Subject: Re: [PATCH v2 3/8] git-prompt: don't use shell arrays
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.22544 YMailNorrin

 On Friday, August 16, 2024 at 01:52:11 PM GMT+3, Patrick Steinhardt <ps@pk=
s.im> wrote:
>On Fri, Aug 16, 2024 at 09:53:36AM +0000, avih wrote:
>>=C2=A0 On Friday, August 16, 2024 at 11:50:14 AM GMT+3, Patrick Steinhard=
t <ps@pks.im> wrote:
>> > On Thu, Aug 15, 2024 at 01:14:08PM +0000, Avi Halachmi (:avih) via Git=
GitGadget wrote:
>> >>
>> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
vn_remote[$((${#svn_remote[@]} + 1))]=3D"$value"
>> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
vn_remotes=3D${svn_remotes}${value}${LF}=C2=A0 # URI\nURI\n...
>> >
>> >
>> > I was wondering whether this is something we want to quote, mostly
>> > because I still have the failures of dash in mind when assigning value=
s
>> > with spaces to a `local` variable without quoting. I do not know wheth=
er
>> > the same issues also apply to non-local variables though, probably not=
.
>>
>> IFS field splitting and glob expansion strictly never happen and never
>> happened at the assignment part of a "simple command", since the first
>> version of POSIX in 1994, so quotes are not needed to avoid that.
>
> That's the theory, yes. But as said, we did hit bugs in similar areas in
> dash where that wasn't properly honored, as Junio also pointed out on a
> later patch. But that was in non-POSIX area anyway, as to the best of my
> knowledge it only happens with `local` assignments.

Yes. "local" is special, and not only because it's not POSIX.

The difference with "local" is that it takes assignment as arguments.

A "simple command" (posix term) is composed of optional assignment[s]
and optional command (and arguments).

The assigments part is never IFS-split or glob-expanded, while the
command and arguments part is (in words which include unquoted
expansion or substitution) and therefore needs quotes, e.g.:

foo=3D$x bar=3D$y echo a=3D"$b" c=3D"$d"

There are other commands (beyond "local") which take assignment[s]
as arguments, like "export", "readonly" and "command".

Before posix 2024, these commands also required quoting of the
arguments-assignments - just like "local" needed in dash.

But posix 2024 introduced the concept of a "declaration utility"
(which takes assignments as arguments, like export, readonly, etc),
and the concept of "assignment context" where IFS-split and glob
expansion don't happen - like the assignment part of a simple
command, but now also in the assignment arguments of declaration
utilities.

And indeed, new versions of shells now don't need quotes in export
etc, and shells now make "local" a declaration utility which
doesn't need quotes of the assignment args, including in dash.

However, the reason we do use quotes in local, export, etc, is
because many instances of shells which don't yet (or will ever)
support it still exist, so we quote for compatibility with those,
but still it's only needed in assignments which are arguments to
commands - not in the assignment part of a simple command.

I've also updated the wording a bit of my guidelines in part 5/8,
and I'll include it at the commit message of 5/8 v3.
