Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFA5248881
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 15:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776957357; cv=none; b=FsamP0a+hWa1lEy1MEqEFg7GxiBud0Ntk0+AmV1kkQE/W08DQyVprtDfQ9yuXAoLzHCEMXFk/K68dTgFX8Ky2pIUjYvjf+KAQ83RBpW27HIgfkp0g5nsJ+P8EgTgDA8stL7lPNGHkooSl9MqHZZ7nn5/5yS6eJP2v5XOtRwTQEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776957357; c=relaxed/simple;
	bh=Fi2CQVjkeT79gLehwwU/HlZl6iBH7cwZC+xheRbQQJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WEy3PWI1JEsPoHBVsq/bx1nDgS1OWxhPBaSYknIyDRn+Wcicpxz7XtYzJ/lLXzfoVukIOt/e9TgR/kt0SlZ1Gvf9QtWcCwfmPFs2YMqryaRgOJ4GRtR1j43dbdqJBxbU3erePyZJefV8CckDPJ+VbK6jH0xyLj/AUkrpUQexhIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DeJnkkA0; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeJnkkA0"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48374014a77so88832625e9.3
        for <git@vger.kernel.org>; Thu, 23 Apr 2026 08:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776957355; x=1777562155; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UCU4i8xmy4VQXVs6X5DrYkqy4OgKbey/3ScKG5wMRtM=;
        b=DeJnkkA0UPXT//E8wnRVJEY7bzlEbIzB/EFHByRX8qKyVctqcTgwglEkuG9XfqIzfj
         KSarIZtRO3UGSCTt+wvZ5nJjbVasd7FrIINypMOgKdOhBE0OlIVskmFF+z/UESqqGcRW
         8d0YFiaBHw2uRtj2Dnu8+WL2tqBtuOW9wPWFyIBUUAIgb7lvmq7ZlaPQV98q9rt6Zx3V
         4kc0GoggQyTtBFdmNvCpEk9GvJuiUD7c/n00vwC1mkqQyAjw9YwhzUlFbYvBS3xQ5ZDt
         Cxh9gXu7JofOI5TguWDRSwCP63o9m3W/9fXekfxjZlSe6rhcKenEl+rXWJupa+Vz8BH2
         B3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776957355; x=1777562155;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCU4i8xmy4VQXVs6X5DrYkqy4OgKbey/3ScKG5wMRtM=;
        b=pfJQNSPe6AknaqI4auHuT1iIwP1EzUMOASyJ3sVHpCquMR3+K4geuik2u8DFVHt7VM
         81pfCjnJ6YVjZXeU2muPd9xdN+3e+CoaJTm5wgf6eY8ZUQrJP+/58Ly0kc7SUT8LwUh2
         tLd6fBciMz48NawL9BIJ12E0RUiX2aw/nr2J0q5nFo83mPEtSXT5OF7iOF1ND1PSbqxC
         1IQm/hgUVJq7TGhqpahnk1dOtR48r5O5cCU6ccLQn+PbL+cPtZR799mlSQj1gz/fcHCY
         dMpwBot7iw3Bb8rSI2v6ZIWLyZAZXvXoMUFQyoZmhMd76MJoMKyHquWYrOnQN+L547Pu
         j5Bw==
X-Forwarded-Encrypted: i=1; AFNElJ9aSwE6GCSAZS2canIL18Sq4WkvHzDLPqvoBhyknj7qI1NBHCUzuAZ80Sj5G8WI0sEy2yQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSm4KBaLuO9BUarPmGmXCE0BmwtF5e+LnEBY8aIgY4sozfIofO
	6QR3xlx3nZFsVbhhNRz7vHRIcS72MiIlMFmSH/bEsE4Aqet6j58iRvRR
X-Gm-Gg: AeBDietCqwc+kli94pjg9Kvb3Lmv3A/twt1xD+8Aj7UQqNDxlEbtvDJqoT5F2L8gqPV
	x4mkCtlhAGvIR2yP2GUzqNaVyMw/0snffNfuvSSE9AIewt9o6raELIARJMLZzK9FxSpyDz2yl6o
	bArSfZqaxEfPu2bz0oRwhiAg2Cb7LCi7auMpN0wHFmew99aLqqHhwOIp8ueMESfRcfMTaxDjzHD
	f/2rbzmVH8qup5cyfVf1PagyhoXEt/bbTceIfqug6ixtsXNdNdAmVtH0n/3+hdiZNtav9EpFnyk
	QBmCbJtHwAaF2hDuLd8X7OYu8jxMGp6oDerO0saLajwqdrXY0PnZ8O7HZyqpFhyKQRsRNVLYJOn
	qGpTRXO0UrTr03cnF+zEIjR8VHeo/55E569NCOGo1My5q8zEfLz7XdbXkelq4P9xOFYwA9hQam/
	ARuxlsDXiLRTsi7P/Fd0cYjVeNkmB6tWPx/asfN7rgOvFcyeK2mWyXFtDN/I0Iyue9a1aX/jgrt
	BkLmGtZVnHyaK4SgqSPoqHC
