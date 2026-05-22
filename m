Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EA082866
	for <git@vger.kernel.org>; Fri, 22 May 2026 23:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779490836; cv=none; b=FghAN5T5xBq9repHYKoyWya8y/S5/u9XnaSgSYktgdycocYQR1glWqF3aGhrP85gJsRQBGue7ZVyTWKv7jPalgzlxi6U3DcMQ8QhiIZBlE1wVO5ASOYRt8WQwVog8xZanK96YrEwbJMlgjSxdvybciqFotl3js8eE1L2lL5iOd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779490836; c=relaxed/simple;
	bh=DF34Xkmqibb71l2ispqx1QHUIyvlue4jNAF/+j2iX/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WtRyjnljSM8xMbOUdJ5v/Wn4mpOg72ENBZSr7khZGKYS7j0G/YYroQneisfNzzD0raXiB0hj5xkibBfuA5gl8bQSIKA+1PPJzIWrKeZCordJyXcMuXJLX+1aboubKX1rWZLDBwl+KGTs38+ze9UqLd9xiBKkH1qW5RZywsz0aVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xf9LV69F; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xf9LV69F"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-516d65a15f6so15590311cf.1
        for <git@vger.kernel.org>; Fri, 22 May 2026 16:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779490830; x=1780095630; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i2d2NBIoS2NdHXaVMNCMN8IGlVrKPGXmAmLWzCbHbHw=;
        b=Xf9LV69FqIRThwegnkxkejBDaKv5FJ8lTe2oVPZyDlPzUSbctIZVJDPy+oulLZynkK
         0qJXF5eMIaOQr5OdSlX4AhwmHy5uFt31Z7PNtSUcf1Ft3Ui5bnfRI/XR2FQn0hCdUTUG
         PpBmKy5o0RdEqFhwYgPwL2fgjfUHpwlvtfXFw4us4mck7RnTflBeoSZJVVLLtwQXf7Uc
         fQGxFktcJJmzhCbr6lHgeEd9iXsemQDdfPPNdil5Uxv90nBZ1iOLiDImt0kf1ANRTE/l
         il62VFP9tT0/Qnw5PE9mvF+QzG7wmat/fW90sUjFpE0dqn+P9I4m4ltmk2dXjnPDaDTk
         GWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779490830; x=1780095630;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i2d2NBIoS2NdHXaVMNCMN8IGlVrKPGXmAmLWzCbHbHw=;
        b=docgX/hax8XIkjvV6KXSjmYPMPt2K2I4TW/lJVNdECHvbSijf6vPNfJ4NCUgpHf8TP
         RiKJeMSje2q5PW3mLtbkYziX4ZuOigbPBUXFIzbLtzNJNhkNvrOL8cqS+HCf2jEETkg9
         GluXmHi6Kiiooq5ju+cNhFaeh1up8u51B6YpbLOpiehbnFmRPkiyhqiD7LoB0fH78g9M
         ug6iI/FNV/Dih0TTqEeqafym8mGW+Mkjth2iGWaTAGVBu4vaFtL1LbEUx1iSJtwbsfMD
         Ww0VF6EGfrSnCC34xdMeEhOWzMN1VhuSXHZd9a4j+zBk3nkXGWqEjaOmXdW4fxbBvIgi
         pRTg==
X-Forwarded-Encrypted: i=1; AFNElJ86AtkvaUeH2HAV+65PlWnRd4TnTxml/TSg4cqnE5GoSDaofe3ogCqeV+0tszJ/BYxNXZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzXf82XwqxDnrOEmkXGsx4k3vxxmdvf5POfRspXIR4AsrAIizn
	YRJiYOSkyMA/wc7cj9IInSEyHlpdal01POVj/z4Xkr6aanQK2Qa817LjrYzORVdz
X-Gm-Gg: Acq92OFupGvCjWiLCUlL3M8HSMrrGa7AoK87BxxT2oaeDi8ll8zDaocaMSGaixrrQxi
	zEdstqN2fLw0WnWho4Mx3CPqM1EqXQjvTdoIlN6xEMROAtUxHnssJEd3EfB72+6zieIRvvRGY8/
	CWmExUX39xPjFmt9G/8BRVlcKxPkMxShQSOiQcR/BtD+cWKrHQc0+gIHermf46QnY+ToXoovaHD
	OhLVtBBqucuN/No56DJm3fiOhu8JxREdPf8j00uAwxYz/TMsfRLP8iILRAI2/z1qmhUhUXFHsqs
	P13u9FFjCq57pIn3GTNsYFQiMRvG0aIfpre3KkdLUmC2kRrxHcguP+tRtqCWFCz93wfCF+CNwnJ
	rEUs6u7qRvc5PzFIcTCT+C2V92BIpWPSRr3TT/2LIm5mjJB7sGtWy5818y8Tz257Q1vNpRTtsIB
	BfQEj5eWV189DJOcOCYXjZo3MK4+H2p595dIgPVDTxhMxkPTfzvqp66WKN3mfdWK5vunf/++0=
X-Received: by 2002:a05:620a:179e:b0:8d8:697:1cf2 with SMTP id af79cd13be357-914a23e28admr1182362385a.30.1779490829507;
        Fri, 22 May 2026 16:00:29 -0700 (PDT)
Received: from ?IPV6:2600:4040:264b:4100:d17e:f99:a560:8cad? ([2600:4040:264b:4100:d17e:f99:a560:8cad])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bba1b8f4sm248664785a.45.2026.05.22.16.00.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 16:00:28 -0700 (PDT)
Message-ID: <fca71977-cc14-4b38-b310-9808b61880f5@gmail.com>
Date: Fri, 22 May 2026 19:00:27 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/11] git-gui: use rev-parse exclusively to find a
 repository
To: Johannes Sixt <j6t@kdbg.org>
Cc: egg_mushroomcow@foxmail.com, bootaina702@gmail.com, git@vger.kernel.org
References: <20260514143322.865587-1-mlevedahl@gmail.com>
 <20260520202411.108764-1-mlevedahl@gmail.com>
 <20260520202411.108764-5-mlevedahl@gmail.com>
 <8d1488ec-c4de-4ddd-b3cd-e1e8b4a343bf@kdbg.org>
Content-Language: en-US
From: Mark Levedahl <mlevedahl@gmail.com>
In-Reply-To: <8d1488ec-c4de-4ddd-b3cd-e1e8b4a343bf@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/22/26 4:46 AM, Johannes Sixt wrote:
> Am 20.05.26 um 22:24 schrieb Mark Levedahl:

> 
> Sorry, but I cannot agree with "prefix is only known after the worktree
> is found". The prefix is a property that can be known even if we haven't
> asked where the top-level of the working tree is. See more below.
> 
>> This is true even when running the repository
>> picker: that option provides a list of prior selections, and does no
>> validation on the list beyond checking that the directories exist.  For
>> now, just initialize _prefix along with other global variables.
>>

> 
> You cannot leave the _prefix empty, because it breaks `git gui browser
> master dir` when invoked from a subdirectory of the working tree.
> 
> This line must remain. I see that you add it back in later patch. There
> may be some motivation to move prefix discovery, but there is no
> motivation to remove it at this point.



Never mind, I confused myself on the process. THis patch has only affected repo discovery,
worktree discovery is later so should be left untouched here.

Mark
