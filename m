Received: from sonic312-21.consmr.mail.bf2.yahoo.com (sonic312-21.consmr.mail.bf2.yahoo.com [74.6.128.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35A2381B9
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 17:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.128.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723744138; cv=none; b=pBhhwcGHH9Efp5659My9LsT2IuokHXgymPWC8vUGiPsR4bHyZK1+PkvBCNkgBofGlOsH3IDOKJc1uYTJpuE2oLMD5kLOHAn4VXWr6CnL2EEpDQc2TmCUqr/Lx8JxnLRJF7TuV8J/vvb/WgMrvXXLAfQRj/M1Td0SwNTcgCVLOWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723744138; c=relaxed/simple;
	bh=3bDQf5oq1Dp2rsVXseFMjJXmGznLUuirVAIATNn5Rjo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=q5Ya9gRqCSWPNlRLbeOlyUwayoZYrrvUhCaR1iJh8cvZAKdgiExHUDSCGRN16QEUPylddxveP3WVaqs0A7jGSL79fn/T/uOKCNaJXfZcobQ6prYepoG7Xg4opsNNTB/xqmUZaAQWIsfPFvyxCbpDzzDS5w13VUh+75MjDt9cNFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=s80QBxLv; arc=none smtp.client-ip=74.6.128.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="s80QBxLv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1723744132; bh=3bDQf5oq1Dp2rsVXseFMjJXmGznLUuirVAIATNn5Rjo=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=s80QBxLv5LEDoiB0Qa0OVjw/by3Yn4Ie/XP+tp64pNP7AbFc+q99rkUeN/+95HtiNEmww2WHGu6ZRm/8Xls1kQ+1lDIirNzRLGPamOK4hcUctr3oylqcUp/PtU7oNOLUpt3bATXBPH5FtXsK8ohapZvkgbPlCI9NwvxBysUfYHeeC5Q1de5E360OfVvO2yMAnJx1U/fpDEntDXsvp5LDEXFhYUXzUWktALMvkbsw99HSBpa1OXmB+SbL6E/ubsI6m/3DCNZPIsOAo/iPwVaFS+3FgyZQ4vH06YQ9X21iQD3ROQ+UYlITE70Oom/agvfi/RbORrT/8WY6AeZHphDf1w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1723744132; bh=RB5l286mcxRko2jqlfPu+g8WPGSax0eFkRHHoOMdpvM=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=bbjZzN7LpTaJ1NJucqR2gAi56l5zG+3UQU3BT2HP/2fUt59sNqoBwPp4Nzfk99agyp0A80pyc3ObXQwA7mi2Jq7sKUDqrUgihYmdZyEhyap695hAo9S4vmnMNC5Cv6YCYl9S/z606AmLZCqXw8GQdwvdy+a0SfHjfIMfp+FOowLct6g5Cyx3S5sxLTbSkHvO3JmpEyJugXIyx0yCWJZVnig5iW/SpVJBcr09b3R544ve9ZHM1puFjw0hkLIpcRobRFZfp6CGPxUz8tJEo6S6t4SOy/O+u8pBCvYdHrc3BEEnyfWHM1ps5ngXaKDyk9dIxws+euI7Z3W+2UiNsApf3g==
X-YMail-OSG: NAWgoM0VM1kOUVe2xDJqO14IuS7oG5.ioopjqf5ki.Vdb7CoCfFh3d0ZDwz9nTW
 flkoic8rFLqC4gMHvrYbKPC85x7OWEYIGds3JmtTzbhjarORuIQ5Er6rMxZTNslW1TMeRgU_7.ym
 bai1HGuNoNPM3llcAMgLeKvAw26wSz3KQNfRSqWHkXHrD5GaD2MI4IDVnEhXatFYvvNmxK1sKK0D
 mMzUz7.nAgRw2TLLWop7surzhcndVF8lFWaSE3FauM7kikI1iwgq6NNOcvJI.7MAJb40I0l98xFr
 O1EBaZQjs3c5B09r1ogv5KxVND60Y6OZwUnZDKa.Jo2zr71xJzvLdeO4Em6Egx1z6NfU1dXdAVnr
 LVF.LbMBnpTUeYPIeOmJXjuSoqwvuOi6a3cLQUJ9GJrig_OH2N0OjLDgKShTACdSuTiRJWK6KwPS
 UB2ZQklw.GaCmRxCIi6MCt.eOC4__cKkKLKIWJ5umwO2RZg72AArfh59DDHcD3NA57NvI8fKgS6T
 Dxf75BrDhDBdPyEeVnGlvwDB10Tt5995UFsZBIk3DU.byciU6OK86tDyytpNqhXRb4YVN.wzUcui
 6c_pwRGX.2QACQ8hEVK0UFsBR7ta4l16a3o8hKYzbq7dWJ3h6lhOyKXMx9DMwe1FfFj77feFVmw8
 8mXSOBlp4xs7foVyDg4..a.qLRBmAGUTpUkCLZjb5ZRNgoDSuJWpogYsi3uDS1qsET9.YTMb5kIt
 eMonrLiaI1w6WqeMI8I_mNV3uOPAGpOI7NiO9XzbZbiBuTyOsh9kUqCpmgtKdR6F43VKSDR1tQLg
 lUQZpjVWiBOYDbbPS_pQhy5VpauHB6gQ_2qAx5qhVQQ4uowMgzkUbiAD.aOjiKA0BLDuknWMqNvR
 _4dsLaiudhp3w5jYUubTVEOis_PHzcDHkoToKZa6Ne1Fl6EjagggDSd3mGdoQngzoJVsYgDzeVGW
 9UNx0YzuT7drXY17t39PoX_0TjxBiRahboIjwX2EDOvb1oLg7o_xMkRFgjtcAmKTJwFwcghT03nN
 ujbux6GJj43KKfADiX7VZpXaUPJH4ifQF6uEvF_USXlizKrBBse0KpMQ3KR3mjkWqOw6fZ3v4wqg
 4.8rzrBjAXUlsoDDSB84TeoVBQaSUwtYjYZfk12XGnNaHkPfoA5vCp8ph64epoCXiQHQtnu9kL02
 AsIMtsyzy5eqXB3H6YdjFVXuCPZmpihw81xtkvfndh_ExIdJhNsAeNIAuUhSC7vQEVem90EugZ8m
 Tu1jINSblNl2e0dtqAp0TvhYMAyVqGv8JEU_6MZg80d6DEClXk_vpxqKvwzYbZbA82weMQ6VxNVQ
 L.JEpOHFMSSBbkeNVz93FXnOE1S96MxL3uCux8wbDqUa7qpIvtjkuxaRStm_XNH80pXkFo_l9arW
 QtuAwz6yXdqeoeorH_h1Lm7aitWz24Ad8GK1evT8zUjQb1ZV_X3tGQZBQoYbvkrN063d4VNqmMxI
 ZirdEx9BMek18sufj0kYKQDK2gsOWDk904jqD8J5cDwlXbZmhifXB3nxKNOmGHWIG2qcq3XwMZB4
 6LfQ4BgL_1nZu8MTg4P3QASo35j25twGsYDiJf3TWhlyF4rR6ieDLmnRw26ZBr26eXQaU0ApgkPA
 PtjgkhEdVi9La8HKd6QsocRptvnAy4yxlxtmRU81A3hFK5g_CNsUlcL7EQDGAkuY0Ec.M1qoXbiX
 b58KYzjjNVGcP4NCYTMc1LJeHjPOIqhyBTr0nXWnVPjdR0ma_pT13bFl0O75G_aTEhnEh.7aUmXx
 ovBsJ0SeUb5iIUzMZ0XsHXxL3RQwhzxFX2SabPE7fGaqg_Qml0hMlrhEKB5pw59tNFhJP5tjr8yD
 igwY0yy7sQpuqlVrO5zZbHMeXrCrD59re6N7zRTi67AALUPi97WNioLEa0E1Ik6xqE0XlIR_zdgn
 XNk5r_cG2u6voFglOedxgVig_mJbaDKl84KXKDFgaJQvJEvidYJOUIuSStvp1jAFfCJrAcXSZfqL
 KgC09HqzSkjSbLBjZu1q06A8DnkiSwsrBDhfrWAGcutJ2BQSyPgSjzsp7eZ9AFkgXS1htroxwf5w
 1W3eXuzfJ3dJkYO3qtLRR9qGFXDc.5HocWiLBzLsA.eyrZHLgM4vlRhfPcrF2mcYaE8UcFExHzTz
 C5RyWNys28IIAfyNxnqaGPzDkuakOyvAFx6gGbB8eNhKVfn6kWUnBlLmuvkZmvj93IxDUPnvPuLo
 4VvAia60n1w9logX1gh.KroDIGnNpIDhY
X-Sonic-MF: <avihpit@yahoo.com>
X-Sonic-ID: 494a284f-408b-4bfc-bb1a-461c2dbd3fa9
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.bf2.yahoo.com with HTTP; Thu, 15 Aug 2024 17:48:52 +0000
Date: Thu, 15 Aug 2024 17:35:13 +0000 (UTC)
From: avih <avihpit@yahoo.com>
To: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>
Message-ID: <1228065843.3779090.1723743313433@mail.yahoo.com>
In-Reply-To: <xmqqmsldu4iu.fsf@gitster.g>
References: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com> <pull.1750.v2.git.git.1723727653.gitgitgadget@gmail.com> <4f77b7eb7f1110e47201b8c97c34a0cbcd14e24f.1723727653.git.gitgitgadget@gmail.com> <xmqqmsldu4iu.fsf@gitster.g>
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

 On Thursday, August 15, 2024 at 07:36:43 PM GMT+3, Junio C Hamano <gitster=
@pobox.com> wrote:
>> > Still in _agumemts_, no need to quote non-expandable values:
>>
> arguments.

Thanks. Will fix in v3 (after more comments unless asked otherwise).

>> -=C2=A0=C2=A0=C2=A0 local bad_color=3D$c_red
>> +=C2=A0=C2=A0=C2=A0 local bad_color=3D"$c_red"
>
> Good.=C2=A0 I think we in the past was burned by some shells that want to
> see these assignments with "local" always quoted.

Yes. After I reached the same conclusion I noticed it was also added
to CodingGuidelines not long ago at be34b510 (CodingGuidelines: quote
assigned value in 'local var=3D$val').

>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # preserve exit status
>> -=C2=A0=C2=A0=C2=A0 local exit=3D$?
>> +=C2=A0=C2=A0=C2=A0 local exit=3D"$?"
>
> Well no matter what value $? has, it by definition has a few digits
> without any $IFS funnies.=C2=A0 Does this really matter?=C2=A0 I'd imagin=
e
> that we would prefer to treat "$?" exactly the same way as "no".
>
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *)=C2=A0=C2=A0=C2=A0 return $=
exit
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *)=C2=A0=C2=A0=C2=A0 return "=
$exit"
>
> Likewise.

