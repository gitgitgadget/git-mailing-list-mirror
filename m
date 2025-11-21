Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9551A350D46
	for <git@vger.kernel.org>; Fri, 21 Nov 2025 14:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763735504; cv=none; b=ZRmTQD7YL4s+HFThU6tVHdDmAaiWHFEFNFi9Ok5v7dvCsgVyM3fYnnH2Ivunw93Wou7RicTZq+fUywqarwfIhzgd7d25pArw6EQ1l5BzHPIRH2nvRtAnxoiWEkya6DU57Sra1KUGdDjDUc9iZv8bNgBWjoxg4+MhuQHlS2Uob20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763735504; c=relaxed/simple;
	bh=jBXbojo7wkRMNyc+JlY4GVy59TKuLnFGsqs09rCFoGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I9ukBiOm/eBxaW3vY1vux0u6i6aRoTZgZaZQsKkcjq/ICYatyiD0S39GwJeNjGjDr7jpn59ve66C7LjUCL2CVRjBI6dQ9XYZ+EfKPssR7Pw9WNNc5xz33fPz9uj4yhyn0r6GakOQSEzKn0Fb5guA/RFziYSR+RFBi4mNLFb5iJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VBajYXau; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBajYXau"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-477aa218f20so13632105e9.0
        for <git@vger.kernel.org>; Fri, 21 Nov 2025 06:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763735501; x=1764340301; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEzdxb2ufEIgJcfIwKmNKx1KiU6wVtVUX+XbBn3G3Xw=;
        b=VBajYXauwemd2LZWA4Suk1PF/08cho5QLfJU0XlX0qqH3Mc6aSM3myghSTTp+YKjOV
         q3fAtBY31/ddSTHVO1lJUPGu6HOXFwJg24KmWGcm6EMiNFNGaplMHyQDEjzGfc59pJdx
         mUY7cebhp2TdYPiCEJWwCWRkgxwPvd6Oc/MP/r6+ZOC9rTqUHGy/d+IG1BlKwfirr4O1
         XuQtRyQkJBL64ZAhP4LIFTb4EiV9bcQWdyyQ5CiGGjggLonSWaZc9IpufvTF759MDBQ6
         23dNyxjwku7Jk5ZC67IneRryEqp+vtMb0RExMfco9FKmYzvXR6cCnWBkGA5wX80bo6Ot
         z6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763735501; x=1764340301;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEzdxb2ufEIgJcfIwKmNKx1KiU6wVtVUX+XbBn3G3Xw=;
        b=KXRCJ+pDUc+qMVd5sPX1o+Yq+y/XjfXcR+1u+5iwqXCsnOu1rpjhP75OOeUPWGBZ0e
         2EM1OdS/l0hUrgsrfB8l8E7yn4Xl6jEB0cszN2Yiyxiz6YT4Fqm1c1kEIsnh+a3xPyhg
         XjGRGtTZRzqJ0wtt5ByZJiPzWBaE8JYBwYP8kMjhF73OrqXwfsrMqykET+GM5eFOj0FS
         JVzWTCI0ZnditpP8WxRVj9txucpn0/hJ+8NqlWoe55Xws4YnyjJ0OqPYgU0dbuaQWjmc
         qrgAdpxQRqSeJyF6GXxOMU127rnnN03IjZ7RU/Q9TosDxRbXNclrLdMg8b31escqE9zJ
         h7aw==
X-Forwarded-Encrypted: i=1; AJvYcCX4sjxT60hgY1ZhOGp9zh64TD42MqWNG2nxDCgVqfU+wOlbC6ajcTTVxDqqjv6i7zxM0eo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBaqL3qu+PILSuFRHrotT5C8xK8ORvDrwH04eTKLSXnlzeraA8
	A1B+uKrlG5Gm0sJ8JMfchbGtJMGr32P1nu9K4JMKCYjp0LZaf5EKEN83
X-Gm-Gg: ASbGncu2Erz9jsqU6OoF430VuRDNoAJWLdU2v2l7fqOds4z7nUlwPdnBW2/bxEV91uh
	IZUFPhvqerabL/M++OSqPY9sPBx3vi/X7SdAv72hXb9xSTL7VOsV07MkLaVXHh67yL3e6KdNCuT
	41xFfN6fE1f9a13V05w2NEKr10/qcHLOv0fDB7jTEPzETJCzBrGNSY3TQIJSnfVVpW6xy1p/FQD
	TvMePa3YZ7nwyA65kfb7PkpnAao27PKvBG3YMuxKwQOcqJZH3ATJCU/QbQvAE3is/2wA58tZbYS
	toYFybUlYdynCAdBE1LTBHZqhlr0AY8UwoNu3S50e6DsoOJwku8ux1A1daa10Pt6SC4cp3Eeac1
	/lDGqR2ImEnE7twEy0vipXV/IpokeWlKQukC8ZoenVx/ZRhrl00QG+n3YkdUTY+Ndb1L4IcL02k
	9rfPSWVIg1tF4E9iYXAu20iWHJFZEle1HhCr5KMyxRFaAbDRGV2qScb56f1rPZ+aM=
X-Google-Smtp-Source: AGHT+IFNxZT0jlR9yhbooKu/YdlqaattPByIZGgYumGniGpCJiVOpkr7M90TXmmtZ8pTmxTuMqvvfg==
X-Received: by 2002:a05:600c:1994:b0:477:7af8:c88b with SMTP id 5b1f17b1804b1-477c01740e1mr25058695e9.11.1763735500637;
        Fri, 21 Nov 2025 06:31:40 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cc231dc6esm3311790f8f.7.2025.11.21.06.31.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 06:31:40 -0800 (PST)
