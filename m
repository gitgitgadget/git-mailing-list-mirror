Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DEF153800
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 20:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731703889; cv=none; b=jLqRvIpqP4l4d62SURfw48MQuhSc/u1+ZEq66KOEYzK878gPAY5TQERU4j5bdvC8tB1hu1mXE90k0JfPCs659E1/pcS2z7ahR0UBpbU1i4d2zgH7zZKZIFLgArvdDo29DC8qLJbAtRHY1tKXwd4HXlPYKiFJ9YKH6y3iEdbmBgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731703889; c=relaxed/simple;
	bh=HksJ9UbU0x1cALj2X0+FZjqpCGh8LhRW8a81Do+J0U4=;
	h=To:Cc:From:Subject:Message-ID:Date:MIME-Version:Content-Type; b=d4ST576y1NrTIoyS+nBnH/ISKXa7EEF/S9RmskOqAdv5pUJYtGN1cZ5XjSrbvh6DtSTzU6degiHujyihtYGsRXXJf6l7eH5dh2rR78FWVdFG/8qoGnTAFH3vEJkprJ1ckyBcGroAmrpnVZTdYGOy9eRlmVhiyPvb5wd3qZ/3Kno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGWWe2f3; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGWWe2f3"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-46097806aaeso253641cf.2
        for <git@vger.kernel.org>; Fri, 15 Nov 2024 12:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731703887; x=1732308687; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:cc:to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JmfGWs5DHzZyZfR/EcoXIvVlssVCTMEdVerIalst2+w=;
        b=bGWWe2f38AUfg1K1XiNKkaJLVFubEdt6CQW5chvTtXAoHZoJEvFuIc+f5tj35kDZxC
         6lg1tICjsmGSSFFVeOmBrkpY2c6ZmWOdXkJmMO5xwhaB03gRtn/JCUoLnc6bp+p2pJN2
         rmXrjSUVVvUSnsWKjIEnnYDNOnVMurW7Bh9ayISpg4I1RjLjT1BQJ6vrQmaOPnk1xo4m
         aSQZ3i1deKola/QzIlKcK/U536+CItMXPfUn5jwUKVqCjdhdMUQj2Ixsfoy6Gi5YT0mR
         GLLIdc2jq0UO4DV+pkbdwDWH5BXmYvcR7yKiIeM5A5Ni3/Fq+xdoigFbkD9SrIw2KMkP
         GakQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731703887; x=1732308687;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:cc:to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JmfGWs5DHzZyZfR/EcoXIvVlssVCTMEdVerIalst2+w=;
        b=Uhy2NH59noJR4UeLbrXGk2j/7BArhJ/7ZLZVpFCxvYipJGVhlmn6O807pHNzgo7gj7
         TnsFPCBpfSc4qZY+MJ6d3qMzjbPUTVZUXa2ljOFi4TQkDrQuioTdTwATyw3kEkxHJdAv
         IbA0eyMskzqt7/0HMB+nDzQ5sU8tEsjTjGZSTiZ++Xsrax1dVQ2XxeHjYFSW5JhvNgJe
         faBpylUS9EH1cocDMWhu6oPzNXCHhHTNzk8FlOl6RlNdPBqwEgXYCjcXZVrAmgPt6aiA
         cpKirAIZgoXEHtiY0ugO9X1x1KKVuL+8hsUaQ9aQe/CdicTDcDY74Ydvpz+s/rqLUd6/
         njXw==
X-Gm-Message-State: AOJu0Ywtn9Cq5N3BSwpV3fCox34hdLjR6Fd53ZigaTqxMDOXTLqtQPhi
	XC8AFRLJot23POQeTQOokGllTZhE0LUf0hMk5mVUGD8EbJqVmaII
X-Google-Smtp-Source: AGHT+IFJikxu7cTGrcBEp0AnQp95lnunOfPRhrJGcOamv48iXT1mtNVP5WIfgN6tcDcs44z9uWicpw==
X-Received: by 2002:ac8:5a4c:0:b0:460:4027:601 with SMTP id d75a77b69052e-46363de9012mr46101071cf.6.1731703886862;
        Fri, 15 Nov 2024 12:51:26 -0800 (PST)
Received: from ?IPv6:2606:6d00:17:6fc4:d174:d15b:fe88:8d9d? ([2606:6d00:17:6fc4:d174:d15b:fe88:8d9d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4635ab855casm23643561cf.89.2024.11.15.12.51.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 12:51:26 -0800 (PST)
To: Git mailing list <git@vger.kernel.org>
Cc: Derrick Stolee <stolee@gmail.com>, Jonathan Tan
 <jonathantanmy@google.com>, Christian Couder <christian.couder@gmail.com>,
 Jeff King <peff@peff.net>, Jeff Hostetler <jeffhost@microsoft.com>
From: Philippe Blain <levraiphilippeblain@gmail.com>
Subject: [BUG?] git rev-list --all --objects triggers fetches in partial clone
Message-ID: <6b41b122-0657-00b2-d613-296354376026@gmail.com>
Date: Fri, 15 Nov 2024 15:51:24 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit

Hi, 

I'm not sure if this is a bug, but I think this is not working 
as the documentation states (or, I do not understand the documentation!):


git clone --filter=blob:limit=250k git@github.com:git/git.git
cd git 
git rev-list --objects --all | \
  git cat-file --batch-check=’%(objecttype) %(objectname) %(objectsize) %(rest)’ | \
  sed -n ‘s/^blob //p’ | \
  sort --numeric-sort --reverse --key=2

The doc states that the default value for the --missing of 'git rev-list' is 'error',
which "requests that rev-list stop with an error if a missing object is encountered."
This is not what happens as each missing object is fetched one at a time.

If I use any other option for --missing (allow-any, allow-promisor, print) then
no blobs are fetched. 

Is this working as intended ?  CC-ing a few people who I think
worked on the partial clone feature.

Cheers,
Philippe.
