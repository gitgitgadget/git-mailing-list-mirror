Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548F52D631
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 19:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmCdBEB/"
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7ACD183
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 12:57:39 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6bd73395bceso98328b3a.0
        for <git@vger.kernel.org>; Wed, 25 Oct 2023 12:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698263859; x=1698868659; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SASZ/r4zO6IplXpCyXINCG5V70DnUIET669TivTiYzU=;
        b=AmCdBEB/uNbm5BnIZnIgNGzbZbRLw3JJT4jiMMwz38SVE3a9xcgzzO9CqAGQwVTMK/
         4ow45Nt/vN+gc2Im3MP4L8OmgWuKkwZmESe8i01Sk7eRfMXIlYqJ1O7b/notr3zBG1e/
         9rxt8u8YQebdwu4Hz13UqQdidGilZ3Gc4wLAh7KRGA3bC1D1hJf8n1Py2Srtj+TEW6dE
         TbsgjqoRFqZOG+yS7E8gRxcOrdmFaYm0kQcj8GGU3Ceb68+jsa296lRfUCuVpnOpfcVO
         KlOicV5ug+d+nfrwgCRoCbbPgQDLTiPVafuk2YjTG5cd2w58CFau0Y6rqt265bep8cUi
         lsWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698263859; x=1698868659;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SASZ/r4zO6IplXpCyXINCG5V70DnUIET669TivTiYzU=;
        b=jVYJn6mu8N/4l0lhSLX41y0QV74IH0TmWzfmgXl7kqm1itzPBhnSNUc9ungXFZUVAP
         qvuj7knM6MBbko2NVLEnnHFPnjGigRlcOtDCW44Tdt40QerAXcZPyN8x9cSwJGSW4S9Q
         JmAKavEZxx1CLwbFDVkO5AO2Z8LE42JT9Jc0idqjlrslsFN/7c/6qnJ/V3JvYC+EYxPj
         BSawpEkhZgfrdHMQn7dVxOdGKto5eKysbfD+MBaskTTf5VP06QJG1IqB+BjR3wqB3lMD
         I7Zw2J8USmLYrFbhvdWEVjK53ouk9A5a1iGB/KMi5I9Ax+NCHrHFl7PWZl0IRPfYH1+o
         rXEg==
X-Gm-Message-State: AOJu0YwrVpuVCc3ggl0rqvPTV+cFB0lAskkLUyABeql1lt2gMCNdqy7E
	ijY7Y7Y8z7Vhxw3WK4++58xpTeFjqx4=
X-Google-Smtp-Source: AGHT+IGElWo+URstVhE0zzuRcmu/fgJvMdaJcfafxdhQl1LHQ0OthZfxUk92uqpvnblkA5cR4LBccw==
X-Received: by 2002:a05:6a00:939e:b0:690:f877:aa1e with SMTP id ka30-20020a056a00939e00b00690f877aa1emr673243pfb.12.1698263858754;
        Wed, 25 Oct 2023 12:57:38 -0700 (PDT)
Received: from ?IPV6:2001:8003:3cef:4901:beb7:1ccc:62ea:5ce9? ([2001:8003:3cef:4901:beb7:1ccc:62ea:5ce9])
        by smtp.gmail.com with ESMTPSA id b9-20020aa78ec9000000b006c0316485f9sm1711643pfr.64.2023.10.25.12.57.37
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 12:57:38 -0700 (PDT)
Message-ID: <39e013af-69c7-4185-99ae-1e8fe5edef5c@gmail.com>
Date: Thu, 26 Oct 2023 06:57:34 +1100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
Content-Language: en-US
From: Sheik <sahibzone@gmail.com>
Subject: Cloning new bare repository using ssh does not respect bare
 repository --initial-branch
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Maintainers,

When a new bare repository is cloned using SSH then cloned HEAD does not 
point to initial branch from the bare repository. However if cloned 
using filesystem then HEAD points to initial branch as expected. 
Shouldn't cloning via ssh also exhibit the same behaviour as cloning via 
filesystem?

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

#Create bare repository
     su - $user
     git init --bare --initial-branch=test test.git

#Clone repository
     git clone ssh://$user@$computer:/home/$user/test.git test1
     cd test1

     #git remote show origin
     #Output [ORIGIN1]

     echo abc >> abc.txt && git add * && git commit -a -m test && git push
     #Output...
     * [new branch]      master -> master

     #git remote show origin
     #Output [ORIGIN2]

What did you expect to happen? (Expected behavior)
Repository cloned using ssh should push to test branch just like 
repository cloned using filesystem does below as configured in the bare 
repository.

#Clone repository
     git clone home/$user/test.git test2

     #git remote show origin
     #Output [ORIGIN3]

     echo abc >> abc.txt && git add * && git commit -a -m test && git push

     #Output...
     * [new branch]      test -> test

     #git remote show origin
     #Output [ORIGIN4]

What happened instead? (Actual behavior)
Repository cloned using ssh pushed to master branch disregarding 
configuration in bare repository.

What's different between what you expected and what actually happened?
For ssh cloned repository test branch should been the default branch 
however master was the default.

Anything else you want to add:

[ORIGIN1]
* remote origin
   HEAD branch: (unknown)
   Local branch configured for 'git pull':
     master merges with remote master

[ORIGIN2]
* remote origin
   HEAD branch: (unknown)
   Remote branch:
     master tracked
   Local branch configured for 'git pull':
     master merges with remote master
   Local ref configured for 'git push':
     master pushes to master (up to date)

[ORIGIN3]
* remote origin
   HEAD branch: (unknown)
   Local branch configured for 'git pull':
     test merges with remote test

[ORIGIN4]
* remote origin
   HEAD branch: test
   Remote branches:
     master new (next fetch will store in remotes/origin)
     test   tracked
   Local branch configured for 'git pull':
     test merges with remote test
   Local ref configured for 'git push':
     test pushes to test (up to date)

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.42.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.5.0-2-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.5.6-1 
(2023-10-07) x86_64
compiler info: gnuc: 13.2
libc info: glibc: 2.37
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]

