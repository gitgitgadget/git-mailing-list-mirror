Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3840CA52
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 01:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774229604; cv=none; b=hGgj6pVT93NH++Tj0mjrd6UJZq68/IDp7x0vr7TLNWiuCyqoWDfYXCjqd0Z2WQPZawTmlYq01M2XlJGTBlrXZaOWXY1bNzXokngd96OEX6R/IMRcL8q9yDtO3d4K4hCKbVBo8eJDWYQw53vFqxYOtdiR9659WpESBX4vAEykmx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774229604; c=relaxed/simple;
	bh=RtauU/IaBJaJ2eZ63hnqGhLfEh9/1aZk66sfUvu/k0w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=drxTQnocYLVAvwE4TR0UIPIhiAvCOHBUosW3Hu3YYy1AEXhaRgbNgnKZKAw6TUXRT7OfRoOROrb23pags3qei3/usbi0S8itvQhMakYUm5k8wFU0Vc9Hj8esIaeKsMdB85f/fxOb27hTL5g0U+O3MRzS6nl+ei6uOhyd0Vn8ALE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9ZsQ82I; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9ZsQ82I"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8cd8c6e365eso219105485a.0
        for <git@vger.kernel.org>; Sun, 22 Mar 2026 18:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774229602; x=1774834402; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bZAmpCUJWQ8/HRMhhsgrRWD0bJ064PlJo6nXcBpjvR4=;
        b=T9ZsQ82IUL4VNTqC3TVvbrGkmwO/f2iQMtfpndhRZiNpLxLzlBQGC76OGcd+Ha/3fc
         YlTluQVYqmTEItdsuC+nMnRJj9c5HtXdESKtXxKjaCMj61KRNYPp+TYN63XetGc2XzQb
         wK1hEcvfB7TFmn1fKJNfhIQVO0aeyinGlU8KO7iXkACIhdhFXLDeYIL0CDSHPy2avJcH
         p4L73ZVkcJYsazybhOZXIJRJcPwdJ/iWYL4mv9AdGGJ2o1A1JcGlTRQT0l3Yptri0EkM
         WPdEIDsw1UQmNMxDardVowNoWKFMJWuEEIo4VRsjxPTnPs6X9j4+dKaDEAlBFH0eo7N7
         VegQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774229602; x=1774834402;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bZAmpCUJWQ8/HRMhhsgrRWD0bJ064PlJo6nXcBpjvR4=;
        b=A7ignmyyKAmYObCd/3G3tRklqzMj0HBIWPsZ4LvciLeMzOnnoLS+Wkjkd6+cghWnis
         pZ4ha5Y5Qhh0EJotLqI/aEq862JsdQ171MS4yyX4ed7CSyzsUSmXfPbKXt8uaV8MDUS5
         9o5vnas9ZsvJIs3E/2s8zz7VjdmxetZ+TCezkpBej7bHc4Beuxg153y1Xe/qSHFbjIlF
         BKLYXwofnqNm7Xxw02fkqFA3E/Ql9R64gDSQ2Vy6U8WNdttnBfWar0P54fRlWLQwOEuU
         4G9jiOwg+9MhHnLtQMyOa4VXigaMCQdFkY/69yShrz/Qt17iWMOl5VHKdwy3+hpJHl3V
         nBIA==
X-Gm-Message-State: AOJu0Yww25H+2yOJjJbkM4/hejtHvXrGuyQGSELflzss+/7LFyt3zsIP
	hxTKn3/4kloFXOww9S0VK1gjnOTW4zIS5ZxBBYUMeq6GO4ZtIiC0GhXQ
