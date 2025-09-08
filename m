Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBD430CD80
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 15:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757344968; cv=none; b=uNsCVFVOSQ66gqdMzHycCBdZF9TGBP+3vFFJ4tQaFxc3P93R/gqYA0nYv4myDdDfpF/JhdJf9LUWGGKl6FDhBBS/+i83Iy5mZqk44eXr+UGL9DuCwuMe3tS8c9XRQZYQtqp1jMMkC5yEBp2d7czkttekhjTEfGvbaiRPJlDfqRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757344968; c=relaxed/simple;
	bh=hhpsnw2XojzgDs1jYGz+Dc+3SudkndrySdyHRysDA9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G1wt2XBS1QE1I3jNxSeDikxMWvKAKDzMgBKyGt0ZGRCDvHeqpAjhFMzaL+GBNgFtN4LrbUiBjG8oX4mI5QS/K2kPe/O2DDn6oRgJCdZSSovXzYoH23iUMhvJVUTt/KCIk/hsjZOZBBdA44ezkTuRYs2s5+t5rZ1C2Fq+SETSPbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=erQL9kpa; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erQL9kpa"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45debcea3aeso2778115e9.3
        for <git@vger.kernel.org>; Mon, 08 Sep 2025 08:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757344965; x=1757949765; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QKNMBIIz7UIYbiRimT3o7VQa3JVtpH3c+pc9Ra9kiPc=;
        b=erQL9kpaeptclmncZHeMQiRdSGAb97lG6RAh1yUEbP28VJR40PK23nAOWNaHltW1Rk
         JFsmrrwtPhZirubR8NYvUt7hXbWEN4dFgALN/g2ZeThmHsjysssrQYix0nKcWhGddkCL
         bcKQiDXVnOLAsnlVVqEwx2oNOnA252UY/gON04Xvmg29gS9aajc21tZ32nYptF7cNe3O
         SjyzDVrzXtA5KcNgBh6FeQJQSqLwMZwanqSccJf0NepbZFsDtrpJJ13Er3buOmr4EMRU
         5s+oocHe7lUSMOB/aXtFNkxnGasjfnJZqIKMCdaTZIjxO1RtJ4iWufCL1l3TO42mqWPR
         CVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757344965; x=1757949765;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QKNMBIIz7UIYbiRimT3o7VQa3JVtpH3c+pc9Ra9kiPc=;
        b=AgNKgSaj9kPT3zlCP52DHyUPpbJPrLUVguwZ66rAEcl4E5W9L/Sce9AuVccCH463Ak
         EkPvPUiwdN9LZU5QsEeW592dU2Fxzjf5nbkXr6HHHDQHeEO2VCdHKxB+F8PEfRAtDXCB
         jJqmXdwS8R6sZyIOeWSoB/7JpjU2jQ0FCGAuIlDSALrtbqJOHdZF7pE+bXUhOxlKKTY8
         yw0qfarKo4p7xH7OiUvy5N7vg5nX21+IQDHYkGuE3AO3iMO2O2qwW/UMgHnLVR1DlCPM
         JSwWXDthwOlubm5Bd+j33Cc2eYZG1n3/kthd1UEvrcHWc4cYYnboxrC0kG1MjaMtq+0a
         9dGA==
X-Forwarded-Encrypted: i=1; AJvYcCWR91sfkhK0XanoPMUBciQ1D6KuSJqnDpqbRYQr/6OvXkDut8rbsoxk3gS//pJDJF+pmOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyezTrhOpyX4GnMI8X1/S+NfpKyK/KPn124ppbIl2Ke+9DBtPOG
	6MDOo0Nhkta0zVVsB7msEuNF3SiQ1G4I0wMKbh2zuiZ2mdyuv74odmxHPNE3yw==
X-Gm-Gg: ASbGnctCWvOJ84vnMFhLGA8HK5jCr7yAt8HkSKQCMNtRK5TD8k2CHksV0VoTfydHJmz
	NseAz7i25O817tXz5/xHfremJdDymQ1xCh3r24N6CbTtE1CbEIH5Uw7t6qCXDr93uTPJawWMKH3
	GieujGuHBrNkcx+iAImAaTU4BhHcckf7ghXiHBahkv2wqJmVtwIkpNcCSkBNeCIE82BhSB0kSZY
	fpQ3zQylVo4eciC/9sze7P97YQPZDBJbh2jaevPAxTqDygQYgeNack8naUYlrN8svo2MT4wc3A9
	hhBVvQgtT+5chinnm1zv+/yMJCdytEwE4pw5hNlfETQ3tudF3cWtD0FdtHlj3jLEIIblLQIqKPe
	e806C09y5IW7dcHfKToXZu6WuL6STM7rFzKGhDijeWjPV+IYs8gxiu1j45ObVH35T0BTFDEJg
