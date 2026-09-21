Received: from mta-02.yadro.com (mta-02.yadro.com [185.162.94.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3C04399C4
	for <git@vger.kernel.org>; Mon, 21 Sep 2026 07:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.162.94.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789976730; cv=none; b=Lpx25P8T/phqw1qrKn3dV53oGqHLKIQBftRoJkNIydlAbccXU4ba7Lw37qFjMNPxz0ohCslvKbcqQJTyIl4SO7xqP4tx98PDKPODyBaW/DzCaHG6scAYfYtWEhUjSXpoez9gANQvewa6rXYGxG/Wnvst0Js7pw/nIdzb3EEmWpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789976730; c=relaxed/simple;
	bh=y0cu+5Es175vE62XcskxxZNl9O+jtuqiWNHK42vrcKQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JNkbcjSIJf/WJCP1jcKptz/S8moz+Fr2pnEFriedgsS/a4puAy+Sd8InSMQqRL0HOWB0vvVbZ1+64ICH4Y9NIqgtTGb8CMlh6SPcqGn+IHMtu/1xYTFO0BMD2lnOBKiU0DpoayCPolQvgoeH9wiRnV9m7d0woroDqzX5iLDylpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yadro.com; spf=pass smtp.mailfrom=yadro.com; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=AZS8+/yE; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=orq4HG0B; arc=none smtp.client-ip=185.162.94.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yadro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yadro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="AZS8+/yE";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="orq4HG0B"
Received: from mta-02.yadro.com (localhost [127.0.0.1])
	by mta-02.yadro.com (Postfix) with ESMTP id B4C48A000A
	for <git@vger.kernel.org>; Mon, 21 Sep 2026 10:45:16 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-02.yadro.com B4C48A000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-02;
	t=1789976716; bh=y0cu+5Es175vE62XcskxxZNl9O+jtuqiWNHK42vrcKQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
	b=AZS8+/yEKhkd2/FjtjUjO0qEQODk/yU4W6ae0jm9rQbZ9UChFvoejqmR7Jnrbjjxf
	 WSWV/T0hWSRntJEYTwwvKaLhjMM8ePk8ZKfbubAKcOjddOGStK8kjNdQ5KeYFpJ+4b
	 i5yDLHEjCHSUd1zqsCxSPcDd9kUo8Y2VxAtmHahHL56+0jVies2fQVQj9biDyyoXS/
	 oShNU9eetr3ExGsm3r8SJhEmlyNN39tPmYkV1pmkfUY3w8K9wrQOsqkl5nGKk19N9z
	 H3tDAXlqvQeB1KbcGlyDcsRIAcJ8Zqwrgy29WasYIin1uSc1ySaMnvX+N2xqLbPXqO
	 PRHkNAYkOppsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1789976716; bh=y0cu+5Es175vE62XcskxxZNl9O+jtuqiWNHK42vrcKQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
	b=orq4HG0Bogy82JDCqhlEbrk1iRXoFPOiGIvTdbtFOJPaaCgmiS7OmWenNfmbwT83I
	 kmHMhbzvXE06QQfpO19qne7m/O9QSEH8dIMMMtdKuIfZP00mKrkgrWqs4ncnccVDOo
	 J2JijK9CE6IpiNpiH+m73ifVgfkDCmErsBwOA10os1LF9/jUhZ1DatyqguvoPLEza5
	 kL+84IubGDL8eZsFYL/HBM/ahRklsaVoqK1mredJXP/VrHpHLI7D/vk5ADITA5mscm
	 ue6Hve+GygZVCYy1xPmv+nLXLiQwp/oMbWH1BzL/DkoTBQsXEyVmSb1iemBN6UeP+v
	 auDpjn9W013yw==
Received: from MRN-EXCH-01.corp.yadro.com (unknown [10.98.245.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mta-02.yadro.com (Postfix) with ESMTPS
	for <git@vger.kernel.org>; Mon, 21 Sep 2026 10:45:16 +0300 (MSK)
Received: from MRN-EXCH-05.corp.yadro.com (10.98.245.205) by
 MRN-EXCH-01.corp.yadro.com (10.98.245.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 21 Sep 2026 10:45:16 +0300
Received: from MRN-EXCH-05.corp.yadro.com ([10.98.245.205]) by
 MRN-EXCH-05.corp.yadro.com ([10.98.245.205]) with mapi id 15.02.2562.049;
 Mon, 21 Sep 2026 10:45:16 +0300
From: Nikita Makarov <n.makarov@yadro.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Bugreport: git log -L
Thread-Topic: Bugreport: git log -L
Thread-Index: AQHdSZzJRIzAWxJWNEWeE4qm17IBGA==
Date: Mon, 21 Sep 2026 07:45:15 +0000
Message-ID: <41c54b809eb1490fb467ba0fd4c5a8cf@yadro.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2026/09/21 07:07:00 #28607019
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-KATA-Status: Not Scanned
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5

Hello, I have the found the strange behavior of "git log -L" command with p=
ython function.
It is counting a blank line that sits after a function's last statement as =
part of that function.
This happens only when the function is at the end of a file.=A0

The way to reproduce that

git init repro && cd repro
git config user.email t@t && git config user.name t

printf 'def foo():\n=A0 =A0 return 1\n\n' > bug.py
git add bug.py && git commit -qm c1

printf 'def foo():\n=A0 =A0 return 1\n' > bug.py
git add bug.py && git commit -qm c2

Then do

git log -L :'foo':bug.py

And you'll see

Author: t <t@t>
Date:=A0 =A0Fri Sep 18 18:21:10 2026 +0300

=A0 =A0 c2

diff --git a/bug.py b/bug.py
--- a/bug.py
+++ b/bug.py
@@ -1,2 +1,3 @@
=A0def foo():
=A0 =A0 =A0return 1
+

Though I expect that commit "c2" should never appear in log, since the chan=
ges from it doesn't affect the functions body at all.=A0

[System Info]
git version:
git version 2.43.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 7.0.0-31-generic #31~24.04.1-Ubuntu SMP PREEMPT_DYNAMIC Mon Au=
g 10 09:38:02 UTC 2 x86_64
compiler info: gnuc: 13.3
libc info: glibc: 2.39
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]=
