Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F041621B9DA
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 18:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756231476; cv=none; b=SiYWCcU3rDViZkSXBa7UUTOj8N6iwsKuTGYrpRwMtWt3HEXGKG7NpCQs1yk8SKFeUagQh08hyp0ZAQ/9aKxaiMBahex+7C9L6QzWg3vX3QPtqbS84YXIxRrFyO3QHVoHlJkQYtFre++iKU6LIf8ApANrG6nXkJT1R1IKiYk6Cc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756231476; c=relaxed/simple;
	bh=/avXRCSgAxbDvSsGsrHNoiUdBQu93iumfYDII+FhrhM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y9GPMZcj6dkerypwZ9w9dqHi/kN+/CGp7u/gu+dxVOkDsEpnwduLxXbQ8a5qD8E4FzTQT+wtk2aeEGLtrxqGmFZAE1vx9I16Tszj41OwWZ3E9sOZZzxiAqxEYc0svH6/bGbZOsUQ3RrU3I81bIoq/o5u3282TrX+0fuTngp1HNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 57QI4URf4054851
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 18:04:31 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: <git@vger.kernel.org>
Subject: [Suggestion] Handling Rust in upcoming releases
Date: Tue, 26 Aug 2025 14:04:26 -0400
Organization: Nexbridge Inc.
Message-ID: <014e01dc16b3$dfae4750$9f0ad5f0$@nexbridge.com>
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
Thread-Index: AdwWsx54G3MUp+VnTaugUtyVc7baqA==
X-Antivirus: Norton (VPS 250826-4, 8/26/2025), Outbound message
X-Antivirus-Status: Clean

Hi All,

I would like to propose a mechanism where some platforms can keep using git
even where Rust is not available.

Basically, make Rust a dependency for commands that need Rust but for those
that are still in C, do not require rust. This will mean that git can keep
being
available, but new development can be done in Rust. It also means that
CVE patches, if they come, can be done without leaving non-Rust platforms
hanging out in the cold. It does mean that some commands will not be
available on some platforms. This has been a well-established position
by git for many years for other non-portable dependencies, like p4,
subversion, and send-mail.

Please consider this as a compatibility suggestion. It will give platforms
who have plans to implement Rust (eventually), time to react, as Rust
is a non-trivial port without gcc being available also.

Sincerely,
Randall

--
Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)
NonStop(211288444200000000)
-- In real life, I talk too much.


