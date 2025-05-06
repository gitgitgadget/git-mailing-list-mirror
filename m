Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814C122D4DF
	for <git@vger.kernel.org>; Tue,  6 May 2025 21:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746567410; cv=none; b=aRhwmnRF72uPQbl40jAxrz+asfqOZBR1dA9qJIwv1YV5atJNgzEgK3evZQQJmfmvB14lA+2ZEAeXV9lts0Bb6fRbe34HugH4EX3lIH7DKplMOlqBTl4jRHAssDHcg+P5dxgHiuru8wUpzb0UQTaPwrLIYwXjRnKtvnaY206i+Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746567410; c=relaxed/simple;
	bh=zcBLetiXM3rgw2ibgeUJJysrq9k1FW2HS7/l/gr1OQU=;
	h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type; b=eODMGVsz09+NF5HEewAlB8sx/kygtaT6MObyGleQcHtwVtHiP8g4/z+wpKYBV4RXi8z0jz5igLro97WloZxS5R/BMF8YfGS2KVPxnwmx5SvYpd2ovm08+1qUpWOCK2H3mX2/D2LoExKNUWb0mrMsLYZiTd88x+L23S7yxgvMXRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajCSnCz1; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajCSnCz1"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3d9327d0720so48829695ab.3
        for <git@vger.kernel.org>; Tue, 06 May 2025 14:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746567406; x=1747172206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:date:message-id
         :subject:from:to:from:to:cc:subject:date:message-id:reply-to;
        bh=w4tq26Z3kHfID0JnZldUQ3zac3uBb50D6yax+Y4A41Y=;
        b=ajCSnCz10iDF4JgbtNbrxHOOmqKA0yMB+uzKHoYfUcFZFktC8DjZg00xCfoJXXMYY+
         w3GUJOYuf76MNBriAlZSg80CFkJQG4lEerErRQhPiEWUdEePpL4Scs75e/IDaEvsWfHk
         dWD6DLQ7RNHSjC5FVM0W+os33Eas0WWdp5vOYxkLMWPJCeRy1KvBnCfrGEGo2qfK3Am+
         Jri6H8qqpr9ExTMhm97alDsdBU169D7KO3y9CzRlMHNQoDQZLAKEVGYqlU/qPFtd7D8C
         jAVTYhB9/DJf7NwfTw0yAf3y5FtQ5RJB2t7topv523j4hLfxLAKgS4sgy3R6C+ZRRVwv
         L4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746567406; x=1747172206;
        h=content-transfer-encoding:mime-version:user-agent:date:message-id
         :subject:from:to:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4tq26Z3kHfID0JnZldUQ3zac3uBb50D6yax+Y4A41Y=;
        b=NbngfM1gdqF1kVITsBrERqFoboU61UUi5ffRKUQte4Koa/Cv0QbX1pOZb+TuNoZhfg
         69Q70gBTfzVf9RLPeai/deRKOuI4z9I7Bjj3aLrDOsSyAfhR6k37WJU2rKJOE2dZNNbi
         TQQliz9X42asu3bV4wricFIlWMV8/XZT+5qiI+PJPYgAYe3TM6P8D5PkAe4rY2vY8Qz7
         VIuU3PrxG846vNG2LJf9U6fGk2BCr6nzGa2y1AZdByFfOUw2xUKJfKKXW9qrd9ylh8Cu
         0LnQmbfKnXxnz6lV40axrj90qQdWZqa4EtYeLzat8Yw+FsXKXrxOeatQFhQm6xLP0YdO
         X0Rg==
X-Gm-Message-State: AOJu0Yy/AmozfSmKEG30A+6pnBkESwLqwJKoz3HAQFjyxQqMDYSBxru0
	IFQv59eMz+aSL31ktFId6rofZpa3xO0YQzIv5AYB85hRPi5ATwbbTO+NNA==
X-Gm-Gg: ASbGnctXo14dSUEK2xaahVlLEdJkfnIYl+ZE3OHVqoXU5iCu9Xw+BoRtsoFRxv55iMs
	9vVPdd3B98gXeUJ0hK6ARgj94kbGjDU6e3Wx+gpd4zWg+0ym9rys8Kn3OViqiE0ElRcsEkuq79E
	6RrxJ8blWFjtcinjfm6bDdZ5aVV4P05xx8Sby48FpDy1o2P4iPTIJbKkXHgrhCOhZNafbzVrjMs
	Ik0JNniK3mgYpd0vT8bWWSlrYAvWdumsehm8hhtCLCz0sV7k72zBPJHYQOQZgWKr0G6hLl1yiua
	Z1W1Az3Azy/BQSdQmm46RUi2gujnXdHV5Zt+jX6MjiziS6H69WzrYTwG30TVDOBUVLHBE6ZbQKv
	Ofdp9VTHQsiZU586kthEsnxYDwMAAcOYr
X-Google-Smtp-Source: AGHT+IHdp6+3mwvnfz1GWYP67TJPTwo/bnf6e0DtfwkoL8KStK80qgPvbazvwlHALMW72NYUhVXdxg==
X-Received: by 2002:a05:6e02:1d88:b0:3d8:1a87:89e5 with SMTP id e9e14a558f8ab-3da738ee4a2mr8932195ab.5.1746567406404;
        Tue, 06 May 2025 14:36:46 -0700 (PDT)
