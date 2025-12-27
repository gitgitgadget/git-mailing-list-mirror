Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCA114EC73
	for <git@vger.kernel.org>; Sat, 27 Dec 2025 15:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766848830; cv=none; b=IGEtMtGn/7v+VUlF/66LrvroqUOU+Ehuhuzi8rsxK8YFL3uyLPAz/7AlnobAmmilBkcPuUG5OOLpRE30gS7SMTAt5p8fwDeyrZul5ArgtN7jpXjERf9xLazzff8DLLLZSW2PwkjrrrymGDgpf7veDPURzAuv5m3lgzRTfs4c9uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766848830; c=relaxed/simple;
	bh=DxdmLG6/gPTDIdXXETDEziipy0gRjMwVpYuNvkgKrbI=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ee6mcTk8nUr6Hc0SchN/tylL9CwLCWDvY+jzi+qk2JeaRdw/mAEhO0SJ1bx37hZxzzUEeSFkR5msGf/T1bfV4LCScE2su9b6wGYqBcy6uDgnGVmHhlZ5KPwKTYmXZJgR/cORLZCZ7R+VC8h5OhpxVuOEDyYVQxKqhBc1JD1GSN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 5BRFJnH3879445
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Dec 2025 15:19:50 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Hadmut Danisch'" <hadmut@danisch.de>,
        "=?utf-8?Q?'Michal_Such=C3=A1nek'?=" <msuchanek@suse.de>
Cc: <git@vger.kernel.org>
References: <eb36360d-f539-4f77-b175-57330ef05eac@danisch.de> <aU_lqe2Z47STv68O@kitsune.suse.cz> <008901dc773c$f05508c0$d0ff1a40$@nexbridge.com> <74793560-49ae-494e-afff-9b833dd25d1c@danisch.de>
In-Reply-To: <74793560-49ae-494e-afff-9b833dd25d1c@danisch.de>
Subject: RE: Git destroys u+s and g+s directory modes
Date: Sat, 27 Dec 2025 10:19:44 -0500
Organization: Nexbridge Inc.
Message-ID: <009101dc7744$3ead0480$bc070d80$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQEn2qJ4gzm8cugOVbAMroE87E9uEgHX2IMNAjLI7kICz68egLZoABpQ
X-Antivirus: Norton (VPS 251227-2, 12/27/2025), Outbound message
X-Antivirus-Status: Clean

On December 27, 2025 9:40 AM, Hadmut Danisch wrote:
> Am 27.12.25 um 15:27 schrieb rsbecker@nexbridge.com:
> > There is an option with ubuntu: Access Control Lists (ACLs). These
> > provide override security for directories that might assist in your
> > process without having to worry about git security settings. It =
might
> > be worth looking into this option.
>=20
>=20
> This does not solve the problem, since ACLs do not propagate into =
newly created
> subdirectories, as group ownership with S_ISGID flag does.
>=20
>=20
> Please try to understand the problem before trying to solve it.

Without trying to be critical, the POSIX ACLs I have seen provide an =
option
that provides inheritance, so nothing in the repository will block =
those. That
is why I mentioned it. However, perhaps ubuntu does not support that
capability.

