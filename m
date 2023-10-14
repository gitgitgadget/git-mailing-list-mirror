Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CED10A2B
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 11:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZoUA2W8y"
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEA9AD
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 04:59:54 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-7a26fd82847so117230339f.3
        for <git@vger.kernel.org>; Sat, 14 Oct 2023 04:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697284793; x=1697889593; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SxzhnnL/VfHsTel3VyubTxVU6TGJ4pLtExy8cdzzIAc=;
        b=ZoUA2W8yhFtR3dQyWk9rbWAy+dyWOLz9EzY4v3s53eOPS9qmzCD2UwVTUeRL8ESShs
         WLBzRnUwoupDZXgE8+9LWrLbJRMCdrZ2b0qeU0G2DISQf5jjP+QFK9BeY3d0LmpVuHpR
         mnGWNhew/sE3O7kvK21HRlPhs210//JXHXPctG0DzEEi9XEBLMXo+P1IQdSz42EcvGpd
         MUgwl3+tc1YVmQXHRuvMLFE1zVDWid3/g7K2tGc24QTKXldfp42TObMkPOQEv23qd4gC
         1W0PzWIjS3WbK7C/iTOfpNwbF080Ego9XqhB37POU11AjcKb9TuHFHlskzK77aOGbJ2U
         PhAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697284793; x=1697889593;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SxzhnnL/VfHsTel3VyubTxVU6TGJ4pLtExy8cdzzIAc=;
        b=vF1Pb31PoO9A+OEcL7TnuAuBUBfGdqT9rhbG6AsaCbvYJiFCMSM0UVr7CmJMpud9Fm
         SLYu/pYkjcWXYzUNxeZnCc25ch1rX7PbfmpI1yHjUC+uX/Uxmxls+Eq5CP1UNAwIMJ+b
         4Yts/4tBdwxRe5Ut89JoC73RYn9udaZQXeLgTcDVCQzou7JFbFJg3vy7i2I7MOOZo/Zx
         9nVls2y+z2ZL7pt+vPgsbNzepaL/CL5kzq0qEu002Fha8ondZVCtAxQ3iNJMu86U/dku
         HC8nw/wfevScuIZssSNqT1QWl/eYv4AK+WaNXgS5pjkI6XsDx466mqELnqiWsMrQnfa/
         0qFQ==
X-Gm-Message-State: AOJu0YyWBhYiSgQY6PqW8zOvWrAOA+C9+CT+Khw6K0arsum2u6anO+ZI
	udatoEEY7pqIBNve1JwggLglvSwNk7NBSMJodKddh3Rma5M=
X-Google-Smtp-Source: AGHT+IF6EGLOh6u/3IyInsZ3daGapV/8OhzlYyZT/f5cnNcb5Bp5CxH5e0yz0TmmaI/+V+4lmPAu1Rai8+Rggivuihg=
X-Received: by 2002:a5e:8e49:0:b0:79f:a36e:bd1f with SMTP id
 r9-20020a5e8e49000000b0079fa36ebd1fmr31558295ioo.5.1697284793332; Sat, 14 Oct
 2023 04:59:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: ks1322 ks1322 <ks1322@gmail.com>
Date: Sat, 14 Oct 2023 14:59:42 +0300
Message-ID: <CAKFQ_Q9WjF9i-Rx2jdCw-adPVQrWNfNKrDY-em8Rpa5RNLXz4A@mail.gmail.com>
Subject: Bug: git diagnose crashes with Segmentation fault outside of git repository
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
Run `git diagnose` outside of any git repository

What did you expect to happen? (Expected behavior)
No crash, reasonable diagnose output

What happened instead? (Actual behavior)
`git diagnose` crashed with Segmentation fault

$ git diagnose
Collecting diagnostic info

git version 2.41.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
Repository root: (null)
Available space on '/tmp': 7.75 GiB (mount flags 0x6)
Segmentation fault (core dumped)

What's different between what you expected and what actually happened?
Segmentation fault, truncated output

Anything else you want to add:
`git diagnose` does not crash when run within some git repository

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.41.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.5.6-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Fri Oct  6
19:02:35 UTC 2023 x86_64
compiler info: gnuc: 13.1
libc info: glibc: 2.37
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
not run from a git repository - no hooks to show
