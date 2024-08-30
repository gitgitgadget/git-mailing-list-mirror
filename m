Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9722D136327
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 04:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724993913; cv=none; b=HbqbP5ulCEzT055xEQ+/gY0MhADQJzxA5wRzdpybPIyDaOS3zXRR5NI5k1pM5/WTUW92HAkek3UPZtzJnakUPkgVn9ndg7IMyhmWF/XQe5gkjA/FgJLqSVj/GqcGuyOlyiJbMoMOUQt2h5E9v2O92k5U5cjiIgOEHoLF8y4q/hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724993913; c=relaxed/simple;
	bh=WYEjsxz6OV4tAE9LS2502+zfb8wdfdBelIPlS0BB7qw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=ZS1udU+XfUgnUkm6ekn4Tvk3F6CLLz0TVdbaJ0XtvKqc5/w+nvSSdfD9SJew+8Z8puIa9ybgsyU90f8ynS0GE9+OZQFSidy3qJ3YjbHHaFCGkEj7q/qWQ3+47hK/eqndkZQ5t5r121mJkWe/K8yPk0sotJJTr8xxIaute/VwjGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.1.102] (089144221034.atnat0030.highway.webapn.at [89.144.221.34])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4Ww5Wf3XTrzRnmT;
	Fri, 30 Aug 2024 06:58:20 +0200 (CEST)
Message-ID: <b282c83c-2fa2-4e8e-b8bf-d42f28c17439@kdbg.org>
Date: Fri, 30 Aug 2024 06:58:20 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Committing crimes with NTFS-3G
To: Roman Sandu <r.sandu@gaijin.team>
References: <7d1dad03-703c-47ae-a039-c15aa765fd0b@gaijin.team>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
In-Reply-To: <7d1dad03-703c-47ae-a039-c15aa765fd0b@gaijin.team>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 29.08.24 um 22:43 schrieb Roman Sandu:
> To diagnose the problem, I ran git status with GIT_TRACE_PERFORMANCE
> enabled, and what I see is that the "refresh index" region is taking up
> 99% of the time.

Of course. The stat information that Git on Linux caches in the index is
vastly different from that that Git for Windows caches. So every time
you switch OS, all files appear modified to Git.

I suggest that you don't switch OS on a whim and take the 8 seconds
delay once when you have to.

-- Hannes

