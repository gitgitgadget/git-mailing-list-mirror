Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC43B4229CA
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 13:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948695; cv=none; b=PY+YDgh5Wx+89OgWvE5ml1IzNApzvPd9kali6kHyvmRgkXzPsK5/BvHGA0xXW/JPUGToxnmPxeDytzyp9QLPxXXgShOlbNY1VHrBT2uWm7e5FL6m1QMLTRQrD95oAAPA/Z3rfgr010V24smuZF7iJDxTcFzJmOHWMaCD8ac7Ylc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948695; c=relaxed/simple;
	bh=L1ZDlkj+blim8OKCBLllRx6CIVqcZOX4/pnVn8kqIuQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kMQ2lHSwvBqvE7DiLoh+hSbyV1SJz34i9fr0oiNANnqR4y4Qa2Swo7OiYMRLvPbRf2FDtq8q7ktdirhUVEkTUtNVkg8HQ19VKglElsKFi1XfKxnTD+GBmITfCctt2xP9hMDCz8czwmxqMuxReTKjeledK+4IHSA8oex/7K70Z0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMZobh/c; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMZobh/c"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c15fd3a299eso396538266b.2
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 06:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783948692; x=1784553492; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZjvjserDcXe7DOv0+ZKJBXSg4aVp0sYWWuj3KOqIrqs=;
        b=FMZobh/csRVWTd3kQJhQMqqaodfe7ZTt11uVmM8/AtQegc+rLskJstTF4TojYxcDRJ
         bLoX9m3V6mRRjrKhzI9ORK0bhGtGfyDtOfJuPHwiPwZkNRZOCmTf9e4MDS/uAHLgc8Bs
         LvyAtxIHoev5OKZpLE6hcJolSe2m1inYEVdacvcAhM5iDsgrel/wpjVcs/vF3kI9WtaD
         d5i8OSm9y8bp3uGDgGv8HG5FV3stJ2BNHcAn0BhWnzqv48QuqQea/w3qcmnaqOWa2Vlc
         G+LKbuHA4EcRaiT9y4GYtLFb+FJjqVoczFqaDi3Kzk82WeGjncnW7sthXvhkZgtUxrIi
         PY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783948692; x=1784553492;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZjvjserDcXe7DOv0+ZKJBXSg4aVp0sYWWuj3KOqIrqs=;
        b=rM/WKI0SEwBcwEbqks1GC1hPEbGTblo9WDPjsYHM71N2tvb4Po9/BsIMhKw+GFcjL5
         7/LtMNumDSzMmGsMFvkmN4AXm0/EBYwP270FwstXZsWFw9UGBzMPPb34gZtkkdP6naod
         SjNYWCOJjXpNlXe4yzf97KtQUr46DmZagV1B+GSm/Z/kRWObMN6JEGVHr1F+C7wkvdWc
         Uel0fgikNKtUxdIhIX1EVoNOzWCKxfeG69CLnaDODeQo84z35peBxJSAHhWJ/G5wzwMG
         Yxd3XDdH7gIzO7qRjcydesjkDyBGYWdGmSwptzsm9Nksr0/CP+7MyZQylWOqgekbh+Cc
         1koA==
X-Forwarded-Encrypted: i=1; AHgh+RonyFnUq1GnhsTlqmni8gtGDKTbBH3lt8NOfCuK4+j0RuTmTK1LhxDQ/gtL3z25AtsibLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMrexw6qVmVWgWiAUND22rf0QiQ5pR0YGt/oS8622FV/De7fsB
	sgB03Tl/Fcg2TMzd1WfbHrE8SoCJxan8L/ppwrL2PhN7t0sYDSYX4WCq
