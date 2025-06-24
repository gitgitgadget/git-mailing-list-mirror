Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C092219E0
	for <git@vger.kernel.org>; Tue, 24 Jun 2025 23:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750809329; cv=none; b=P/iTGV1tyf7JEX2Rhv14y2i0Co3gUlHLn4iM9ZEtbj5AtTSlUcvHa6CFn6PYYKFqs6imx6alkPfeJTs+fMLfUCWQqImSW9WvIYgJ5Vc8w+yBPVe3UpS+gbzGnJ1DEiL8SXGV5uL4LiX+Ywn7V88D0MbuQvptP01PYxVus3YjgBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750809329; c=relaxed/simple;
	bh=574l/NhJ66Cr3flmpNLObvHnyuIeUMGi+qQhok6Hdvc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iNWbGyi9thPyYkKBt20UnP/BF1MJr2zOWP3vjz2BLevz7eJbVdQMwrix8EszRDYSaml4kLtDlHuquEffa/E5nVfaKu+cfn6Yx6mxynkpn8rauWSECPUuwn4toWr3/k7rHFxhWwy1RV0aP09zUydXj8RlhnLleeEcJyZ7oAoBdNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=guixotic.coop; spf=pass smtp.mailfrom=guixotic.coop; dkim=pass (2048-bit key) header.d=guixotic.coop header.i=@guixotic.coop header.b=wiokvYQ5; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=guixotic.coop
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=guixotic.coop
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=guixotic.coop header.i=@guixotic.coop header.b="wiokvYQ5"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <maxim@guixotic.coop>)
	id 1uUDTz-00CgGH-Oh; Wed, 25 Jun 2025 01:55:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=guixotic.coop; s=selector1; h=Content-Type:MIME-Version:Message-ID:Date:
	References:In-Reply-To:Subject:Cc:To:From;
	bh=vSKU0Ap/C9DV5ES1TgdEt2C2RCvZFByEcP8YB3eLORQ=; b=wiokvYQ5K+2uenxvx0vDdUmsqD
	jmw5kZXyhR5VjSIzWN4EPwnHW8wPEjm4Xk2kuAkf18G9ldgM90+yR3fFvO93gZKdoj7uzyLBwhg+M
	KcY8fNJbgotg+PaWfF5EboggyiWVx8xA1qULUf9C+RMMunwTc+LIVkiUwsKPwkXew9F7jYvdvPEBh
	A812o2FqzwZv4Hl2UlRK7xOtqx437r0mCUTW6irCcaP6oUAqPR57D+iFEyy4aI6ZU54c3n9OVTBYQ
	PTJ4dQfy1gDXR5u2MgyO4EXw78SraEYaKbOviNzQe9ekzM6LbsR2/V0xi3o46bS2e2ONrsapsvJJ+
	IrdF17zA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <maxim@guixotic.coop>)
	id 1uUDTz-0006fH-5W; Wed, 25 Jun 2025 01:55:19 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1476852)]  (TLS1.2:ECDHE_SECP256R1__RSA_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uUDTx-00Grsm-Ah; Wed, 25 Jun 2025 01:55:17 +0200
From: Maxim Cournoyer <maxim@guixotic.coop>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,   Andreas Schwab <schwab@linux-m68k.org>,   "brian
 m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 0/3] git-credential-netrc: better symbolic port names
 support
In-Reply-To: <xmqqecv915y7.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	24 Jun 2025 09:04:48 -0700")
Organization: Guixotic
References: <20250620041239.27839-1-maxim@guixotic.coop>
	<20250624014857.3748-1-maxim@guixotic.coop>
	<xmqqecv915y7.fsf@gitster.g>
Date: Wed, 25 Jun 2025 08:55:12 +0900
Message-ID: <87ikkkk84f.fsf@terra.mail-host-address-is-not-set>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

Junio C Hamano <gitster@pobox.com> writes:

[...]

> v2 and this iteration both have all messages set as replies to a
> single message in the old thread.
>
> Please make sure in your future submissions:
>
>  - [0/n] is a reply to [0/m] of the previous iteration.
>
>  - [1/n], [2/n], ... and [n/n] are all replies to [0/n] of the same
>    iteration.

OK. This means I need to submit with 'git send-email' in two steps,
right?

-- 
Thanks,
Maxim
