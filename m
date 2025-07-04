Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097CF30B9BA
	for <git@vger.kernel.org>; Fri,  4 Jul 2025 13:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751637108; cv=none; b=fIQESl+iSIVvivGC3eY2X1M0/FRYbyzyNaR2kPCtXSF6Fm1YPEov0JYGUmtC9KCk+jbpg5AZFJdj/n5wvHsJBm86tKO6nOcDcPtLj7fvrIgRDoSx1qtumNI+EURGSld7BOghwwePuW6sSM8BiUIBdlBxX8kxTlOId4Y4zL3kSQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751637108; c=relaxed/simple;
	bh=QjlQhuV8gNYwRatSnhIR2aqf1wBaXaf0zDIFcdbK/MQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TRdZagHIs01kaIUAICbmn2SGKgldTnGldIF2NNJ+5tqkg7TqaNSL4v77AJt//OEWFQqDOSpS+xmOLiN7j5FeupfFak5tut08SvQlLDnQqdgeGvZ9uhJTBCfUhImeIfJbWtG1wBuWIZ4ttJnal0t7iSus25W8GNv9qDlTzQ+VtFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4bYZYm4T85z1r57D;
	Fri,  4 Jul 2025 15:42:04 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4bYZYm47qmz1qqlS;
	Fri,  4 Jul 2025 15:42:04 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id TGOrBfebYhpk; Fri,  4 Jul 2025 15:41:54 +0200 (CEST)
X-Auth-Info: rGvQG7gF2FiRrTJVTCIzHxthltzIkuS9mXls3t+qYNTBwkgKDJ3g8nKqOQ2cGbGk
Received: from igel.home (aftr-82-135-83-93.dynamic.mnet-online.de [82.135.83.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Fri,  4 Jul 2025 15:41:54 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id D1A252C1969; Fri,  4 Jul 2025 15:41:53 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  gitster@pobox.com,  ps@pks.im
Subject: Re: [PATCH v2 0/4] for-each-ref: introduce seeking functionality
 via '--skip-until'
In-Reply-To: <20250704-306-git-for-each-ref-pagination-v2-0-bcde14acdd81@gmail.com>
	(Karthik Nayak's message of "Fri, 04 Jul 2025 15:02:28 +0200")
References: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
	<20250704-306-git-for-each-ref-pagination-v2-0-bcde14acdd81@gmail.com>
Date: Fri, 04 Jul 2025 15:41:53 +0200
Message-ID: <87ms9kcbtq.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Jul 04 2025, Karthik Nayak wrote:

> This series adds a '--skip-until' option in 'git-for-each-ref(1)'. When
> used, the reference iteration seeks to the first matching reference and
> iterates from there onward.

I would have named the option --start-with.  It has the advantage that
it is clear whether the matched ref is included.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
