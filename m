Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF0B35AC3D
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 18:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775242602; cv=none; b=gspPXj1mP5+xFLgGju41dSwjr9P4Lxi3lh1E0mvbZJwB33B10pHI5KAJHpdtd6Jd6ANxOKo4o2weK07njPqvgSwXJsEai8teDcJhC7+gFsHoWxza/artGzSwmuPlmppiRM5KZj7+bSNERIagHL+i/nZQ4GSyvwvFgA7lbt5ASf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775242602; c=relaxed/simple;
	bh=QTgQxJedHsSqlfRymWMUAWrMWAnjzGVpCruQXQ25wlI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C4P1hNTJceOpk3HtpVvaK8zhUX1FNwMaT78sWtRrYOEx8wYgIt99Phqz1U3uwVB0d/77Ov4IipeceEpeDaMKITOeNlmI1E3kJg5XP9Lv/273bvlEC67Qs3IfBX5ZP+j8tNyO9saUYuZUUfyhgG0kmIyt1C7y8ZYwngXrkurHuj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FhEdv8MV; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhEdv8MV"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ad2b375e58so2265665ad.3
        for <git@vger.kernel.org>; Fri, 03 Apr 2026 11:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775242595; x=1775847395; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BOOJjlivb0gCTbaA4eZqgL8hsLmzzX+qcwaBT0e81WY=;
        b=FhEdv8MVLo5mV9A+esSHCDFJ2T32QW25wSJNSZMVNZcJr62eA6KWYVRhFNnUipXXv4
         woH3JVeSAiNgNtmln95JC6DdI/8gaDEmRSl85+nch3EVL0wpSy24ntNgN/U9Gc8Q9s6H
         9DhzKWdsi/f2Q6fdnat0IEGywWa3o/tJJ3yOxm4E/K4jW0aaXn5/Mq/BWmXfcrF5VV4b
         i1qSVwmCLsMFmwbBKRQp4AnIMvY1GzFXHJvkGzWjd3eByrVdElb9hirn8v/MTqCTscIy
         F1TNSAYcb9R0TvwkiPsysI/hHGKgCcb6qQCyp/dJJbGMIvgBHaHIuo3pc1aMG2RwxI5g
         GLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775242595; x=1775847395;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BOOJjlivb0gCTbaA4eZqgL8hsLmzzX+qcwaBT0e81WY=;
        b=oCELv7M+n56tCcSTkI8cluwUlUB+oejQtZFjjpxo1WDZZMp5rKGIbKGOvOOlDgvPCq
         vObdNXKcvHBDpi03rzWP0L8D54S0aXjL+J2mp/XvilNBrbk0+tuoInzvEBS1v532UH1N
         1CqSUeLP3HnESCb44XEyv6LK700oBI45G7BJFb/xwUnGsyFaLQGRFRzUn2Ygj3/ZQOx5
         UYOV7TDac49NxuQup2tMEVncF/TNKE5Ot22zDceK1Xhl9yv2q4MHejFuIKiTmqmJhNoJ
         kyGH8u/1Dold4tGRFeHEfOacTQe6j2ZwGQx2qGA9QsOHBeuCitDVitsa2cFyHzAyrB6n
         yA7w==
X-Forwarded-Encrypted: i=1; AJvYcCV3izu988w5aDwoWVtGM+2SFck3EjBqXOe2dVqe6hlh+jGLtatZRsa1jnzMkjQRgAYJqyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnFULj9CHwMGk967ilVvK4Mz1Om32YNXP3un8fvmMb8pbVjdKl
	OuJnGrPAhPo51bW699RsN7/P9Xwa8r0CplIJ88xzbqyGY2vGNvAyFqlO
X-Gm-Gg: AeBDietUIdsAn4MLx7ivDZTGnDBc4w6t3K0xz9Uh1Np0+36+ZN3j3AXw0txMb7ZzEg4
	Xd9ebRNVspTQN04ZhYFwR5TXH9CvGjBdYL7278bwJqd9ZNlDQetPVdMwESPtJFTTIa8H/qfh+01
	DLlA2xxzPbsNAw8sFYEUBmWKiRkWg+K5SwQ+TwTj9JyrmM1C7Xh4ygJB62cJNVVNdFx8S4MBBh2
	XxtSIwQ6d0vFHHsmk25Z13XOcHVQ6ipK1hBNJiCNrwA9C/oo4As11hgFGDwFRpBlpXSdT+UywCr
	n/hS2vepKqXHnKtpnN3RsjRiHAlN9HrRMl0lOC+suttIriJUYZ4sQoHUa77pi1SAf0IsCLM3RFv
	pAKDhiKxoHRYgjbrVJo69CG09lL1WfJsBVT3QtoXKTHw/iceJNK4jNGdFL9kqc93/fw8B/S7FPG
	YdCiKN6eLLjKutmWiINVZJsCH+RDZpeTDFHGXw/XUxnnMeqHNHx2lespzqH8st6T5+dA5CW1kcC
	a4WEHq7QPw=
