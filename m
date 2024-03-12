Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B14D142636
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 21:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710279386; cv=none; b=halccPtbKY3fBEOcjEzkx+iBT3i8F/8axaJEwGnl1bpJJmEZKexPXGqvXxUiuEaXTEYkghukQJVizKD/BaOE/UB/I8bNgGBI43o1Tja3RCxJgXl7CwoOxOVh5Jz9y6J/w2XcK1zIJas2XsR65wL6KrLZ66DX3dwPNfpYSuu2Ln4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710279386; c=relaxed/simple;
	bh=7Mpjh2O3D9xKr/fI69esBGDAp02QUyH93M1y0MXhOCM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=mDsOgHXXt5+8q9MvEKMN4dOK7UuBgFx3pG8A1NTQBdEFdMeyjqCmY+vXzeraHkCK659/I/8WYT5+COeqIcsZGSvFfAt1rN3SrZV2L4aC/cPmR6yrnN34VGCQqNAINQ7KOG8Db1ltI6IuLGYINXdx+vSewL9nOivqIzfVLCxuhFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJVLtPxB; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJVLtPxB"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-60a15449303so34484467b3.0
        for <git@vger.kernel.org>; Tue, 12 Mar 2024 14:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710279383; x=1710884183; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2Lyelo0+F3sBmw294QRDyOCnJ4y4WVl44nk5n9soFdc=;
        b=aJVLtPxBJzfFRZBDDZ4v+U+2BTart4RK/cILal53gD1au+mTBv2BF329xree6U9MUB
         sFz5znUuDqe9Zryrcm49XSPQINCCnCJhep1pELy3G4c01l6VcWifr58J7ZgYNrftaacW
         ZvOGnVE+iRJPPbBQuHBoUoC0vPKDI8hVcEwvGnq/+veZk2XGwG9W/M41NksOzvvatDyQ
         ijx2os4CPnV020l6odm4CFFx06Uqt1+tzSiqzYo6ZKszPI855krhoLwtv/lpRk85OLpt
         nDc24I3Q/1YBl0Y2ev2+Tj0SfFyzYULwILnLTm94dZR1pRrnoUF+Y+z4vbibSCh90IG1
         +8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710279383; x=1710884183;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Lyelo0+F3sBmw294QRDyOCnJ4y4WVl44nk5n9soFdc=;
        b=Lni0+7H21uia7fHCU85xbziSEupAu+4O2NApu8hoQLUATgW8MMNeIZREJjJQf/bZn4
         Ig+oOFW1sQPWwk+lGJsB2+ERPtNdqY8r4Fao6pzpY4G4oBTXzwjIIY85OX7SL4cyKmM+
         gxET0gf7C6MfnDpaIiZwx2bFtwLXow8y21ORcj2kkfAOwTbj+e0uaABykiPZFbepsEpZ
         VhmTi3VM93DcBP0mBRTcjf+pQJWqmDPLmAHB0xUOaQMwWGdzGUTzTogh+5FFiwRDzrxp
         lauDEfdRNR2KY0QIwy7OnJZmIR0wxEKdfQwNb/zKMVfX0jMhHER81NqLO/nSOIjO1Bj1
         J4Dg==
X-Gm-Message-State: AOJu0YyEej3y82OarY9mXIr8MBYGXwqm16H0E4PxmSt+jCPRJfXlUoXF
	q7ShDvGGEINNT4tkohy+csHVqJzn1JXEHpkwaqgC5CqiEQzFVhS2roL4Plbgu7ZnpVqdXaw7Vjn
	hN0SiAv9x7CFeejLfSz8AkgCvWVK1suXCihw=
X-Google-Smtp-Source: AGHT+IFZGv584Pc9bpfxNrpMgEVPyXVeCpvexUg7DIGqxTQTc9ITSnvSYSPl05ntE9qZweSshwQJ+mxuJ4V1MrcDZaQ=
X-Received: by 2002:a81:5250:0:b0:60a:425c:10cf with SMTP id
 g77-20020a815250000000b0060a425c10cfmr797227ywb.9.1710279383645; Tue, 12 Mar
 2024 14:36:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Nick <billingidentity@gmail.com>
Date: Tue, 12 Mar 2024 22:36:12 +0100
Message-ID: <CA+cJT-HV=GH84p1nQaoywnJABDWDK9PS-StzW8BTEBezHuvocg@mail.gmail.com>
Subject: having issue with git commands. Probably a bug
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Git Team,

I am having the following issue:
My repository has all these files but my terminal shows that they are
deleted. My repo is in Amazon Web Services.

My terminal show the following:

Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        deleted:    Page2 csv file.csv
        deleted:    Page3 and Page4 csv file.csv
        deleted:    dummy demo.mp4
        deleted:    page1 csv file.csv
        deleted:    page5 csv file.csv
        deleted:    page6 csv file.csv

I have been trying to delete these files from my terminal and from my
repository but git commands are not working.

Git commands:

#git commit -m "try to delete csv files and dummy demo"
error: invalid object 100644 d54132721804e177f865b31a807d9fbebc7ff7
for 'page1 csv ps.csv'
error: invalid object 100644 d54132721804e177f865b31a807d9fbebc7ff7
for 'page1 csv ps.csv'
error: Error building trees

#git log -- page1\ csv\ ps.csv
commit c302c5202fc374739c0275b2e507a957be45e6
Date:   Wed Feb 14 22:03:46 2024 +0000
    Added page1 csv ps.csv
error: Could not read 32286e5dfdb73b4cfa9eb87abf140dc81e68ab
fatal: cannot simplify commit aee35d8a1bcde08c2249df029b06d46537751f
(because of 32286e5dfdb73b4cfa9eb87abf140dc81e68ab)

#git push
Everything up-to-date
# git status
On branch BranchName
Your branch is up to date with 'origin/BranchName'.
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        deleted:    Page2 csv file.csv
        deleted:    Page3 and Page4 csv file.csv
        deleted:    dummy demo.mp4
        deleted:    page1 csv file.csv
        deleted:    page5 csv file.csv
        deleted:    page6 csv file.csv

Please could you guide me?
I appreciate!
Thanks
