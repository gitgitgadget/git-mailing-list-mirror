Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A2230AAA9
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 08:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767687317; cv=none; b=bCOOSzWDRK/H2VYiR9+RkThBJt4dPnsWbrZGPIxUHbYJdqbKvI6MH9Cd6itVLnC3BrjLXpaX3kumVsqR4TVQ89wnXvvsq6srgydlqDc2YtAhKFg0Zo+e8YaE/R6aBYOjxr5Ax9TDqFRZr06pIE0JqZ5rwUQkMiNJCkQ3d8RKHKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767687317; c=relaxed/simple;
	bh=/GzhCd+ZtpZGpEJ50tHLfJkp/3I2bUde4fLUD0DuDrk=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=GeEPiI5g/Gm44UTrkP8Xc5KOp0yjtwsanyuRFKs2KL9D1UBmGwMxqKkYR7OE3TFlxeaKBmlZ18/PXeZVPrKUsdc9SUPYEhgXqMeebY2WjbFI9EtyG9x8Map4YNkQMsEkzPrj6cRxZIHIh2JNmswure8BcksowqXkKgkqZjDSjvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp1.bon.at (unknown [192.168.181.104])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4dlkVm5Y68z7QRHw
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 09:15:12 +0100 (CET)
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4dlkVc12sczRpKY
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 09:15:03 +0100 (CET)
Message-ID: <f1cd3ca7-9b31-45b0-b990-05f4d1f6b4f2@kdbg.org>
Date: Tue, 6 Jan 2026 09:15:03 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
To: Git Mailing List <git@vger.kernel.org>
Subject: How is git diff --relative supposed to work?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Try this in your favorite repository:

$ echo foo >> Makefile
$ git -P diff --name-only --relative=Ma
kefile

This doesn't look right. Shouldn't the path specified with --relative be
interpreted as a directory instead of an arbitrary textual prefix?

-- Hannes

