Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4787F9
	for <git@vger.kernel.org>; Sat, 20 Apr 2024 01:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713575597; cv=none; b=QXvXxWht4SbUUcz8lVhyon1jeYijTD2VU8P1fsbzhyqPWISG/dsulDNWP0Yir3oQo12ICfgvIbXZxzy+ulu9O9C05GkklRXEigSpIKleLkmCROhhjIKxwhIMNh8/oGkOf0NzYHbgRZWboURU3npTGUD1BQJyIFEwfjHX6nWYJL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713575597; c=relaxed/simple;
	bh=gFyY54d+LR3CB7qTEpxSyLqPTGyiaM6K4yC8tZ2s8J0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=h2S8wwLUBbnH0zmLWMRNpIvCLeHfXMSBw5s753xa/rjEC8QmKbHCCGGBbmJLqbli/vPsJBZRhyNOLiQ2psbxkau7tOFTKkiYE057n50upg2HFN6WJNjg9ErA8Gw0iSYq/Fs6jbEZ/gKTJtZ7onXKBPQXfG49jcWBs7M+3XOE76o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kpiSlUyX; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpiSlUyX"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-22efc6b8dc5so1611747fac.0
        for <git@vger.kernel.org>; Fri, 19 Apr 2024 18:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713575594; x=1714180394; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gFyY54d+LR3CB7qTEpxSyLqPTGyiaM6K4yC8tZ2s8J0=;
        b=kpiSlUyXsPtLxqXYT+5+8DRVYJjPm94OSTaNut06zaJIkfNslORG/0rqq8IvGzBeBG
         5PFub66PhpKa18Yd+P9Zg/FXtyBfg1o8h9O8T+YvfoP6UtJPmagae6Q3N/SFQCTNnQ0L
         asQe8X0dYxjUeWzm0GqZihlIFQkJdHrYJLxpqZZB9R3tnqoy5r3VJ6xSlkIoMIUTvEHy
         qTOsR9Umq1z06iGce1YBln39+ZwtYfracqtzZF/yxZAfvM+DbkHt7NhMxZTKIAFB4YiH
         nFEpUpcLjy+7i1dfD4w+2A2PlBVLZdKxiqE6Sf6GEeGfon7cCVky2JKgBEYiGzOCaxX2
         FOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713575594; x=1714180394;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gFyY54d+LR3CB7qTEpxSyLqPTGyiaM6K4yC8tZ2s8J0=;
        b=WYi7kztt9TuJ42XhmNjQ/zUiMBQ+nVzFo9upbLHxdHjHbPefcQNN1svMur1CY5UORc
         jGk5+VXp192P9lHVG7nPVvQCCi2b4kqE4SuN+whtJ8imoPp5p7ME+1C+hxPpRl5Z1kBe
         93AdiDbCMTXgM9lAcFJFKWLItPMj2G6lpk81Kmn7Lgrj9eBLdN8QEC9P+SOU3KVqiD/c
         LSnFPs9hUSY1qpPQ8hzHPa7KkTUOWtDHINxqV8Xvuemjexn2t6/9AXIIeetDu9Vd4yZ5
         A1JOKiITjgkJpipfG9lLtQDB9ZerW8AGR4oOp0nwzSQVyKms6Lr8pL3ZJYypBqHlj7uw
         aiUw==
X-Gm-Message-State: AOJu0Yz6xuidScMkpdhdeN1RcXLbV8qWhkB+Hlnu8QD8bxwwr/sNuWN2
	xs6UvN8vIDTF2XkpdDFYsi4KmpgOIcEedJqVTP5dV9JKStRMXKVvLKCpjtU9LWM3POHRfGGBI8V
	6N22yYgTRIcefKXu7oKxzla5MADKLcbEu
X-Google-Smtp-Source: AGHT+IEtbBPOoiJB4lkP124StsoR5838RvTvj9LzCGb/v0L+c7HLLUEnrQ/gGoXXeFco1w6y9q78LTiw4NtiPtZWVmM=
X-Received: by 2002:a05:6870:e99:b0:222:1353:ad0f with SMTP id
 mm25-20020a0568700e9900b002221353ad0fmr4708373oab.24.1713575594550; Fri, 19
 Apr 2024 18:13:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: German Lashevich <german.lashevich@gmail.com>
Date: Sat, 20 Apr 2024 03:13:14 +0200
Message-ID: <CACDhgro3KXD0O9ZdE1q46jmXE0O=vf-Z+ZX50WMqmRHAeowGAA@mail.gmail.com>
Subject: Possible git-diff bug when using exit-code with diff filters
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> What did you do before the bug happened? (Steps to reproduce your issue)

I configured a diff filter via gitattributes to use a custom script that,
sometimes, can change the files being compared in a way that there are no
differences between them.
Then I used `git diff --exit-code` on the changed file.

> What did you expect to happen? (Expected behavior)

I expected `git diff --exit-code` to return 0, since there are no differences
between the files after the filter is applied.

> What happened instead? (Actual behavior)

`git diff --exit-code` correctly produces no output, but returns 1.

> What's different between what you expected and what actually happened?

The difference is that `git diff --exit-code`, instead of returning 0, returns
1 even when there is no output.

> Anything else you want to add:

I have prepared a repository with a test case that reproduces the issue.
You can find it at https://github.com/Zebradil/git-diff-exit-code-bug-repro
The Readme file in the repository contains instructions on how to reproduce
the issue.

[System Info]
git version: 2.44.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.8.7-arch1-1 #1 SMP PREEMPT_DYNAMIC Wed, 17 Apr 2024
15:20:28 +0000 x86_64
compiler info: gnuc: 13.2
libc info: glibc: 2.39
$SHELL (typically, interactive shell): /bin/zsh

Best regards,
German Lashevich
