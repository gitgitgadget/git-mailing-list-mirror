Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48A42F5A36
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 12:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771416328; cv=pass; b=Yoo1oj+3q2HndjVu0NQ8WV3mit5nZpvHZm3BL+1YdHZ+pMu2U5SskYTgpMYuPpEj69/AZP9JzrvLJca2E0lJFevYrKypHN9orrR9P4O8hUuv/+8F7u15QQtixdO9IZdyN7wCUAzyRIfAh54CQUGwyi54d7TtdGd6UwjTSDibgcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771416328; c=relaxed/simple;
	bh=pwNrXbDyvBm3ZhyJCz+4W7IYtcPdduvdWvTFxoi4qT4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=jh/BAhlMCpWNWIeFTeK/WhQxppkk4dCm4fRofF8Ep2XAHwwKRcIvzEvrGaFsYEpWS+w/LvR/Be20ARFNNEGtWGEVo87IZBpPnRj3OXT5MH+dt73Eh6/q1LsG1Dnt8m6tQTPzXx4UD57NkomL59UPNz94MsF2sO3MIs4d04WEzLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ktw7xbQf; arc=pass smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktw7xbQf"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5fc456c3742so1149713137.1
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 04:05:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771416325; cv=none;
        d=google.com; s=arc-20240605;
        b=J4Tz/n902gYcX8w3tdkgpXHbYFp3N32ZFduDEnesX9H7g5opsy1oA9A/2vzGXC3iAh
         eZ9Mf1D+e7DCDqPz9g/eLEPvtAnRYTrSW4mlUn2H7G4ZEVZ34IH1Ij+NGtsGHWv0Izbb
         kim3e9c5NEC2iS/b1fnAG9G3bt0BUIpJt73Pm0aPxJoDA3W1HXADFZdqYiTLAyiXibWJ
         pDJvhQBWQrBpmC4e7sGBn2Zqg8bhYg22zeF+hHJX7cOdVt9zD0oGlFvMtK93rjuNtN/C
         osD3dqbV2cgCQ/q1j6prrksKg+3txOh8pKGjuWKSkwnYONRWesHXMDNXDD1Vcx6PFaTJ
         joXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Sp2MLe8iOVggzjUzAaUuMdd5/76aM+kwxv/zZB/10ls=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=b86/un+9gm0bT+4UJjVqb5g50GKxZJ9YUkpOk8hJYVJxQ0hSlEEHPd2Nru9rkqQEgf
         8Ka+N70K+9MoEzZVGaTfLw5uTiekQ3SAlKQm0W1t4uum/Z+iTRSgDW3XhGJPmGdHOomz
         N1lQIFE4vN5zUIXMHxDVOfjUX2I9N8I3up5mQtCsdaGE6e/tHrNAEa/xG4LYW8rGmCg7
         1f6g/p9q5T3+yiywBkgYeS8H9r1tBODvyPj8JR4aV1EuGm10AeORfCIJKmp0FI+gOrZt
         oDFMHF84R8NUw0FELQRNbpTRReqRdsWcSfEgvCQO9c2bKsEMnoWOI4e+R1tA/Mw1il1w
         uOrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771416325; x=1772021125; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Sp2MLe8iOVggzjUzAaUuMdd5/76aM+kwxv/zZB/10ls=;
        b=ktw7xbQf4Qi4snFbONAqhhvallXvYaK97B1KTMsesOhI1e/a8EI9L5os0F9gWB3j5F
         gTTbwtRSbhfJRgvZbriAN/Q52cq7gRdcgz4dJgmejKfjdgSiGT7EZ0BBWld0jpxoexjw
         EPClZbPwaWTRaaXNT8FAPjSpflM36qqpM6Y+TfIaEtc3iEQaUNojaN1VOUZ3mTPD0Fxn
         hw/jTXfN4DnPkMYxCQfYXFU+AdPzPj+pFlWicveM3Leja5dgZ0RziEHql920QmLrN3EV
         ThdK+5gHo3+H5Al36UadN5ECuam3bmiP3gvrznpxiSRfM3iSI+FUkXOqpG9wZHMVAIGx
         ClQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771416325; x=1772021125;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sp2MLe8iOVggzjUzAaUuMdd5/76aM+kwxv/zZB/10ls=;
        b=ims1nq8mzlvpD9MxQnlUEV3xUimQnUWCSQQm1cNdsQOlJ3WW7HE51ozj0EbQTg+io9
         7WnSQPGX4Zj/zK4IqKLgtGFfbDvGQ/lJv5p4dDEF9HpqN51ex63QvuEtm0YwQThItPkM
         ylqQV9LvZWND7+3kNq6qHunNi8ImVTziBrvHj1whQFby8S7X4nupxxYAfPaD9EFOs+Ao
         vqNz9UCP40r/FClvD6iNw6Vc7SuoE8beWxXxSy5OrIvuiYVYlMsRLBvcCkYUVBhlOB0x
         HHJGuwYEozMiU3L6wG8bySCS6iMpW9DpGQGdxC2fOueKjoT2jAwkaY9y4Uy2xmJczwr2
         51Cg==
