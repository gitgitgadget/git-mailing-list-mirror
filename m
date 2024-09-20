Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54588208A7
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 17:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726853867; cv=none; b=HPdxqtJXvSF5DlfaHF2OBOBuepKLUCfHmzKeiW3S5lafqczbzkGO2hSQV9QsHKGUOqlgZrY3r0sKSw5Vw+SB2yZMBYAgnrn2vFcWya8CSr5SiL01XdGHX1oEiJuBuWmotKeIntXrN/VowWJoR8NkiFcFpPlAX+CgCV5sUj0XvFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726853867; c=relaxed/simple;
	bh=jcVa9AkSUkTanVq1sVbr6K5IHcDMLXSH3IID3gYY8G4=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To; b=E9Z9+LJRU+MeoNj+FzRLpcFJ4dnel/QT9/zN6IJDFEJ51w3duZ8dkHlaZdTrA/nhPMC9PMYxJ9cDx1y27tPSi3swwQopP6QdtelpffnqHG0cD6UIE7dRtKleWSwAFL3b0UNnhrc+/32xwa3BIyNE5Wow4Iq12D17p3m/voiGcQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rjp.ie; spf=pass smtp.mailfrom=rjp.ie; dkim=pass (1024-bit key) header.d=rjp.ie header.i=@rjp.ie header.b=i0ycHJe5; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rjp.ie
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjp.ie
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rjp.ie header.i=@rjp.ie header.b="i0ycHJe5"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rjp.ie; s=key1;
	t=1726853861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UFbjwYSipitW7l1nNhp/GkD/aNFM/D8baWxbIXB9RAg=;
	b=i0ycHJe550+aSxMrEt1HsTHod4yb3R4FyIPh5mh6UMGOTQnQHI7cHRry7ujj+PQWtjtdTQ
	O8s1S4ta8Hl+yD9lt68A20JnjIVj9+tFAxvuIc1LEo1kGJ021cspcGj5s7/DCJRlGmmPd8
	DKjTjPPgs9ikb+0kXjBg0S6NbknakNA=
Date: Fri, 20 Sep 2024 17:37:40 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ronan Pigott" <ronan@rjp.ie>
Message-ID: <1b9fb3f3fde62594b9ac999ffb69e6c4fb9f6fd6@rjp.ie>
TLS-Required: No
Subject: BUG: refs.c:1933: reference backend is unknown
To: git@vger.kernel.org
X-Migadu-Flow: FLOW_OUT

Hi git,

The following is an abort in git:

  $ git --version
  git version 2.46.1
  $ git --git-dir=3Dnotexist archive=20=20
=20 BUG: refs.c:1933: reference backend is unknown
  zsh: IOT instruction (core dumped)  git --git-dir=3Dnotexist archive

Cheers,
Ronan
