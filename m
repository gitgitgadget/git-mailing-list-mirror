Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AFB1E480
	for <git@vger.kernel.org>; Tue, 14 May 2024 15:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715700752; cv=none; b=g3Tc8xeMCF96fTK98PxPmhk7KkASUev4LunefJRBnhReQfa4jkL9mIgENuEsjHisut6pjo3d5rTG8/ichG+cxBJuRL8k5gw5DYzkJLZ7CW6MayXRngqF0GFbdzajuypUXQb48nO2xUzVucwr4X3vl2Y9J2mnxaO0fjN65sX/VmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715700752; c=relaxed/simple;
	bh=s9tlSrewquPKMbX0+xvgahHu9KluO33FTF2LhFSbAzI=;
	h=MIME-Version:Message-Id:Date:From:To:Subject:Content-Type; b=Q/mSMoc1EvtQBSi0PjmW+NMlmLzpW2kK/BDrpnRiFv8b4pr67GGhak//wsQZDqJDs+xEHxMtfjfol2f/xncDreqgDDGLGwkDD7VFrc+DvdIiCM3TqxFaycvMiPKHtlds7KTZ+xP1kbh0OhKsK4j4CundybXs5hNPFJpNjgco/xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=omglol.email; spf=pass smtp.mailfrom=omglol.email; dkim=pass (2048-bit key) header.d=omglol.email header.i=@omglol.email header.b=VplfD+pe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=La5+ZA4s; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=omglol.email
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omglol.email
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=omglol.email header.i=@omglol.email header.b="VplfD+pe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="La5+ZA4s"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 29B661C00146;
	Tue, 14 May 2024 11:32:29 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Tue, 14 May 2024 11:32:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=omglol.email; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1715700748; x=1715787148; bh=s9tlSrewqu
	PKMbX0+xvgahHu9KluO33FTF2LhFSbAzI=; b=VplfD+peEhqiG2pGvjctwawbqx
	fISpVWtgiyjevG5zryxOxt/vKq5iEqvp/q0txiyNLZgeF7e/vjr4EMjNnehi6thf
	kb3STK4t66uWBJUtMsfxlAsUUqfTFEMwjlOA3/Lu8v3R/r69U3y3TqUrHbUsIxTn
	0AHpYaPXMSwCuR6d/nFjpXlCeCCRVAcGe4n4lUdL7ENnhRe6PmedLM3C7aJBDq7p
	OnyaDPXWDPkquPZQBARjesNZumRZSRlWc6+anw3FVWCOgznkAW+Vh9uB6fIhjV7U
	vzEghKdf4wKBMG62F2TPloLKVeDWPcnNO+LiCUWdAFL0rUzdfAREa5MtqBrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715700748; x=1715787148; bh=s9tlSrewquPKMbX0+xvgahHu9Klu
	O33FTF2LhFSbAzI=; b=La5+ZA4sIwLTI3Uua+lUvB5stFuf9Uz2FPTls0ePHx5T
	5O+Z4JSLDaBVP2TBri0nw9T+meM16Vd4eyax2j25s0+/85X+Ex8Kq6kiCVRUGkbu
	nRDqBCLZuwFGHH9hKnZRMLfaVZbmVHKm97bMc5faXvvW+mZEJJnTkwASk6DGHxUi
	HUYebTYhbnEh+yo8l8bZjF8W7PXJPa1swZjCv1VtOcrUNZsOMHAl2yaVPI6kbjD/
	+xHYiSX0XCFHfte8nSiahrzkccFqml1j8CoOBCmEh8jmUQ+Uqb3aPaZVKe+OcFb9
	+bezn6KQVHILwUo3QPj+hq5uBfGE/Jcvehz1ID3YgA==
X-ME-Sender: <xms:DIRDZrLw-EcHRPVGXKRVm_4gwXf21hveOKVmnAGFJ8PegpcF9WuW4g>
    <xme:DIRDZvKDTNXUdhKaJMmtIUcpgZOg9m08h8TxxZdLBOwm9sRNlTSSmQpAO4IoY3qgR
    FqRuxrEMrcNIZrf53k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegiedgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdludejmdenucfjughrpefofg
    ggkfffhffvufgtgfesthhqredtreerjeenucfhrhhomhepjghonhhgmhhinhcuoehrvghv
    ihesohhmghhlohhlrdgvmhgrihhlqeenucggtffrrghtthgvrhhnpeeihfeiveekudetff
    duteevteeiffdvjeeihfettedvleevgfefjeefveehiedtvdenucffohhmrghinhepphhr
    ohhnohhunhhsrdhprghgvgdprhgvvhhirdighiiinecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprhgvvhhisehomhhglhholhdrvghmrghilh
X-ME-Proxy: <xmx:DIRDZjvylwYBtDDU0kpe9ZXfpITc13s2Ft6AjloUyjkma3X1PlAssQ>
    <xmx:DIRDZkaRmg8thI853cyuz-0icgVWfJE5PhrNR8asjVv8cghHKy3-bA>
    <xmx:DIRDZiaDIGDogrUsb7JEp5aoUi6qrwo86Lyfj-sHQQf2a_3XM-mjWA>
    <xmx:DIRDZoCXmn_hOXTF9nHdH-Ahyfhz2VYGQ_Mqd5dpkkAaRkV85IxRLA>
    <xmx:DIRDZlw_nJcJvLxD5_-fNRHS-AFSPWdCS0L-Ls6hz3Dg6qvAR0kNNUv1>
Feedback-ID: ifc394682:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 770E215A0092; Tue, 14 May 2024 11:32:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-455-g0aad06e44-fm-20240509.001-g0aad06e4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ea41a92d-35df-4b71-be70-a736d620b21f@app.fastmail.com>
Date: Wed, 15 May 2024 00:31:43 +0900
From: Yongmin <revi@omglol.email>
To: git@vger.kernel.org
Subject: git format-patch displays weird chars when filename includes non-ascii chars
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi everybody,

When the file name has non-ascii characters, the file name gets mangled =
somehow. Is this anything from my config side error or something gone we=
ird with git?

 Steps to reproduce;
$ git init
$ echo 'BlahBlah' > =ED=85=8C=EC=8A=A4=ED=8A=B8.txt
$ git add =ED=85=8C=EC=8A=A4=ED=8A=B8.txt
$ git commit -m 'test commit'
$ git format-patch --root
0001-test-commit.patch
$ cat 0001-test-commit.patch

From d2aa2b2f5aa290edec6a5fd141318a479ac9de8e Mon Sep 17 00:00:00 2001
From: Yongmin Hong <revi@omglol.email>
Date: Tue, 14 May 2024 15:15:52 +0000
Subject: [PATCH] test commit

---
"\355\205\214\354\212\244\355\212\270.txt" | 1 +
1 file changed, 1 insertion(+)
create mode 100644 "\355\205\214\354\212\244\355\212\270.txt"

diff --git "a/\355\205\214\354\212\244\355\212\270.txt" "b/\355\205\214\=
354\212\244\355\212\270.txt"
new file mode 100644
index 0000000..86724be
--- /dev/null
+++ "b/\355\205\214\354\212\244\355\212\270.txt"
@@ -0,0 +1 @@
+BlahBlah
--=20
2.32.7

I searched a bit with the keyword 'format-patch ascii' but couldn't find=
 anything useful.
Thanks in advance!
----
revi | =EB=A0=88=EB=B9=84
- [he/him](https://en.pronouns.page/@revi)
- [What time is it in my timezone](https://issuetracker.revi.xyz/u/time)
https://revi.xyz
