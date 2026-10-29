Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793307374;
	b=BtuyshdHl51aRxi0R50zf50hQeubiW+kJoI+CUZ6qccMANb8GsVE5SnGTf6weN1VlNZ2
	 eKqGXDZQpx/mhhQtqaqx4EOIG0nanOGkX/5RLteIkGIspHiXGJuWwX5IqjpaDEb9jY8i5
	 ibqt8bVP5GkYg06lhl+D5soBJuG9LdGw/LLI5LlnkLXLH7/QOpkH0VWCge+BZHwuBlktU
	 EOUsHVFnRRQ6sJgKCalHyh/EzRuTdsI+Ljb0vpjFS9Z6K8QsJVKdywFO1I4UdowzQSkHl
	 sEjpdD2/i3qZC1pgPxbsLWzJz6X/cAnN71hoElcURJkKqVFQMLMrrKL8/bDg6Nci0Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793307374;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 From:To:Cc:Subject:X-Mailer:References:In-Reply-To;
	bh=NElWhDyuvEyoaOfHZqn43s6wBRhiKHr1icq0T1Oa2+Q=;
	b=DzyCKRqa/TIrLcN5PZxAlwTFBekLBMwGfsqvYyjzvJjnY9+aZIHLYOOGBeAiUasb8sh4
	 BLgjd2zl7UjPZ03zylhvD64cb3/wjR6FDzIfM9oU95lmj0uFJ0syHq0/XQ+isOy8D0xup
	 Oq5AwiFKJQSWqB+XG/n3/O9UJRWLSWDt60DJZkO/QkIH/Hbc5uHKgCLNs/qOoR2G/JruO
	 mxLEvxyFpKAd4wLSNt+x3pynPWtGJ+cwpfoliuHn8D+0h11dSdIxfk+bGMD8Zd0xY5auR
	 Dd7cOmhTNaXKBqO+OKZWqwGBKKYjDKm0F8AZixilDoPMlMDu0cRyB1lQoN4yaOh6ZeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rtsOclqd;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE901606A31C
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 20:56:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE901606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rtsOclqd
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-14394530ec6so3041181c88.1
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 13:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793307373; x=1793912173; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NElWhDyuvEyoaOfHZqn43s6wBRhiKHr1icq0T1Oa2+Q=;
        b=rtsOclqdIRCvUvtuCUpVBp3/D92Dbds+F/ccN2VGdoE/gX4tJDo0s2xC9BI1v5YH3G
         g1KLQxk+RR4X+QwRBra/tx/ACx8Z8l09MQ3H+Gx6a9Z88X0rVKb98zCAlRz5K/UW8lTN
         e2Of93IK5kMIGBSct976fk5bRU82YlViOCZ3piLfMY74oL4zKA7Bye4Gk09FNAlRRxKc
         5kmL80yknUmhsojhr4o8ja3tHksOxVMHXtSp6/pappfAu+ihgwfOqF3HyW3BXFtJn/Gl
         t/ynGnoN1UmrioE3WyHXDjVarDslvTDhhINT0J6inCQ6JXButA7NlH15YGDvOAllT5pP
         4thg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793307373; x=1793912173;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NElWhDyuvEyoaOfHZqn43s6wBRhiKHr1icq0T1Oa2+Q=;
        b=uuL1Cgy2y79evMuGwQNlJ4yEdUmBkXjdQ/Sdgdi4T3yjjvxygXQNrOOXSC2rtg9vz6
         ilB7t1WgmKMvCwynkR4VSspywrNkTzxEBvMx+XG0bjeUzX0HB0LWMpp8YD61YF2u891B
         bI1ff7bqSazh6ZytvDydm2c4ZL/at79/EbcRniSkZmtDwHwk5nDDBr51VM7cyp6ugiRH
         j0h5uaESoyzUM0R89uvQvZFZLuSkEjuuXPifmPoaJ+YfgtxTBfVt5Nhq1nLcDDVTJhok
         vLHVczB4bmxO9oRJIr7mJzDlJCuFDZTopib3mcHPa9f6d+Jl9HYd0r+7Onpj7rJZLs2b
         pvkw==
X-Forwarded-Encrypted: i=1; AKwUvBwuIij4jWBZKwDjP3FOVsFmBkMQ3eN5Leyo48/2BUVNbQUDaqdnomPnK61GrZd1ltYsock=@vger.kernel.org
X-Gm-Message-State: AFq9FYKpMZelM6TY7WeAOmBnWB1AxrbQ81I0Vzr+Wet0R8kCEkf+ThlA
	xrH0Y3j1v+Aud7cICSDJJFKekfUFxNtWii2wqmqsU9r1KMaC7SclYm6J
