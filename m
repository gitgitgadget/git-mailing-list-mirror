Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D817222156D
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 17:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757697821; cv=none; b=UO9caA/RvLFxD1GABteVAVOmN/iN+0V4I/LupmO+tHHWUe8AvPLwMnzSSVTz6bjyluQx+57XNtM4zLsoTS3UDGMEw3WwsFDJcBjoKLrQ0EcagDDICznrw5XxR0N/KbjcxOoNpD9fBu4gFv7KRcmuxOb6ZoHSg+RCS51MfF4Fw7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757697821; c=relaxed/simple;
	bh=NA088ouFte8+C1/revZ2675IeO4oKCKs3o863NO9T0A=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=U+JLpPK1lPre+tvMWk+EUAMWFEsmrgxhK7OZZmj8LrjSv1FQRXw+NURldTygvMNWggNvIhCyUdUDseoZLluD6jHSAWKNJzX21017hTgRzKq0HDhLsNGmkq+wVC4pNt8xPJFCE84TaUvdh381vNWF3Um6IfjIp4vZbP4dpCH69oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 58CHNZfE3997866
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 17:23:36 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'usharerose'" <ushareroses@gmail.com>
Cc: <git@vger.kernel.org>
References: <CAJKmQvf-sLxowLJLitvqDmyL1BXXDK+anDE2jaBSEabApMNVoQ@mail.gmail.com> <071101dc23f5$fbf06e30$f3d14a90$@nexbridge.com> <CAJKmQvcqLzJDnpYg5K7_eUNCUdLCkkFse-wB+4R8KGxKo_e+0w@mail.gmail.com>
In-Reply-To: <CAJKmQvcqLzJDnpYg5K7_eUNCUdLCkkFse-wB+4R8KGxKo_e+0w@mail.gmail.com>
Subject: RE: [DISCUSS] validation on git config user.email
Date: Fri, 12 Sep 2025 13:23:31 -0400
Organization: Nexbridge Inc.
Message-ID: <071e01dc2409$f9785230$ec68f690$@nexbridge.com>
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
Thread-Index: AQFhsskxhIwwf9HofCc/CXNKi72LFgGEk2wLAsjePLK1YkJn8A==
X-Antivirus: Norton (VPS 250912-2, 9/12/2025), Outbound message
X-Antivirus-Status: Clean

On September 12, 2025 12:52 PM, usharerose wrote:
>On Fri, Sep 12, 2025 at 11:00=E2=80=AFPM <rsbecker@nexbridge.com> =
wrote:
>> Some customers integrate single sign-on (SSO) via the user.email
>> value. In the case of one customer I helped, the value is an SSO =
token
>> used by GitHub for their integration. The token value does not =
conform to any
>valid email address format.
>> Adding an email validation will lock them out of using git.
>
>Thanks for your reply, Randall.
>
>I've fully understood the scenario you described. My follow-up question =
is: was this
>use case something that was discovered and utilized later because =
people found
>that Git doesn't validate the email format, or was it a scenario that =
the architects
>anticipated early on in the project's history, leading to the =
deliberate decision to skip
>the validation for flexibility?
>
>In other words, is this more of a case of "exploiting a perceived =
backdoor that later
>became justified" or "a thoughtfully made design decision from the =
beginning"?
>
>Thanks again for sharing your insight.

I cannot answer decisively. The functionality was first used in this =
customer about
four years ago. I do not think any changes were required in git to =
accomplish this.
It is possible GitHub had to have an enhancement but only they can =
answer that.