Two things here:

1. It can matter, because we don't control IFS. __git_ps1 is
=C2=A0=C2=A0 a function which runs in the user's shell, so if the user did
=C2=A0=C2=A0 IFS=3D0123, then unquoted $? or $exit can get IFS-split.
=C2=A0=C2=A0 As the commit message notes, this is unlikely to fix things in
=C2=A0=C2=A0 practice, but it will fix things with weird IFS values.

2. In general, yes, $? is only needed as yes/no, and there's only
=C2=A0=C2=A0 one place which tests $? instead of using "&&" or "||" after
=C2=A0=C2=A0 a command in this file (rev_parse_exit_code=3D"$?"). I didn't =
feel
=C2=A0=C2=A0 this needs any portability fix. It works.

=C2=A0=C2=A0 But with $exit, $? is not used as yes/no, but rather to preser=
ve
=C2=A0=C2=A0 the exit status when __git_ps1 was entered. This is important =
if
=C2=A0=C2=A0 the user wants the shell's last command $? at the prompt, e.g.=
:

=C2=A0=C2=A0 PS1=3D'\w$(__git_ps1)$(e=3D$?; [ "$e" =3D 0 ] || echo " E:$e")=
 \$ '

=C2=A0=C2=A0 If __git_ps1 didn't exit with the same $? it saw on entry, the=
n
=C2=A0=C2=A0 $e will be __git_ps1's exit code rather than the exit code of
=C2=A0=C2=A0 the last command which ran in the shell, so it should be the
=C2=A0=C2=A0 same value as before and not only yes/no.




