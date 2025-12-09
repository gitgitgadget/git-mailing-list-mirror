Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E1826E17F
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 08:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765269848; cv=none; b=S5jiG2Cy/QPFBcexB8fI340ITHCX1dGMEilo1+Et2glOZbgAIuwIR5m+XmjN80gIfuPKPY5iqj+nsqB3/GhmqjWTsYmGtcuTkNvJMq34NuaX/FjiIFbc5/NKKNyUEfpHRVc7sMqlQei8x0qbGa3sdrhywNCpNKFtcpg66RyW+p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765269848; c=relaxed/simple;
	bh=ehxszC1zcnabBrL/sQgR+j4sHznSoZUkp3UwhStPfoE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U+/fXGKK8wkCVUH3Vu57OspXTO/oeCE1C/sDBC5qURA64xSVZ9bQ+INyoDp9jV7eUQ1VwM7yp8Isf+ETbK+kGWVZNlpQvTP0DcvdzvYVWG7h24EBx1p41hNYeXSv9hx3jiihS88gCI/3n7ncFBF2A9YYOzaBnEFTikllvexG+SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=tcguvcuc; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="tcguvcuc"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1765269840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uGWOJ44z7TJ/9n8jBDeZC05236f9Leteftjc2+Ycj2I=;
	b=tcguvcuc/VcykMz2RBR0HW7mo5H4GA8HSkYmRnjsR5DSBAqSUAKT1YuMoUX92HbAEhMpTz
	K6N5GogIgXyyvblqTJ/tCv9ccDQuRKbztM4rr4z13ohaY0eR0tjAVXK0dJo/r9UgOuqDcS
	veA4TVoyAR+Y6cSunDVPsYCod/6nFys=
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Karthik Nayak
 <karthik.188@gmail.com>, Anders Kaseorg <andersk@MIT.EDU>
Subject: Re: [PATCH v2] last-modified: fix use of uninitialized memory
In-Reply-To: <xmqqikehkstt.fsf@gitster.g>
References: <20251128-toon-big-endian-ci-v1-1-80da0f629c1e@iotcl.com>
 <20251208-toon-big-endian-ci-v2-1-76b46763a597@iotcl.com>
 <xmqqikehkstt.fsf@gitster.g>
Date: Tue, 09 Dec 2025 09:43:50 +0100
Message-ID: <871pl4vyd5.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Junio C Hamano <gitster@pobox.com> writes:

> Sorry, but hasn't the old one already been cooking in 'next'?

Okay, fine by me. Let's abandon this v2 then.

-- 
Cheers,
Toon