X-Gm-Message-State: AOJu0Yxp6WN8NuOnyM6D0dn4SCt2LyzzsydTraUjkdeOLZkMOcbCIVCa
	310SCnnO9k28cv0I8DYBQf1x5C3SqqQBMMP0NdY/7S1bd4BIFIOl9FftsWizn39PzQ5ZyLrSC1M
	6Hr/1223auZrn9EBSAeNV0RqO0HfpDLVNvQG9
X-Gm-Gg: AZuq6aKN5oVaKidFrFKBJCadDsUbDBZrXikdC49oqPDa2KkCl1l+GCkDqcITfRRubir
	imxe37M2t90EaYy0aVJt5ouUktfLJXrfTp+Iy/Mb7bNrFqMpbGJZHqSYocje9jIm5NBXdOCbDzo
	0IlM6HY3Y26aWvBb9FAxAbfqEBThwkG8uMVshUZtRvH6EbNorVHcA5/DYK9vIcDkwAYZRm/5HJR
	cuoif5grKSrze2oeWXnuoNDNQrqATscaHoRy1AybLOtgHdwyiX2Niiju3sgJATLSDG8Jxm+tHvy
	F5LaDrNrthZbW78CweEEWs3L85UcCff/3GoxCWMFCvliNzD3X9bCNwrVWSNXW4Mrpvm6bFT+Og=
	=
X-Received: by 2002:a05:6102:38c8:b0:5dd:f9c2:551c with SMTP id
 ada2fe7eead31-5fe7fcab2f6mr432328137.27.1771416325259; Wed, 18 Feb 2026
 04:05:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Cary Reams <cary.reams@gmail.com>
Date: Wed, 18 Feb 2026 07:05:13 -0500
X-Gm-Features: AaiRm52Orxt4uIt2gCGzgTeQo3y-OnsvS_XI8yH9hAEvw__pNwIkPmJqBHVlHLg
Message-ID: <CALT4vkh_t35eJ8oWkSokVzt4mj+cZYxPQCr=gtU5hEuA0v1baA@mail.gmail.com>
Subject: rebase --abort had issues
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

wont be a lot to go on, but here goes. Apologies, I don't have a
precise timeline for you,
as its all running together mixed with a nontrivial amount of adrenaline.

while attempting a rebase, made it to commit 7 of 18, when received message
about segmentation fault and inability to parse the file experiencing
the merge conflict

fixed the file as per normal
added the file
rebase --continue failed
rebase --abort failed
repo seemed to be stuck in the middle of the commit
would permit checkout of other branches, but still displayed the
interim rebase status report

At more than one juncture I received this message:

fatal: Unable to create '...MERGE_RR.lock': File exists.

Another git process seems to be running in this repository, e.g.
an editor opened by 'git commit'. Please make sure all processes
are terminated then try again. If it still fails, a git process
may have crashed in this repository earlier:

However, after removing MERGE_RR.lock and attempting rebase --continue
or --abort (I don't recall which), I received the simple segmentation fault
response with no other messaging.


w/r/t to state of the compromised repo, I have been able to checkout
multiple branches
I have under development and move them to a fresh repo clone (init
from backup). However, every
status command responds as if the rebase is still in play, regardless of branch:

On branch <any>
Last commands done (7 commands done):
   pick 6c706e0f5 refactors endpoints to include element-delimiting comma
   pick 0373d1796 #1680 interim save to do research
  (see more in file .git/rebase-merge/done)
Next commands to do (11 remaining commands):
   drop 5e3a99f46 fixes 0-day enabling facilitator to edit their org data
   drop 428947142 #1680 creates facGroupInvoiceCreate template
  (use "git rebase --edit-todo" to view and edit)
You are currently editing a commit while rebasing branch
'wip_i1680_pass1' on '85bcb9270'.
  (use "git commit --amend" to amend the current commit)
  (use "git rebase --continue" once you are satisfied with your changes)

nothing to commit, working tree clean

Began rebuilding a new copy of my repo. Once I finished getting my
files transferred,
I attempted to get precise error messages and detail for this report.

the status message is as above
checked out the branch I was attempting to rebase
rebase --continue failed,
rebase --abort did not fail
and status no longer displays the interim rebase update messages

not sure what to think, now.

self-healing ??

Thanks for reading, apologies its not more precise.
