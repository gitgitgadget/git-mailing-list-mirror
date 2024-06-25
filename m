Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD21D158A23
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 22:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719356081; cv=none; b=Lwd4WUkpWJ9i7gDyP8zfyTnztK/R0DRu0jJabkVKyx09b55np4PB6Csta47p4mR+aZFVShJ9VMmnymkgtc6unYeYHxQzyduv6tIH/k9o4BMbEgNNjCfjJOAmMpc+PWnbGBU4Ha4vmJcoA2F6KZsc6dajHIHsQrdmaxYN0EOlGU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719356081; c=relaxed/simple;
	bh=0IKkYirQ7xyyWFpqeoySr5ki1UqJm/jmAdMicqxgb+A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=PwD1htXZYKs47A4SpCLGlxR4/rTcGzH2joFtOaDizC64yJUpIMYNweCaxrVJrCWmVIJoKuaRBWyBL8qs/I0NCqULjhQPD0LlJmc/Wvkwp02jKkDsDQ+sARt+N50hXoi908QoQA+TKVyoJkaYLq3u90umR5acjZ9exUPqQFfkU4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nhTzpXHk; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhTzpXHk"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a72510ebc3fso418495566b.2
        for <git@vger.kernel.org>; Tue, 25 Jun 2024 15:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719356078; x=1719960878; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H5m+6Doo23c2Y7gZibnIT3gDB3J1jTp9aYQKstk5uzM=;
        b=nhTzpXHkIG5Z91efs+sjufOfr1ZBxddtJccmYj5psWqRCNc5X61hbpu+iXhnc2Tylk
         6KcRHpVeNsfsL80q/fk9lxkXpQpKbLNaLaqHd7Mg2hcbojre+rmMv+WXVJjpDJQaHC26
         dVlJJAYtQ/PbWrWu+7IVNxPCUJv/ALCMmU5bursfzQfXm9uIoPNltJyOKCNR1NIBBbd8
         ZE0rr+KrHI7gMWMR24ntBfUqxANClNhc7o8dy3+UTAXR4WYJ52kCiUouceoc3VxkAq7h
         je1QPIbJToqQ5gPDyYOYOgYrH+MSx2K9NSxf/Qw1XCocl7+qkNFK/EWRGE5NsvWiicod
         SipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719356078; x=1719960878;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H5m+6Doo23c2Y7gZibnIT3gDB3J1jTp9aYQKstk5uzM=;
        b=AWfngH6CwdUP6Wt1NvQcPFaO5Wate8IMlwjEMNMI7wrBqftITaP7xEri3SztfiaTQC
         BkON9XHizeAqySx+h2/xof6GXIOYx534/eBIQYNA3Sf/IBuwdoHpptozbqhuNEGn5ebo
         glg42vxm4pM3s11SsqwO/kdV2bY2uR6HACoWcrn2ZdHjrJYgsEAnmgpr0VOTUd/LjDpw
         Bb8m5y774p81N5MbkDwk9OMcIw9dqsqu7Z0kZUpvyhinxETP87Yo48i0okNSi0lPxlx8
         TNBZCvf7T1AzQo2dwzyHTDype/gwtojBkswUuJGrEkO9Mg/LY4amzn3RmY0O1T8h2Mf1
         BeVg==
X-Gm-Message-State: AOJu0YyqMV3mcrrxRkdM05l4zmKKj6MvBHCS83hFuru6aciqw0IwVdxZ
	cj7/wxmZ/KqpSthVGEQ3Qvoh88x6T3qbnw45sNiCj+UzslpVTcDv44rTD00Zc5X9/HVq8hgOXYY
	MSonqF7y7W/el3YhFjbaUFad2695su8KryAs=
X-Google-Smtp-Source: AGHT+IHrRfi3KK4iMqnWy/sIa/UpVoda1dtL6aHvLR9cMBe4UitvWYME5WYr/vIWzL4jo6qMY99/s0Gj7dUDVbOssas=
X-Received: by 2002:a17:907:b19:b0:a6f:4b5b:4ba7 with SMTP id
 a640c23a62f3a-a7242d2a239mr638267166b.67.1719356077530; Tue, 25 Jun 2024
 15:54:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?SmVwcGUgw5hsYW5k?= <joland@gmail.com>
Date: Tue, 25 Jun 2024 15:54:28 -0700
Message-ID: <CA+osTZWaDpH_ZcEhHKrzcaWmHjTAiiWfPmf6C9u3NnzmY0PghQ@mail.gmail.com>
Subject: Problem with multiples levels of submodules
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi there,

I'm seeing a strange thing with multi-level submodules.
Not sure what's going on, but it feels like a bug.
(I'm doing this on git "2.45.2.windows.1").

For a while, I've been globally setting the recursive and active config options:
    git config --global submodule.recurse true
    git config --global submodule.active .
This has the benefit that I don't need to "git submodule init" new
modules since everything is active.

The weirdness happens when there are submodules within a submodule.

I can reproduce it by just creating 3 git repositories (I have only
tried with GH hosted repos, maybe its different if done locally).
Each repo has a directory within it, and that directory is a submodule
of the next one.
    top -> middle -> bottom

Now, if I don't set the global config above, I can:
    "git clone --recurse-submodules <PATH>" to get everything.
Or:
    "git clone <PATH>", "cd", "git submodule init", "git pull" etc. to
again get everything.

But if I set the global options, I can do:
    "git clone <PATH>" to clone the top level.
    "cd top" to go in there.
    "git pull" to update everything, including submodules.
But while cloning "middle", it gives me an error:
    fatal: not a git repository: ../../.git/modules/middle/modules/bottom

Something is getting confused and thinks there are worktrees involved:
    ".git/modules/middle/config" has "worktree" line in the [core]
section (this appears to be normal).
    ".git/modules/middle/modules/bottom/config" is not a repository,
but just a "[core] worktree" section (definitely not normal).

This all works fine if there is only one level of submodules (top->middle).

Any ideas?

Regards,
-Jeppe
