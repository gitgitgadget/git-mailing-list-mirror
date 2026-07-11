Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985F63C65E0
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 16:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783786294; cv=none; b=h4l56ZC80ZXHW24rK4kfgIEh0hnMX8kTkFw0ERLF6V/a00qzcdT9qA8zGM2tgEa+TR0jCwu1MXXY/8Q6TnsWKooEkPuiuJqU5EKA93omCtRIU6Vub5/0bxZb/YdbsGpxXMsUgblqm9Jibrdz82fat4S8wtAf2Ll1if2S3YPucDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783786294; c=relaxed/simple;
	bh=H6aN/y07p/DD3EgpQyOc7qnMO84rJ7i4R+533ThZUEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m34zJARB8v7Z++ebYYHPY5U47XV2hKC+Wbjb7oOMGZDZp/YHwtXYllBFveBTeOEoAUIrGGlF4y/UElwAwr03QU57U8jPD1m3FOEL3156jCLg03MRy+GNYvUHjKyGwpzwNIoLprC2TxLTxv01JHGNKIXTRYBw6M0bX0X3adFHezw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=DXMc8P9R; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=hXSGMM5K; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="DXMc8P9R";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="hXSGMM5K"
DKIM-Signature: a=rsa-sha256; b=DXMc8P9RqPK4+pSDmIh/OL2qPoGdIUqkTTqQMPpyctBwXJYeFPybng2Z8aaEpaj8JjecZKHYvXotzMBrISTq6xkmYGTkZDKaeUSA9pxZZs3JtF6JAmKD8FN9umdJitFS5ioEFFQy1Yl8ceiatyVHi/ChFzRn67N5DnoSZr54I1MmnNg8Ya+1lOA/D99P8+CZfv/9fl1JdELDxsZDOXPQc08Buk7IbuAZjFkE8Rpvg56las1Zeg/b1Am6fvGKYBIWLcOVDA0OJRWM6pEeQfVNaGWIp3SwEsHgttS2d1osLTExmNdoqnVjVxhwxTVeQt6j7zxhk2APIzgsxtpO6Dmdgg==; s=purelymail1; d=malon.dev; v=1; bh=H6aN/y07p/DD3EgpQyOc7qnMO84rJ7i4R+533ThZUEQ=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=hXSGMM5KGCERFvJi+LaTPApz8UicVzriKGWLvGtlgEh+HzOZoP3e9fJQDta7R4FwsVcmB0F5BB/P9OurCDI8sZou8M5sXbXISLMVuzV4dApRUWFkKw3QeCgN1Hzh47ZuMwaxBH0Hej8K3lMUgonULsklxHRin6m16TifKPO78hsfoQ7QSXGFdhtTT81jSIa4y0t3UFAqABMG3FGx6g4GztNXK2lQjYFU982m5S7J3dkNXUAhCH9zz/NWq/14Fe+XZ9Sf0uzg1YPiBgt2HG1SKbT+NfUthlnWNhSkXhe4BPpi/3EeTTMDdKC7hse0lcqCNyyJ67YMUvT3Ddff8K1j0A==; s=purelymail1; d=purelymail.com; v=1; bh=H6aN/y07p/DD3EgpQyOc7qnMO84rJ7i4R+533ThZUEQ=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 837741660;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 11 Jul 2026 16:11:29 +0000 (UTC)
Message-ID: <a7aaa57d-5250-43a6-9646-d1aa29328964@malon.dev>
Date: Sun, 12 Jul 2026 00:11:22 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/9] migrate more variables into repo_config_values
Content-Language: en-US
To: Pablo Sabater <pabloosabaterr@gmail.com>, git@vger.kernel.org
Cc: cirnovskyv@gmail.com, szeder.dev@gmail.com
References: <20260708160300.8852-1-cat@malon.dev>
 <20260709161145.13349-1-cat@malon.dev> <DJVUGL8XA0Y0.12LN2COXI5BIY@gmail.com>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <DJVUGL8XA0Y0.12LN2COXI5BIY@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Pablo,

On 7/11/26 23:24, Pablo Sabater wrote:
> On Thu Jul 9, 2026 at 6:11 PM CEST, Tian Yuchen wrote:
>> Hi everyone,
>>
>> This patch series continues the ongoing libification effort by migrating
>> a batch of global configuration variables into struct repo_config_values.
>>
>> What does this series do:
>>
>> infrastructure & strings (commits 1-6):
>> Introduce 'repo_config_values_clear()' to manage the lifecycle
>> of heap-allocated configuration strings. This infrastructure is utilized
>> to migrate string variables, including 'excludes_file', 'apply' whitespace
>> configs, and external programs including 'editor', 'pager', 'askpass'.
>>
>> enums (commits 7-9):
>> Migrate enumerations 'push_default', 'autorebase', and
>> 'object_creation_mode'. Care was taken to make these types available
>> to the configuration structure without triggering circular header
>> dependencies.
>>
>> RFC:
>>
>> Commit 3~5. Is it really necessary to migrate _program variables?
>> https://lore.kernel.org/git/8e657184-ee0b-453a-9f2d-a98080d3582e@gmail.com/
>>
>> Commit 6~9. Previous related discussions on 'git_branch_track'.
>> https://lore.kernel.org/git/CAD=f0L-mPX+KECUjXk-WBzEbTP7wCa8sB56GySQT0yh9mfUOWw@mail.gmail.com/
>>
>> Note:
>>
>> Since a new getter 'repo_excludes_file()' is introduced, as previously
>> promised, once it is finally merged into 'master', there will be a patch to
>> update and squash the comments.
>>
>> Similarly, I've noticed that the classification and sorting of variables in
>> 'repo_config_values' don't seem to be correct. There will also be a patch
>> to fix this, and I think it will form a commit series along with the comment
>> patch?
>>
>> Change since v8:
>>
>> Fixed a memory leak in pager.c.
>>
>> Thanks!
>>
>> Tian Yuchen (9):
>>    repository: introduce repo_config_values_clear()
>>    environment: move excludes_file into repo_config_values
>>    environment: move editor_program into repo_config_values
>>    environment: move pager_program into repo_config_values
>>    environment: move askpass_program into repo_config_values
>>    environment: migrate apply_default_whitespace and
>>      apply_default_ignorewhitespace
>>    environment: move push_default into repo_config_values
>>    environment: move autorebase into repo_config_values
>>    environment: move object_creation_mode into repo_config_values
>>
>>   apply.c        | 20 +++++++-----
>>   branch.c       |  2 +-
>>   builtin/push.c |  8 ++---
>>   dir.c          |  4 +--
>>   editor.c       |  4 +--
>>   environment.c  | 87 +++++++++++++++++++++++++++++++++++---------------
>>   environment.h  | 75 +++++++++++++++++++++++++++----------------
>>   object-file.c  |  2 +-
>>   pager.c        | 26 +++++++++------
>>   prompt.c       |  3 +-
>>   remote.c       |  2 +-
>>   repository.c   |  1 +
>>   12 files changed, 152 insertions(+), 82 deletions(-)
> 
> Hi!
> 
> I missed a base-commit to easily apply this locally, could we
> add one?
> 
> Thanks!
> Pablo

Thanks for pointing out.

The base commit is 8d96f09e9245ddf80c1981476fcbac8c4bb4125f.
I will put it on the cover letter in the next reroll (if any)!

Regards, yuchen