X-Gm-Gg: AYBFou0buNHrMDJWKnQZNvBwRMH/ZosLzVM2o4N+08DiWTJOSUSlGlPtr97FiTvVqXa
	AUvCdJRCju6o3KB7vXgQVOTbTuSPuFRm5kO0vEdMrwpl6pBnIAhXJ71IWO/gdhb45Vf2on5rn3q
	OSP6QuT+zqlv5e5RfuZ/+0pRf1xf/Vz6FW50nRO8Ct9+r26dkoZMqXMhLBEjb9OnDOlETBh5t7b
	akGTfkx7+qGX4qRvySYJlBFsmP/OSwFpzNjIDbWSrDq8yRV6vSjExRfHUfgRjBdkxyg2lXKKALx
	77hua4EaoVH5j6mnf2me1tLZhV1U68qC+x4dKFEyYYzqgjcCFbH+nMGofkNQ8h8Z63JMNTZGwHT
	zaBn95UzQlf7fkPDSXKt+oRc4PVob2h7jmOuA5kG1UJC/Eb+dGGP7LB7JNmA8NHU6XGcRcBan7U
	4EM1erWNzURcNSzuZYMUqbaXCd1CE20zqzHaG0I6yeSz5ovaT0U8mWRo5gRsG6+YLuTU+IhMWBb
	FL7VX0Rije2K+BgVA+5FqL7yL0iNhwLf/7KJS/4fDkald5KTw7nQqyIHxyKZu4nSfc1so2H/wk5
	ZS+nRdzzXib04/gbbFjtA4dRMTNcqV2o
X-Received: by 2002:a05:7023:a5c:10b0:18d:5ef2:1644 with SMTP id a92af1059eb24-1ac5e6f4f90mr213180c88.30.1793307372542;
        Thu, 29 Oct 2026 13:56:12 -0700 (PDT)
Received: from localhost ([73.222.46.22])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac18458e07sm1073445c88.8.2026.10.29.13.56.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 13:56:11 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 29 Oct 2026 13:56:10 -0700
Message-Id: <DMHMEOZ1ZXRI.TDMEKTJ9W325@gmail.com>
From: "Farid Zakaria" <farid.m.zakaria@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Kristoffer Haugsbakk"
 <kristofferhaugsbakk@fastmail.com>
Cc: "Farid Zakaria" <farid.m.zakaria@gmail.com>, <git@vger.kernel.org>,
 "Patrick Steinhardt" <ps@pks.im>
Subject: Re: [PATCH] notes: do not drop notes written by a concurrent
 process
X-Mailer: aerc 0.22.0
References: <20261028-fz-notes-concurrent-write-v1-1-3d513e1fdbb7@gmail.com>
 <3c4f3793-07d4-47c7-b503-13a6ae567147@app.fastmail.com>
 <xmqqbj8c2wk8.fsf@gitster.g>
In-Reply-To: <xmqqbj8c2wk8.fsf@gitster.g>

On Thu Oct 29, 2026 at 11:25 AM PDT, Junio C Hamano wrote:
> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>
>> Instead, maybe this would happen in an ideal world:
>>
>> 1. `master` and `feature1` race to commit a note
>> 2. `master` wins
>> 3. `feature1` notices that there is a new note commit (from `master`)
>> 4. It checks whether that commit changed the commit that *it*
>>    (`feature1`) wanted to update
>>    =E2=80=A2 If so: fail
>>    =E2=80=A2 If not: continue
>> 5. `feature1` retries (go to (1))
>>
>> Maybe this is too much logic for a =E2=80=9Cporcelain=E2=80=9D command (=
interactive
>> use), but there is no plumbing Notes command.
>
> Or possibly
>
>  1. two races. Both remembers what commit was at the tip of the
>     notes tree (call it commit #1).
>
>  2. each creates a new note commit on top of #1.  Call them commit
>     #2master and #2feature1.
>
>  3. 'master' one wins the race.  As #2master is a fast-forward from
>     #1, the notes tree gets #2master at its tip.
>
>  4. 'feature1' loses the race.  It merges #2feature1 into, or
>     rebases #2feature1 on top of, #2master and updates the notes
>     tree.
>
> ;-)

Your proposals for retries when possible make sense but I may leave that
to you to implement.

I felt confident reviewing the current patch at it's current state
(AI-assisted) and I do concur that it's a net-positive change in the
interim.

(I guess I could try to implement the retry logic - AI
assisted if you like)

Would it be OK if I also suggested the other two bugs (+small fixes)
I found on the mailing list (with the same tool)?

They are:
* Similar race-type bug for credential-cache leaving a stale daemon+credent=
ial
* fsmonitor daemon keeps running after its worktree is deleted or moved

Both patches are of similar size and complexity to this one, with a test
case.