X-Received: by 2002:a05:600c:468c:b0:48a:56d5:16f2 with SMTP id 5b1f17b1804b1-48a56d5179amr167878445e9.7.1776957354487;
        Thu, 23 Apr 2026 08:15:54 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f? ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ffc5e3f4sm286739415e9.2.2026.04.23.08.15.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 08:15:53 -0700 (PDT)
Message-ID: <2abdc8ba-e361-492c-88b7-0c807ee9fb4d@gmail.com>
Date: Thu, 23 Apr 2026 16:15:51 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/3] builtin/log: prefetch necessary blobs for `git
 cherry`
To: Elijah Newren <newren@gmail.com>, phillip.wood@dunelm.org.uk
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.2089.git.1776379694.gitgitgadget@gmail.com>
 <pull.2089.v2.git.1776472347.gitgitgadget@gmail.com>
 <a705852723fbe88e94ad3de1daba548dbce32211.1776472347.git.gitgitgadget@gmail.com>
 <a010a4ad-403a-4b6f-9a92-a33323eca0f2@gmail.com>
 <CABPp-BF4woakYQ5RZ32J8SzDs_VpvT2Wv+Y2WaHTnFnM=96Kzg@mail.gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CABPp-BF4woakYQ5RZ32J8SzDs_VpvT2Wv+Y2WaHTnFnM=96Kzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Elijah

On 21/04/2026 22:28, Elijah Newren wrote:
> On Sun, Apr 19, 2026 at 7:04 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>> On 18/04/2026 01:32, Elijah Newren via GitGitGadget wrote:
>>> From: Elijah Newren <newren@gmail.com>
>>>
>>> In partial clones, `git cherry` fetches necessary blobs on-demand one
>>> at a time, which can be very slow.  We would like to prefetch all
>>> necessary blobs upfront.  To do so, we need to be able to first figure
>>> out which blobs are needed.
>>
>> "git rebase" without "--reapply-cherry-picks" suffers from this problem
>> as well as it does the equivalent of "git log --cherry-pick". Is there
>> any way to share prefetch_cherry_blobs() with the cherry-pick detection
>> in revision.c?
> 
> Yes, you're right; git rebase without --reapply-cherry-picks and git
> log --cherry-pick both go through cherry_pick_list() in revision.c,
> which has exactly the same shape as the patch-ids loop in
> cmd_cherry(): build a hashmap of one side via add_commit_patch_id(),
> then look up the other side via patch_id_iter_first(). The on-demand
> blob fetches come from the same patch_id_neq() callback.
> 
> After poking around, I think the approximate scope of the fix would
> be: Move collect_diff_blob_oids(), always_match(), and
> prefetch_cherry_blobs() from builtin/log.c to patch-ids.c and expose
> the last one in patch-ids.h. In cherry_pick_list(), between the
> add_commit_patch_id loop and the comparison loop, build a temporary
> list of just the lookup-side commits (filtering by
> SYMMETRIC_LEFT/BOUNDARY as the existing loop already does) and call
> prefetch_cherry_blobs() on it.

Thanks for taking a look

> That said, I'd rather leave this out of the current series. The bigger
> picture is that I have reservations about expanding partial-clone
> support further into this area. git cherry, git log --cherry-pick, and
> the default cherry-pick detection in git rebase all exist to answer
> "has this patch already landed upstream?" -- a question that, in
> repositories large enough to need partial clones, I feel is rarely
> worth the cost of computing patch-ids across arbitrary amounts of
> history. The honest guidance I would probably give for users on a
> large repo is "pass --reapply-cherry-picks (with rebase) and skip this
> entirely" or to narrow the range under consideration.

"--reapply-cherry-picks --empty=drop" is certainly more efficient. When 
we're computing patch ids do we do it for every upstream commit or just 
the ones that modify the set of paths that are modified in the branch 
we're rebasing?

It is a shame that we don't have a config setting for 
"-reapply-cherry-picks" as it is easy to forget to pass that option. 
Unfortunately it is not supported by the apply backend which makes such 
a setting potentially confusing.

>  The omission of
> a --no-reapply-cherry-picks option in git-replay wasn't a lack of
> effort or oversight, but a deliberate choice where I'd rather hold off
> (possibly indefinitely) on implementing it.  So I'm a bit reluctant to
> make the performance hazard less visible without also asking whether
> we should even be doing that piece of the operation.
> 
> I only implemented the git cherry fix because of a specific customer
> situation where the operation was already baked into tooling, and
> prefetching at least makes the worst case tolerable.

I'm a bit surprised customers aren't complaining about tools that use 
"git rebase" being slow.

> I don't want to
> hold myself to doing the same for the cherry_pick_list() path, but I'm
> fairly confident the code here can be re-used for those other cases
> and I'd help review a patch from anyone who wants to carry it forward.
> 
> Anyway, you are making the right connection, it's just that my
> personal answer is to let some other interested individual do it.

Fair enough

Thanks

Phillip