X-Gm-Gg: AfdE7clWqC4Me1+cvts4uck16OMZZVVUyJ2BOYUviGZMU9NzMXLdXJ0QEkyoHoSfP9Q
	IbklI+QjxN0HZ3dH9VqEty7N2Uc1q0Umhg4NO40ghnHQ1EywswFEmJ7elEtzkpvhPshn8Gpaxw8
	F2D3f1JRlihjHMPALVwXVgzuw0V0MfLLNPThEH5LSbserQGivwNxAIdfh9XifsRjWzBgWD5Fokv
	DKWEqHuINKtS+fYtxV7S8b02e9+kGmZffYtdXIdp0IcxCgX9H8390YMrLbj4EeXwyLs9q+OXOYY
	T9DuM/jlimNikmJJQhDCX0Yv16xgOgVrnm5VXsq0asz3WWdvKzUld7QN2qiav8Vek3li3NMGIQm
	gKeTYtP3y6ByPLiedP13I3pre4DijoUZjFIWpJd9ngtsLAPP2JO9jwdCHHKX1ba796kZIVyG6P6
	yxFSUyypHHdli8IDBUu4DmdKgqK/UJAoVKU5gDcr28ibO6EreRFWQvlxbTJHNNHq7VWUc=
X-Received: by 2002:a17:907:8997:b0:c12:7b3f:6c15 with SMTP id a640c23a62f3a-c161f3faad2mr398624066b.62.1783948692118;
        Mon, 13 Jul 2026 06:18:12 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15cfac0f76sm820600066b.33.2026.07.13.06.18.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 06:18:11 -0700 (PDT)
Message-ID: <a8d78707-ef0d-439c-ba0a-52a494967046@gmail.com>
Date: Mon, 13 Jul 2026 14:18:07 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "phillip.wood123@gmail.com" <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] sequencer: honor --empty when a fixup!/squash! empties
 its target
To: Yuxuan Chen <i@yuxuan.ch>
Cc: "farid.m.zakaria@gmail.com" <farid.m.zakaria@gmail.com>,
 "git@vger.kernel.org" <git@vger.kernel.org>,
 "gitster@pobox.com" <gitster@pobox.com>, "newren@gmail.com"
 <newren@gmail.com>, "phillip.wood@dunelm.org.uk"
 <phillip.wood@dunelm.org.uk>, "ps@pks.im" <ps@pks.im>
References: <20260709-fz-autosquash-empty-v1-1-84cb494c3613@gmail.com>
 <afb76b98-661a-4663-8e8b-fd00572db5ba@gmail.com>
 <20260710182937.716304-1-i@yuxuan.ch>
Content-Language: en-US
In-Reply-To: <20260710182937.716304-1-i@yuxuan.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Yuxuan

On 10/07/2026 19:30, Yuxuan Chen wrote:
> 
>> Using an empty commit has a marker has the advantage that applying it cannot
>> create conflicts, so you only have to deal with the conflicts caused by the
>> commit being dropped, not the by fixup not applying cleanly.
> 
> I am concerned, however, that representing a `drop!` commit as an empty marker
> would be semantically unsound. We expect `rebase --autosquash` to drop the
> target commit, but until that rebase happens, the repository is not in a state
> where we consider the target commit dropped: the target's changes are still
> present, and the empty marker changes nothing. Therefore, I think a `drop!`
> commit should contain the inverse of the patch we intend to drop. That way,
> the repository state reflects the intended removal even before autosquash
> rewrites the history.

That's a good point. Looking at the gitgitgadget issue tracker [1], 
there is a suggestion to add a new option to revert that behaves like

     git revert -n <commit> &&
     git commit -m 'drop! '"$(git show -s --oneline <commit>)"

and then "git rebase --autosquash" would replace "pick" with "drop" for 
the commit we want to drop and drop the "drop!" commit as well. That 
avoids conflicts when dropping the commit and means anything built on 
top of the "drop!" commit before the rebase does not see the changes in 
the commit that we want to drop because it has been reverted. That seems 
to be the best of both worlds.

> I recognize that applying the inverse patch may cause conflicts. However,
> this is not a new problem; `git revert` has the same issue when the inverse
> patch does not apply cleanly. Such conflicts reflect the actual difficulty of
> undoing the change at that point in the history.
I agree conflicts are a fact of life when rebasing, but I think it is 
worth avoiding them where we can.

Thanks

Phillip

[1] https://github.com/gitgitgadget/git/issues/259
