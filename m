Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1932CCC5
	for <git@vger.kernel.org>; Mon, 25 May 2026 22:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779746487; cv=none; b=PrwrSx1XMAyemm8Ez/5ONn27hAHrMi+ukH43jD+Fhj4yNHuTgIMtYd49FeD7+ygV+p56RUv+FKoudlF+3wPw42QrjOJVylXgvh7vyoqr+F+h0lts6FLMUK2TxcjOXKlT5P88wo77d/LkA+9qpjWjeaKTzbzmb07HNO6Ihpxx/Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779746487; c=relaxed/simple;
	bh=88BRah0IWzTIOQ5sNXGnV6JjCPhL6n05olIFz2kqIY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fzEZF1UmoM20wGAq9+qUy5mjkmNADHYBu5RbVvOSFMKiJHHaftqCv74uIRnWVSNJ1sRT+5DLSE5EZllROycnjUhvRLyadZNb+soFOQo67oXHlZigVsmamECKxTZ/8e5kpEXlpCgXoIU0NdIzbKKyW5mOOxZulm93iJDpmOHhvYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VcZ5FScH; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VcZ5FScH"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-367c2a39fcfso4564844a91.3
        for <git@vger.kernel.org>; Mon, 25 May 2026 15:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779746486; x=1780351286; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5wMvk9FWx/xKregYiJes+cH8WKPoZ8O9GrvDnp+L0xo=;
        b=VcZ5FScHdc/B4oJPPbBe6dn7b7+NKszJUeqXb64XWz1LF+tc0ccKize7ZsB4f97OSJ
         wZMhRai0z1pUdwFaTClnnxx8NP7H4xmtgapgbrxktRBbIQhYin7oE7f6RHGir8bZaqZH
         P2Mjb+qHaXjiFqEWQjTahCUWeOib5F8Up8NRtruoHajua1OkHcAYfyQwWb9b8vS+B/Tn
         CwEr6MNLJOlwCadIgRa2o7QE7ml14zdWycvwK+gkuJMiz74lZwdva/6g4rbQjLSDCWY4
         nzfx4YKugl0Mbc2HGE6oS+yy5QGfyNSs5lChaMk89j5QI6fD9anAS3+qVknfVerXXIUY
         3FVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779746486; x=1780351286;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5wMvk9FWx/xKregYiJes+cH8WKPoZ8O9GrvDnp+L0xo=;
        b=NK1FsYyhjvl2pdGherrnkwXvlPfWg2XIjieFBJ6LK7p0IBmDMkzrTbfV8cFNluvi2u
         SO6Nk90JxUQ4A+nM7hpxrFr3FMVRCCIA7O8v8KmZpjWKjB3/TZqct8ar04FXKPrDEbaD
         StwpjZeaXfJ7V7YnOEIoTO27YIz9pwaXt7F28/2NhtzD9d/d5/p7fKo1JvcO2gPPM7iN
         bXYuVEwB+3MW5M60kE22SzK9eZzdda1iXmKFjQ5WA1gQIaV/cvig3FPxT10UJzxF9u9/
         YYLI5zhuLypfKbtFKeIQvjD+RVVq4s3GmTS+VFSm3cymweiSmnPKAemHeng6vt83BnRL
         hHgA==
X-Gm-Message-State: AOJu0Yy9Fuvc07RvVWLFWU7RFBKAqtvZRPSdqgAlPW6RozlrNJolv1wu
	VfLql0hDTBkBHhlkHKSa8dxY2sRINMVnjGxfFhi/DTHUcvqYe5vX2LuFREFG25M2fB4=
X-Gm-Gg: Acq92OFR21dcf2YgWpu/x8SBRCrTPBFU2rmeoDapsddBqpW4ryQSydCQ2czNAsyfKIL
	864gPxYAykm292h5DKUelyhd8L48sWJ6UPmLfxfZm5iW27yLunbvk/3dwwySyn4L4OAr8U8Be/m
	zjKdHd8h8QIUddthlZCPdkyXgPXQwhH1NTzBXpp+5bKGBu7ou29ypeQmj7y9y9AjRzz3ZNhY4og
	F1HytmmLIutw76vcMk2sunP3ZJ0KuZAoC6sJf3N7u65ZlGjO3bQf5w8hxoECXN1lAsBGSRWPuXQ
	utVtkkELjcrk4VL+HjPnG6rZ3m2Jb1lhADdYyE1LC6s1RPpmA7/S+3vrPBtbod3kMweyNiVYISO
	1c4Be2OKc06bYJc5Ja0FuQ1Oa+goD1PW5J67/a2wUvl5WqxhAqrdiACarPTI/BKaKmdWQwm8h9s
	AvUQgzrCOFRTtkIsSCcRF/H3XegW+fL3FtJySQRle1pRfOnINXTxhrTKM=
