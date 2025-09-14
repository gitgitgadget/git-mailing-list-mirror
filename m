Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCE2E571
	for <git@vger.kernel.org>; Sun, 14 Sep 2025 17:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757869585; cv=none; b=JMejH5mCbc176+w7N8Bfpa0HyO4X31lb8E7XvMLXbRaud3BdTDN4o8eA5VDv+AtAOW15/ezaUdUzqDT3A01nBRiMg0b9jykEy/sCVDY0cQNiHktUjFwAFDW0aQzwTeUXTHeZT138m5bhsWhX0zTLI7QeWIxg3BSdPrgMoRtLkHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757869585; c=relaxed/simple;
	bh=0oWigNz0CaYm5jPf40C9TV9MhcU4FT00vR9k1NgTNtQ=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=cR3dC0cYJKxpq7RM9y94mEwA5RyZgyZlUhbSC1vfU43rHDQtphl1NKOS2B8YYkUtdlWOhFdYt8TQWPej1jZrZwnSef4s9usoy9ChZUXuxFa9ujN7H2jdZoK6zQHGfyBwynFAmjh2cJCbTnX/E796lqG/db/PEVKKQF39iHKkJMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 58EH00QG143039
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Sep 2025 17:00:01 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Kristoffer Haugsbakk'" <kristofferhaugsbakk@fastmail.com>,
        "'usharerose'" <ushareroses@gmail.com>, <git@vger.kernel.org>
References:  <CAJKmQvf-sLxowLJLitvqDmyL1BXXDK+anDE2jaBSEabApMNVoQ@mail.gmail.com> <071101dc23f5$fbf06e30$f3d14a90$@nexbridge.com> <88e9b975-70a5-4773-bd08-634e56c491c6@app.fastmail.com>
In-Reply-To: <88e9b975-70a5-4773-bd08-634e56c491c6@app.fastmail.com>
Subject: RE: [DISCUSS] validation on git config user.email
Date: Sun, 14 Sep 2025 12:59:56 -0400
Organization: Nexbridge Inc.
Message-ID: <007701dc2599$02b6ca30$08245e90$@nexbridge.com>
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
Thread-Index: AQFhsskxhIwwf9HofCc/CXNKi72LFgGEk2wLAivJrUy1akjtwA==
Content-Language: en-ca
X-Antivirus: Norton (VPS 250914-4, 9/14/2025), Outbound message
X-Antivirus-Status: Clean

On September 14, 2025 7:18 AM, Kristoffer Haugsbakk wrote:
>On Fri, Sep 12, 2025, at 17:00, rsbecker@nexbridge.com wrote:
>> On September 12, 2025 12:13 AM, usharerose wrote:
>>>I'm a Git user and curious about a specific aspect of Git's design
>>>regarding the 'user.email' configuration.
>>>
>>>Git allows any kind of values without restriction when setting
>>>'user.email' via 'git config' (e.g., `git config user.email
"not-a-valid-email-
>address"`).
>>>
>>>I'm interested in understanding the design philosophy or historical
>>>reasons behind this 'lack' of validation.
>>>
>>>I've glanced through the documentations, archived emails, or forum
>>>topics, but couldn't find a definitive or official statement.
>>>
>>>Thanks for your time and insights.
>>
>> Some customers integrate single sign-on (SSO) via the user.email value.
>> In the case
>> of one customer I helped, the value is an SSO token used by GitHub for
>> their integration. The token value does not conform to any valid email
>> address format.
>> Adding an email validation will lock them out of using git.
>
>That sounds unreasonable.

In what way, may I ask? I have personally seen this done. Their core.email
value is not a valid user name. It is a token with no @ or . characters. It
is an alphanumeric string.

