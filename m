Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA10321D3E6
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 15:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757689242; cv=none; b=NEcmexxefVUu7axtuYcefwqpkXJmxNaCV3k0XtvwzMohm8EWEZDnSvjmqJ9kPHWH0x6eUvXUAa8ybAd2IcE198y1oiekgIu8CVB7zJyjAQNd+xObHrnkIqTd2u4qb4UDhF+gBW/IZ1/QGCvYcZgcky94h8iYa8cdpJrsJFBO6wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757689242; c=relaxed/simple;
	bh=62D6qn6jEBIluX3EIbsc5zmY7/RWIQmO8lNVRMm6c7s=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=JRSreeAfNir1S34PHO8tA5va3iEVv7QYNR1/dAgNJjpe5owZREi6p4okhaTShlJAsNwChmWJQ6027DiKI0QTqTrFdVGg617+qlbcjzfpyliFY7Xm5O/a8XATAhL6S2IeE0kKgbYK3mXlhPyYSd+vMBFEOoWuRChqRaVZ7ZtjNco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 58CF0UXa3974193
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 15:00:30 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'usharerose'" <ushareroses@gmail.com>, <git@vger.kernel.org>
References: <CAJKmQvf-sLxowLJLitvqDmyL1BXXDK+anDE2jaBSEabApMNVoQ@mail.gmail.com>
In-Reply-To: <CAJKmQvf-sLxowLJLitvqDmyL1BXXDK+anDE2jaBSEabApMNVoQ@mail.gmail.com>
Subject: RE: [DISCUSS] validation on git config user.email
Date: Fri, 12 Sep 2025 11:00:25 -0400
Organization: Nexbridge Inc.
Message-ID: <071101dc23f5$fbf06e30$f3d14a90$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQFhsskxhIwwf9HofCc/CXNKi72LFrWEhUHw
X-Antivirus: Norton (VPS 250912-2, 9/12/2025), Outbound message
X-Antivirus-Status: Clean

On September 12, 2025 12:13 AM, usharerose wrote:
>I'm a Git user and curious about a specific aspect of Git's design =
regarding the
>'user.email' configuration.
>
>Git allows any kind of values without restriction when setting =
'user.email' via 'git
>config' (e.g., `git config user.email "not-a-valid-email-address"`).
>
>I'm interested in understanding the design philosophy or historical =
reasons behind
>this 'lack' of validation.
>
>I've glanced through the documentations, archived emails, or forum =
topics, but
>couldn't find a definitive or official statement.
>
>Thanks for your time and insights.

Some customers integrate single sign-on (SSO) via the user.email value. =
In the case
of one customer I helped, the value is an SSO token used by GitHub for =
their
integration. The token value does not conform to any valid email address =
format.
Adding an email validation will lock them out of using git.

--Randall

