Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF16FF4ED
	for <git@vger.kernel.org>; Thu, 15 May 2025 10:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747304183; cv=none; b=jsK4peQD926OlxrZKfDtr03wuruQaLRYqkh+d6RbpoWb5+AmXe5nLjff4dagXuF6FKQtNEWB34GsUGmNJirOqD7zcAcEgMQdYFQmmpXwVWafJNkESZ9iO+9Zgc1N/QJSZr3YhCe9ojyRja+iA6Matlcj6Tha2wbmyDPPFQRsveU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747304183; c=relaxed/simple;
	bh=VNLkfN3IMHrtRm4p1Gj8a97bMlYqsb6b6Pr2X9BTGsk=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:References:
	 In-Reply-To:Content-Type; b=BZGs0Y+DvLHy0c1BeY3JR3L9aFzvqjp8LNurulSvWr+RTqUmHMQkQt+7+R7j9LRrhjAq9q/4xSsHE9PUHbrZYGjzgRxJvmnF7l3m43TWSUelRvKc1VI1PPMUWf8HV94NddolFG8ugdw5hZL2YKaqWl9zLjMBooZbh7cwP7ErJpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fG8LuJFS; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fG8LuJFS"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a0ebf39427so633206f8f.3
        for <git@vger.kernel.org>; Thu, 15 May 2025 03:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747304180; x=1747908980; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:user-agent:mime-version:date:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PjKL7ZwQBB+IdnuhVoqUk2E+ZvUv4K7gDn2j48zbia8=;
        b=fG8LuJFSYPIjt2Q32wgJmdqRPUnG3klRybBkn2sYKmEHGOkZ/Di3bonG9arEaiyole
         GuaEYKwSaIgfe1an8hL5fhdP7qwIJfasascnYHQ5neSd5dFZazDEcWq9KKd37kHLzjUq
         Q2dJDR3b2tsAGd8i1gY5LkGlk8e6sOiX2eEFA5jw3auiVJAOvgBdR9N4h0gpQ1Lhm9/6
         u6+gHqdQE+OCpNLRJZsxgLPiL6srRpRo2BNvecPihJKTKRtoP37aGqbp2LnPeS1Rwpgx
         dURmtO7TGJqmMJxvTuxfoE4tSM8swivP1Im0tL3lcDbbXJ2HbpX8PrpktNFdJfUunE46
         2fTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747304180; x=1747908980;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PjKL7ZwQBB+IdnuhVoqUk2E+ZvUv4K7gDn2j48zbia8=;
        b=b5BuoqPYXp1BDKbG8p96C/iCyPa/tIbvGejF07CFG8PM+r3YHTtOdxVkNR6tZEuyKu
         FduUuiykc4QU4LNRgiLhc11bFsQaq4tLPzXgMxu3Pcq+tRfsJ3fQ834YRCpGqJW8wvCa
         pbw8khXyFgwbY8nBn244D3UcuLyvrY1H1f3Iuy82UYj0I2dORKKGQB7i9ztzCuXTzc3M
         zYvjKRtgO78XGGyb+/SoYQBe91o/lmcsEwGmMhWTnHvn6y6sqy6yVdRHeOV+ZHHidAKV
         gZx0BFm9HaW5pry90GMwo/W+mGRREiRndQKH9k8/bEvn04tkOlTCY3qJ8dqtfq3a2scv
         xK3Q==
X-Gm-Message-State: AOJu0YwxnfVwJBByybva0gsChA9fgSjAph41s15JGd+nav+unsLUzlvj
	FVEl1CWeQ1vvKn2iXlH0X5DLmtrp3y1u85woZqYrPLw/0ETPOjkko+H2mA==
X-Gm-Gg: ASbGnctyKVdq9EDsq3n+9B9tGRuE/eCAdUufysGW9ZWPJbF8ZjuYNu6mGop4phMDmXL
	amCEhgnThZspme9LqAnjO0VWt4ImrN6iIOU/96GyG4vzB/60uQMmP+Lume0vy1K87I9yaVJixkJ
	W/4mAcgzgy9QmU01c7NMM7C19itsFlOqyoL8AFeV6X/E9fprOmLFn0dTT97K6X7EQFePBN3gI/D
	zi3PAwX8+5xvhakJ7dTZgWiCcafd7+9GkP4INt6BnhvkRtRt7OijCe60QzaQMZLqdjV4qK0hySk
	hudNuRv++qLUZsAC5k4xG7nLwAL+cEo1HqPd4mFJgRL9OYKazp9/T1vVy/22xz5xbgrwgvpbI69
	hDTmBKdo6HeUYfmw1EBbYbIBCFrw=
X-Google-Smtp-Source: AGHT+IGAv9NK6qvIbMZHgNbzQHJ2hCkb+//iiV7ByeCjXE+C5qtAp8kQnVvF9a5tdyheUOkASXstvg==
X-Received: by 2002:a5d:64c6:0:b0:3a0:83a2:1e79 with SMTP id ffacd0b85a97d-3a349694eaamr6489224f8f.11.1747304180116;
        Thu, 15 May 2025 03:16:20 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:efb:6e00:24f3:2d85? ([2a0a:ef40:700:a501:efb:6e00:24f3:2d85])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58f396asm22678468f8f.59.2025.05.15.03.16.19
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 03:16:19 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phil@crinan.ddns.net>
Message-ID: <40c32d33-b170-4319-ba1b-b93dcb2b23cf@crinan.ddns.net>
Date: Thu, 15 May 2025 11:16:19 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sequencer: make it clearer that commit descriptions are
 just comments
To: git@vger.kernel.org
References: <pull.1923.git.1747275627422.gitgitgadget@gmail.com>
 <5voz3jolpff7wbs5yg7jvz5dt7omcikhna7j7646veagr63quv@kkxhzxxf4uf2>
Content-Language: en-US
In-Reply-To: <5voz3jolpff7wbs5yg7jvz5dt7omcikhna7j7646veagr63quv@kkxhzxxf4uf2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Reto

On 15/05/2025 05:42, Reto wrote:
> On Thu, May 15, 2025 at 02:20:27AM +0000, Elijah Newren via GitGitGadget wrote:
> 
>> It may be difficult to correct users' poor commit messages, but we can
>> at least try to make it clearer that the commit summaries are not
>> directives of some sort by inserting a comment character.  Hopefully
>> that leads to them looking a little further and noticing the hints at
>> the bottom to use 'reword' or 'edit' directives.
> 
> For fancy things/editors that recognize comments, this will *dim* the commit
> messages, to light grey or such.
> This is decidedly not what I'd like to happen at least. The commit messages
> there are my primary way of navigating the commit, given that I'm not learning
> the commit shas by hard ;)

As the commit message makes clear we already insert a '#' between the 
parents and subject line of a merge command. We also append '# empty' to 
empty commits. If there are editors that erroneously treat a '#' 
anywhere in the line as a comment they're already dimming things they 
shouldn't. A line in the todo list is only a comment if it starts with 
core.commentString which defaults to '#'. Editors that unconditionally 
treat '#' as the start of a comment are buggy.

> While I appreciate the motivation, I don't think the comment string is a
> good approach here.

As the commit message points out strictly speaking we're not using the 
comment string we using a fixed single character.

Best Wishes

Phillip