Received: from [192.168.1.253] (76-206-246-123.lightspeed.cicril.sbcglobal.net. [76.206.246.123])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f88a8d0fd6sm2369750173.22.2025.05.06.14.36.44
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 May 2025 14:36:44 -0700 (PDT)
To: git@vger.kernel.org
From: Mr Bill <billc56196@gmail.com>
Subject: Bug report for pull --rebase
Message-ID: <8c075e6e-c28c-4146-66bc-9bd7bc705611@gmail.com>
Date: Tue, 6 May 2025 16:36:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit


Hi, I ran across this doing a pull --rebase using the current master 
version of git

This happens on Slackware linux, using git HEAD, version 2.35.8, and 2.46.2

I have a clone of the ffmpeg video package, with a few custom commits on 
top of it,
I periodically fetch and "pull --rebase" to update the underlying ffmpeg 
code.
I tried this recently, and my custom commits disappeared.


I looked further with a small test, and it looks like this is happening:

The setup:
    "base" repo with a few commits (A, B, C)
    "clone_1" cloned from "base", with a few extra commits (F, G)
    "clone_2" cloned from "clone_1"

Add a few more commits for base (D, E)

Then use "git remote set-url origin" to point "clone_2" to "base"

Then, in "clone_2" do "pull --rebase"; the F and G commits disappear.

Then, in "clone_1" do "pull --rebase"; the F and G commits are retained.

Something like this:

# commit trees:
#
#    base: A---B---C          (initial base repo with 3 commits)
# clone_1: A---B---C          (clone_1 cloned from base at commit C)
#    base: A---B---C---D---E  (base added extra commits D and E)
# clone_1: A---B---C---F---G  (clone_1 added extra commits F and G)
# clone_2: A---B---C---F---G  (clone_2 cloned from clone_1 at commit G)
#
# *** now, change clone_2 to use base as the upstream url, and fetch / 
pull / rebase to get up to date ***
#
# * set clone_2 upstream to point to base repo
# * "pull --rebase" in clone_2 (should fetch from base repo and rebase F 
and G after D and E)
#
#   expected result: A---B---C---D---E---F---G
#   actual result:   A---B---C---D---E
#   commits F and G are gone
#
# Doing "pull --rebase" in clone_1 gives the expected result:
#   expected result: A---B---C---D---E---F---G
#

This looks like either stale state info after the "set-url" command,
or I'm doing something wrong.

I can repeatedly cause this to happen in my local ffmpeg devel area, if 
that helps debug/test this.
... and answer questions, if any.

Thanks for the help!
Bill

P.S. here's the test script I used for this:

--------------------------------------------------------------------------

#!/bin/bash

set -o errexit

BASE_WORKING_DIR="rebase_bug.working"

# Clean up the test area
rm -rf "${BASE_WORKING_DIR:?}"
mkdir  "${BASE_WORKING_DIR:?}"
cd     "${BASE_WORKING_DIR:?}"

WORKING_DIR="${PWD}"

mkdir test_rebase_base.git
cd test_rebase_base.git

     # create the base git repo, with commit A, B and C
     git init
     echo "Commit A" > testfileA
     git add testfileA
     git commit -m "Commit A"

     echo "Commit B" > testfileB
     git add testfileB
     git commit -m "Commit B"

     echo "Commit C" > testfileC
     git add testfileC
     git commit -m "Commit C"

cd ..

     # Clone the base area into the clone_1 area
     git clone test_rebase_base.git test_rebase_clone_1.git

cd test_rebase_base.git
     # Add commit D and E to the base area

     echo "Commit D" > testfileD
     git add testfileD
     git commit -m "Commit D"

     echo "Commit E" > testfileE
     git add testfileE
     git commit -m "Commit E"

cd ..

cd test_rebase_clone_1.git
     # Add commit F and G to the clone_1 area

     echo "Commit F" > testfileF
     git add testfileF
     git commit -m "Commit F"

     echo "Commit G" > testfileG
     git add testfileG
     git commit -m "Commit G"

cd ..

     # clone from clone_1 into clone_2
     git clone test_rebase_clone_1.git test_rebase_clone_2.git

cd test_rebase_clone_2.git

     # change clone_2 to point to base

     git remote set-url origin "${WORKING_DIR:?}/test_rebase_base.git"

     # expecting this to pull in the "base" extra commits, and move the 
local HEAD commit after it in sequence
     git pull --rebase

cd ..

cd test_rebase_clone_1.git
     # do the same pull --rebase in clone_1
     git pull --rebase

cd ..

cd test_rebase_base.git
git log --oneline > "${WORKING_DIR:?}/test_rebase_base.oneline.log"
cd ..

cd test_rebase_clone_1.git
git log --oneline > "${WORKING_DIR:?}/test_rebase_clone_1.oneline.log"
cd ..

cd test_rebase_clone_2.git
git log --oneline > "${WORKING_DIR:?}/test_rebase_clone_2.oneline.log"
cd ..

# The test_rebase_clone_1.oneline.log and 
test_rebase_clone_2.oneline.log should match, but they don't

echo "done"

--------------------------------------------------------------------------------------------------
