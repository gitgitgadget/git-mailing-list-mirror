Received: from aib29agh125.zrh1.oracleemaildelivery.com (aib29agh125.zrh1.oracleemaildelivery.com [192.29.178.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443471C243C
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 17:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729703268; cv=none; b=p+k8zJIFLwR/88IL0jRuuOmBLNILn2opg9DhrpRzX2hKtl9fbseF359WM7nXAn0vHWXsg4ujEe7A9KM/sJw7qQveF1H6dCCaPh7ixwjXhn/eRueu7Z0KHkBScoCtXvEgC6KpHcya+bNqeXBsB7rZQrfLo0pH7Z+N7HthzoCTnMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729703268; c=relaxed/simple;
	bh=TxMICiVG/385z3Iioj2gEgaUcRDEU5K+rUB/FTxeYfs=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=Q9coekWaLX/JT/ML1nbge3gI3UaFic5vk4hYUoaNlZMEiaDJtkE5o+xjf9YKMuaXKrJzVsiYU6wATlXIq8u867i5p/vdhXGnwESURIUlt3Xp743xVmjocuQPOpjPsmv1sFUEFyWhCf3JM89E/dTII7UKdG5mvNkVB0e76VjViW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=JSPVDJjy; arc=none smtp.client-ip=192.29.178.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="JSPVDJjy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=QWCNuKJWucYckNnCeHWT1ifgceilhNRgh6lmimzA124=;
 b=JSPVDJjyjhg2FeL6MmMHkBtI3U59hoEn61fU+pdC3DPiVMZ8YBv/Zr/ZpMo0iUN1ZAYMuvjhtyme
   SlTFzS/cytRUF4AH0ir7/NxewcuMu9UZCHFE18oeeo22upm3/RwaZ5fnqh+YNrRn8Ivw9GmqJr95
   Czf8GBytReJ1hqYo0f58knDjuQ6d82S1g7InOZ33a0JpKyMSW/5gobiQZ5VmE4keh3jpfCDPc/aI
   tHtH9A2EYNbTZTMAkzzNTKVjy77IlZbvVH4U4LjiiyqhEV+zzlICT1aisxDSx3Iw0+raQ73+mGIs
   ByIRcV8gaeDJzexR2VYJfBK2F5iQffpJ+dEA4g==
Received: by omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLT00G2DJKW6320@omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Wed, 23 Oct 2024 17:07:44 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Wed, 23 Oct 2024 19:07:06 +0200
Message-id: <D53CMCABS8FO.374EKJJ6LN0MJ@ferdinandy.com>
Subject: Re: [PATCH v12 7/8] fetch: set remote/HEAD if it does not exist
Cc: "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
 "Junio C Hamano" <gitster@pobox.com>, "Karthik Nayak" <karthik.188@gmail.com>,
 "Taylor Blau" <me@ttaylorr.com>, <ferdinandy.bence@ttk.elte.hu>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 <git@vger.kernel.org>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <20241022194710.3743691-1-bence@ferdinandy.com>
 <20241023153736.257733-1-bence@ferdinandy.com>
 <20241023153736.257733-8-bence@ferdinandy.com>
 <d715d76b-1dd2-46e7-a16b-b2cf30940470@app.fastmail.com>
In-reply-to: <d715d76b-1dd2-46e7-a16b-b2cf30940470@app.fastmail.com>
Reporting-Meta:
 AAE3E2yj7RcntEa9ZQAgXIrjzU4XcukpfUYogdhY4k8jpoCTBWTGODvDlIz70Xjn
 ssPa+a+P7IAcXylge90mhQyLXr6svSzJuZSx0pa93lPtR6+zwhS5mfEDg8SosCjo
 hn+GibTJyK/faJiFY5EKRYrl1rqIfvhU6JejuKE28b5Rw4ZRZht8YHjzzB73qmYC
 kOPbMCKD9BXEMSgxZ8Ih/WF2OoNNcHcH2bvewRT0tFzvadL9cioye7YoFYgT4pVo
 Vr6Mb4AHf1UacY+8XZ7chPBWeGLZNVf78wFzmcMa4U9wfXPWbPXx332dr47CssVT
 LX6uE4G4ADRTJHueIMom+nSuIDkWNf2xuwv5KRhM+YGtMJ/9lq9En8JzRwfcUs31
 8cxj/oJGEYYigJ/tXL/I8RZ0ajSuDm00Ij2ZEjSyPl2nz6hGSb9QddAEELTG/20n
 RZCOoggrxngsypVrWQT+m8lPMdtKlOkPqQ9yR3M1EpAf555n24N4PCdi


On Wed Oct 23, 2024 at 18:50, Kristoffer Haugsbakk <kristofferhaugsbakk@fas=
tmail.com> wrote:
> On Wed, Oct 23, 2024, at 17:36, Bence Ferdinandy wrote:
>> If the user has remote/HEAD set already and it looks like it has changed
>> on the server, then print a message, otherwise set it if we can.
>> Silently pass if the user already has the same remote/HEAD set as
>> reported by the server or if we encounter any errors along the way.
>>
>> Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
>> ---
>>
>> Notes:
>>     v3: - does not rely on remote set-head anymore so it only authentica=
tes
>>         once
>>         - uses the new REF_CREATE_ONLY to atomically check if the ref ex=
ists
>>           and only write it if it doesn't
>>         - in all other cases the maximum it does is print a warning
>>
>>     v4: - instead of the discarded REF_CREATE_ONLY, it uses the existing=
,
>>           but updated transaction api to request a silent create only
>>         - it now uses the atomic before_target to determine reporting
>>         - refactored for legibility
>>
>>     v5: - instead of printing a not too useful message, it now fails
>>           silently, this in line with the objective to only set up
>>           remote/HEAD automatically if the right thing is trivial, for
>>           everything else there is remote set-head
>>         - fixed all failing tests
>>         - added two new tests, one for checking if remote/HEAD is set to=
 the
>>           correct one, and one to test that we do not override remote/HE=
AD
>>           if it has changed on the server from what we have locally
>>
>>     v6: - fixed style issues and unintended extra empty line
>>         - updated function call with bool to int from previous patch's
>>           change
>>         - removed calls to error(...) inherited from builtin/remote.c so=
 we
>>           actually fail silently
>>         - set the test for remote set-head --auto to the correct value h=
ere,
>>           which was previously erronously set in the remote set-head pat=
ch
>>
>>     v7: - no change
>>
>>     v8: - changed logmsg in call to refs_update_symref from "remote
>>           set-head" to "fetch"
>>
>>     v9: - follow through with refs_update_symref_extended
>>         - fix test errors uncovered by the new patch
>>
>>     v10: no change
>>
>>     v11: fixed some memory leaks
>>
>>     v12: no change
>
> I think it would be better to reverse-order these patch changelog
> comments so that the newest is on top/first.  (for next time)
>
> Thanks for the careful versioning here.

Yeah, this works fine when you only go up to v3 and it all fits on a screen=
 :D
This is definitely the longest patch series I've made thus far, both in num=
ber
of commits and versions. I also noticed this today when I realized that I d=
id the
cover letter in reverse and how much better readable that was than some of =
the
patches ...

One thing that would not be easy is that with so many patches, how I start =
out
the notes is

	git rev-list HEAD~8..HEAD | xargs -i git notes append {} -m "v12: no chang=
e"

and there's no "git notes prepend". That could be another patch for another
time :) It also bothers me, that the branch description that can be used to
save cover letters is not a note, just a local configuration, but that's
a third issue.

Anyhow, thanks for calling it out, if we do come to a v13 I might just spen=
d
some time on reversing (or be lazy and just continue at the top ...).

Best,
Bence

--=20
bence.ferdinandy.com

