Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02A119DF40
	for <git@vger.kernel.org>; Sun,  1 Jun 2025 09:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748770625; cv=none; b=f/exJOaoYgjOHLnIfUbcRiIHHI96wUDGwXGX/yNKYhHHTunQrhClaWAmdkSY4WYkwBHZwKnq+MM/tORQlFe1I8FWgrnQfhWzF2I/oRXrAYOc62v/G54cPxBu4mtG5XOMxJ1sHVlWSs5R3Yfh2ZKDdBwuZiokkF61hS7AZkCbTOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748770625; c=relaxed/simple;
	bh=XVfM9F5ox5C8vWOK9daLUCt6RYnXN9KLiZl2O/i8ing=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=OeEnf8/OVUcuAUzs1bSMuD78LrusxkPDrp+HImLEg7wuiUYP3cOGPyZAGYNboQP5uWIX/Cv82j5xIe1FZCtC6+Mq/x5NAZW1HurRAAeQ3lSBt5W7nXGLweavN/LU/WiJYFSZepSOCNFo4BwYEynyOzYYVXA+3jojNmHYq1VnzJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (ec2-3-99-153-20.ca-central-1.compute.amazonaws.com [3.99.153.20])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 5519apAd3792287
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 1 Jun 2025 09:36:52 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Patrick Steinhardt'" <ps@pks.im>
Cc: <git@vger.kernel.org>
References: <046901dbd002$a0c245c0$e246d140$@nexbridge.com> <055d01dbd15b$14d4c880$3e7e5980$@nexbridge.com> <aDnAGra6dsfubSHF@pks.im>
In-Reply-To: <aDnAGra6dsfubSHF@pks.im>
Subject: RE: [Bug] Build Failure: Git 2.50.0-rc0 on NonStop
Date: Sun, 1 Jun 2025 05:36:45 -0400
Organization: Nexbridge Inc.
Message-ID: <061401dbd2d8$b4ba03a0$1e2e0ae0$@nexbridge.com>
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
Thread-Index: AQIZ8GewMoKKTrWsVoibs7DyG3Q0ngIDXrENAkbgYxezT35c0A==
Content-Language: en-ca
X-Antivirus: Norton (VPS 250601-0, 5/31/2025), Outbound message
X-Antivirus-Status: Clean

On May 30, 2025 10:27 AM, Patrick Steinhardt wrote:
>On Fri, May 30, 2025 at 08:04:47AM -0400, rsbecker@nexbridge.com wrote:
>> On May 28, 2025 2:59 PM, I wrote:
>> >To: git@vger.kernel.org
>> >I encountered the following failure of rc0:
>> >
>> >static void file_release_data(void *b REFTABLE_UNUSED, struct
>> >reftable_block_data *dest REFTABLE_UNUSED)
>> >                                        ^
>>
>"/home/jenkinsbuild/.jenkins/workspace/Git_Pipeline/reftable/blocksource.c"
>> ,
>> >line 105: error(112):  expected a ")"
>> >
>> >
>> >I am not at all sure why this is failing at this point. Compiler is c99.
>>
>> Looking for help on resolving this before rc1.
>
>Did you maybe miss the proposed patch at [1]? That should fix your issue.

Thanks Patrick. As a packager, I can only build using merged fixes for
2.25.0-rc*. I'm hoping this
makes rc1

