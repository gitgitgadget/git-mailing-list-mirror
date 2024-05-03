Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B99951037
	for <git@vger.kernel.org>; Fri,  3 May 2024 21:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714771932; cv=none; b=QJlgzLnMoQXso4fdEPg70JcMoYg43n8JoVJ2fpQgol21eC0MFPMsh5BxRdeIpFx1GnM8ztp3qx9YKGoviWIeY3B0Oj9PC3jJosMBqLxzDd1xBkPfyYKTBg9CpTZgDlkOsGHHD7YYA7noPDEDL2x33fY85psBFRsHomIKBgoJcrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714771932; c=relaxed/simple;
	bh=i3Mgzi40VlfOrMvMdqI0Lwe5byjOqlMoIYR6rVvg4ig=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=BgTnQeXiu0c6RJAZuZ3XTOaPKI5rbK1zMw7PVzlZ5gSuNVJLHL39s0i3C/rBJqo7+Yzf4UTND2ibUwpIdjX8EPWAZPB5OLwZCsiE9JAvMLuAYf/I3UQZI44M5jSBwn7kV+j8yjItA30xah+k/3330E7iIfL5Wmnzc8ELz+LI5B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqLwLkhS; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqLwLkhS"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-69b10ead8f5so848026d6.0
        for <git@vger.kernel.org>; Fri, 03 May 2024 14:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714771930; x=1715376730; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i3Mgzi40VlfOrMvMdqI0Lwe5byjOqlMoIYR6rVvg4ig=;
        b=RqLwLkhSNuZ5ThIvucfx1JegFWoDkWjjdQ5N/mj26Hj6PJvkTWFSmi1H2iQuDHsNN0
         kxzAG667AUbQ8DFmyl+8lYmmRGz9OYRNbL2ebWRTCjQd6YH93GMYTEmakmKAs+NZ1xQX
         6uPLfnUQVzWL85dzelhp2bCUJBNuyqG+JQnOlimWq03fdKG+krH/ZXmN0BXLGaINd6gF
         0flJzGL445R9Jk+kQJFEGyQ1S6EwFuQZajm7wV5Nl2yZps4de8njX3Lbjy1KF9TbJe+k
         DySAPXXmzO4zLljHBilY+UhfxVoXiSnyyY1w9Jf/K90yfTl2jnkke9PXWjpN4RyFJ4Tq
         ZWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714771930; x=1715376730;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i3Mgzi40VlfOrMvMdqI0Lwe5byjOqlMoIYR6rVvg4ig=;
        b=gABfDaWBYUgTr/kwc+40Hz6NBmwbc4lq4s8EXHsDw2lMwA6YdFPG4QotjcYqYXBiL7
         NMVu0m7YAN7LutnO2L16hv+0zZrtf3SGu2aEFUG9VKwlhlzb1eVxbQ3dwFKXdQe7k3q6
         l4AyNPp9tELwckQ5DRqcZVj2XlM4g0TRKAP9BjrdbQexNoidP63Yrl0MoAa8esm4G1ET
         T+eZBfSYYuqD5U+BNBpLwXk2uYWoIgD3Ft4FuzwWfAxOyK62KAv+1GBi9UTK1SlbJReo
         gi3XX4OMOjEX5FHcJvbveOYAI6vGkVbk2eNHQdrMtqBvLNDcpok2kb9mBSa17o9rIP1l
         8Uhg==
X-Gm-Message-State: AOJu0YxrIlC2l46xjxd9EMn8opM5r3M2VcuuXJqFLT4wL6M3TTr6X25Y
	I4bHg4lIZtxAAo9EDxHAnfn2AIC1bXE2JtSkNkMHVx+5ThNg+rRAm2e3lGY6zroc/eVlnadsWLH
	qzMns34R8W6Z+9qiA4bPH32U7y3NUtz/7
X-Google-Smtp-Source: AGHT+IE3I8gGdoUw75h+KMguiUon42BQWY06law/VqTnvRhReZPCLuUPkvmFB1HXIWwUHNgkcdLCM0+7pb5e7+bw2ts=
X-Received: by 2002:a05:6214:212f:b0:6a0:c8c3:7e2e with SMTP id
 r15-20020a056214212f00b006a0c8c37e2emr4577866qvc.1.1714771930224; Fri, 03 May
 2024 14:32:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Simon Thurston <simongethurston@gmail.com>
Date: Fri, 3 May 2024 17:31:59 -0400
Message-ID: <CAKx51amU_c9EU+573RWDc0+w3V2u5TSk+mQhts1gYyKRhxGCzQ@mail.gmail.com>
Subject: [Bug Report] git config includeIf not traversing symlink subdirectories
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
On Windows. Create a directory. Configre a gitconfig file to includeIf
gitdir that directory. Add any configuration you wish to the gitconfig
file pointed to by the includeif path. Inside the created directory,
create a symlink to a UNC Path/Network location. Change directory into
the symlinked directory. Run git config --show-origin on a configured
value.

What did you expect to happen? (Expected behavior)
The value configured in the includeIf path to be found.

What happened instead? (Actual behavior)
No configuration data found.

What's different between what you expected and what actually happened?
Git seems to be unable to traverse subdirectories that are symlinks to
include any git repositories stored inside them.

Anything else you want to add:
I am well aware that while running Windows 11 in a corporate
environment there is likely something silly that is stopping me from
doing something correctly within our Group Policy. However, I just
wanted to open a report in case that something is not working. The
workaround I had to do for this is to regular include the config file
I had written, which is not ideal, even though I am pretty sure that
the includeIfs I have after it should override it. I am interacting
with git through pwsh 7.4.2.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.45.0.windows.1
cpu: x86_64
built from commit: b5d0511969ccd9ab86395c37e5a7619d8b4e7c32
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Windows 10.0 22635
compiler info: gnuc: 13.2
libc info: no libc information available
$SHELL (typically, interactive shell): <unset>


[Enabled Hooks]
