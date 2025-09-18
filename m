Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79452E3B03
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 06:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758178627; cv=none; b=TP/C+B0Azhn+KxdleqQitbp46r1s58zqJouIpAUnJ36lkGEVVP1zCjmN9lV/UKTBKPBCYhRwJ5Ne27fGoraglwNA8NejtzugHIPaB/WBqwzlTbmIXSmII8qE03Wzz+V6xvw6c0GMmUYAXYh0Y6N3WFtv29aUAQ85+OaexBVbpG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758178627; c=relaxed/simple;
	bh=jS/jaaOaBweWfyXz3vTekt/wjeIHM0Omn194kff5zVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=rA3yKs74/nMTbIWgju9RLuEFGcg2w8OJ7ND3P1mldXqS9qIgak0IyizbUW3c/CfXjDhFW6ClggKb0zUV1DCShTpJiY0t9V1hrN+hrA4Mg52aehQhxlAJrpZzp9txx0nh5EIEdyO7PXmarkhrw2zKEuVxGomw3iutf1y1jebC5vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.104] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4cS5zC4BPJzRnmT;
	Thu, 18 Sep 2025 08:56:55 +0200 (CEST)
Message-ID: <42250bbc-95f1-4f15-825e-66fbafb0b061@kdbg.org>
Date: Thu, 18 Sep 2025 08:56:55 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: Why does git-status suggest different commands to unstage
 files depending on whether there is a commit yet or not?
To: =?UTF-8?Q?Anselm_Sch=C3=BCler?= <mail@anselmschueler.com>
References: <8e1905c7-7744-444f-9a39-ca809edb6896@anselmschueler.com>
 <c28bff47-04ef-4568-8dc3-add99f52209a@anselmschueler.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
In-Reply-To: <c28bff47-04ef-4568-8dc3-add99f52209a@anselmschueler.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 16.09.25 um 23:51 schrieb Anselm Schüler:
> [...] I
> would’ve assumed git-rm simply removes the file and “writes” that
> removal to the staged changes. This seems to be what y’all are
> describing. But with that suggestion, I was confused, because I assumed
> git-rm there would be equivalent in some sense to git-restore in a
> repository with commits.

You seem to think that `git rm` removes a *change*. This leads me to
believe that you think of commits as a set of *changes*. But this is the
wrong mental model. A commit is a complete state of the project, and the
index ("stage") is the complete project state that is going into the
next commit. `git rm` removes a file, not a change.

-- Hannes