X-Received: by 2002:a17:90b:3f4f:b0:366:132:fda3 with SMTP id 98e67ed59e1d1-36a67475eddmr15662861a91.11.1779746485575;
        Mon, 25 May 2026 15:01:25 -0700 (PDT)
Received: from [10.2.0.2] ([159.26.103.58])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36b014b5691sm424955a91.7.2026.05.25.15.01.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 15:01:25 -0700 (PDT)
Message-ID: <23221493-ea81-47c3-9647-6c6ac8d03360@gmail.com>
Date: Mon, 25 May 2026 15:01:23 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Expected test suite behavior
To: Jeff King <peff@peff.net>, Michael Montalbo <mmontalbo@gmail.com>
Cc: git@vger.kernel.org
References: <CAC2QwmKgQW2c6_OhepsB1hzXYHxpX0X4eyQS0dPcxRZLOnCdig@mail.gmail.com>
 <20260525072711.GE2737798@coredump.intra.peff.net>
Content-Language: en-US
From: Amogh Dambal <amoghdambal1@gmail.com>
In-Reply-To: <20260525072711.GE2737798@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks for the replies, and the pointers!


 >> Hello. If you run `make test GIT_TEST_OPTS=--verbose` or uncomment
 >> L16 of t/Makefile is there more information describing the issue?

 > You can use --verbose-log instead, and
 > then output is in t/test-results/t1234-whatever.out.


`GIT_TEST_OPTS=--verbose` was very illuminating. I captured 
STDOUT/STDERR: `make test GIT_TEST_OPTS=--verbose &> 
git-test-verbose-fail.tmp`, which shows that almost every test fails 
`check_config` because a `git init` is creating a `.git/config` file 
whose executable bit is set:

--
Initialized empty Git repository in /root/git/t/trash 
directory.t0001-init/plain/.git/
plain/.git/config is executable?
not ok 1 - plain

[...]


However, I'm not able to reproduce this, e.g. directly using the local 
built binary seems to work fine:

mkdir -p /tmp/debug && cd /tmp/debug
/root/git/git init plain
ls -alhrt /tmp/debug/plain/.git
root@ec94ab1b260e:/tmp/debug# ls -alhrt /tmp/debug/plain/.git
total 24K
-rw-r--r-- 1 root root   92 May 25 21:26 config
drwxr-xr-x 3 root root 4.0K May 25 21:26 ..
drwxr-xr-x 4 root root 4.0K May 25 21:26 refs
drwxr-xr-x 4 root root 4.0K May 25 21:26 objects
-rw-r--r-- 1 root root   23 May 25 21:26 HEAD
drwxr-xr-x 4 root root 4.0K May 25 21:26 .

In fact, even the specific test directory that I assume is being checked 
reports properly set bits on the `config` file:

root@f695346357b9:~/git# ls -alhrt t/trash\ directory.t0001-init/plain/.git/
total 12K
drwxr-xr-x  3 root root  96 May 25 21:08 ..
drwxr-xr-x  3 root root  96 May 25 21:08 info
-rwxr-xr-x  1 root root  73 May 25 21:08 description
drwxr-xr-x 16 root root 512 May 25 21:08 hooks
-rw-r--r--  1 root root 111 May 25 21:08 config
drwxr-xr-x  4 root root 128 May 25 21:08 refs
-rw-r--r--  1 root root  23 May 25 21:08 HEAD
drwxr-xr-x  9 root root 288 May 25 21:08 .
drwxr-xr-x  4 root root 128 May 25 21:08 objects

I've further checked that the POSIXPERM requirement is being set and 
verified that there are no shell differences (I'm using /bin/bash as my 
main shell in the Docker container, while the test scripts use /bin/sh 
(which on this Docker container is symlinked to `dash`):

root@ec94ab1b260e:~/git/t# ls -alhrt /bin/sh
lrwxrwxrwx 1 root root 4 Feb  4  2025 /bin/sh -> dash

I'm sure that I'm missing something blindingly obvious with respect to 
my setup, but I have not yet been able to figure out what that might be.
