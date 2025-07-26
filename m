Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42542E371D
	for <git@vger.kernel.org>; Sat, 26 Jul 2025 07:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753513256; cv=none; b=P+TLIb351sX6M98EJ2y2k4QdMd9u/gcVp+F7x8HE9dMLgZknNKYIFMWxJTp2hGPYKpS9AmhM621hKQA+/d43g6x+hR/60AGqNZCUkEEmT3zNEwivSafqtTyu94vppPdFW0xB6W/uM5ZsFkFhQcAlvicS+U2bf7yQ7OtOXvMoue8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753513256; c=relaxed/simple;
	bh=fcgAh2acypgeKO7thUA4y/VTD3KIgY/HxP8qv3FXGzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ejGbbCitSh9F6utX2Q2m0wbC6yxFt9S4pyhauDws01V41YXYqNj+c0bEBms648GwzXOTWXHTOP+B9AC2cNX7l3ARRZKYwzwCgppMEPfii3mrUA02+Sevo18vSJGX+TvhWx0RwXrITJLLpxGN641GtmlwRtbMa61lwydyvc5EiAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp3.bon.at (unknown [192.168.181.108])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4bpwcZ3SH1z7QVGM
	for <git@vger.kernel.org>; Sat, 26 Jul 2025 09:00:46 +0200 (CEST)
Received: from [192.168.1.102] (089144220187.atnat0029.highway.webapn.at [89.144.220.187])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4bpwcN08SxzRnmF;
	Sat, 26 Jul 2025 09:00:35 +0200 (CEST)
Message-ID: <553bd772-a92c-4782-a7aa-3092b3aa0494@kdbg.org>
Date: Sat, 26 Jul 2025 09:00:35 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Show skipped commit message after rebase conflict?
To: Cameron Steffen <cam.steffen94@gmail.com>
Cc: phillip.wood@dunelm.org.uk, git@vger.kernel.org,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Kristoffer Haugsbakk <code@khaugsbakk.name>,
 Junio C Hamano <gitster@pobox.com>
References: <CAAVFnNkdgXuUk6ziu5FkB=sAHzEOyiynQpQJFox_p_ZL9VGRfg@mail.gmail.com>
 <xmqqwm7xxn4a.fsf@gitster.g> <184ec60f-9431-43c1-bce3-405bb6b7f959@gmail.com>
 <CAAVFnN=q5nCD3K1jppVcq7qB9P5WX0M070jqR_rey2hzBt0ERA@mail.gmail.com>
 <xmqq5xfg5o5j.fsf@gitster.g>
 <CAAVFnN=S-bu1FNafyyH797AeBxUu+8vk5yJ5xaxCUBkBZin_6w@mail.gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <CAAVFnN=S-bu1FNafyyH797AeBxUu+8vk5yJ5xaxCUBkBZin_6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 25.07.25 um 17:20 schrieb Cameron Steffen:
>> But only if we can positively tell the reason why there is no change
>> relative to the parent commit _is_ because the commit we are
>> currently picking has already been applied, that is.
> 
> I thought we merely would need to see that there are no staged changes
> to be committed, and there is a currently-picking commit that will now
> be skipped? I don't need to know whether the commit was already
> applied. I just want to know that the commit in the rebase plan is not
> being committed.

How would rebase know what I did while I had control? I could have fixed
the conflicts and committed manually. I could have reset to a different
commit. I could have split the change into two commits. I could have
removed the changes. I could have made additional changes. Possibilities
are unlimited. Saying something like "commit 123abc is now empty" or "is
skipped" would be incorrect most of the time in my workflow.

-- Hannes

