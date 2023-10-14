Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AC75CBE
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 15:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bL97Qa/j"
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265CFBF
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 08:42:21 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-7a25040faffso130630139f.1
        for <git@vger.kernel.org>; Sat, 14 Oct 2023 08:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697298140; x=1697902940; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VVxM3OJFNEjJoaJVCJB4wRRCs5mkmhwhfE3I6yiUHyY=;
        b=bL97Qa/jhQr2JZeaTn0fDFZvVtAh0Gvd7Yt0zSmkCMccoZGRsAgAJf9ul5hOJ37wBR
         5ExuGNKAVSTJS+OZO8Rh717swb3q9o3xeJW03DX6+5AKsFU8ks0od93gSFzzC35eHL59
         7FKXEKXeqNlis0z0XtuPxj7O8CXeGsD/vRozzMJJAKeUPIQaOGnk8AIwlKbltxvrQDmy
         F5Mh4MgQFA9yD3hDXZZgMWnsw+3vkeQbAlDRtU+GDaNgS1ydTcqUhbmL90Iunebdx++y
         hbNbWu/YdxAlfoW8N8F4Hm0gq1bP3/8pVSLHNbxmnPJWpfOqf60EgRpVPkqUPHpX2agI
         fAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697298140; x=1697902940;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VVxM3OJFNEjJoaJVCJB4wRRCs5mkmhwhfE3I6yiUHyY=;
        b=I4RJEAcJNtD2kUHQbO/V3D88Zleko15qxqraKTarG4RKwDaa3AxRSizD6a15/Uti7N
         0FWETZb6wwntrIu5PdR411O6+eOVzKpeumGPigR0z/Yy//VXrap6LxEoaM0Rsem/8lq0
         rjCEOWXgIlsnkBBFDjsAw1wOl1JjYt0HBWT9aCMo3Cx51uagLemCpE8+0bvvZEuMQ9D+
         MR5KNFs2WyrulF3NhGPFrlxWGWlAUhUMH2vC1Mbf26AwprbwR+Ip4BZ4XDC/dk4YDdru
         m843azvCf/oX9zplWO3iWWUyvIGwKENOBamgQ6gHMMjazhhH0bcmKEhGnJCF45L8Y8ZH
         XQSw==
X-Gm-Message-State: AOJu0Yw4lOdSA33qSnILHUf/XVv76JOsrVlR5d0u01N8C4KSgjsPKE8I
	i298TERAKl7rhTJa+z0WnmuZGgOanhw6iQ0OyJC9z6bcx0MX4g==
X-Google-Smtp-Source: AGHT+IGJXZcoJXG90qtsq3FltRKR8WknP6ePvB41yvM9baZFqlyVZ+tPfhN8piWAsybsZAeLco3AUMI/dmsb6Bk8Zzw=
X-Received: by 2002:a6b:fd01:0:b0:790:c3d0:8f87 with SMTP id
 c1-20020a6bfd01000000b00790c3d08f87mr31915863ioi.19.1697298140147; Sat, 14
 Oct 2023 08:42:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: ks1322 ks1322 <ks1322@gmail.com>
Date: Sat, 14 Oct 2023 18:42:09 +0300
Message-ID: <CAKFQ_Q_P4HvCMHsg4=6ycb8r44qprhRCGSmLQf7B3_-zy28_oQ@mail.gmail.com>
Subject: Bug: git grep --no-index 123 /dev/stdin crashes with SIGABRT
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
`git grep --no-index 123 /dev/stdin` outside of git repository

What did you expect to happen? (Expected behavior)
Ability to grep input from stdin

What happened instead? (Actual behavior)
`git grep` crashed with SIGABRT

$ git grep --no-index 123 /dev/stdin
BUG: environment.c:215: git environment hasn't been setup
Aborted (core dumped)

What's different between what you expected and what actually happened?
Crash, no grep result

Anything else you want to add:
Plain grep can do that, so I suppose `git grep` could also:

$ echo -e "123\n456\n789" | grep 456 /dev/stdin
456

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
