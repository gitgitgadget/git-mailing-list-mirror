Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1893715B54C
	for <git@vger.kernel.org>; Tue, 13 May 2025 17:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747156970; cv=none; b=XUBphKts74OemNffCvpbQMfXn6R0VjQFMXL2tpPXLcK+1HPI4N93xdnseSxbmLjmjEcmz//f/JOcCEQzpxa0uoBO+b0Ns8GhymrjweUw5AtRllVY9Jt4btixYKI1voL9rKXO3NWlLr0WJlYX5a8Zr67QdbCsx6drUZJU6CtJ8b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747156970; c=relaxed/simple;
	bh=lVo6Ebiz2u5AMQxeRJlw5xrpGauoDz7l5ULpv3pWuz0=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=e6Y5bmODvJ+pD8KG7yWIKCyKWJ9mXbtr0Wn5kWHesDZl3sB6NQwPTsTfwbYbo33IggV9g99Lts0/78n/Af6nNI0c9B1qAjnKKKjxmi2V7xAAMtxrCBaPvxyuu/IVHQ1QmFS/if5ll6UR17Hzne9i0s0UGO/c+bsmAsblAEpKJX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5YdfMmt; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5YdfMmt"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-86142446f3fso155673539f.2
        for <git@vger.kernel.org>; Tue, 13 May 2025 10:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747156968; x=1747761768; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ioMQC7OHwdBPaZrMpqeZWd/gmWcqrg9KbNVC14UTlAE=;
        b=N5YdfMmtWPtN2cR85KcVbgZMwxCTTc07WwiFRSwzyM3qmleElr3IcRrFPZznG4TrKv
         MlOPynpxAwY1H/z6fQwe/YSW44T0NRIvRqvbVjPgax91bbs/J9Xx9832Vv0HNenXk3fr
         Dq9K1gUWSK9Hi9h3wrPcWIMiHBcEKM/zTufSlJsV0p7gZk+u8MQcxRLbMN5qo2timLWp
         TZIs2mou8y2qffQmUeXogk1HiQ60xDxJhPDNSGLOWtmFBnY6+ecB6B6FKiaoOAROdY99
         ZtH0LTgDjLINVSNNnW212xJTTpaJejdyDLQeCeMl2t+9KO6WcUMTHGvELBUNZUViGcSp
         h0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747156968; x=1747761768;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ioMQC7OHwdBPaZrMpqeZWd/gmWcqrg9KbNVC14UTlAE=;
        b=X2Ysh7cpN/4F16NNleIPi8Kbg0jYx0D6seSMuW1oOfPFqDasHH497hlzjaqGqcrkEc
         4vvZDNbr5UFz1FRFkEQShKJqvvGUdo973L4LEzOhQjoePYdsSE0VOwE7n4FDJb/RE5Q5
         GwZBDWY0G3Cs/3KmWbQ52lCocWErjr+ir8NxfJ0Rz9HVwdJkn5EFwG1ew+GtZRSQZb1s
         bsXbLazcvst0Wlh9VWLZeW+RcrPRhz3KxtCR+zs555ZT0cmCe4f//QCp16U1AWP2PORq
         V6i4lMtu7U4dl6Iw9sxIGUjpuzoY3lhPozri2EU0dTZnphPJom2hyORim1XTMRFRRnYl
         eo4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWWmh9OGwDkTkyIz7YNDIfhPS/4KXa4HK3qW6t1UIH4gXvJWDpaigO0+7/rWsOEblEHoto=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDDe1ushz689W+IN2ma3zYIaxIWLo8/5due73h8A7VBlVQs/Uk
	utO33A0y3q8VrxF3DokjWxYVFtDqYO4OxHyfNNsdfcN1gaWI9HjXG6JT1Q==
X-Gm-Gg: ASbGnctiq3kYNhKRTKJKvQvNBy3Oro/3/psVzI4VdaxcsOYbGessECq4HkSvydkjmb5
	7yCptjyoj6rvifsMWLYckQSVvdxop6KkaveYzSCxC9MKpU1vUqd464yFzjYNEq6vtkqfCxOOuDc
	YPkoMOc2bb/qXnFbVP27ewKh4vzD3AQOGE/GFacbwVWRpw6aE3vTqRD/9MFivuKeDk+4hqiV5HV
	PQUhQRA0l8x1kUtR29sWu7k8duXpCe2lMhOvmIwqMobgS5cgHe9IkAEJ8+EMNngdYJpOXKbtilg
	iDAy9KDj21TRBe01qlSBylwNJxPSteiJ3bQpSW+a25JYzs2KIvptfyqelpu7v/JmBR70KMh0asm
	6y28fNKHzcPEALPsVzn+epTamjUP3+ACrteSGSsa5DkY=
