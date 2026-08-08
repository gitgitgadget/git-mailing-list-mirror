Received: from mail.aegee.org (mail.aegee.org [144.76.142.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BE84B04B0
	for <git@vger.kernel.org>; Sat,  8 Aug 2026 14:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.142.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786199953; cv=none; b=NC0ZQGqaL7PE1qAOQS64j44VfrlWKPg8obQXXDQQ3Lyw1jimMV4R6JObPZ8adgn4urWaf5h3y+aLU8QNbE+8dc5KuujjSyAkrk3JSfBzaV+2keerC1Nbl4ohwI5e8na+Eswo88w89NpsEYPwGiWb4WZ5cZqzSyo52rlHQ8lSnNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786199953; c=relaxed/simple;
	bh=3P5bmkRFCFjrLJP8bxC+4VP15UiIlmCEF3eq3uNl8lQ=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=hwc38n77lOM9NWdzkB10Hz+1USpuUihfH/GW9cxF/UJs4Ibl4BTLd6OTXeuCsfTvoOqogyu09NrWYtp0j0mqG4xFwtQEZb8r9R8LrWvVDyES8sxPqsERlrlhm8apA+W7waWqmc1A5nOovS5gTT7vl4thrZ4Xik3DYX1lIamwHc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aegee.org; spf=pass smtp.mailfrom=aegee.org; dkim=pass (4096-bit key) header.d=aegee.org header.i=dkim+MSA-tls@aegee.org header.b=Wds6wA27; arc=none smtp.client-ip=144.76.142.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aegee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aegee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=aegee.org header.i=dkim+MSA-tls@aegee.org header.b="Wds6wA27"
Authentication-Results: mail.aegee.org/678Ec0gw1839603; auth=pass (PLAIN) smtp.auth=didopalauzov@aegee.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aegee.org; s=k4096;
	t=1786199881; i=dkim+MSA-tls@aegee.org;
	bh=3P5bmkRFCFjrLJP8bxC+4VP15UiIlmCEF3eq3uNl8lQ=;
	h=Subject:From:To:Date;
	b=Wds6wA27tFXA6jt4l1AUoBf/wSnGvxtzmXv8LzIryC/YmNnP1Nn/5xOINn+snxZc5
	 4GSA7gZyAJiDDp/pj+90YSSdTh4fbHWmLoIasJZt8OuHIp8ZQJEUm39VKNX8sxOoio
	 wwj7GWM9YNPCBUUuq4C+lc+5tc/5uNmsxk4vVBs48n623qGZbeOAfZAlsaGPKFt99j
	 q5yjqBON7dJ4BqkfiRrECJvmRJwOCwJcds8nrB7bv7DKBqImOh551S0M8YfWDV2nBN
	 ecafLWv1AZ1cnC65c0iDCduW4jev3PVO/ySkAD8xvgCpnez7H2jYgbvgGV/MQNe1/r
	 w55t6mJkv/lBUTFEyta9iuldG9hpaLzH1GJ7RuMPI5ct7DH318vix3tnwjAAdtfnpC
	 t4ftZNz6mqEQYEDDRElZR4HcNlvItg8EjlBzIey8PQnr2iyGAsjjRU+PJ97IW4FnV5
	 dMivPVU2FtFWxwjdZy4JLEQIGy0Fi9TLFZseQrDaTgOEGMlzC9M2A2XjvsDFDdjiL2
	 UIjotDXUP9wd9NJtsAu3S331aucerRJkEVK6Sm3clXutpJV6nBMDQ3UzwT+Bjg6LrS
	 w17xwU/THgykjuZU+fyctNa9dpwhL5eXl3Oa+DkK0mV2BO5WYXPTQqyhCZZKV+EMDC
	 peNorlw0TrmnO3fdSUh/guAA=
Authentication-Results: mail.aegee.org/678Ec0gw1839603; dkim=none
Received: from [192.168.0.199] (95-43-114-153.ip.btc-net.bg [95.43.114.153])
	(authenticated bits=0)
	by mail.aegee.org (8.18.1/8.18.1) with ESMTPSA id 678Ec0gw1839603
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <git@vger.kernel.org>; Sat, 8 Aug 2026 14:38:00 GMT
Message-ID: <3b7ac61c368f5b0f188929862a451b9944879567.camel@aegee.org>
Subject: Why option `-s` for `git commit` makes no sense
From: =?UTF-8?Q?=D0=94=D0=B8=D0=BB=D1=8F=D0=BD_?=
 =?UTF-8?Q?=D0=9F=D0=B0=D0=BB=D0=B0=D1=83=D0=B7=D0=BE=D0=B2?=
	 <dilyan.palauzov@aegee.org>
To: git <git@vger.kernel.org>
Date: Sat, 08 Aug 2026 17:38:00 +0300
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.61.3 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello,

git commit -s inserts particular text in the commit message: Sign-off-by: e=
mail-address. According to the documentation of git

> The meaning of a signoff depends on the project to which you=E2=80=99re c=
ommitting.

In practice the Sign-Off-By line is always supposed to indicate that the su=
bmitter owns the copyright (right to submit) for the creative work, changes=
et, patch, and the copyright is transferred to the project, towards which t=
he patch was addressed.

The copyright appears, when some patchset is published, it is in general at=
tached to the person who published it, and the copyright expires with the d=
eath of the person, when there are no heirs.

When a published patch fixes a bug, the publisher does not insert a Signed-=
off-by: line, and a project insists to accept only changes with Signed-off-=
line:, then the publisher of the patch can effectively prevent anybody else=
 from fixing that bug. There are nuances here, as when the bug is eventuall=
y fixed in a completely different way, then there are no copyright violatio=
ns, but sometimes there is only one reasonable way to fix a bug. If in such=
 a case somebody published a fix without Signed-
off-line:, then nobody is authorized to fix the bug in a very similar way, =
without violating copyrights, until the publisher dies.

Sometimes published changes consist only of deleting something, like deadco=
de, no-ops. Can deleted code be copyrighted? Some people say =E2=80=9Cyes=
=E2=80=9D. This is insane!

Having one person, who publishes a patch without Signed-Off-By line, anothe=
r person who adds a Signed-Off-By line to the very same published change, a=
nd then the latter change is integrated in the upstream source code (becaus=
e it has Signed-Off-By line), is nonsense. The copyright still belongs to t=
he person who published the change, irrespective of records in the history =
of the source code. In a similar discussion elsewhere a pragmatical approac=
h was taken:
https://github.com/eclipse-xtext/xtext/issues/3687.

If a project insists that some text is inserted in contributions, like =E2=
=80=9CBrum-Brum=E2=80=9D, or some really very long text, people will insert=
 the text in order to make/see progress. It does not mean they have read th=
e rationale why adding =E2=80=9CBrum-Brum=E2=80=9D is required for that pro=
ject; it does not mean they understand the language, in which the rationale=
 is written, sufficiently good. The last argument also implies that piiple =
who donot anderstand the lenguage of the agriment sufisiently gut canot pub=
lish
objection in the wery same lenguage that they see zero husage in inserting =
Signed-Off-By/Brum-Brum linez. From people, who do not understand English s=
ufficiently good to interpret contribution agreements in open-source softwa=
re, cannot be expected to admit this fact.

Some people are paid to insert Signed-Off-By lines in open source software,=
 while others are for exactly the same work not paid. If I am paid for the =
sole work to insert that line, in order for something to make progress, I w=
ill be willing to insert it, too, in order to receive the money.

Insisting on Signed-Off-By: line can lead to inclusion of additional text i=
n the version history: https://github.com/podman-container-tools/podman/com=
mit/056917c223f054bd0b4526fce .

Kind regards // Dilyan