Message-ID: <3fb47b15-ed43-4137-95f8-cee97ab5e44c@gmail.com>
Date: Fri, 21 Nov 2025 14:31:38 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 00/11] Introduce git-history(1) command for easy
 history editing
To: Elijah Newren <newren@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
 "D. Ben Knoble" <ben.knoble@gmail.com>, Sergey Organov <sorganov@gmail.com>,
 =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>,
 Martin von Zweigbergk <martinvonz@gmail.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Karthik Nayak <karthik.188@gmail.com>
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
 <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
 <CABPp-BGLrVv=maEqhs=j9MmST-F=K=XN6gGqmd9Hox5QRDMiHg@mail.gmail.com>
 <xmqqbjkw78jj.fsf@gitster.g>
 <CABPp-BG+2+vanKAS-cwAD2XZxwx=PPcu5OG58ys+8O7rfZEhug@mail.gmail.com>
 <xmqq7bvk77lr.fsf@gitster.g>
 <CABPp-BEyMFiRdHoseTaYG9rUFO6Ta=dBG88CGRb3CfNf8aSAkg@mail.gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CABPp-BEyMFiRdHoseTaYG9rUFO6Ta=dBG88CGRb3CfNf8aSAkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20/11/2025 22:02, Elijah Newren wrote:
> On Thu, Nov 20, 2025 at 12:49 PM Junio C Hamano <gitster@pobox.com> wrote:
>> Elijah Newren <newren@gmail.com> writes:
>>> 
>>> I'm a little unsure if it'll be small or just one reroll.  Some of the
>>> changes for patches 5 & 9 might be big (but straightforward), there's
>>> also a couple design related questions (single branch, HEAD-centric)
>>> that might bring up bigger usability issues to address (if a commit
>>> being edited is part of multiple branches, do we just rewrite all of
>>> them by default, or error out unless the user specifies how they want
>>> it handled)?, and a potential gotcha on patch 11 (how can you preserve
>>> the index and working tree if the user edits the patch while splitting
>>> a commit?) that may require rethinking or restricting that feature.
>>
>> Perhaps.  But I thought the existing patches limited its initial
>> scope small and manageable that by operating only on a single strand
>> of pearls, with an intention to extend to cover more cases later.  I
>> was hoping that we can start small and simple, initially limiting it
>> to single branch, etc., in other areas that require design
>> decisions.
> 
> So, you are referring to the single branch, HEAD-centric piece of the
> feedback.  The funny thing there is that operating on a more limited
> case, without checking and verifying that you are indeed in the more
> limited case (and erroring out if not), risks painting us into a
> corner or providing some really buggy behavior when we aren't actually
> in that case.  To me, it opens a can of worms and makes the problem
> scope bigger instead of smaller.  Funnily enough, the single branch
> thing is also the one piece of this that I think could be solved by a
> fairly small change in the reroll (and I pointed out how in the
> comments), so the limited view really didn't buy anything here IMO.

I can't find that comment. Are you referring to reusing more of the 
replay machinery? If so we have the problem that the user gives a single 
commit to "git history" so we don't have a handy revision range to pass 
to the replay machinery unless we assume we're rewriting an ancestor of 
HEAD or we go and find all the branches descended from the commit the 
user gave us. Long term we should certainly do the latter but depending 
on how much work it is to implement that we may want to go with the 
single branch case at first

> The other problems are independent of whether you try to limit the
> scope initially in such a manner:
> 
> Are the testcases and the code requiring something for the feature
> (ensuring the index and worktree are preserved) doing something that
> is incompatible with the capabilities given to the user (allowing them
> to edit the patch while splitting, so that they stage stuff that
> wasn't part of the original commit)?  Or...is it assumed that the
> split commits always "sum" to the changes in the original commit,
> meaning the "other" patch immediately undoes those extra changes?

Yes that's what's implemented. I think that makes sense for the "split" 
command. Often when splitting a commit one needs to make small changes 
to the diff in order for the result to compile but you still want the 
same end state from the sum of the split commits.

> I'm also worried about extended header handling for the edited
> (reworded or split) commits.  That seems to have been overlooked in
> this series, despite the fact that in early versions extended headers
> were explicitly called out for the remainder of the commits being
> replayed/rebased, so it seems interesting that they weren't considered
> for the commits explicitly being edited.

What headers does it make sense to copy when splitting a commit? When 
rewording it is more likely that copying the extended headers is what 
the user wants but the example of the "encoding" header you gave does 
not make sense to me as we re-encode the commit message and author data 
when the user edit's the message so we're not preserving the original 
encoding.

> And I'm a bit surprised that the original commit message for a split
> commit is automatically associated with the second commit; if I had
> been forced to choose, I would have assumed it should be associated
> with the first.

I don't think it is safe to assume either - we should prompt the user to 
edit the message when creating both commits and seed the editor with the 
original message.

> Granted, I think good progress is being made and perhaps the changes
> needed for the rest aren't that huge (and maybe there's more pieces
> I'm not quite understanding yet similar to the
> two-split-patches-always-summing-to-the-original), I was just a little
> surprised that my comments are summarized by "expecting a small and
> final reroll".  :-)

Yes I'm not expecting any new functionality but I am expecting a bit 
more than tiny cleanup.

Thanks

Phillip

