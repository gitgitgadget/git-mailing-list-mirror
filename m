Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE9B3115AF
	for <git@vger.kernel.org>; Sun, 10 May 2026 21:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778448623; cv=none; b=O6RayNoqY7LXup3j1z8vQoXyD6YmQZSQfoSDiILQIyXpVzR5jteYV55CTPWj9QGm2NzVAxUM2/TNx/xF6KoZSwT+A86BENFiQBSlkrHaELECwnsiDYmhq7CgWUDiLnW5aICM1+2KAwKrp/YjWSFWteFlOvRujkDB1rP4zDNcgV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778448623; c=relaxed/simple;
	bh=LbKNGDPRIEFTfvE+N889bmx0XJXGfQZPi+4A+0Z6igs=;
	h=Message-ID:Date:Mime-Version:To:From:Subject:Content-Type; b=tDmL/gKb1oopY/eJpdgC/yDV/+ftfEZIC0/fObxSMgSGK74fEVIssB6Jzcq4bwM+2NifruLKH/HIOGwZdxkjMp3Mlz5vG89erpGKkJl1T3VkCGSWmvkLdZu3+6VsFpL3niznRUsi1RY2X8HKh5P7MjuTgCshhBp6f5p5XeMP7iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.li; spf=pass smtp.mailfrom=gmx.li; dkim=pass (2048-bit key) header.d=gmx.li header.i=optik@gmx.li header.b=M6m0jDE+; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.li
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.li header.i=optik@gmx.li header.b="M6m0jDE+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.li;
	s=s31663417; t=1778448619; x=1779053419; i=optik@gmx.li;
	bh=LbKNGDPRIEFTfvE+N889bmx0XJXGfQZPi+4A+0Z6igs=;
	h=X-UI-Sender-Class:Message-ID:Date:Mime-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=M6m0jDE+LJERVWuvTBzvFUmXDPQpHgGUgIR1J/Mk6tNEgo7fbNfggsBrOlTPJakF
	 vPeUKRd5XOL77bfSzKX24dW9oZxGfNNSsNSIToZ8DnJPYXd+8h8Z7gGRvnONOrxsK
	 F7l6GilaygkaiuxbikdygHDldHMGIH+UBRnTX91jK19SCcKo4lt2SAUQ8YxAEc4gT
	 o/dWKzVWg9rpdMoBHpJyfpAojpGhxbwQM/6qKLAGp+WF2AbrqRhsBMyU+g2Kaact0
	 wxNHDhhv8oYgG5fSRs5lmLUpvlNIZsuxshif3VtfYhgKJU0uTlXsBUXG+HxSQscJ9
	 UwIX3HCwvm7uoNGNAQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvsEx-1xEi5c2MIZ-016YFh for
 <git@vger.kernel.org>; Sun, 10 May 2026 23:30:19 +0200
Received: from [62.201.172.42] (mail.co.uk [62.201.172.42])
	by fda.mooo.com (Postfix) with ESMTPSA id 21BD054008C
	for <git@vger.kernel.org>; Sun, 10 May 2026 23:30:19 +0200 (CEST)
Message-ID: <d8940847-896b-4cc5-81d4-f6512326e15f@gmx.li>
Date: Sun, 10 May 2026 23:30:19 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
To: git@vger.kernel.org
From: optik@gmx.li
Subject: [BUG] git-svn: 'Duplicate specification "id|i=s" for option "i"'
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:23Uix9AQVAUv/qBAG4ppTRjzez/UUc6+Blh2WLfp62Lt0TNZv/o
 a+EIFGbJyPt7wOW7DEUoyDC9DR0cMUdZBRTjC8uSXYTjTX+J0eTdbEWh6MwKFHucenOTNfn
 dZQkGsDZBbQvXaUEqb+y6A06G9N2Gj+hHQPQyboI3C2oSoqJ3vSaHITgi7a/TPPg1+aRogn
 QmYjAPexM0Tb0hkXovtlQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zrDbx0K6MTA=;TYYQbYjH8Vp2AdGSFf+etpKgLN2
 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


Fedora 43 aarch64

git version 2.54.0

Installed package: "git-2.54.0-1.fc43.aarch64"


I get this "warning" ("become a fatal error in a future") while using=20
git-svn meanwhile:

 > Duplicate specification "id|i=3Ds" for option "i"


This problem is here in the git code:

 > my $rv =3D GetOptions(%opts, 'h|H' =3D> \$_help, 'version|V' =3D> \$_ve=
rsion,
 > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 '=
minimize-connections' =3D>=20
\$Git::SVN::Migration::_minimize,
 > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 '=
id|i=3Ds' =3D> \$Git::SVN::default_ref_id,
 > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 '=
svn-remote|remote|R=3Ds' =3D> sub {
 > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0$Git::SVN::no_reuse_existing =3D 1;
 > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0$Git::SVN::default_repo_id =3D $_[1] });

Link: https://github.com/git/git/blob/master/git-svn.perl#L352


Source is a change in Getopt:Long 2.55

Installed package: "util-linux-2.41.4-7.fc43.aarch64"

 > * Fix long standing bug that duplicate options were not detected when
 > =C2=A0 the options differ in case while ignore_case is in effect.
 > =C2=A0 This will now yield a warning and become a fatal error in a futu=
re
 > =C2=A0 release.

Link: https://metacpan.org/dist/Getopt-Long/changes


Currently it still works as expectd, until getopt is changed