X-Google-Smtp-Source: AGHT+IEGBPsBGjHSvmXbby1DfFJNGuIUlZcfIut2pBuRylmIvW/XEFsdDNV2avuF/gMgaKOns+QFZw==
X-Received: by 2002:a05:6602:6ccd:b0:867:237f:381e with SMTP id ca18e2360f4ac-86a08db2c12mr16721639f.2.1747156967851;
        Tue, 13 May 2025 10:22:47 -0700 (PDT)
Received: from [192.168.1.253] (76-206-246-123.lightspeed.cicril.sbcglobal.net. [76.206.246.123])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fa2249efb9sm2184247173.7.2025.05.13.10.22.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 May 2025 10:22:46 -0700 (PDT)
Subject: Re: Bug report for pull --rebase
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
References: <8c075e6e-c28c-4146-66bc-9bd7bc705611@gmail.com>
 <6bebcee9-1315-4ec3-a49b-d767f0f67bf7@gmail.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>
From: Mr Bill <billc56196@gmail.com>
Message-ID: <06c4f0b7-c314-59e0-5a05-a9d9a8369b30@gmail.com>
Date: Tue, 13 May 2025 12:22:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <6bebcee9-1315-4ec3-a49b-d767f0f67bf7@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/12/2025 09:07 AM, Phillip Wood wrote:
> On 06/05/2025 22:36, Mr Bill wrote:
>>
>> Hi, I ran across this doing a pull --rebase using the current master 
>> version of git
>>
>> This happens on Slackware linux, using git HEAD, version 2.35.8, and 
>> 2.46.2
>>
>> I have a clone of the ffmpeg video package, with a few custom commits 
>> on top of it,
>> I periodically fetch and "pull --rebase" to update the underlying 
>> ffmpeg code.
>> I tried this recently, and my custom commits disappeared.
>>
>>
>> I looked further with a small test, and it looks like this is happening:
>>
>> The setup:
>>     "base" repo with a few commits (A, B, C)
>>     "clone_1" cloned from "base", with a few extra commits (F, G)
>>     "clone_2" cloned from "clone_1"
>>
>> Add a few more commits for base (D, E)
>>
>> Then use "git remote set-url origin" to point "clone_2" to "base"
>>
>> Then, in "clone_2" do "pull --rebase"; the F and G commits disappear.
>
> After the url is updated the reflog for the upstream branch still has
> an entry for "G". When "git pull --rebase" runs "git merge-base
> --fork-point <upstream-branch> HEAD" it will return "G" and so that
> commit will be excluded from the commits being rebased.

Thank you for your comments on this (Ben and Tuomas, also)

I've seen this situation when looking at this issue.

Running "git merge-base --fork-point..." returns different values for
the clone_1 and clone_2 branches:
* clone_1 points to commit "C"
* clone_2 points to commit "G"

... apparently because of the extra "G" entry for the upstream branch.

I was expecting running "git fetch" after the "git remote set-url..." would
update the upstream HEAD information to reflect the new upstream repo state.
(and "git fetch" happens as part of "git pull --rebase", so that's 
covered, too)

In my case, I can use the "rebase --no-fork-point" style to keep my updates.

Thanks again!
- Bill

