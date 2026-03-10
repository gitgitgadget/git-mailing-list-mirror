Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4729184A35
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 09:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773135846; cv=none; b=G1SxMOoznY7lW95CiSYDyueD6QpzND76P+kTX3py3cU0PNmD7XeRPsCzWowyyVrmONHfy4NOXsFnJad2vt8e22fQE87cPG3wSr1QdRHWhdd9OswwE/n1Z6to13OM6mtDDdmdZla/+2Wm1noAp4tNV7u2oWhma4R42D6/VQdmnlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773135846; c=relaxed/simple;
	bh=PL8VgGiD4BMng6gPhkZJJw0FBtzG1GuEeF1rpIonFgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eL4m1wgHkU0J04tNvKV4rYvETwwigjHi5dnBrG0vc2NTmw7onKI0rPNoy+2hoKKUH+Wov4XbSUPdEa1RGDSDDUxCiNjYq62yqJ7xCw8SSqRSejRBlyxsRLlUjflJ4QrnI3PxQqdY734WioNE2zue/78GaHgJSo1cuVAzawFbqww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=QuoyzOoZ; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=qy0W92B+; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="QuoyzOoZ";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="qy0W92B+"
DKIM-Signature: a=rsa-sha256; b=QuoyzOoZYyWESckgl4UJtx0cTVTeovpvQ3pS2JJGyt0BNTMTJUGUFflUPoMyBlv5k7R0Uq2jbRQ4VartsgHMqR22dv8WrohlysAYGtS6kc06f24Ak6yH0fvdybDlk9ERzvWyj5jt0FP92NCUe2kHwJodU71hAgkONtJA0ST5BqDLJQ+xBUU3Zgq6OmYuvPfNc/EQYpGrUXUalpnGXGyLVmXEwSn30H57/e9jwaApuO7gtal5PBfqacVJiNPpyfvyKgRyzuyZBXkPzo+zfSmhYhdUab2OBNmhmCEOmTAc9Zxd4rCfz3uY/46a+XWuGW6vWzvn9vVjxNv4ZR0NQW26Og==; s=purelymail1; d=malon.dev; v=1; bh=PL8VgGiD4BMng6gPhkZJJw0FBtzG1GuEeF1rpIonFgk=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=qy0W92B+m97vAtyBSmEX0GHc6epkO5YZLzTxtyFLNF29iaAz2uDFO6I9XbmiBE6oEBr2cfNi5ciAq73XpLBQhGFajkgpgNHSHIJ/AEruIuPUp4P4AGSRXG/n1rXVWeN+JsGLG/sTndmE+P7BayOzOD87oGo76ClXe81FLL+bDY9wRRqjrBxZ9U+A9E9UQBdIR+WzEHz+0D5JJHWYaaY6bPk8cetehy44lvb/7Uun1Uh5ZFiEwIkxhNnXXhMATi2dW2cx9MB7zwSMDEH+APKkHEiZHL3yHMZm3Ayift9EqcagwW5TrhtQMt5HuCNDKsu+E/adsUKO++cU4qyUhodGwA==; s=purelymail1; d=purelymail.com; v=1; bh=PL8VgGiD4BMng6gPhkZJJw0FBtzG1GuEeF1rpIonFgk=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1124441529;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 10 Mar 2026 09:43:56 +0000 (UTC)
Message-ID: <736d3c7a-49cf-4ed5-9686-5a653caa20a4@malon.dev>
Date: Tue, 10 Mar 2026 17:43:48 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] diff: document -U without <n> as using default context
Content-Language: en-US
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: git@vger.kernel.org, gitster@pobox.com, ben.knoble@gmail.com
References: <20260309172719.125419-1-cat@malon.dev>
 <20260310053032.129327-1-cat@malon.dev> <aa_hTifKYZ5KYREv@ugly.lan>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <aa_hTifKYZ5KYREv@ugly.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

On 3/10/26 17:15, Oswald Buddenhagen wrote:

> i'd replace that with:
>=20
> Hence we retain this fallback behavior for backward compatibility, but=20
> document it as such.
>=20
>> +=C2=A0=C2=A0=C2=A0 (`-U` without `<n>` is accepted as a silent synonym =
for `-p` due
>> +=C2=A0=C2=A0=C2=A0 to a historical accident).
>>
> "silently accepted as a synonym" would be much more natural.

Thank you for pointing out. This change does make the message read more=20
smoothly.

Will send v3 shortly.

Yuchen
