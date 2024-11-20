Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62712158D6A
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 10:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732099231; cv=none; b=A1mQTXk/7lWtAI7pCNFk88Xz1jrCbM2o/KjtwjS8iO+x28+T9Mgu9eyf3tCg0o2kIZY6C8hMW+tu9E9zQrRpVKdhXYyGdca8fX026Nmsy3hNDISOTGxBLO+5wDCykM5igqlSCkxTAJ4tsJBeII41/ScvJSRAcDovaObS3nyJSqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732099231; c=relaxed/simple;
	bh=SlFTpxMIbROAPuD6M1pkrrRwNeJx1v73gNgalk4kdL8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AX8hHBSUN0bTwRwl1xosu4A69Dz9LOBsEcmT+Py8Bz9WsfKa0QKm+pqzsWs6TAhDoE6+xK+UkHdV7YJSZSAEA/BNg+IfMAiCT7KAl2GDi7GXThpJdBqk3Of5RG8/xCPHLy88ogq3ycJ3LhgLSCa1V41S69cghRYOVbnP1gYgnW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=TCD0gZkC; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="TCD0gZkC"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1732099226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SlFTpxMIbROAPuD6M1pkrrRwNeJx1v73gNgalk4kdL8=;
	b=TCD0gZkCsDgYLAwbeXBLzxAIHdhpQGEmNxY2Dml8GqXiBGw3Ttaiip7o/kFiHHMSV6eZK4
	xh9DWS6qKco9I3tsScuqdXdm+OIT+VBTg3hhEF7PM+HIG5+l3RLMqEU6tfCqONCZWwPt0J
	b0bJ9rrxUlGAxYfq+qvA+ko8OPmoD5c=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Subject: Re: [PATCH v2 27/27] t: remove TEST_PASSES_SANITIZE_LEAK annotations
In-Reply-To: <20241111-b4-pks-leak-fixes-pt10-v2-27-6154bf91f0b0@pks.im>
References: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
 <20241111-b4-pks-leak-fixes-pt10-v2-27-6154bf91f0b0@pks.im>
Date: Wed, 20 Nov 2024 11:40:15 +0100
Message-ID: <87y11erxww.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> Now that the default value for TEST_PASSES_SANITIZE_LEAK is `true` there
> is no longer a need to have that variable declared in all of our tests.
> Drop it.

Amazing to see this finally fall into place. Thanks for all the hard
work. I've sent you some comments on some of the patches, and the other
look good to me.

--
Toon