X-Gm-Gg: ATEYQzzkgm9t/swL0QkAOnfo8Ws5bX8Yz116tcf2QDsk0w5/p/M1pIxqHmzkUhQ4LOR
	jDRf2MqBEnijtEO6HX+lFYkQI22Ghk4InZEPaiaQPy3LtguZol/VVMY8DjLoNnGlzUIDaSAU5F7
	SWpKhqkLoTkBJikNZJS9PyndL08xi1Tlr2PstD5gzGi57qy3ZL308QWmBAhf7nLf80o+T33Fgti
	bnCRKfd0buJKGKLMYOlL/hLDYIKDa7W2JcVDis69+LjJA8/Jl5Q6Yk50MDVZf7/uE/W3wBD3Ca6
	1ya37oc98s9r4HZEY2SprKAvXlMcoTY43er7YmXAaxeUzixcELg5NTrBfPoxp/vl/UyIt54b3Zl
	C1X589JbofOoBZ/0F6gSFY+IuNfVvNGverJ8o9jId2EdfIz4WU2sWP0TUTpmo9rC21Y8iMnhn+M
	Zgc33buAtCctcweizMTUb00cQz5u8q+MN7lRKvmUDYT+qO7HmfAJ5peWkoG3V3I/vE7D6+7yffe
	DK/BiE/d2onz+4dgNd0ceU2D1ItLgIAlp7uC+MbX5cABxlvj/TMe442+VkXjQ==
X-Received: by 2002:a05:620a:46a5:b0:8cd:a76d:630a with SMTP id af79cd13be357-8cfc7f516a4mr1586741585a.42.1774229601631;
        Sun, 22 Mar 2026 18:33:21 -0700 (PDT)
Received: from ?IPV6:2605:a601:a6b4:9c00:dca6:e357:abdd:ee2c? ([2605:a601:a6b4:9c00:dca6:e357:abdd:ee2c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c85381a8asm89636246d6.49.2026.03.22.18.33.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Mar 2026 18:33:21 -0700 (PDT)
Message-ID: <bf0cc84b-b4ea-4100-87b6-d29777155037@gmail.com>
Date: Sun, 22 Mar 2026 21:33:20 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] path-walk: support wildcard pathspecs for blob
 filtering
From: Derrick Stolee <stolee@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
References: <pull.2070.git.1773707361.gitgitgadget@gmail.com>
 <beb1c92554c76907315a4d1a7983226d2bf5a828.1773707361.git.gitgitgadget@gmail.com>
 <xmqqms06hzfv.fsf@gitster.g> <443e5b25-46a1-4990-96b3-122e66d81828@gmail.com>
Content-Language: en-US
In-Reply-To: <443e5b25-46a1-4990-96b3-122e66d81828@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/18/26 9:16 AM, Derrick Stolee wrote:
> On 3/17/2026 6:19 PM, Junio C Hamano wrote:
>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> From: Derrick Stolee <stolee@gmail.com>
>>>
>>> Previously, walk_objects_by_path() silently ignored pathspecs containing
>>> wildcards or magic by clearing them. This caused all blobs to be
>>> downloaded regardless of the given pathspec. Wildcard pathspecs like
>>> "d/file.*.txt" are useful for narrowing which blobs to process (e.g.,
>>> during 'git backfill').
>>>
>>> Support wildcard pathspecs by making three changes:
>>>
>>>   1. Add an 'exact_pathspecs' flag to path_walk_context. When the
>>>      pathspec has no wildcards or magic, set this flag and use the
>>>      existing fast-path prefix matching in add_tree_entries(). When
>>>      wildcards are present, skip that block since prefix matching
>>>      cannot handle glob patterns.
>>>
>>>   2. Disable revision-level commit pruning (revs->prune = 0) for
>>>      wildcard pathspecs. The revision walk uses the pathspec to filter
>>>      commits via TREESAME detection. For exact prefix pathspecs this
>>>      works well, but wildcard pathspecs may fail to match through
>>>      TREESAME because fnmatch with WM_PATHNAME does not cross directory
>>>      boundaries. Disabling pruning ensures all commits are visited and
>>>      their trees are available for the path-walk to filter.
>>
>> Hmph, I wonder how significant an impact does it have on the
>> performance that we have to disable pruning here.  With the bog
>> standard tree traversal, wouldn't tree_entry_interesting() already
>> be capable of doing this, even with fnmatch / WM_PATHNAME ?
> 
> I will explore what's possible here and see what I can do.

I must have needed the 'revs->prune = 0' at some point during development
and left it even though it isn't actually necessary. Leaving it
implicitly at '1' should indeed be faster due to traversing fewer commits
and parsing fewer trees while still reaching all necessary blobs.

Only changes 1 and 3 are necessary.

Thanks,
-Stolee