X-Received: by 2002:a17:90b:39cb:b0:35d:a9bb:1e49 with SMTP id 98e67ed59e1d1-35de6a5033emr2374784a91.8.1775242594904;
        Fri, 03 Apr 2026 11:56:34 -0700 (PDT)
Received: from [192.168.0.109] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dd35f50e9sm6311242a91.6.2026.04.03.11.56.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2026 11:56:34 -0700 (PDT)
Message-ID: <dc134cdb-cdc3-4c54-a97e-993a26900d0d@gmail.com>
Date: Sat, 4 Apr 2026 02:56:28 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC PATCH v6 0/3] graph: add --graph-lane-limit option
To: Junio C Hamano <gitster@pobox.com>, Pablo <pabloosabaterr@gmail.com>
Cc: Johannes Sixt <j6t@kdbg.org>, christian.couder@gmail.com,
 karthik.188@gmail.com, jltobler@gmail.com, ayu.chandekar@gmail.com,
 siddharthasthana31@gmail.com, chandrapratap3519@gmail.com,
 szeder.dev@gmail.com, git@vger.kernel.org
References: <20260325174401.217577-1-pabloosabaterr@gmail.com>
 <20260328001113.1275291-1-pabloosabaterr@gmail.com>
 <bdff0a5d-b738-4053-9b72-08eba88156de@kdbg.org>
 <CAN5EUNR_yfkv_hC4wg-nHNg=3FnkYdvFm6FcOUNG2A=MdGs7ZQ@mail.gmail.com>
 <xmqqikaawrpx.fsf@gitster.g>
Content-Language: en-US
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <xmqqikaawrpx.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/2/26 00:49, Junio C Hamano wrote:
> Pablo <pabloosabaterr@gmail.com> writes:
> 
>> While working on this I spent most of the time with graph.c and
>> I got to understand well how the rendering engine works. I think
>> I have an idea about how to tackle the column rearrangement
>> like gitk, which I believe is what you thought it was about at the
>> start (and the
>> TODO that's been on graph.c for 16 years c12172d2ea).
>>
>> FWIW, I'd like to send an RFC about the column rearrangement
>> because it would be better overall, no information is lost, you can
>> still limit the number of visible columns which would replace this
>> in most cases (only scenario I can think of where you still
>> want to keep the truncation would be if you want to keep the
>> branches going straight vertically).
>>
>> I'd like to hold this series and send the RFC with the idea for the
>> rearrangement. If it ends up not being viable I would come back
>> here and add a 4th patch to remove the extra padding lines
>> (merge and collapsing lines truncated) to make it more useful
>> making the graph more compact vertically as well.
> 
> Oh, I may have found a volunteer to fix one of my pet peeves ;-)
> 
> Imagine a history with multiple root commits and you are drawing the
> history near one of the roots.  Immediately fater pacing that root
> commit, the graphing engine seems to say "ah, the next display row
> immediately below this commit '*' is vacant because it does not have
> any parent.  We can draw a commit right there" and draws a commit
> that is unrelated to that root commit it just has drawn.
> 
> Which of course makes it impossible to tell that the commit on the
> earlier row is a root, if we draw a commit immediately below it.
> We'd want to leave that column/lane open for at least one row.
> 
> Instead of
> 
>      * a child of the root commit below
>      * one of the root commits
>      * an unrelated commit X
>      * the parent of X
>      * the other root commit that is a grandparent of X
> 
> we could probably draw
> 
>      * a child of the root commit below
>      * one of the root commits
>        * an unrelated commit X
>       /
>      * the parent of X
>      * the other root commit that is a grandparent of X
> 
> or you or somebody who stared at the graph engine much longer than I
> have may have even better ideas to draw such a history.

I have some reservations about this idea, although I know little about 
the graph engine. ;)

In terms of user conventions, in --graph, '/' and '\' represent 
branching and merging respectively. Here, however, the '/' used to break 
up between different root commits is merely a placeholder and has no 
specific meaning. I feel that this not only goes against user intuition 
but also creates visual confusion: (I just drew this off the cuff, but I 
reckon it should look something like this?)

> * (main) commit 4
> | * (feature) commit 4
> | | * (doc1) commit
> | | * (doc1) root
> | |   * (main) commit 3
> | |  /| 
> | * | (feature) commit 3
> | |/
> | * (doc2) root
> |   * (main) commit 2 
> |  /
> * (feature) commit 2
> | * (main) commit 1

I don’t know about you, but I find this rather difficult to grasp. At 
the very least, I can’t tell at a glance where the actual merges and 
branches are. I don’t think a good solution should involve shifting left 
or right. Perhaps it would be better to use a special symbol in the root 
commit (such as the ■ symbol, which resembles a full stop? People would 
instinctively recognise it as a terminator):

|* (main) commit 2
| * (feature) commit 2
| ■ (doc1) ROOT COMMIT
* | (main) commit 1

(I wonder if there might be any character compatibility issues. Anyway, 
I like square characters. Square things are all rather cute.)

Regards, Yuchen
