Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793467367;
	b=3ppQUJotsoPb62aS0yYBtISNE/Q6D+pz4pjRhEPegTwpjMHy/+2lIv15D9Ik1FVqPstR
	 a5yHc+1Y7rS2xAuKaEeTy07XZNjnJjMp9J5WnfbNDGsSAtRHNJGZE6epIyAleqN5Q5fy3
	 7bex56gKbteZ+XBUPHt6K/Q/DPh5sP2rMO0jJUyrO6xyYVKfTzcZo7UlwWFxgSewk7Xoh
	 zHUMAGNiTfr0Zk1DwPLgN8eLqf/HcFnD3GcJx7yMeYaFGcuR6bKevknTEAA/ot/tdJimb
	 sJYS6995AumQ5mic+5lshR6oK4wgxb2fWbusTUY/buwAHxGUFfZDGsEyy450X7ix3Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793467367;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eltmB5OoKgy3bLrHLeFRh/hpvMIjtYRtwlzdwljJMkA=;
	b=FkkqCuoApObM6TFIKxNfb6F7zhr1wxUiKh5ZT7Zm0grDQD79CdUmr16xleZRsrwN7kLo
	 BaDhhXtYGkGRX3lsUSTxEca2UZ05u6XOweoH6F9CYTXvC5YTQinf3lT17bsDzL0jBimlb
	 O4DD592N8jekhFFL3Wkav9tp/e81IoSgSIGyAwRDWbU+METJAz6CC3NPpILusF6ES9Kdz
	 vToXiByD5oC0VZzmPaHwFyKEwJ3H68mLptEkVCIvkJZnd8w7MZIlXNxbEgaF1NoT9cGad
	 0lZjVBa4fB3fsyUTs0D9Dgg86f6q53p/thaAExHq5NpuZrp8JMprJFSzqW/rC8Ga9qQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EIunOiTC;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C540A606A31A
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 17:22:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C540A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EIunOiTC
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-15dd124bbe7so1372392c88.1
        for <git@vger.kernel.org>; Sat, 31 Oct 2026 10:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793467366; x=1794072166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eltmB5OoKgy3bLrHLeFRh/hpvMIjtYRtwlzdwljJMkA=;
        b=EIunOiTCh6J7t9UFN5KUZFKjwpYUJ1Xd5VCpoldNS/xw//FReLMGM4XxwDlKFkoEf8
         CtgHAKC2RHiFqVHTDxiDP7xXD6+zEYXifLaDsVsInk+XuwuJa3Euoe1w+Gum7t3SI5Tm
         x++J6kF5qJsiVmqc5syMJrs1nYBVzHDn757Wj2a4YGNRCWZxnk2RZBdFgz9Ci7bxdpea
         JHqgqAvx/q4Ji36F2YwOzSv2ZQZmw3Aq9+nUDnZV785zn432gdrmJSD1s8IcOq7fabRZ
         r+oLsuDzWctQ3IhQ9ouzsVw8HdxKcC4wBBxTsmlDhjxMNp/tsOD1sjrjz5GjBzwJlTIc
         FT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793467366; x=1794072166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eltmB5OoKgy3bLrHLeFRh/hpvMIjtYRtwlzdwljJMkA=;
        b=Zh7ggBbdsLsSaLJ3ubYcNpnMSRqxVX7Q1fyvJ5idK/jTZLZzhJpkY+XjCgexwTUwUh
         Xz9zwIIU0u2NDqWUSl+Fx/pkiIdis1K89Hm2UZ6sTHfGdICZR0+UqowTc1YPWj7CfvCc
         qgeWXu9La8dAfiRAtAPX7JP7QPkmXJNyqkBHjo7T5Ut5ZfjZ6d2RbAyZBxfIVmVS+9ZE
         VkFNS7nRzNH8Zd57BMLyI3M9HU8T7912Z3jJnZG5r38mVXhInhnQnrDr2nwHN0Kseh/i
         pCAykxDWIqLHJhXI8XnogYb5NsG8LDghhSK7YHeGOZV/R+FgjBdK960YSLUu2aSEvI/9
         +uxg==
