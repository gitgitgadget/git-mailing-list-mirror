Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192AC21A43B
	for <git@vger.kernel.org>; Wed, 28 May 2025 19:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748458857; cv=none; b=mzBpEeAU0efErXrk+0PZpV15D3PofEEmrFa4KAPwjZNltW8X1FohE9LZOqLmzj74q1dgG7mWPc4Az+gBb2Jq7Py4ZFyAZJIYMJ7KXeS6KHqUc48jwtKj9islQs+GDMBvshHWCgtW4zUV1wvVN59Jl/PHNIzan5DM8tQkgTugwxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748458857; c=relaxed/simple;
	bh=Wj0ahl4fdZezgdKow+JiGL4wP+YhG1tLU+Dfk8daYBo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XTmSm9crKd1YV/2fz2b/Ub+FHIRkxkP0dNQaCUZEEHsNn1/+zBKdM3TpycZtqLEtQpE2zTHpo/nffirwIQ/HzQlqdquAN6fGPTZ+pCv6dBbG+M7/hr94aKPIRcQnc5WHmZob84uDz8nwcCwlqDuvcYc3jhUBiQqTxc+aNHtoEH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 54SIxNR92830278
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Wed, 28 May 2025 18:59:23 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: <git@vger.kernel.org>
Subject: Build Failure: Git 2.50.0-rc0 on NonStop
Date: Wed, 28 May 2025 14:59:18 -0400
Organization: Nexbridge Inc.
Message-ID: <046901dbd002$a0c245c0$e246d140$@nexbridge.com>
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
Thread-Index: AdvQAoULxYhkbUkVSvSB2+Xt14k/uA==
Content-Language: en-ca
X-Antivirus: Norton (VPS 250528-6, 5/28/2025), Outbound message
X-Antivirus-Status: Clean

I encountered the following failure of rc0:

static void file_release_data(void *b REFTABLE_UNUSED, struct
reftable_block_data *dest REFTABLE_UNUSED)
                                        ^
"/home/jenkinsbuild/.jenkins/workspace/Git_Pipeline/reftable/blocksource.c",
line 105: error(112):  expected a ")"


I am not at all sure why this is failing at this point. Compiler is c99.


--
Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)
NonStop(211288444200000000)
-- In real life, I talk too much.



