Received: from sender-of-o54.zoho.eu (sender-of-o54.zoho.eu [136.143.169.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AD318D62F
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 22:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726872023; cv=pass; b=JLeGRz0lV0hShtqpRLxyAJyaeqmRigBv9K0zmUInKWagZT9KLK3rPgeleFyBgxdaFeGkeFqk8+2ZZ+ogDXLcxXr6uFcKwDUDSkA6voGObD9vj05dmyxkTFMn+wbJsJG8UlkfOUxdQCuP0tsrGGyuNScfUjbb9ADq6XuH3BYNXbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726872023; c=relaxed/simple;
	bh=VdP2uaWWXfj6jpd0BidzWLAmr77/UZS7Y1xoJWBD7wo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=uNeieVFmzarjdyWF+2aFXyp3AqSfwRSDJs4f7iWO84DPN5HhDnveDQPwKgiSs5/EyjrgsakGbypbcEqx9w0hy2H0Y9P88bPnkBdCRrXQuV3m4LEHOQsYKg8dksSYBaoz99Ndg/IX2C3LcR35Mni2M9ejeVXhaZQbLHAwR2nQUHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet; spf=pass smtp.mailfrom=orca.pet; dkim=pass (1024-bit key) header.d=orca.pet header.i=marcos@orca.pet header.b=uUPMFP59; arc=pass smtp.client-ip=136.143.169.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orca.pet
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=orca.pet header.i=marcos@orca.pet header.b="uUPMFP59"
ARC-Seal: i=1; a=rsa-sha256; t=1726871994; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=HvWXEJvb8GyJuC8sWwYWO3gZZasOnWfv83pJhQJppADUD0Fg0lTtC+AEcMkBtLabu796gErM5dj5kkQA+x/EVfXAgMXUX7LZjsCusSik9/4AWzOCEhrT4X3J2exdF9SxPt2HLHNIfqlTXaoyHSyX336h+7LyIHzk8A+Yq/gSxH4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1726871994; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=dW4sglH+ULAaHw//f80wMz2pVVLb7vkoj0m5M71PAI8=; 
	b=hJokmiCK7jdVXLElZhOiukKttzkV9uEHzWgSvjDd9U+dYrjJUhxQcy5YRQrI+dIOQi1bOmYcHLn8Gj4dpX9REfAzQty1mKBHGAZ8U1dU+GiCAhb5l04/ERl38mme99M0wdzYfflZM/njvuCO1YeoigEMHA/9uNdidq/Oig62qlQ=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=orca.pet;
	spf=pass  smtp.mailfrom=marcos@orca.pet;
	dmarc=pass header.from=<marcos@orca.pet>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726871994;
	s=zmail; d=orca.pet; i=marcos@orca.pet;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=dW4sglH+ULAaHw//f80wMz2pVVLb7vkoj0m5M71PAI8=;
	b=uUPMFP594Ilho7U8+Yv7PtJfKKOyFD1RouVLeVQVRDwTBShNEPMIFFjlOv0GhZfK
	MFXMNLSq1fG1v6PcvMLZzr9DSKC8I978FKUlj74qKGOoa+2xNNTNmppp3q6W1BlCMnO
	6vp9J2JNEvNzO/iS6SLGeBZD2HcgmH48v5NmF818=
Received: from mail.zoho.eu by mx.zoho.eu
	with SMTP id 1726871991360265.3039634233327; Sat, 21 Sep 2024 00:39:51 +0200 (CEST)
Date: Sat, 21 Sep 2024 00:39:51 +0200
From: Marcos Del Sol Vives <marcos@orca.pet>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: "Junio C Hamano" <gitster@pobox.com>, "git" <git@vger.kernel.org>
Message-ID: <1921197742f.d7b8c9992630384.1644253106538527208@orca.pet>
In-Reply-To: <Zu3ec1mDj9JD1Bbj@tapette.crustytoothpaste.net>
References: <19205ebb4b9.c2a2da5a2387912.3559118454287459572@orca.pet>
 <Zu2aHdaw_oDv_dp7@tapette.crustytoothpaste.net>
 <xmqqsetugpip.fsf@gitster.g>
 <19210b887c6.f59622352625372.1022723129771458212@orca.pet> <Zu3ec1mDj9JD1Bbj@tapette.crustytoothpaste.net>
Subject: Re: Permission issue in Git in DrvFs-mounted network drives
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

---- El Fri, 20 Sep 2024 22:43:31 +0200,  brian m. carlson  escribi=C3=B3 -=
---=20
> Git could, in theory, accept a patch here.  However, you're also going
> to have lots of other software that breaks in this case, not just Git.
> So it's less useful to patch Git and hundreds of other packages on Linux
> distributions that have relied on the POSIX standard and more useful to
> fix your OS (or maybe switch to WSL2, if that doesn't have the problem).
> Most Linux distros will generally not be interested in fixing this class
> of problem, in my experience.

There is not a significant amount of software that opens files for writing
in read-only mode. Despite using WSL extensively for development, so far
Git has been the only that failed to work.

WSL2 has poor support for accessing local devices (such as serial ports,
something really useful for embedded development like the Proxmark project
where I contribute to) or pipes (which I use to sign commits using a
TPM-backed SSH key), so it's not really an option.

> In addition, chmod doesn't always work under WSL.  I believe it _does_
> work if the drive is mounted with metadata, but some people don't have
> that enabled and I don't know if it works for all drives.  For those
> people, the current code will work, since it doesn't call chmod or
> fchmod, but it will fail with your patch.

I can guarantee you it'll work under WSL, even without metadata, because
I've patched Git on my WSL1 Debian machine by doing the aforementioned
trick and it totally works. Metadata is not even supported on anything but
local NTFS drives.

WSL1, when mounted without metadata, chmod and fchmod calls will not fail
but would instead just ignore the call, *except* when setting mode 444,
400 or any other read-only mode where it will set the FAT/NTFS read-only
attribute:

marcos@desk:/mnt/nas/marcos$ mount | grep nas
\\192.168.0.245\marcos on /mnt/nas/marcos type drvfs (rw,relatime,uid=3D100=
0,gid=3D1000,case=3Doff)
marcos@desk:/mnt/nas/marcos$ touch readonly
marcos@desk:/mnt/nas/marcos$ ls -l readonly
-rwxrwxrwx 1 marcos marcos 0 Sep 21 00:33 readonly
marcos@desk:/mnt/nas/marcos$ chmod 444 readonly
marcos@desk:/mnt/nas/marcos$ ls -l readonly
-r-xr-xr-x 1 marcos marcos 0 Sep 21 00:33 readonly

That is exactly what is causing the issue - two SMB requests are being
issued: one to create the file in read-only mode, and then another to
open it.

