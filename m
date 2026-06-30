Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C242BD00C
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 16:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782836468; cv=none; b=TNPzHPWXsGZ2v3Vexl3l1/PY1ZVhn22aOUp90oGvjE9D54rcLwnPAHn06NAOBotTsJgZWr8UJH/hYiOY7v/xzeEA92BBvmLDsr2N2PUZLCNbWqVk6CQ5Ti4nzcVDW9GDSy6MFI5RO5KjXYwS9l3KqgHNK7TvqBQFNcGgBu3oX70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782836468; c=relaxed/simple;
	bh=rgg1zdwx9U7hZdhCZHqLjm5Hvv1K3PEuSWcSJKG5Zw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k0H9+4QrAA4BwlKvxaw/ioyWAO9ErpfWW+0uLp9jIcvsbubIWdrKPTFv5xlsMuT7Gegc6wPa+vSINcc8/y7gf5tPbsBgGuKt3Vt+UDI4SHaxY/YaLeIhsnFnj3EFj1eK5HO61YUngZkBvP0W73PIml4lbyf6cXT8lcTql6KXAaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=G/jVdyDx; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=NSvnThN1; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="G/jVdyDx";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="NSvnThN1"
DKIM-Signature: a=rsa-sha256; b=G/jVdyDxVEOZOoK+ruf98De2D2z3JmjPVIP2sS9bt4XECuHLzHBcMmuD4t5BICsql31xV8L0MgufEivrZZRcsRaw9I6vd4WIhxlyKMhlkp6zPYPAOFsIMVY7XKDluyS3xJIaWpfkNGxGKkM0ZsDdRQHjz8bs0ij7C89WbqW72u5WURwt0FyZWEfbQMTo4L+AXUhEpoEfJl1367sB7Cno896hGerW9ws2mHWwlvrF4aIOmYILbEu57aAi1cM5kQbIoaTdD4Tg01tAzWVEJ3fCjXXp00X/jMir5TcjZYUlKtl+jAJV4ad4bPPcf6dJIyT0qyD1pe54R8h/hZL/cEP3uQ==; s=purelymail2; d=malon.dev; v=1; bh=rgg1zdwx9U7hZdhCZHqLjm5Hvv1K3PEuSWcSJKG5Zw0=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=NSvnThN1qkfRhZ4yM2g/SZslgEmAqCx+dL8Aqo5fkV/PbozRyFaWpmvBAcx69wjy7sMM20aCWCexhiUoNZS6Ji41+wo4JP6m06jxKCTfmrnh2AsErr/pfDJzH/dgKQ/MnkZJefD7TbGeDUVnwfKTdYFfxeL8mYNvCJCnjtsRLfxA0IEk5FWdCe08XH8QQd+oHqzV6GL9CQ9WC9kLLBR9Gfsh0U5iJCm68yhA2J5dLP43dxPdBzxJt/1dddYsKXv8GROi05G7j6+J1zgjLIF1j3EexKzGKmHZl8WRgecWxajYVQ05KpPkEmUSaQfhFqKl1WD2/TG/Wp/K6EnVbrNKCg==; s=purelymail2; d=purelymail.com; v=1; bh=rgg1zdwx9U7hZdhCZHqLjm5Hvv1K3PEuSWcSJKG5Zw0=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1894788807;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 30 Jun 2026 16:20:47 +0000 (UTC)
Message-ID: <054b3fb6-0e69-473d-9778-b1b11ea82b3a@malon.dev>
Date: Wed, 1 Jul 2026 00:20:42 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] environment: move excludes_file into
 repo_config_values
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>,
 Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, cirnovskyv@gmail.com, szeder.dev@gmail.com,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Olamide Caleb Bello <belkid98@gmail.com>
References: <20260626075037.532164-1-cat@malon.dev>
 <20260627160813.1074201-1-cat@malon.dev>
 <20260627160813.1074201-2-cat@malon.dev>
 <04d1a7d5-ef83-4728-b816-5cdf1cb4aa25@malon.dev> <xmqqv7b34snt.fsf@gitster.g>
 <eabb8169-2c13-4961-9b21-f44b1fa66f70@malon.dev> <xmqqbjcv2h3j.fsf@gitster.g>
 <18ad7c1c-5ddc-4f62-ba7c-5cda53f5a48d@malon.dev>
 <CAP8UFD3Z0M_1NEXGcAxNZKpRUQiSkHZLTEvNNYushKA_PoPgjA@mail.gmail.com>
 <xmqqbjctz9mh.fsf@gitster.g>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <xmqqbjctz9mh.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Christian and Junio,

On 6/29/26 22:47, Junio C Hamano wrote:
> Christian Couder <christian.couder@gmail.com> writes:
> 
>> I agree that the best end state would be to have no `if (!repo ||
>> !repo->initialized)` check, but we shouldn't have to get there right
>> away. I think it's fine to proceed in several steps:
>>
>> 1) `if (!repo || !repo->initialized) return NULL;` allows us to remove
>> the global variable and use getters which will help us in the next
>> step.
>>
>> 2) `if (!repo || !repo->initialized) return BUG("repo must be an
>> initialized repository");` now we want to find and fix callers
>> (including tests) that haven't properly initialized things.
>>
>> 3) No `if (!repo || !repo->initialized)` check, as we are sure that
>> all the callers that didn't properly initialized things have been
>> found and fixed.
>>
>> So I think 1) is fine for now as long as we properly explain in the
>> commit messages and in code comments (maybe using NEEDSWORK comments)
>> that we know there is more work to do on this in the future.
> 
> I am OK with the progressive improvements, but if "wean us away from
> global variables" topic stops at step 1 I would have to say that is
> a failed experiment.  Not doing (2) means you made the system bug-to-bug
> compatible from the old world where these things weren't in repo-config
> but were still globals, which is code churn for nothing good to show
> in the end result.  We need to get to (2) before declaring victory.
> 
> But of course, we need to start somewhere.  (1) with in-code
> comments sprinkled to such places that say that we'd need to revisit
> would be a good place to start.
> 
> Thanks.

Thank you both for paving a clear way forward.

For the upcoming V5 patch, I will implement:

1. Revert to the shields ('return NULL' for the getter, and bypassing 
'repo != repository' for the _clear()).
2. Add 'NEEDSWORK' comments above them documenting that these are 
temporary changes.
3. Update the commit message to reflect this.

Once this initial migration safely lands, the next goal will be to 
investigate those failing CI tests.

Will send out V5 shortly.

Regards, yuchen