X-Google-Smtp-Source: AGHT+IH2YXZFqA59dlsC0HXfecef1ZR3h9jjbGim08Wj0GrJYH9w9ugeiMnS5nKqOcLm173eoZ5UmA==
X-Received: by 2002:a05:6000:2584:b0:3ca:8031:4b38 with SMTP id ffacd0b85a97d-3e62a211cc5mr6015470f8f.0.1757344964813;
        Mon, 08 Sep 2025 08:22:44 -0700 (PDT)
Received: from [10.0.1.102] ([81.194.30.237])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45de16b8b58sm95094105e9.4.2025.09.08.08.22.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 08:22:44 -0700 (PDT)
Message-ID: <e6003a2c-bc1b-4cf5-aae7-ef5aa9c82f10@gmail.com>
Date: Mon, 8 Sep 2025 17:22:42 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/11] contrib: remove "git-new-workdir"
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Patrick Steinhardt <ps@pks.im>
Cc: Matthieu Moy <git@matthieu-moy.fr>, git@vger.kernel.org,
 Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>,
 Eric Sunshine <sunshine@sunshineco.com>, Todd Zullinger <tmz@pobox.com>
References: <20250512-pks-contrib-spring-cleanup-v3-10-32e151b0bfb0@pks.im>
 <5580aa89-09f1-426e-8483-c99481c998ab@gmail.com>
 <2b3c951b-0400-4cc5-b790-17ff77154ec2@app.fastmail.com>
Content-Language: en-US
From: Gabriel Scherer <gabriel.scherer@gmail.com>
In-Reply-To: <2b3c951b-0400-4cc5-b790-17ff77154ec2@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 08/09/2025 11:58, Kristoffer Haugsbakk wrote:
> On Mon, Sep 8, 2025, at 11:28, Gabriel Scherer wrote:
>> Dear git developers,
>>
>> I find myself affected by the removal of the `git-new-workdir` script
>> which is a relatively common part of my workflow. I am writing to ask
>> if it might be possible to reinstate the script in `contrib`, and also
>> possibly create a discussion with other users affected.
>>
>> (The removal of the script was released in git 2.51, three weeks ago.)
> Did you run into this issue when upgrading from 2.50 to 2.51 or from an
> older version?  Was it simple to troubleshoot that the script was gone?

I create a new workdir by manually running
/usr/share/doc/git/contrib/workdir/git-new-workdir, so indeed I
quickly found out that the wordir/ folder was gone and this was
clearly a git-side packaging change.

> Just curious.  I’m as naïve about release management as any
> random person!
>
>>
>> Thanks for your work on git!
>>
>>
>> ## Details/comments
>>
>>   > The command thus predates git-worktree(1), which is what people use
>>   > nowadays to create any such working directory. As such, the script
>>   > doesn't really have much of a reason to exist nowadays anymore.
>>
>> `git worktree` suffers from the substantial restriction that it is not
>> allowed for two worktrees to checkout the same branch.
> You can override that restriction with `--force`.[1]
>
> † 1: Naming override options just `--force` has some UX issues like
>      discoverability and the fact that (in this case) it is used for
>      multiple orthogonal things

Thanks. I just tried this, but I think it does not suffice. The --force
option is available to "git worktree add" to create a worktree for a
branch that is already checked out. But typically my workflow is to
create a worktree for a new feature branch, and there from that worktree
temporarily switch to an existing branch using `git checkout`, and there
I get a hard error (if another worktree has this branch) and there is no
--force option to override the worktree limitation at 'checkout' time. I
just tried to test whether worktrees created with --force would allow to
switch to checked-out-in-other-worktrees branches in the future, but
that does not appear to be the case.


>> I understand
>> why its designers felt that this would provide better guarantees (it
>> is not a good idea to mutate branch names that are checked out
>> somewhere else), but checking out various branches to test them and
>> inspect their code (before returning to the feature branch I am
>> actively working on) is a common part of my workflow.
> I agree, that’s a great use of worktrees.  But I never feel like I have
> to checkout the branch itself.  I detach on top of the branch.


I'm afraid `git checkout -d` is not part of my typical git workflow. I
could retrain myself to use it, when I get into a worktree error, but it
is cumbersome to know of this new complexity¹, and various things work
less well in detached state -- for example my bash prompt tells me in
which branch I am, and in detached state it only shows the commit hash.

¹: it would be nice if the fatal-error message on 'git checkout' when
trying to checkout a branch that is active on another worktree would
suggest using `git checkout -d` instead to proceed. I may try to send a
patch to add this information.

>> Getting a 'fatal
>> error' because some other, independent worktree also checked this
>> branch out is a hindrance.
>>
>> Note: I don't know about the `worktree` implementation and whether the
>> [snip]
