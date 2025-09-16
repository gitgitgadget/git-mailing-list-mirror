Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826DC199939
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 08:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758012131; cv=none; b=Zzl3OOjl9zxS3XASbAdVSGl4vS0EgfQEmg3a1KKb+9C4a6Oe8MeLtWrZBHf0s3ZtTUn8IGxwrSZZOrjOo5zO/Vnx354z9jjV5IVIVmLp2XNkE7Y7iIvd7dCDtEupS/ukwR3hajCyb034KKbqtlcQi1/IuMCMza57x6NHF3slHSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758012131; c=relaxed/simple;
	bh=gqOx53w2eeS9SEa4OBZci2xToKBoPogYkfPvc8RFNnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RIZRIGUcH1vGG1MmvU+txyOv7QS8l3zXHiJraIPyAhfjF7hpnukPbVEA5n/0xXUyAe5F6vV33RYoHH75XPwsmU9w7mTgt6u9lg+rDvLTcXRlbyMNexNx0rAVGqNaBCjlKs7iKgUS2gyIdI6y7JVMwRoZqDY0ctDVWrq5hden7jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4WnCQXP; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4WnCQXP"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45deccb2c1eso37624295e9.1
        for <git@vger.kernel.org>; Tue, 16 Sep 2025 01:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758012128; x=1758616928; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=45L9S77mqQQFfhROv6t+EGFJlNcP4n7mEn/zinmq59Y=;
        b=I4WnCQXPODtvFdPP4xqwP0YjKpR8MqbaZYjQ9kJpljZ4ZXJaodzvRerhOU4lJcO0Mc
         mG7V6jdZPPIp6zMo1zVkc6OYtLN5wm0m9a5vAwDp1NCB80TU+dLZ7J4H5DA6jcEy+o0h
         +lPEBcP72DQDEqvBqu+MhickAOpozYHrD/S2tNUyyMjJ6/Inzh8+DoKkrIkwv3JGXFkP
         slSiCB+FmLo+sbYfJNzGcuPUENr4MVzKt+PIuiikNaiV7PiX/DlOiQOX4NOFY26vOoW4
         1IBcQrjW8VA+p7SOx2zgaJJHI4Ql94F7fapJ9td6L/xc7YueiLKj+Ej9nac9csy56fNE
         TXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758012128; x=1758616928;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=45L9S77mqQQFfhROv6t+EGFJlNcP4n7mEn/zinmq59Y=;
        b=mHUjKq6m3laVaJkDXGNt2zGR9YhBRxaeWOqBjFILxco3ThAGEH65h49TFi4IXguBn/
         8k4uLbXwG0H0/xHoNCp0xulbeGQ/QQOZYFLMrJlao8zAS4t1i4IgbN5/dyfR1eyC4zNp
         qPUhxq7NqEcT32IiFTHYVemNDEtRYE4AOAex7uJFbNE0CORSGO4NE7to2wXDX4LBObyw
         rwuLPTRvc0vnAMzoQxrnDR2mFPDr/fQmnfk96p/mTLDUaecgL1EXA95c0iuTV6Zf5bAe
         +MHF/TY53ABA7+GNqkhfqmc4keeD8aXQM2NCYEgdXZ4FIjlETOY/AmNgOzfqANbhxrhC
         PfwA==
X-Gm-Message-State: AOJu0YwhArMMPY53ENfQ/O3xVAGacuzEmWqJsQBEoX/9eG0Ui7fjqO+h
	ZGTMd78j0UgT37ZFvNzg5vU7zI5NWXB/WeaMEgRQDkRMpGHLyKsB3tnn
X-Gm-Gg: ASbGncvej6mdzgRPzxLMJrCu5WD7NV1oxHu8Zm/5hGZsuW7fLisrEmbt3aCm9dzWbyt
	O0DlNp+WFHKUqGh/IvysneP48hFaKkviigIX6NiqHx41/vLMkzdasCjpndqYL/dxjf0/hlK97Zo
	g+V7VUxsdem+dlUFkhBLHtIJlFoDcDcUnujJ23drjmwXfbGTunQ2IAZgp7zgu/PfusRJS75ZmEg
	y+lhPYRBra3iuFZdobpzTE8pzVGFXMoxl9RV+JXdhZYVHrrgCpI9FAUx94sCyHI1yPmn84H4oo+
	F9lGcAn/GwF4ptO037FfASzL8+zV/l9vP0q1hc9FBlDoEQhkoW90iwwscuzxj/6NIs2tDR2gNzB
	jbJdUZdleLY6swKCM4vdJR75BJNolZh7QpDeG9uW/Ufjve2h+RtfGk7kgLGaiyvaer6XtCEE3N7
	g=
