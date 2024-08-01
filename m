Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1068143883
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 18:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722538429; cv=none; b=qv60icuxl09xPMfJhKxW3/eXmV8v/Q025iq7lV2DFkK7Vm+9jKCwqPRI36AbJtc7qMxNVKkbQuWvhFjzNgHj8pQgFGre4inN6ARlTZg3ACS6q4JKATDi5PiP+xIg1GFY8ALU6p0v/3WyxXZ/Q0VOlSOl70gtO+E8bIfvamNsbtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722538429; c=relaxed/simple;
	bh=N9QGH+vi05vHqEjeY7HYt9qHiddzRbvaiLg3eOdZU18=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=On8/wsSd3zGIE9V1Ehe6oRyYtrF0QzD5IbG+rGG+WU7t+lMWAQZ4bw+L1YHPZH3ajxH5kpleZbGBhRGxF9cGbQ2AzROuMQzrDc89sgv4HdqFA3IpxAV/X7ZhXSfNMHdRABpsDHjhLNlu2CIvSVH9YNJSGvANUONz/pd5BLoy5es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 471Irjjh3506487
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Aug 2024 18:53:46 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
References: <02d401dae43e$c076b000$41641000$@nexbridge.com>	<xmqqbk2cum5o.fsf@gitster.g> <xmqq7cd0ulen.fsf_-_@gitster.g>
In-Reply-To: <xmqq7cd0ulen.fsf_-_@gitster.g>
Subject: RE: [PATCH] t0018: remove leftover debugging cruft
Date: Thu, 1 Aug 2024 14:53:40 -0400
Organization: Nexbridge Inc.
Message-ID: <02e401dae444$23172780$69457680$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQGnznpkW75Rul6Kx/55mvNhpy8eIgI+lrsvAcZshW+yWMMK8A==

On Thursday, August 1, 2024 2:51 PM, Junio C Hamano wrote:
>The actual file is copied out to /tmp, presumably so that the tester can
inspect it
>after the test is done, which may have been a useful debugging aid.
>
>But in the final shape of the test suite, such a code should not exist.  We
cannot
>even assume that we are allowed to write into /tmp (our TMPDIR may not even
be
>pointing at it) or read from it for that matter.
>
>Noticed-by: Randall S. Becker <rsbecker@nexbridge.com>
>Signed-off-by: Junio C Hamano <gitster@pobox.com>
>---
> t/t0018-advice.sh | 1 -
> 1 file changed, 1 deletion(-)
>
>diff --git a/t/t0018-advice.sh b/t/t0018-advice.sh index
b02448ea16..040a08be07
>100755
>--- a/t/t0018-advice.sh
>+++ b/t/t0018-advice.sh
>@@ -93,7 +93,6 @@ EOF
> 		>README &&
> 		GIT_ADVICE=true git status
> 	) >actual &&
>-	cat actual > /tmp/actual &&
> 	test_cmp expect actual
> '
>
>--
>2.46.0-179-g92bab5172e

Verified to work correctly.
Thanks.

