Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A75B672
	for <git@vger.kernel.org>; Fri, 17 May 2024 03:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715918378; cv=none; b=qd42OmIAesKp3NSJloJ32zq/Topbl0CPanHe1D99ghUER3qlq2dBvr4YwS8glVc4+MyUYrPJWIsCOu8R44ghcTA74pL9O/3Yq98SNYG//hWDpFRqog+0bukhNwQifylAol/LTZPPeuT+V6MDwri8w27uqAcdFPvu495Rlf955/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715918378; c=relaxed/simple;
	bh=P0o85WYscV3YD1kv+NDSuAOtmYfU4ZcIPTVJG7i70fg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=hxbWnuc+kwQtVizTRe1QW1enyk3nFOwzyWtmQOqwIagK3KcHdPQT3fukQBj8NTZ15qUJjI/O6lyKa6G80Qbcank/RQepnb80IpCK6R5YufiaxdxR0LRV9yEgPs4YjWTwCDlbtYcM1+zEP3jZigWkTA1iKd/uPz+ZVpnQZMJzmmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NP42ZkbE; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NP42ZkbE"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e2c70f0c97so2029131fa.0
        for <git@vger.kernel.org>; Thu, 16 May 2024 20:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715918375; x=1716523175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ykJn8IOEP07vrROmsixxNgSqGpvWhKxZKAP9rskbMyk=;
        b=NP42ZkbE/fijwjOAR0hXK/ZTUnciTeGG1YekjKGZLAuRBtusBw/gcv6g4cUfweIpaR
         PbF3d0EF1YPwDDa2LFiQmm8IePV2/bMoovXP7ss5S4J7JXGslYRIBkv6khEokldMWP6q
         QBLGXz/Uo3uPYAhbtQXsmUN3vPABTaIiwPSJx/ggx51z/1OQW3T2W2DbxVWk7iVgxXDw
         AOiYiWQXHxlA5sbLyG6c5+H6lEyvPbBUMEhRxWiMiDcFjawUs11K2hrp6V/Ne3tmOH9d
         REAy6CbZdPQ073mWNWk02b7kOFUJGoXmIlhJhxXgJOyQi4WO7iFW8NCnrgEaT/IbONop
         MVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715918375; x=1716523175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ykJn8IOEP07vrROmsixxNgSqGpvWhKxZKAP9rskbMyk=;
        b=ZijgkjVj8nzZ7ltN7o8WeLWm7UDUbWTlSXXf6TiSeA8SrFTl+y2OKje7fpnwijEJm9
         tLkKFNGXv2q4h/7IR8/BftG2/TvpysCl/pie42OiHbdj2Hck5RZCvXgaln3r1M+xeu5j
         qia4Apg5yjjTqvq/wbVByPPE52ec/1lRiAJlB7JLkFF2mCLwW5Clyc3o2lSsk2XeNZxA
         AnCAeCZjE2k2RgadNHYak1RmfFO1f81iRYLC099o3jTx2W1HG2Ov3CqIiXTFESKbQGhQ
         GGeWm9Ut1topdEok7WRMBhAnrXrhgZNmqOvxTzRRWwThswjlz21g4c4Xqq8Uct3pYV9Y
         mOag==
X-Gm-Message-State: AOJu0YyDl/j1Um21g9Ueg0PTa0Qb60CS7CQjReot9bPWrP8N42OEzK5h
	p1vNz/aQj7G1To3BvFzzTF51f/2JBGaGEvujvjxgOskeN6vc/MoPiVrmHRe7g5j29JBqnOLCL3Y
	zAhJAg6Hp4jYn8UhjGDR6MJNqmPg=
X-Google-Smtp-Source: AGHT+IFRVxAfSbrgBXoXPYBicfC8y7M5Axpc+o2M49D6pedYasPtHlkYSCzirVuQuUs9iiNy8rnbuNfatrAwrXfefME=
X-Received: by 2002:a2e:9888:0:b0:2dd:372e:959 with SMTP id
 38308e7fff4ca-2e51fe52146mr139711901fa.8.1715918374744; Thu, 16 May 2024
 20:59:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kyle Zhao <goldofzky@gmail.com>
Date: Fri, 17 May 2024 11:59:23 +0800
Message-ID: <CACzX-JMdDtZR6XoKEbn422e8ALng_pzkLCi3_Tb8qtXVrdiZew@mail.gmail.com>
Subject: Re: [PATCH v2] merge: avoid write merge state when unable to write index
To: gitster@pobox.com, gitgitgadget@gmail.com
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> "Currently, " is superfluous in this project, as by convention our
> proposed log message begins with an observation of the current
> status (and "what's wrong in it" follows) in the present tense.

Done.

> My guess, from reading the tests, of the situation this patch
> attempts to handle is something like this?
>
>    When running a merge while the index is locked (presumably by
>   another process), the merge state is written in SUCH and SUCH
>    files, the index is not updated, and then the merge fails.  This
>    leaves the resulting state inconsistent.
>
>> If the user exec "git commit" instead of "git merge --abort" after this,
>> a merge commit will be generated and all modifications from the source
>> branch will be lost.
>
> I do not think this is accurate description of the "an user action
> can make it worse".  In reality, if the user runs "git commit", a
> safety kicks in and they get:
>
>    fatal: Unable to create '.../.git/index.lock': file exists.
>
> In fact, your "How to reproduce" below the three-dash line removes
> the stale index.lock file before running "git commit".
>
>    From this state, if the index.lock file gets removed and the
>    user runs "git commit", a merge commit is created, recording the
>    tree from the inconsistent state the merge left.
>
> may be a better description of the breakage.
>
> But stepping back a bit, I do not think this extra paragraph is
> needed at all.  If there were a competing process holding the
> index.lock, it were in the process of updating the index, possibly
> even to create a new commit.  If that process were indeed running
> the "git commit" command, MERGE_HEAD and other state files we write
> on our side will be taken into account by them and cause them to
> record a merge, even though they may have been trying to record
> something entirely different.  So regardless of what _this_ user,
> whose merge failed due to a competing process that held the
> index.lock file, does after the merge failure, the recorded history
> can be hosed by the other process.
>
> In any case, to prevent the other "git commit" process from using
> "our" MERGE_HEAD and other state files to record a wrong contents,
> the right fix is to make sure everybody who takes the lock on the
> index file does *not* create any other state files to be read by
> others before it successfully takes the lock.  That will also
> prevent "git commit" we run after a failed merge (and removing the
> lockfile) from recording an incorrect merge.

Yes, your understanding is very correct.

In fact, there are many other situations besides the example I give
that will be affected.

> I do not offhand know if returning 2 (aka "I am not equipped to
> handle this merg e at all") is a good way to do so, but if it is,
> then the patch given here is absolutely the right thing to do.

In the latest version I modified it to:
=E2=80=83=E2=80=83=E2=80=83=E2=80=83die(_("Unable to write index."));

Maybe it's better. (Refer to the code elsewhere)

> Do not use "touch" when the timestamp is not the thing we care
> about.  In this case, you want that file to _exist_, and the right
> way to do so is
>
> >.git/index.lock &&
>
> > which already appears in t7400 (it uses a no-op ":" command, but
> > that is not needed).

Done.

Thanks.
