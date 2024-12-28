Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0569E18E373
	for <git@vger.kernel.org>; Sat, 28 Dec 2024 17:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735406116; cv=none; b=EYBnfrM3vHgdGxkGk23tgoFlCFs8skmUfmrO44PznFCscZ1dEb+wzvRf4hDaj+oy3cx0hMCbFLGkVSNG9lXIrhVvarPE6QQkfEeAIb9r5JLNnvwdbgnersSLeywmV8lNP4R9YONk8QB4CHDY8VibEcDqunMi/TBEFooAauU89wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735406116; c=relaxed/simple;
	bh=cse1SXiJunkaH1hXGVLsZkU4DXes4UJDJ9yA2l9WmbA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L1FLiX+Bt0iwrbLtpIB2OMaG8CKRcvC/3s1SslaZxUOOmUf6X4ut4guOAsrdO45Lnx1kjNTzqaPwu0JQUdJHmIlrkscWAhs2qWHaWmhv4kxfepJewzGv/Zl/PGBlX7uG9u1jEyUP8Zr+QchAmyv6f64bvLDvnwkxL2Xd2E83bGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4YL8BG6NHTz1qsPp;
	Sat, 28 Dec 2024 18:15:02 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4YL8BG5kCTz1qqlS;
	Sat, 28 Dec 2024 18:15:02 +0100 (CET)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id ZMnH3XEghbKP; Sat, 28 Dec 2024 18:15:02 +0100 (CET)
X-Auth-Info: 3C0p7L6zQndGZ3NoioddPNG4NdB6vFSFtfINzTwhfMtBoKdr3/0YWlHhqyS1OjwB
Received: from igel.home (aftr-82-135-83-134.dynamic.mnet-online.de [82.135.83.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Sat, 28 Dec 2024 18:15:02 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id CD2B42C1A00; Sat, 28 Dec 2024 18:15:01 +0100 (CET)
From: Andreas Schwab <schwab@linux-m68k.org>
To: crstml@libero.it
Cc: git@vger.kernel.org
Subject: Re: connecting the local main branch to the remote origin/main
 without pushing
In-Reply-To: <a69c4e2e-cbb0-c242-a34a-8997a84fefb7@libero.it>
	(crstml@libero.it's message of "Sat, 28 Dec 2024 16:47:27 +0100")
References: <a69c4e2e-cbb0-c242-a34a-8997a84fefb7@libero.it>
X-Yow: Used staples are good with SOY SAUCE!
Date: Sat, 28 Dec 2024 18:15:01 +0100
Message-ID: <87h66nk9uy.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Dez 28 2024, crstml@libero.it wrote:

> My question is:
>      Is it possible when applying the method 2 to have (without pushing)
>      the local main branch connected to the remote origin/main branch as
>      in the case of method 1 which by cloning connects these branches.

You can establish the effect by setting two config entries:

$ git config branch.main.remote origin
$ git config branch.main.merge refs/heads/main

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