X-Google-Smtp-Source: AGHT+IGJH0gPa+mTBufBlC3zAEhPcUnjp51+aLfA2vI4q2r6rEERGKoV/wWGKRwICrAp4r2wYmrRaw==
X-Received: by 2002:a05:600c:604c:b0:45d:dbf4:8892 with SMTP id 5b1f17b1804b1-45f211d559fmr107681345e9.11.1758012127577;
        Tue, 16 Sep 2025 01:42:07 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45edd9f75d1sm190372605e9.17.2025.09.16.01.42.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 01:42:06 -0700 (PDT)
Message-ID: <cfcfaa43-7a16-408c-8d8a-325549a7838d@gmail.com>
Date: Tue, 16 Sep 2025 09:42:05 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH RFC v3 18/18] builtin/history: implement "reword"
 subcommand
To: Patrick Steinhardt <ps@pks.im>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>,
 =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>,
 Martin von Zweigbergk <martinvonz@gmail.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im>
 <20250904-b4-pks-history-builtin-v3-18-509053514755@pks.im>
 <10696a16-3f2b-4844-9f9c-9815976b3e1e@gmail.com> <aMfdMe72WB3DR4gW@pks.im>
 <fe671dbf-5177-4e66-a89a-8f99b379ac75@gmail.com> <aMkbOgLlDDRlqt7a@pks.im>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <aMkbOgLlDDRlqt7a@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/09/2025 09:09, Patrick Steinhardt wrote:
> On Mon, Sep 15, 2025 at 03:10:56PM +0100, Phillip Wood wrote:
>> On 15/09/2025 10:32, Patrick Steinhardt wrote:
>>> On Wed, Sep 10, 2025 at 03:05:04PM +0100, Phillip Wood wrote:
>>>> On 04/09/2025 15:27, Patrick Steinhardt wrote:
>>>>> Implement a new "reword" subcommand for git-history(1). This subcommand
>>>>> is essentially the same as if a user performed an interactive rebase
>>>>> with a single commit changed to use the "reword" verb.
>>>>
>>>> The sequencer already knows how to reword a commit, it would be much simpler
>>>> to reuse that code.
>>>
>>> I'll drop the second half of this patch series for now to reduce the
>>> scope of this series a bit. But once I send the second half I'll have a
>>> look at whether this can be simplified.
>>
>> If we passed a todo-list rather than just a list of commits to the sequencer
>> then it would be as simple as writing "reword $oid"[*] in the todo-list.
> 
> One downside though is that we'll now be in interactive-rebase mode
> instead of in history-editing mode. We could of course introduce
> history-editing mode as somewhat of an alias for interactive-rebases.
> But the required changes are non-trivial and all over the place in
> "sequencer.c", so I eventually stopped pursuing that route.

I'm not sure I understand. At git-history uses the sequencer to 
cherry-pick commits by calling sequencer_pick_revisions()[1]. Both 
cherry-pick and rebase share the same todo-list format and the main loop 
in pick_commits() processes that list in the same way for both commands. 
As I said in a previous mail I think we should add a new entry point to 
the sequencer that takes a todo list rather than a list of revisions but 
that should be simple enough and then we get most of the functionality 
we want such as rewording commits and updating refs more or less for 
free. So I'm not sure what you mean by "we'll now be in 
interactive-rebase" mode.

There are good arguments for not using the sequencer at all so that we 
don't update the worktree each time we pick a commit (that would be a 
lot more work though), but I cannot currently see a good reason for the 
approach of using the sequencer to cherry-pick commits but implementing 
all the other operations separately.

Thanks

Phillip

[1] At some point we should figure out how to teach "git status" to 
distinguish between "git cherry-pick" and "git history" as I think at 
the moment both probably look like a cherry-pick.


> I still think it should be possible to at least separate out the actual
> operations and share them across the sequencer and git-history(1) so
> that we can avoid some of the duplication.
> 
> Patrick
> 

