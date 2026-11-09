Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794211397;
	b=krsFEToqwGq2XvDeV21g2mwNLN3uXJloTCPtYPhG7wMdhZ4sFrQkriLpeDBS9T/36rIt
	 IiMwTOlLRJWnoREntR71sW3YNF+ZBrV+cwBEJYjkvXa+409LOxTdKBDUpKoutlPYXS/OR
	 W2rj6C/jDkvotUDtxxsUxNaMEXyDtMSK1bwJM4p+X5o/tkh+5VGpgAS4S60deYQLkawXy
	 nnyoAKm2Tj/Y2M/LR1oogXHJLxLXPtAKI1JpIUfos1j+NLbwZbxZwNfBkD/j9OHCDVsIx
	 UldOyqGm42nH9+3q134K85/VgjpEajFkzKYaqaGu2wXPKcE9qrO6Kz5U++ZUcVlyJYw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794211397;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
	bh=gd0sI+ZXOaI6zaRvSc9nsJTcV9OxBKa4KZRUvKOSq1o=;
	b=xURLMjWZZ6kOsauP9uQWjjMG590cOD2B07mvqqGeXZDI1Ecg57RRWQljZZPPCvJ8p9Dp
	 CegQkpSsTJJ4Z+e7f0rEbc7WDzwcAHi1PSbHLmJz/bXeyrxng4ToxI79bCG86O9aQ2aQo
	 YsEsDMcdduoV1f3t1nqDJVMjq3sOrJv4FI525jnG8anYRMOfoHrqtoTnxxhqu0Q2EdVU+
	 QFVUCabILD+rZOao5aNEn16H1pTWzQdxSMlU3rWxvXt5+apNPF0MInUASPvA5KbkGmAME
	 vCEEghrt1qVKOnSx5tXvW5AyrecvNT4DE73c2+5WrjQkI0CIOlr8V0bOILEEVbKjPGw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=hROt3R8c;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
Received: from sender5-op-o12.zoho.com (sender5-op-o12.zoho.com [165.173.182.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C1C606A321
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 08:03:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42C1C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=hROt3R8c
ARC-Seal: i=1; a=rsa-sha256; t=1794211391; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KYo7l464tVpYvErKK2RjPsyj0Ryu7QONIF7csaabLl2XC0IY4GS4Br8O+mfHaedHNAIBC0DWhdmSSp6WuOBC2Hi86afPkpqG0cnwmdYobUswQ2b/cnYOW6quMJ0VVTxbwuq8lK0ihYh/5eDf/LvkSh4Q9MbZM+1bRvbF8OQNcHo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794211391; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=gd0sI+ZXOaI6zaRvSc9nsJTcV9OxBKa4KZRUvKOSq1o=; 
	b=W9UKCqsM1EG81o6ZD1i++57j5LC67X8hph88pKKf1dXGdxF+u0AnzCNrnYr9Wf8b86yQhKKZTTv10GSvHgcGiY7D0A0K+vrks0FcCXWllzE9cAsvr4mSLilRY74Lsh96TdZXGBxV4ZCK2YurNr3EQ9tCQVOH9dJbLhaYdptkqwA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=vmiklos@collabora.com;
	dmarc=pass header.from=<vmiklos@collabora.com>
DKIM-Signature: a=rsa-sha256; b=hROt3R8cm0GKUgQMBtTZ32G3bwh0rXWMKC2oCe7Htkix/p7NSyMVmvcVRNyTGzXXhkrjAvDRv9M3n+QozU/Z0lFUfVrG5sftMb0Ai5EpuV5qVOR+lJv5+6/BK+mIjw4IIuwChh+r0/vqwbbQIXNryDESJSEMnSSxc/s6HeT4KYQ=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=gd0sI+ZXOaI6zaRvSc9nsJTcV9OxBKa4KZRUvKOSq1o=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794211390649261.4524477879711;
	Mon, 9 Nov 2026 00:03:10 -0800 (PST)
Date: Mon, 9 Nov 2026 09:03:03 +0100
From: Miklos Vajna <vmiklos@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: gitster@pobox.com, szeder.dev@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH v4 6/6] log: fix --follow following an edit on a side the
 merge did not take
Message-ID: <avF-N2Pva7mZE40M@collabora.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <au3guSIBfekx7gNL@pks.im>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/294.182.33
X-ZohoMailClient: External

Hi Patrick,

On Fri, Nov 06, 2026 at 03:14:17PM +0100, Patrick Steinhardt <ps@pks.im> wrote:
> > Fix the problem by also searching for renames when the merge base
> > doesn't have the path, but the parent changed a file since the merge
> > base that the merge no longer has: only such a file can be the old name
> > of the path that still needs to be followed in the parent.
> 
> This isn't true though in the case where you copy a file though, is it?
> E.g. the following test case is exactly the same as the one you add in
> this commit, but instead of using a rename we use a copy:

You're right, I didn't consider copying. I've added your test to 1/5 and
fixed 5/5 in v5 to handle this correctly.

The pre-filter now also takes a file into account that the merge still
has, but with the version of the other side, and the rename check now
also detects copies. This makes the linux.git case take about 42s,
instead of 37s here.

Thanks,

Miklos
