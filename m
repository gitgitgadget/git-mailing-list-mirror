Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8E264AA4
	for <git@vger.kernel.org>; Tue, 19 May 2026 21:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779225370; cv=none; b=ifC0kwKzVKYBMQT44T0KhhRaqk8+U3fbxWs3TLdfO8rP2Oe5iexZjlECYg8o7DBbEz0ISUV5WkLhh/EltzfVFldjg/d97KXyQL5EofLTZZ/xLdzmHCP3zkUhxIaLz0QcPvSU3IgCc8OODRw/9t9HNPoCfbcGskjyOc5W/KzoYgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779225370; c=relaxed/simple;
	bh=vddB0y9Aqar4mEBMuvsWFak/tar3QAh4l1nghU7B6O8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ir55CwIR8ETkwfslbqqWpB0etI+CHgcNwvRSPSxsbf6xnkGhrmn46ZHagQhakFSEzk2iQVEn3erpYP68yqLqS6xoVZRm5PWBTycHgQv4rglHQvnDqqMTTNtg99qdZHNMXBSVMg9DYT8uLLMypWu4WvG9vqMrAfcHQezanT9G9wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4gKnXF2c3lzRnm2;
	Tue, 19 May 2026 23:15:57 +0200 (CEST)
Message-ID: <246039f4-8f61-4f7c-bd8a-50b7f519e7ae@kdbg.org>
Date: Tue, 19 May 2026 23:15:57 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 11/11] git-gui: add gui and pick as explicit
 subcommands
Content-Language: en-US
To: Mark Levedahl <mlevedahl@gmail.com>
Cc: egg_mushroomcow@foxmail.com, bootaina702@gmail.com, git@vger.kernel.org
References: <50df7f28-c63c-4762-b542-b888ea3604c0@gmail.com>
 <20260514143322.865587-1-mlevedahl@gmail.com>
 <20260514143322.865587-12-mlevedahl@gmail.com>
 <e336544b-941d-43ed-890f-2b8950dbaf88@kdbg.org>
 <fad43240-1089-4447-b97d-ee553c34eef1@gmail.com>
 <3b16fbc6-074b-410d-861e-6f77794b02a0@kdbg.org>
 <ffbbd733-2af9-4ff5-9354-cb2f333927a8@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <ffbbd733-2af9-4ff5-9354-cb2f333927a8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 19.05.26 um 20:45 schrieb Mark Levedahl:
> What I have now is
> 
> if (enabled gitdir discovery) {
>     discover gitdir
>     maybe an error occurs and gitdir remains {}
> }
> 
> if (enabled pick && gitdir eq {}) {
>     unset GIT_DIR .. (just to be friendly, could throw an error instead...)
>     pick
>     discover gitdir to VALIDATE pick gave us a good thing
> }
> 
> if no gitdir {
>     error No Repository
> }
> 
> then on to worktree discovery (which also validates what pick returns as pick may not have
> done so).

Sounds good.

-- Hannes

