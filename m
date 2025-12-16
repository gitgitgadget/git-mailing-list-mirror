Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB553B1D33
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 13:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765890918; cv=none; b=fULDfam/S3c8aNGlbPhTH17jdTLI/50fr4k+jP/n7rbFPq+zNpkWda69EY6IhvF6EmxmKTMATpVCenh/ZaEjZbcsmSXN2k6C9r+MO43Ki0eSP8yhkN6xWoujRBxFg1ot57A2w/TGAwCgokZM2At74c48kF/LvVi8Pb7X/y2ZEeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765890918; c=relaxed/simple;
	bh=YJOIbs1KNBUcb10oHbJ7cPcqIHwElIum1pwG+UHQAZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SOFX+SlJJY1l3KcWPGEj27E++UBSzfDv221AuGk0R4tvbFwOiuEHoRbkR16j7atHNne4gdh9djKuTFPB+qt/+o+/oVD655XDyb5+rlGr4mNz48FvF8SO4bsTNaA+nAmKdE+No+ZV/ie3ZXTbwUKz+De6y/GrZYu4/Ddqnks+H1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YvWoOD6d; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvWoOD6d"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b727f452fffso151567366b.1
        for <git@vger.kernel.org>; Tue, 16 Dec 2025 05:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765890915; x=1766495715; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tqg3u0hWMAmXEhbQCyDFUmERVZyYdcSq8LsnOV0BSo4=;
        b=YvWoOD6dq1wh3ZHNOOm7si89RNTfAL1vrB1QmDjAUqKXBFJaRhZ+7BQyhCJ+XHFmZB
         FdMZ0gGQrw1G9piwY5H53P8FjxSdRWa8eZu3YdDH2ETtWc/eoR5rZgWIRTYsSjOt90xO
         phjKQBSd3C5Q2WJn7lQOqN3nSiBY3hohG2Wv7ig2ZjpSCh7qIWznlA1376xhI5iRhBcB
         veMtcKQnOl1KJwMdLcM+qlyA/JASLSNm6lXQMwm++uizyxZeFxjAKH8Zqf8CdYW2sY0r
         j2/7+6xyAAz53TNFsGQ6YdS2tW9ivs8defDBNrfx9d1QScgD+NzNNAiti+158+4iKICS
         13Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765890915; x=1766495715;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tqg3u0hWMAmXEhbQCyDFUmERVZyYdcSq8LsnOV0BSo4=;
        b=b6cdgl/RzJA47YMIMx9K/bYEOdwTowVW/Io0puPxOqmwg+eXlM6Zi7A2Gy3Ic+g80r
         b+b4Qs3Rsp/851/z/TLTksxsfdTPzx67Fpj9Bl6Rc5AjYqJFhYvpCb+/nBUg7tZykCc8
         vsp/wy8pU+05tBazwTBUjJjxh5zDRex5wdm7xNr91nKJO0+AuYa78I8MLRYidVk2IcGB
         ybSbDAB6hTL4SzOFp8L74RIMeawsg57fWT+WLZ4K3+0FNhCd+Rg2qCSz+8Mlp79AuOQx
         EvhK8+6AzCoMIx0eioltHEZBXXHYNF/6iAuWN8qOT3oMisahNVNfRbgEewKcRj5HbRFl
         N/Ew==
X-Gm-Message-State: AOJu0Yx2QSJ4iYdob57KLwdOTHQXedN8xGPtI79dE/VK3cjRVvtc5IBK
	7XCdFItCD3NH3MXwzYlJEmS9KCYZ1kYhf/485XpAnHvGKn6cVaHgkkwK
X-Gm-Gg: AY/fxX67pBkYqMGrZiZ/GNp6gCefndKU6PiaOFvNPxkxCSYUEFxFDFVWUyPhCsZqjRE
	9Ia35ag+xjI35u1opPOQVSBEfdVCCfPYuNOdkyNWoEG/DXpBAQm/Q+Inz+VR5UcRTMzbtoMFfRy
	qZ1N+HlKDVAr9wNH1qjPuxqFCemPBEElpbpfsfR08zul4M5j23of4AIj39uprBYOyQicTFRzwhw
	WDCYvnPFqIWb/dMgnO137SeGEpsnlsfEUebHznvcLwwy6N0XPcoOsUjw5IEFXoqlsKjfj9eAmFq
	YWMhJt15b3AnpKA7VJ26ij9ly2NkD5MdHHrmHd0E95buP9jDZ0iJ/qSIJ3KbOcLXAXN1xwLCT2+
	sPg7beZGh6pZSbY8arAYC/Fc25xQa0fE95wb60kT96QX3iq/qMadJBxUmYJM5suP+2bGn7j0qcs
	rPF6XpeT15wsE0T45CjJjmYtc=
X-Google-Smtp-Source: AGHT+IEJOMU+eQKag2ecg2/xhUKjvbEV0IQs+NtsZ+7u19ClvGCgNL4f/Me9hyg4ZSV1/Br3AOFXLQ==
X-Received: by 2002:a17:907:1dc7:b0:b7d:266a:772c with SMTP id a640c23a62f3a-b7d266aaa99mr1064042466b.21.1765890915175;
        Tue, 16 Dec 2025 05:15:15 -0800 (PST)
