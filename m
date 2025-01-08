Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDFE19F133
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 15:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736350036; cv=none; b=bkXjJg9RcCq43TFXpjLe/6TsArstlJJschpjXfEUUMisstguFprcPq76je3NQBN/tReGgkS2pG90Y5cUUW6NYZO7UkRrmYWiCr175+xbPgisyId81ufddp0zmtrcREHZ4QJW7I2MByIdTru5MYdEvmuzzx6mQdysIMAp8WYI2/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736350036; c=relaxed/simple;
	bh=KAttN1eAtBhArQm4O3OSyWLKYZvaVLm/aIkUtdTpW3w=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=P+0cvA2JfR/Uu5LyoZc+eRtIuvR6TGV5s5sbNWRdqJxusFJBRAfI0Regl2aZd1rO0pc+u9lNqLDiAnTmT9oQTZR51cj4TBlhUR1ywcvLaXoK8F/9W4G85JqgKkrG07ulPzYXi434U5JxF9IwCC3/Dw7zs2udlNp1UnFgakDQejM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org; spf=none smtp.mailfrom=kambanaria.org; dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b=rGptvywf; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b="rGptvywf"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d3e6274015so29807572a12.0
        for <git@vger.kernel.org>; Wed, 08 Jan 2025 07:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kambanaria-org.20230601.gappssmtp.com; s=20230601; t=1736350032; x=1736954832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3aObokjKthcYS+qvP4wKFiU7Xm8qcBKHePJ9ILnMJvA=;
        b=rGptvywfkohhF8HlaTUWAaVWANyJ6YYIdCNpoaWEB5FQQPv2BN4KopXJDnFvYHV8qv
         mt0LWs0yUe7KBrfY+dK8xAIAoNcfw1SJqHDwYnd43vji+1ZRJKu1JdxnrdpxfThJLR44
         74r6j71b5yPRAhqUZhvWmWTRqQbxaGh10DHcP7/lqCdkmkJ5LJhSk1vdY3Wr86z0Py3I
         l/D8k5Y8IzuTr+geBFRJvm78zLpHePODXT7NYbVhfg90MPaLPOen2+maijTMmFUqmWAz
         D701fU9AZlwkX/ZnJJB1hoQE4Ov0kIBdba3rM2MbUaKFh7OMtN5ASst7lJH+TCHlUVhU
         I+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736350032; x=1736954832;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3aObokjKthcYS+qvP4wKFiU7Xm8qcBKHePJ9ILnMJvA=;
        b=iugEjiFoKfdkQUp8sigbfTD6IvXdL+kN2/qjPU9Gt33CXZ4IEZ6JV0PLcVWBZXP7h2
         0WaGqZaOtMdiPPzPp3TNfC0KA84GucvX4ed3pmNbUF1A7n9HVwTPXC/R/bqPOvS6jKmT
         CDvjDEovzKW8ZrgsJSjxV1/k5LZAbv6npTboX3P5bwoVqPTaE9eK+rNU1hN5hySmDAb3
         xB8FoCrUREm5F9BX34/0OJasFNrCSM99FeUO5Asoetj3ClJ1OgQakCmrd2mB4tnPbICs
         DIIHCtKRygLnkYlWYK7h7mb0nVDykZgIch3kNZ9EKOM2W4dTW9xw3M4GgUf9LsukQLYJ
         6Wig==
X-Gm-Message-State: AOJu0YxtZ8GvGnJS229xw62Oa6jcDcbDmafVny3woKFDFw49UJMqVrRU
	1WzMYu6ESG6CQPeo8aRV4c9+0mzrNvpY7MobxbDZaP2YwET232BUWPxnh2amztjooo8Uk+2eKJZ
	fQJE=
X-Gm-Gg: ASbGncsCFzKdmAVvb+qQSV36mI/QhoWCAliiSm4knnIViU8+9M0GAlm12wsHv+SLttn
	gWUbn6KT8jitl62l0yf52WpVcNbcMf++MCorDdA69SW/69N6Gk+jsQTFdtd3Ed59Yrlb4NQsu4z
	D7h8362e0BN8RSesVCOPF6FEPZrk+wYXobUNxqKy8aqPHro684nT/s7w025cVTeHuv5DtA2pbOY
	WO+gKLBjn4VzLceUbHt3ISACYQWXooN/+prFNK1ufcT3OBd+CM4JKg3P3Z8GnA9eHk6
X-Google-Smtp-Source: AGHT+IGsEcKqr9ny5MxUqsalyvwdUTkyzKH3NxL4n+FFofZ02+5FW+UVj8R+GKK7yy87vkQRM7vzFA==
X-Received: by 2002:a05:6402:270d:b0:5d2:728f:d5f8 with SMTP id 4fb4d7f45d1cf-5d972e4dcddmr2698670a12.27.1736350031811;
        Wed, 08 Jan 2025 07:27:11 -0800 (PST)
Received: from [100.64.0.1] ([147.161.132.184])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0f06ebf3sm2485594766b.196.2025.01.08.07.27.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 07:27:11 -0800 (PST)
Message-ID: <c82d19d1-9b47-4881-b199-b00a9233f7ec@kambanaria.org>
Date: Wed, 8 Jan 2025 16:27:10 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: bg
To: git@vger.kernel.org
From: Alexander Shopov <ash@kambanaria.org>
Subject: Intent to prepare the Linux FSMonitor patches for merging
Cc: gitster@pobox.com, sunshine@sunshineco.com, edecosta@mathworks.com,
 chooglen@google.com, Johannes.Schindelin@gmx.de, avarab@gmail.com,
 me@ttaylorr.com, m.ispare63@gmail.com, ps@pks.im
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

I am gathering inititial feedback on continuing the work of merging the

fsmonitor: Implement fsmonitor for Linux implementation to git


This was previously discussed here:

https://lore.kernel.org/git/pull.1352.git.git.1665326258.gitgitgadget@gmail.com/

(gitgadget) https://github.com/git/git/pull/1352


And then resurrected:

https://lore.kernel.org/git/pull.1667.git.git.1707992978.gitgitgadget@gmail.com/

(gitgadget)  https://github.com/git/git/pull/1667


I will start by trying to rebase the patches and checking if there are 
comments to previous patches that need addressing.

Still I am announcing this as things may have changed since last time. 
AFAIK I have CC-ed all participants in previous discussions.


Kind regards:

al_shopov


