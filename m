Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089544315F
	for <git@vger.kernel.org>; Sat, 12 Oct 2024 06:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728714336; cv=none; b=sm5Ig0pBqGC7IOtXqPVUnWdAuIGy/MnBx1gATy3mH79lAYlpLCcPkzeTr2usStNYvwGzbfWu0++mx/tzHX3ocfceiOaQkixbvqJqkkM5tkPgzkBNs37+IPqooP+gHQ1RPHwHMAxn7cw+bs3A7Xg+jevDiKhEs7B0EfF+e5cV1jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728714336; c=relaxed/simple;
	bh=1q/b6b4Wfma5Z+zo58EopVFBvQafHghMD944tV+DGx8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=olnfBJJXAVP0XhflJCkrpqgeSfPJnGRKpqgd/L3dYKnxvOF0oQKtHxQO7mTf/1vF0LJh7TKMT11IYjrjb7YDKrGQfP39oC8Zc42JWLO0o8BXzfi3RkvWDzzBS5jo73LCCqlTLzrkHNfkTy4Y7LsOXh9Wl/T1q/e3vTORzBrVUXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4XQYQF3S8Zz1s953;
	Sat, 12 Oct 2024 08:25:25 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4XQYQF2ykRz1qqlS;
	Sat, 12 Oct 2024 08:25:25 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id KxBRDDocODCb; Sat, 12 Oct 2024 08:25:24 +0200 (CEST)
X-Auth-Info: hwvqEnYixcQMwCaX2ogyE0APZY5+gcdJkhmFTpU37rRHmDitTFygWzaydVR0+G3n
Received: from igel.home (aftr-82-135-83-221.dynamic.mnet-online.de [82.135.83.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Sat, 12 Oct 2024 08:25:24 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 7C6C82C1A11; Sat, 12 Oct 2024 08:25:24 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: "Bence Ferdinandy" <bence@ferdinandy.com>
Cc: <git@vger.kernel.org>
Subject: Re: ref: with git update-ref?
In-Reply-To: <D4T9VCF8OS6U.1FMB8P6YU7I3S@ferdinandy.com> (Bence Ferdinandy's
	message of "Fri, 11 Oct 2024 22:51:08 +0200")
References: <D4T9VCF8OS6U.1FMB8P6YU7I3S@ferdinandy.com>
X-Yow: I'm rated PG-34!!
Date: Sat, 12 Oct 2024 08:25:24 +0200
Message-ID: <87ttdhsuqz.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Okt 11 2024, Bence Ferdinandy wrote:

> the documentation for `git update-ref` has this sentence:
>
>> It also allows a "ref" file to be a symbolic pointer to another
>> ref file by starting with the four-byte header sequence of
>> "ref:".

This is about the format of the reference to be updated, not the
<new-oid> argument.

See gitglossary(1):

       symref
           Symbolic reference: instead of containing the SHA-1 id itself, it
           is of the format ref: refs/some/thing and when referenced, it
           recursively dereferences to this reference.  HEAD is a prime
           example of a symref. Symbolic references are manipulated with the
           git-symbolic-ref(1) command.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