Received: from [10.29.112.243] ([193.204.167.189])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa29e060sm1723832866b.2.2025.12.16.05.15.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Dec 2025 05:15:14 -0800 (PST)
Message-ID: <61700785-5421-4fa8-8277-c0837b09a737@gmail.com>
Date: Tue, 16 Dec 2025 14:15:08 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Different behaviour for --find-renames between git diff and git
 merge?
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org
References: <3742e7de-7d88-4e77-b711-9fed867a8c23@gmail.com>
 <CABPp-BH80R4LJDRKQnPmh5Am_HAcCgxWiA8vRoN8LgLRUMz+JQ@mail.gmail.com>
 <d7135cd2-e577-4f96-8142-cd9c7cd6995d@gmail.com>
 <CABPp-BH1qgQNHJzJZ05Ckru2PdYxRnWfQ3xVPrqGG5F56bX1aw@mail.gmail.com>
Content-Language: en-US
From: Luca Balsanelli <lucabalsanelli@gmail.com>
In-Reply-To: <CABPp-BH1qgQNHJzJZ05Ckru2PdYxRnWfQ3xVPrqGG5F56bX1aw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/12/25 01:57, Elijah Newren wrote:
>> Even though the `git diff master~1 master` doesn't detect the rename
>> (the content changed too much compared to the empty file or one was
>> empty (although it says it defaults to include empty files as rename
>> source or destinarion)), the rename should be detected between the two
>> heads, even when merging. I tried to read at 'git/diffcore-rename.c' but
>> I'm not very good at C and it would require me a great effort to fully
>> understand it.
>>
>> So, why `git merge branch` is not detecting the rename and not resolving
>> the conflict automatically? Does it use a different diff machinery
>> compared to `git diff`?
> Merging never diffs the endpoints, and shouldn't either.  It basically
> does two diffs, each from the merge-base to the end-point in question.
>
> If you only diffed the endpoints, and one side renamed file A->B, how
> do you differentiate between A->B and B->A?  In other words, you may
> know there was a rename, but you can't tell what it was renamed from
> and which filename should be the final one.  You can only tell if you
> look at the merge-base and determine that the file started out named
> as A, and thus that B should be the final name.
>
> If you only diffed the endpoints, and one side renamed file A->B,
> while the other side renamed A->C, you'd be misled into thinking this
> was a normal rename (you'd only see e.g. B->C) and be unaware of the
> conflict, which is problematic.
>
> If you only diffed the endpoints, and one side renamed file A->B,
> while the other side renamed C->B, by diffing the endpoints you can't
> even tell there's a rename; you simply have a file named B that was
> totally rewritten.  But it gets subtly worse in special cases that
> might really confuse end users: if they modified A or C on the sides
> of history that didn't rename those files, those changes would not be
> propagated and combined with the ultimate B, and they'd be left to
> pick up the pieces and try to combine things.
>
> Further, it's just semantically wrong to diff the endpoints because of
> the underlying concept of a 3-way merge: If you were merging D & E and
> simply diffed D & E to do so, you won't know whether differing lines
> were added or removed by recent commits.  For example, you might
> notice an "import" or "include" statement that one side has that the
> other doesn't.  But did one side add that import statement?  Or did
> the other side remove it?  You can't tell by looking at the endpoints;
> you have to compare the endpoints to the merge-base to find out which
> things were added or removed.  So, fundamentally, a 3-way merge thinks
> in terms of diffing the merge-base to the endpoints, not diffing the
> endpoints.
>
>
> So, in summary, no, merge does not use a different diff machinery.
> You are just diffing the wrong commits to see what it sees.  Combine
> that with the fact that you have a funny special case where both sides
> drastically change the file in a way where the new versions happen to
> be similar to each other while not similar to the original, causes the
> behavior you are seeing.

Thank you. I understand.

Moreover, deepening the rename topic actually made me forget something 
about the merge topic. In fact, even if the rename was detected in some 
way or even if I didn't rename one side at all, the `git merge branch` 
would still be unable to resolve the conflict automatically, since both 
were modified in different ways, even if in similar ways. But similarity 
is not enough. This confounded me.

In the following example, I start from an empty file and I modify it on 
one side of the history and move (rename) it on the other side. The 
rename between `branch` and the merge base is detected. So, can you tell 
me why in the following case the rename is not detected during the merge?

    git switch -c master root

    touch aaa
    git add aaa
    git commit -m 'aaa'

    git switch -c branch
    echo -ne 'A\nB\nC\n' > aaa
    git add aaa
    git commit -m 'A\nB\nC\n > aaa'

    git switch master
    mkdir dir
    mv aaa dir/
    git add aaa dir/
    git commit -m 'aaa -> dir/'

    git merge --no-edit branch

Sorry if I'm pedant and thank you in advance.

