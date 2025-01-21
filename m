Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E5A1B3921
	for <git@vger.kernel.org>; Tue, 21 Jan 2025 07:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737445934; cv=none; b=HInRA0UkB7pvtvWKjYa0OjxiEuLQk8d7ifWFKjUALx4kdQJuC/J1jXvozWJ4c1Ykj3bwEP7kODmBV//6bwm5T2TfQkRaTxLghNUXCUKo58wD08QvqaJgYMqlESIyRi1k+5WB3l15Lhda1V/issvR+c5KxvuwYUjL4Ex+tWU+aTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737445934; c=relaxed/simple;
	bh=6Mcj3gv7tiYdSVyeD9vWMvO/p+fL2JL3StYW/tGa2MI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Z+4QlxsoIi/uMUU5UPeUpi3++TASfPthDkhsYeZ3sYlrBOMUZCyFHv8GPHiKHf8xwISOpE++L7O6AcuA/WO1eKnTL4fnBSBMaydBgg6+NcU9zV6F2cdo1BESCaKdgiR89wG9VLvCbHp2b5B544EBflnd5JnoAMENsTaNGTF06U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLeM5oWw; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLeM5oWw"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2f4409fc8fdso8002085a91.1
        for <git@vger.kernel.org>; Mon, 20 Jan 2025 23:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737445932; x=1738050732; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QolBN+jgfUxNqhdNID7NF3HIsDr9aUN+nzwnAD4LgkY=;
        b=eLeM5oWwLKpXL1V4It3yKzz08ZaaUTvQH/zEFjJPYOEYkFSwrojuJJWwiuqpL09Zab
         t/tt09cvdRWwJp8SMz5+RTcPj7MSTylVH3RCPilpRlYc/hvCYur+r+rQ4/6lhZcIU881
         /bOysVZz0QNhsyHICgKtoTsFsr+tXZSA1Ud7bYAEZ3256ZQIKbXlQcJMy0lFvMUbbsM0
         sDc10Hm6tI9zpdMbkbYFwj/KqCiEaEpnLPMEgKL7O3IZ2VpZUyWwIrlRX9I7GbGaFogm
         wzK3KHT0YtNPv62K8vl5wxkU4ZFjsGrl0a7x8fjXLlvp3BDpLXmxQygM5YmfHJ+KVOnq
         ioMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737445932; x=1738050732;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QolBN+jgfUxNqhdNID7NF3HIsDr9aUN+nzwnAD4LgkY=;
        b=G7lk2cWKAPs1nPLjXqL/EbcCfw6f8hJREHKdzUTaR1xHAXbRJKRRTDL/aguzu3whkZ
         eKnBT+vKaaNHCunKbMKd3WlFl4DDAZOVvrjs+4brPp3WnhfXgBqoo9rU41p+amQSc58v
         9umvJWIRIlm5TSE8YuVaIwxHYkvPycOb9+qVEXBf3NR2548sWfhizbVW3c3mA4bVtQrz
         I3vM5hTWGIKHPSb/L22UaF/c3Qa8VSok2PqnFjRoCqTn588jVezk7F6ShG2ZHpW+u81P
         JoUcmCGgdaSaZ+XTmF6abgHOffc4neWCtQXC8BuOfvUcrzvrotG8M8Kuztebon86c8Vc
         fR0g==
X-Gm-Message-State: AOJu0YxELSAtqXaRY5CIlZxDM0iMM+wWZhjX2pZostj2uleIuwVw/Ba1
	dPiRIoCmI0svAZhkP3WK1Gqd0+mdpbrXb8IJhFmwB+pRWRElgDvV7yjQCZ/f
X-Gm-Gg: ASbGnctOiwfnyYCRuJIMYYZ3mN+zVfZkJsRRVN+2XddL1usWsyyNG8ge1eXjgNr+CYS
	zemqYMM+LwBrLoawzZsclqFwKuYSIhOluCpulv3nHWEciPXhQORPP2SaeZSY6IJRbadCmsgMiDY
	pMdb5yFJzG9Z1bRCIi52RYqPwAgMZD5OJeZON33Dx/ubOonPou8XzuGwHoivlf0Exv0MEY0O1kI
	N9hNzgOFOEaFS5iVXv66eZRzcIWRtSpvYAOOTUvQepiTS5yzd1vtyPV09jaCh6NL1a5QibESqQ/
	nrTMIWs15PvqetKiq8WmDjk5koUGc2opmuiQLu2rSGqpbFKP/g==
X-Google-Smtp-Source: AGHT+IHv/8BV3JdqInK5FNPjXfmeMQBc1BnwWN6SHREZuOeoRL6FUr6TokplibPcLdSTTlxpKfoicg==
X-Received: by 2002:a17:90a:e7c3:b0:2f4:4431:51d4 with SMTP id 98e67ed59e1d1-2f728dc0ae0mr36284092a91.6.1737445932139;
        Mon, 20 Jan 2025 23:52:12 -0800 (PST)
Received: from ?IPV6:2402:800:61c7:46e3:ca2:9bb0:6bf1:5979? ([2402:800:61c7:46e3:ca2:9bb0:6bf1:5979])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a9bdd30d1fdsm8277457a12.60.2025.01.20.23.52.11
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 23:52:11 -0800 (PST)
Message-ID: <7e5e2f26-deda-41a3-af46-79c42435b3c7@gmail.com>
Date: Tue, 21 Jan 2025 14:52:09 +0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: =?UTF-8?Q?L=C3=AA_Duy_Quang?= <leduyquang753@gmail.com>
Subject: `git add` with unmatching case silently fails on case-insensitive
 file systems
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Good morning,

I am using Git on Windows, whose file system is case-insensitive. If the 
working tree has a file called `SourceFile.c`, for example, and I run 
`git add sourcefile.c`, I would expect either (a) Git stages 
`SourceFile.c` or (b) Git errors with "fatal: pathspec 'sourcefile.c' 
did not match any files". However, none of those actually took place; 
instead Git did not stage the file and produced no output as if the 
command had succeeded, which led me to proceed to committing without 
realizing I had missed the file.

I would like to know whether this is intended behavior or I have bumped 
into a case-sensitivity bug.

Regards,
Quang
