Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B433C29CE7
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 01:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738805282; cv=none; b=ZBugqIdIzAPQve324wWHGVFr0YTPk2yv6rjYBISwU5x+BaLBL0OVP0oVsplztbAlk8g0SogGjqlGf9gAiiaLICzmS9sv1oaT92E0lDrjK8+uYBVeVwb9APUXJjAH7ACdB5Q7S+F1H2cvD2auUYUAisOIIFPdH+C/11jTN1hroSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738805282; c=relaxed/simple;
	bh=I3UsbOKVmjHj4yFHgiR3rhOH6cat0OChVKc86JkO59w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=COvlLZUtNjkGdNe/SdHA10SwaDPqXD6xzjofJCWIoTq7nkne2NNHO5qObMigQCkJxc123GG+7u/4JYo0aLVjuDomYSS/EMeKrLQT+XnARYFmrgzLX7qm8f3d+GW2/MgiY8FygX/CgYCVgPpvwZXJYVb/KAZzZ+ol6KVm5pBRESQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alumni.ncsu.edu; spf=pass smtp.mailfrom=alumni.ncsu.edu; dkim=pass (2048-bit key) header.d=alumni.ncsu.edu header.i=@alumni.ncsu.edu header.b=g/yW94E1; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alumni.ncsu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alumni.ncsu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alumni.ncsu.edu header.i=@alumni.ncsu.edu header.b="g/yW94E1"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e1b11859a7so3190436d6.1
        for <git@vger.kernel.org>; Wed, 05 Feb 2025 17:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=alumni.ncsu.edu; s=google; t=1738805279; x=1739410079; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I3UsbOKVmjHj4yFHgiR3rhOH6cat0OChVKc86JkO59w=;
        b=g/yW94E1b8NB/gamYaPA4htOfCBbnBJ/k0gF+sx4MtFL82kM0s1aAdJ1aokLQjDpsL
         1N2GPrzJbVjr/k5v+N/T2W0AKgNTBiLxnjCEg5bcvLr3WUUZsGSHFHARSaFupW+jC3tq
         LJUZ1HdRP76PDZez9ew1pl8Ovz/E/SX+IkgyTAjb4zGph3TT2ycMweJttJXc+MB0SZe3
         gUgYn1QVMz8HykgcR967xnTxqNnggh6yKJjttL8GJ2EjyROYNGeFuf3DgrRB2VRNmpbS
         maf1dty3Ib5XmW21g9PimhFo9vdIJurQbdMPChhRv4/qR+cuDDCD1WOPJy+CZSWOVX3g
         TtzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738805279; x=1739410079;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I3UsbOKVmjHj4yFHgiR3rhOH6cat0OChVKc86JkO59w=;
        b=cLbOViUupNmkeRv7kO9EC9T77sifvQCN+0Q4PLz0FhwzCZLvctQAnbe11iJXlHa1Q8
         IFGnp0Ya5QfkTpW/hgNoEbH2F7RD80fXhxHxUVIJEzgKqAaPAJwD7O3lpZv3jaY5v4Fe
         hK26jggMHOwOB9s90/1E+m9pi4M7JwURKk27Di2cXwnwJ6MkY/cSQJd5KyTed/tS9yX/
         LDVKB/ZYX7Yx6PcLnmR6fqFegicpUkqv4BbG9VlVo/vDzu/wmFdLCc9MAlSuq9bYJwGG
         unl+Pt3EQsZD98U3jJSEKPzfTsyxlBFCYu+AFiNk8WpQcLIuJzDAQ6XxYoCvxkDte2pq
         cm7A==
X-Gm-Message-State: AOJu0YyD0srfdRMtkoOSPLl/svaJHAnLyKC3ZFklfNCMbqik4Bx8ArZF
	BoIY/ibrh+/K1VULoQONOumKcvGmU6aosD5zEPuX5URpmB+XP4ggfQE94mOFkcRSC4R8iZESx0a
	gDjiUa7qp5B/WneE5HD8c7nTW0NxwLxHbKusMVh6UTW7FxTmPomY=
X-Gm-Gg: ASbGncsKsseMZ1eWNWeS/Yf30fYQVQWk1MZXFQYYIdTizYYYe2NPyf9mj3yIYz3hqSd
	6V3eutnDUSpDcsz1uifZPuWSVU8Myslnm2YdwVVhZxfvWale5GVnH6bL09dR2hUW0KtY5HZyRQg
	==
X-Google-Smtp-Source: AGHT+IGLVJrlNyrOvJrD9JcThakW+Bf/9vRrfEM30pV5EswG/8WgoPd/5B13XFsO/WZMochSYi6QrHa8owjFc4gLufw=
X-Received: by 2002:ad4:5f45:0:b0:6e4:2551:7bd6 with SMTP id
 6a1803df08f44-6e42fc05836mr69431026d6.26.1738805279394; Wed, 05 Feb 2025
 17:27:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kapil Somani <kmsomani@alumni.ncsu.edu>
Date: Wed, 5 Feb 2025 20:27:48 -0500
X-Gm-Features: AWEUYZlRXmAWCk9V_vnV29ys3aNaqbaMDDPz9A3NLgTOfwQVdOmIB4kOS4AcQGo
Message-ID: <CANF_+=4dG7bVF5n+s4ezHR=HneeMgvYNhsOjsz7e7bFapG2f2w@mail.gmail.com>
Subject: `git p4` broken on machines which do not have python on path
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
Run `git p4 clone //path/to/p4/depot --destination=/tmp/localcopy`


What did you expect to happen? (Expected behavior)
The command should have imported perforce depot to a git repository


What happened instead? (Actual behavior)
The command threw error
fatal: 'p4' appears to be a git command, but we were not
able to execute it. Maybe git-p4 is broken?


What's different between what you expected and what actually happened?
The command did not perform desired operation


Anything else you want to add:
The machine does not have python on path
I noticed `git-p4`'s shebang line points to python.
On my local git installation, i was able to update shebang line on
git-p4 to python3 and
the command worked as expected.
With python3 now being default should be update git-p4 to run using python3 ?


Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.30.2
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.10.0-33-amd64 #1 SMP Debian 5.10.226-1 (2024-10-03) x86_64
compiler info: gnuc: 10.2
libc info: glibc: 2.31
$SHELL (typically, interactive shell): /bin/tcsh


[Enabled Hooks]
not run from a git repository - no hooks to show