X-Gm-Message-State: AFq9FYJ5xiBofP+MStHDIUJuLQ+slZwY7gY5852UjMCT5HMrdJBJTDkC
	R8pnC0hZhZEabT8rzoEV3AhVbSpAA17Krd1OlmIU8c1maH2k/arsMpAq
X-Gm-Gg: AYBFou2OxJpMt3YrmKwGCXySQtSz9e8FjGt3Uw45qpkPNu4MGz5uxao3DoJUwjaqsvC
	cKloQtBjVxnOtZccQzURJRiNO0JwZcZrFqn0h8pNu3GnzBpiSHhkMpU9BRzTNLCjTF+H2168h35
	Z8hq7BhF9dQKqKIMbDv/aajVQwMxEQIV9JNoYQQ2ByW7mAga0bpj/5upt6DBN0XyM9K4VsrdlVv
	gtRWWfyoiChoxydcJZG/8RYu9npDqIv5fa2pQ+QbGR4GzkYZaQq/FKN8OURYhiaiMIyNiLYRrX4
	opG4Lcr4sURO7BLZMGFgoQ0oPSZb9+Tmpnx8cSt4qGn/wdD1uPsYaNPrI61pm4aBUqCbn7kqkWv
	bDj+PD94ZykrYcaqAEg1YVb236HM403o1JjWhDGTdqKZQBZ4pHF9FKkYppY1NfXzBDCElH1CyKm
	eTNvED9VVwCxaCHqfh+MIajjpIvoWfMUm+fEJ0yHmisOvRc9oe3JuAprqIp//vEGuzzKvsc9gMO
	zm2eavcUdHwVGgzN0MeQrjVkG0/ZPCD/Lg5hKvDO7h3F8aOg5mrKeD0fUYuex96S3MRQSecGAgv
	ORWNXgwqmSRV10ExGj+SUkxg81TNQw4HsCch4X5+CUqaDfF1esM7uQ==
X-Received: by 2002:a05:7022:ed09:b0:17d:7b45:f927 with SMTP id a92af1059eb24-1ac5c2727e4mr7434814c88.33.1793467365667;
        Sat, 31 Oct 2026 10:22:45 -0700 (PDT)
Received: from localhost.localdomain ([117.206.63.98])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac194b5437sm19703754c88.13.2026.10.31.10.22.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 31 Oct 2026 10:22:45 -0700 (PDT)
From: Nakul V S <vsnakul@gmail.com>
To: phillip.wood123@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im,
	phillip.wood@dunelm.org.uk,
	gitgitgadget@gmail.com,
	vsnakul@gmail.com
Subject: Re: [PATCH] sequencer: refuse to revert shallow boundary commits by default
Date: Sat, 31 Oct 2026 22:52:38 +0530
Message-ID: <20261031172238.66306-1-vsnakul@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <235e7dcd-2d29-47e4-b68f-9b02f80085dd@gmail.com>
References: <235e7dcd-2d29-47e4-b68f-9b02f80085dd@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Phillip,

> From the user's point of view, I think do_pick_commit() is a bit late
> to error out. It would be nicer to refuse to add a shallow commit to
> the todo list in the first place which means we'd need a helper
> function that's called from sequencer_make_script(),
> make_script_with_merges(), single_pick() and
> sequencer_pick_revisions().

You're right, and I hadn't thought about it from the user's side. I
tried "git revert <tip> <boundary>" with v1. It reverted the tip, made
a commit, then failed on the boundary and left .git/sequencer behind.
That's a messy state to be left in.

So v2 does what you describe. The check is made where each command
builds its list of commits, and they all call the one helper. If any
of the commits is a boundary, the command refuses up front: no commit
is created, HEAD doesn't move, and there is nothing to abort.

"rebase --apply" doesn't go through the sequencer, so it gets a small
check of its own before it rewinds HEAD. That check does nothing in a
repository that isn't shallow.

One thing to be aware of: if someone types a "pick" or "revert" line
for a boundary commit into the rebase todo list by hand, it won't be
caught, because the check runs when the list is generated and not
after the editor. Git doesn't catch that today either, and the person
would have to type the hash on purpose, so I think it's an acceptable
price for failing early. If you'd prefer, I can add a second check in
do_pick_commit() as well.


Thanks,
Nakul
