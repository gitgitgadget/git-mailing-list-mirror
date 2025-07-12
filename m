Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C612AE74
	for <git@vger.kernel.org>; Sat, 12 Jul 2025 09:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752313554; cv=none; b=hRADG+f6BFWM4lujad1YAjbiv0xyDDVnVbQetqejGCm6c4vGgPzYRYMkGsh3r6Ufnq5qzud40gLBZfdcgJn5psNdPaH8Ck14fMes1MKFXvh0mHqJN06AgzJeOtkdKOXmT3ss95jDQkppXlUbJ/a+BURsndnUIGJMEpVJuHexg0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752313554; c=relaxed/simple;
	bh=eji+9PWW3BxSreCzyNF/OhqmPkeuKSCoNir0STI1iEE=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r6kFNgvJD88crgyasjohh2RGWo6y5ZbpMgix7aj2wEMbGGgVuugo7DsjazJN3u+23weTLK5xMbq7th15Mf1Lvjix5BBG5TTvmk2xUTZe3VuTX7Ik8gzFv2Q0LhtT8HEdceiPDSCpFjWZXm3gUaSQ0t2QeF3yU0ArYwWUYj3ICXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=CKc8ChNe; arc=none smtp.client-ip=109.224.244.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="CKc8ChNe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1752313544; x=1752572744;
	bh=eji+9PWW3BxSreCzyNF/OhqmPkeuKSCoNir0STI1iEE=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=CKc8ChNen2jk4ilOzvduFMG1FwRI7Xt4QDvKiufugF1oOV/7oPqyD8DI1cUqpdgw6
	 7S73ZJ/0pXa8ch2mWQe6eHNHffVBNGo94wJVlAEC6yZ5mJbmLG3ZEWPX6Hm0N/beQM
	 DKk3LwebOsme9JAytPVfhoi1tTI09l9n8KOyvAz2rx72Ez3DRa9YnP+3tSssyAVq5r
	 NdBzN2TlzBwijbEt98R//42HQK3D5DiemIkWRA6ncqlk03o1MOJc3bsuEPGtjNoNyH
	 YCKKfoXXNqoYH9HyZLpwJxZfGpGXUqBAYe4Ysh2NGWOnFS2OvNlYG2B05XcJ8ma+D0
	 rDcSI9lr0Einw==
Date: Sat, 12 Jul 2025 09:45:39 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: Jason Cho <jason11choca@proton.me>
Subject: Why doesn't git core.eol=lf work?
Message-ID: <QcbAE4JJXpU-NcQ1loYdHthi-nYA2ZXcuuetCHE_0N0fRi0mdaf90VaLk0Y2ehrnVzoZraYO7jLhB7Pl68_k4l3HCqkFVGuMOzZ26cHYkfc=@proton.me>
In-Reply-To: <8jPyf4EU-z7W6OHX4j_kba2G-1c2RIDtgBcSkFjWSNhMuE6pxOOyxSGBnguoZvuDQSaJPypH0u1vLJf6FBX_ahUn3bBO_1DVscfOQm4Jovw=@proton.me>
References: <8jPyf4EU-z7W6OHX4j_kba2G-1c2RIDtgBcSkFjWSNhMuE6pxOOyxSGBnguoZvuDQSaJPypH0u1vLJf6FBX_ahUn3bBO_1DVscfOQm4Jovw=@proton.me>
Feedback-ID: 126703824:user:proton
X-Pm-Message-ID: 86a865f1fd7904f5d66c1016411734eeea75d9eb
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

```MINGW64 /tmp/summer-temp/dbeaver/docs ((e4219ccb38...))
$ git log -1 --patch license_header.txt
commit b5121d4a6e8f3f21079920180b0fb14ada6d3349
Author: serge-rider <serge@jkiss.org>
Date: =C2=A0 Thu Jan 10 21:56:55 2019 +0300

=C2=A0 =C2=A0 License header update (2019)

diff --git a/docs/license_header.txt b/docs/license_header.txt
index 86de505a18..d75b48e98e 100644
--- a/docs/license_header.txt
+++ b/docs/license_header.txt
@@ -1,5 +1,5 @@
=C2=A0 =C2=A0 DBeaver - Universal Database Manager
- =C2=A0 Copyright (C) 2010-2018 Serge Rider (serge@jkiss.org)
+ =C2=A0 Copyright (C) 2010-2019 Serge Rider (serge@jkiss.org)^M

=C2=A0 =C2=A0 Licensed under the Apache License, Version 2.0 (the "License"=
);
=C2=A0 =C2=A0 you may not use this file except in compliance with the Licen=
se.

MINGW64 /tmp/summer-temp/dbeaver/docs ((a3f59b66ed...))
$ git check-attr --all -- license_header.txt

MINGW64 /tmp/summer-temp/dbeaver/docs ((a3f59b66ed...))
$ rm license_header.txt

MINGW64 /tmp/summer-temp/dbeaver/docs ((a3f59b66ed...))
$ git -c core.autocrlf=3Dfalse -c core.eol=3Dlf checkout -f HEAD -- license=
_header.txt

MINGW64 /tmp/summer-temp/dbeaver/docs ((a3f59b66ed...))
$ cat -A license_header.txt
=C2=A0 =C2=A0DBeaver - Universal Database Manager^M$
=C2=A0 =C2=A0Copyright (C) 2010-2019 Serge Rider (serge@jkiss.org)^M$
^M$
=C2=A0 =C2=A0Licensed under the Apache License, Version 2.0 (the "License")=
;^M$
=C2=A0 =C2=A0you may not use this file except in compliance with the Licens=
e.^M$
=C2=A0 =C2=A0You may obtain a copy of the License at^M$

MINGW64 /tmp/summer-temp/dbeaver/docs ((a3f59b66ed...))
$ git --version
git version 2.47.0.windows.2
```

I ask git to force checkout license_header.txt with LF line ending, but `ca=
t` tells me the file is checked out with CRLF. Why?

