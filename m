Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3497245033
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 14:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711119043; cv=none; b=ZotD8/c97/ftJjeztPEBgTExUCw8X6xSa4hO3OpXjW1jy/CO/8KSM5QYmiRlsfGm4W9252uGB1/kphi21CF4jCQ0WyGNGwBXtm5G+MumuCZ+NRw0MnuxUyYnheCO4uwwegRTkM3wQLIpTzJ2UoU7Ttbqd80UHZ02k3wQBWGwwKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711119043; c=relaxed/simple;
	bh=JkL/1DcsoumhGxpW/AUs9yzSf5XG2RtxFLkpageIoWQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=d8oog0qQlTwkpfKLAD0siYB/vhhCPs+9o/B8N4ejiPV6IwnXxoFkzMd388ajtP6hW/IX+v99eWH6TmAJBYm4mAbHykPy6I6eXRYCIw7vv4MlgcWyYNExC8GPYzwlP+C6PBxD1CKnbsRL0mVI8tcNdn05QodiLDptxQ+bcvb75Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SR2Bs21R; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SR2Bs21R"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5a128e202b6so784534eaf.2
        for <git@vger.kernel.org>; Fri, 22 Mar 2024 07:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711119041; x=1711723841; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/WMkg75jXEjqonUiId8ScmLoKISk2tAmXZrJrxw9pH0=;
        b=SR2Bs21R2TtuQ5pxtXH1ejr4wI9r0RIMlZMsnMZFbtLaRyBOu9YtkNWkzUwo09lMLD
         AwmZmesdw8eMj9+tMb1K/EdXSOoZXR9aLmj/cUBwB2rGLYmLbldq8DFUnd6pX8VlVZMz
         1TGi/COxjivQ+vYLLwCsGXvRVAjNb2sZhGh1cKEONdIBo3LlMag9CL65t8jMcpt94GbJ
         DuXclE59Q7bo/loFjD0zibHBwF9dlV8wu89kss46jYMa/YT9k7xQzsGacjtcWRGvm4sg
         gaHZHtTmloX9LCk8qPZ5HPlJ5o4sjh5v96+t1qaGpamKueoRer6nIsxCc8s3lbCRWdpL
         r1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711119041; x=1711723841;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/WMkg75jXEjqonUiId8ScmLoKISk2tAmXZrJrxw9pH0=;
        b=PzhQaLSIcqEuWpAVJkXs/w5z49pYCE5PWrimb73mQBR0gzmNfqQxiIBV08KnTm5cB/
         c0C0ptjBR9U4CxeDDO3JLxgwMZtD/APDWBQGPqH2/yue8t1Wa4oMPUttqqcop+CMk5rp
         CD70MSBJHfySCCynotyIA5k/2/K0ykzM4CAdMv3FLol8gJaZcYNBZ/Q9rG9jd0B9kEtR
         ex3CjWkd8T+7tjlHU7fqfJn9Sa2rsGiXhSjhle3UDg43I814GSrMZQibeGfw+fjwab8Y
         pLNYRtz/QIp9pBPAcurI5iCBCm42DGBjtUNcZIVksFrrPfP3uuFUFRq30mJB3jFg1np1
         wiVw==
X-Gm-Message-State: AOJu0YwapR3SR/LzIW+wyiYBSJyrfdWHobqGvLAgNmDFndE6GaTigeQK
	mT099XQoQ/6u7XBpjRZyhg62Gj1HRFMLKY833mvyCXVGiy3wlYMYz2pF0At9f41GZXYhqB/J6lr
	Q7DmLgFUl47OBNSG9UFyMHNfZlHNjHGQMq7Y=
X-Google-Smtp-Source: AGHT+IHh/Phdwn5okGexwb0NyI4x9nR9+54xt6jNoC6YfiB2I7gDKKG2m2G6L8NyJykZP+OfRmeYV9smi4fc0/5FFJc=
X-Received: by 2002:a05:6870:e3d3:b0:229:929a:b127 with SMTP id
 y19-20020a056870e3d300b00229929ab127mr2568765oad.37.1711119041158; Fri, 22
 Mar 2024 07:50:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Bill Wallace <wayfarer3130@gmail.com>
Date: Fri, 22 Mar 2024 10:50:30 -0400
Message-ID: <CA+2m0i8E5Qnj520LXitoE49U_8V17v_NUnrqcRfzHz0cA_ONSQ@mail.gmail.com>
Subject: Worktree shares a common remote with main checkout
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This issue is just to fix an easy to make mistake when working with
multiple remote origins and worktrees, where it is too easy to push to
the wrong remote origin because one can't set the default origin on a
per-worktree basis.

What did you do before the bug happened? (Steps to reproduce your issue)
Used
* git worktree to create a worktree
* git remote add to add a custom repository
* git commit/push to try to push changes

What did you expect to happen? (Expected behavior)
Expected to have the git push recommend a remote origin that matched
the worktree, but it defaults to 'origin' all
the time, which means I need to checkout a clean clone from the
specific origin I'm making changes for so that I don't accidentally
push to the default origin.

What happened instead? (Actual behavior)
Suggests 'origin' as the default origin - which is CORRECT for the
main git branch, but I want to use worktrees to allow working against
several remote origins, with the default being determined by which
worktree I'm in.

What's different between what you expected and what actually happened?
Suggested 'origin' for the --set-default rather than allowing me to
define the origin I want, for example 'wayfarer' as teh name of my own
remote that I have cloned on github.  The default origin is still
supposed to be 'origin' for pulls/naming, but when I push, it needs to
recommend the matching origin.

Anything else you want to add:
This is a bit of feature request, but the reason I'm listing it as a
bug is it makes it very easy to make a mistake by pushing to the wrong
origin for a new branch.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.31.1.windows.1
cpu: x86_64
built from commit: c5f0be26a7e3846e3b6268d1c6c4800d838c6bbb
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Windows 10.0 22631
compiler info: gnuc: 10.2
libc info: no libc information available
$SHELL (typically, interactive shell): <unset>


[Enabled Hooks]
