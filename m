Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704713A3835
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 09:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781689694; cv=none; b=hMYunWzXfUh/JA1ukdfuEaetAHPe26vg3SpmekkWLmVxQeVa7YruyJIROTeZfkbEthj3ejoTL/VM3T7uyxOwtcZfcrhmiiytPruY74rgadt26MUVtrIYDNnSN+Wvb7EktlVz1600FFVOMEYbzyiveOOTijM2UBlbEKyYHpGt7BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781689694; c=relaxed/simple;
	bh=Osr5fr43mi1HpFiM9QsNZGEoUxvpTXC4yK021XMCITM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hbaRedOeSAGwTDmN+n8mfDCU/pQVq5xLKky5U2M6ebiniQsLg+ahzlaBD6arfAm8d1mKN0+n5QW0ZqsLTO4WAfbbYciM7PXlTh4Vn+vPbnB6Gi3WweMuAjQb6KX+luX3xS6YsxoCvAbzge2MFKLvFzaNKu77wAJPNcb24a2fWE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oe5nQv+I; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oe5nQv+I"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6957f9ca40fso460958a12.2
        for <git@vger.kernel.org>; Wed, 17 Jun 2026 02:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781689692; x=1782294492; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W/+H/0r6Xt8aZN1deM9AnUu9HcOuoW0OkBEozbVPT+0=;
        b=oe5nQv+I/edOCHc3Q3yOr1HNd775TjyMybJxsFXT6hZAB7utv8Kda3PbBy/rgWQ5dS
         IXcSCC9NT2+P/NkB0TD1nk0hsOg1BE3tKPYis66jazWyMFIESQevl1V4uffKXCh1ch5g
         2y16nlgGNrjseM01Hb259vgBK+wkPEp/9BxNQ4oz4l46PMj7qK9kH9n8/ZdsgLvog6jc
         Wog8TLh1CLYIZROUXRbj6gg8fYhQ9sc8+yDwViqqQxmfma0vvWy68bhhxXopHUN3rGY4
         1O0xAJH1gFWCJlVwLiIt9QeuwkevuKh+PjoMsckPhEHcyCgo2S9pJQVc7T/lMTgb5FvP
         e+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781689692; x=1782294492;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W/+H/0r6Xt8aZN1deM9AnUu9HcOuoW0OkBEozbVPT+0=;
        b=B0o0M9aALatGyK2X9Wozu+UiWjGfOuj0IsQ8owfie4XzA2SmqXiRc4SbVvx4+dxVlj
         JZiYGQYwf1w2gO+rpE0V138RQNMhHIEn3uR5wus3cHzwQZOKKLcqPOOh34j4mVX9tFmz
         IXJKNCQPjPn63/wBZFOPAkpHH9vgRLQJdaoIuO38k++nL2eXKvISrbzwGNiD7VfIDpBw
         l+HE5Qo+bJMbtLrSr1UXVRM+I8fGyHP/yNFCpouwwRiRzVleASpHvnKNTVogoK4d8Ao2
         XI6aJP1m6NjxCho3v8Ww4wBUtI2JpsCC/TiPvElcf3YiQZgJvZbDEovjxyxDdwRx2Yd9
         9B3Q==
X-Forwarded-Encrypted: i=1; AFNElJ9C5KfiZ+rKHjPujZj3XZg0KgAr2zhSbBEJTzlFV1hI5FFPr+RpN5fznaBRZqnsKjjr5hg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcB8m0xhBSer3f084zBgKnic8CAAcI6A/rVh7LAB/0NvOwZ3va
	gzlq/4OVGey/BluU48/2IOQtvTy4M7YpU5SoCRg0ufDVoNUjk0I2cpZ+
X-Gm-Gg: Acq92OEyDtm473SdwWsqIOVDgFEQTjObkfZkNuzUkgsOSV+avSzyPyRP+wcKlg2TBUg
	yvPKCwpI1QVSv3loLqJQkTvRCITQjrBjn/Q3HMwxZh5bi5J5y84sKqorQHa05oRCEJu0kHwFxJp
	Fa78A+LVmQQyuS/20dfAcr9sTzAor42AAi6Ukz9JfYAAOCAwjAQcjUN2D0HdtFt834IUyZgx7Y1
	8lnMznSOImPFkSxyZ62/BKQ5pV35GvL9zDFhppUjiWeXqMoKtn8FvRqAhK3JtOUvlHHnKLTFysz
	f891b0GnI+rMtGl4/oYS6XMnFr4yMJ2bxXjmF2Cci1A6BhUwtvaqzCFuNmb1EXt9HG9HhOwuwZr
	red7tdzWR8dn9PajXKo3RdcqBbSQHa6LbQySf2NRoIz+PnHz5lk6RfTRKiyr8zB3Xq7iLWQnpnT
	00oj33c7epf8c4rau4irh4aseH4LBhNOrkfrZYS193/3UYNjpP2bn8tFr9VJRcOPCKxh+dNw0M
X-Received: by 2002:a17:907:d05:b0:bed:a7d7:82c8 with SMTP id a640c23a62f3a-c05a73ae9f1mr210190066b.37.1781689691488;
        Wed, 17 Jun 2026 02:48:11 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:537b:c4f5:ba6d:96c6? ([2a0a:ef40:69a:b801:537b:c4f5:ba6d:96c6])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6937919b458sm6382281a12.5.2026.06.17.02.48.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 02:48:10 -0700 (PDT)
Message-ID: <fa4a6793-5114-4b12-a60b-ea79a7b3f632@gmail.com>
Date: Wed, 17 Jun 2026 10:48:10 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] rebase: add --squash to fold a range into its
 first commit
To: Harald Nordgren <haraldnordgren@gmail.com>,
 Phillip Wood <phillip.wood123@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
 Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
References: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com>
 <pull.2337.v2.git.git.1781512625.gitgitgadget@gmail.com>
 <d55b6600-50f3-4e81-a6bf-d270cd7abd2d@gmail.com>
 <CAHwyqnV_pt1fEhUGPyGtXrJAwhjpQHOyX9juHRv_88T2md554Q@mail.gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAHwyqnV_pt1fEhUGPyGtXrJAwhjpQHOyX9juHRv_88T2md554Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17/06/2026 10:11, Harald Nordgren wrote:
> On Tue, Jun 16, 2026 at 12:10 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>> On 15/06/2026 09:37, Harald Nordgren via GitGitGadget wrote:
>>> Rename to rebase --squash.
>>
>> Please include the original cover letter as well so people who have not
>> read the previous version know what the series is about.
> 
> So you mean this one, should that be included in each version, and
> append each subsequent one:
> 
> ```
> Adds `git rebase --autosquash --fixup [<upstream>]` to fold a range of
> commits into its oldest one, reusing that commit's message.

Yes, see 
https://lore.kernel.org/20260615-b4-pks-history-drop-v6-0-2e329e536d78@pks.im 
for an example and the "Cover Letter" section of 
Documentation/SubmittingPatches

Thanks

Phillip

> 
> Related idea: https://github.com/gitgitgadget/git/issues/1135
> ```
> 
> Or make each message a full cover letter instead of just a diff?
> 
> 
> 
> 
> Harald
> 