> Running
>
>   git fetch && git rebase --no-fork-point
>
> should keep the commits "F" and "G". Alternatively instead of updating
> the url you could rename the "origin" remote and then add a new remote
> called "origin" pointing to base. That way when you pull the reflog
> for the upstream branch will not have entries from the previous
> remote url.
>
>> Then, in "clone_1" do "pull --rebase"; the F and G commits are retained.
>
> That's because "F" and "G" are not in the reflog of the upstream branch
> in clone_1.
>
> It's debatable whether "git pull --rebase" should use "--fork-point" by
> default. On the one hand it is convenient when the history of the
> upstream branch has been rewritten but on the other hand it leads to
> unexpected surprises like this. The fact that there isn't a way to
> disable it and it ignores the rebase.forkPoint config setting does not
> help.
>
> Best Wishes
>
> Phillip
>
>
>> Something like this:
>>
>> # commit trees:
>> #
>> #    base: A---B---C          (initial base repo with 3 commits)
>> # clone_1: A---B---C          (clone_1 cloned from base at commit C)
>> #    base: A---B---C---D---E  (base added extra commits D and E)
>> # clone_1: A---B---C---F---G  (clone_1 added extra commits F and G)
>> # clone_2: A---B---C---F---G  (clone_2 cloned from clone_1 at commit G)
>> #
>> # *** now, change clone_2 to use base as the upstream url, and fetch 
>> / pull / rebase to get up to date ***
>> #
>> # * set clone_2 upstream to point to base repo
>> # * "pull --rebase" in clone_2 (should fetch from base repo and 
>> rebase F and G after D and E)
>> #
>> #   expected result: A---B---C---D---E---F---G
>> #   actual result:   A---B---C---D---E
>> #   commits F and G are gone
>> #
>> # Doing "pull --rebase" in clone_1 gives the expected result:
>> #   expected result: A---B---C---D---E---F---G
>> #
>>
>> This looks like either stale state info after the "set-url" command,
>> or I'm doing something wrong.
>>
>> I can repeatedly cause this to happen in my local ffmpeg devel area, 
>> if that helps debug/test this.
>> ... and answer questions, if any.
>>
>> Thanks for the help!
>> Bill
>>
>> P.S. here's the test script I used for this:
>>
>> -------------------------------------------------------------------------- 
>>
>>
>> #!/bin/bash
>>
>> set -o errexit
>>
>> BASE_WORKING_DIR="rebase_bug.working"
>>
>> # Clean up the test area
>> rm -rf "${BASE_WORKING_DIR:?}"
>> mkdir  "${BASE_WORKING_DIR:?}"
>> cd     "${BASE_WORKING_DIR:?}"
>>
>> WORKING_DIR="${PWD}"
>>
>> mkdir test_rebase_base.git
>> cd test_rebase_base.git
>>
>>      # create the base git repo, with commit A, B and C
>>      git init
>>      echo "Commit A" > testfileA
>>      git add testfileA
>>      git commit -m "Commit A"
>>
>>      echo "Commit B" > testfileB
>>      git add testfileB
>>      git commit -m "Commit B"
>>
>>      echo "Commit C" > testfileC
>>      git add testfileC
>>      git commit -m "Commit C"
>>
>> cd ..
>>
>>      # Clone the base area into the clone_1 area
>>      git clone test_rebase_base.git test_rebase_clone_1.git
>>
>> cd test_rebase_base.git
>>      # Add commit D and E to the base area
>>
>>      echo "Commit D" > testfileD
>>      git add testfileD
>>      git commit -m "Commit D"
>>
>>      echo "Commit E" > testfileE
>>      git add testfileE
>>      git commit -m "Commit E"
>>
>> cd ..
>>
>> cd test_rebase_clone_1.git
>>      # Add commit F and G to the clone_1 area
>>
>>      echo "Commit F" > testfileF
>>      git add testfileF
>>      git commit -m "Commit F"
>>
>>      echo "Commit G" > testfileG
>>      git add testfileG
>>      git commit -m "Commit G"
>>
>> cd ..
>>
>>      # clone from clone_1 into clone_2
>>      git clone test_rebase_clone_1.git test_rebase_clone_2.git
>>
>> cd test_rebase_clone_2.git
>>
>>      # change clone_2 to point to base
>>
>>      git remote set-url origin "${WORKING_DIR:?}/test_rebase_base.git"
>>
>>      # expecting this to pull in the "base" extra commits, and move 
>> the local HEAD commit after it in sequence
>>      git pull --rebase
>>
>> cd ..
>>
>> cd test_rebase_clone_1.git
>>      # do the same pull --rebase in clone_1
>>      git pull --rebase
>>
>> cd ..
>>
>> cd test_rebase_base.git
>> git log --oneline > "${WORKING_DIR:?}/test_rebase_base.oneline.log"
>> cd ..
>>
>> cd test_rebase_clone_1.git
>> git log --oneline > "${WORKING_DIR:?}/test_rebase_clone_1.oneline.log"
>> cd ..
>>
>> cd test_rebase_clone_2.git
>> git log --oneline > "${WORKING_DIR:?}/test_rebase_clone_2.oneline.log"
>> cd ..
>>
>> # The test_rebase_clone_1.oneline.log and 
>> test_rebase_clone_2.oneline.log should match, but they don't
>>
>> echo "done"
>>
>> -------------------------------------------------------------------------------------------------- 
>>
>>
>

