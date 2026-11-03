Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793720086;
	b=ZL5rAuAnIjYnbp8VVprnduEJjegVZ3zZgtRXzmuXE4o8wYGePSNSY//ak3KXEoIpTUdS
	 GjB8Ah8QxdlPsHFpv68LXX6GUi/3WQLt/Y4u+H/wrI/fhZiHyIEx0XKn63/ep/mrfcfrc
	 2sEAHr9angIHwywf8k/YRZ254uKZvuRLMq3OrwrvUV7MBiOKXWyw6rekAVUSo7Trq/eP4
	 cFroELEObNSGCXA3uJc+QISfQ0jGpNckQJSzg5O3Bkxeu0WsFZ74Rh5Yq4QtM3fr1Z7Jo
	 dr4zamU+PHCawbz6EBPk8WN4p6CL6wjH3NQYdIs/ayhysqoktpavaqBZEaw+Bt4jwCw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793720086;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type;
	bh=s5aCicw6epmugn7az6ivmyY7UTI2/3hniLO+wZT+rb4=;
	b=T/x79bXft0/JGuFxhWrCaaN/WbXCu/cvwKiOFGfS4+wubCR5uGd9jLEAjvJxhKLr/J2c
	 bkB+f4Pu25NUZlDvpkdr6Qxi3OZAC7iS/2fCz4GyshhKu2D3OBLwIN3CiynLB4fnOjMnQ
	 08RVdw+CKLRq+y/306WyImNkom4JeTf11YVjrLAiu4migCmXit6RcG3j2xT/5rkcfnBNr
	 8h4AAciSSt+vtwNUXglWTEKZGt+GvjbjTlimmoaY70v8eLS8kqKvXXEjQg28Mv0h861+O
	 rJqIjU9L9cXWOZCWu56aMQfWk+BjbdCkAgPffUZBxqOcZI1N6zNmFg/YDApFZNg/kgQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=fBjT818l;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.172
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEBE606A32F
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 15:34:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BEBE606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=fBjT818l
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8b0f59a5fdeso36508207b3.1
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 07:34:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793720085; cv=none;
        d=google.com; s=arc-20260327;
        b=qCQ9zjXZxPqxi3QymMEvTvu97RYGwOo0YrEkM8ziED6vpTVGspvxwUkuM5QYPMVHVc
         xDaCKE4+aTn/gmayGDjlyFJmya97QJdNDpZMEYvqS2NYTs3dPmhpB2TaOV5M97BWR6jL
         dr8n+4F1IIpPMIrbWdqMzrZ30c+UQfZFgr8yvzIxEO/S271x4ECSKW8+eIWvLyjtZ1la
         vS+GFjCKv8vYyoPUl1lSE3uxaye84ddyXF51ZUM6g+SIHl2+cWECCrXjkMQPronuESa0
         WR3aAcKGlDbbtF/vr4qIKX5+IgPrkWSZcBUPvwDGgctou9lkbvjIWOkVKJgiceEPd92S
         DIcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=s5aCicw6epmugn7az6ivmyY7UTI2/3hniLO+wZT+rb4=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=f0K6bdpi4oc05gZ3fqo+duNKHJzlLmvFtJu2usdy/tZVua6gA+6Lnt/XsFCdU4ltNi
         imFi4IOfClG3jkCsCXyi1Agm/Q2nP+ntRroH6cDY3WuskMfwOCDXlqwYC+5YqsomAyjb
         pshcKun/LfF7sFZSUNmfCxiSqayyDDYXFMclj1JY2UzW4At0pvdYS5LTypaEl0s6+qjD
         wesNKGpANFxcB/Zzx8HdvwzCR8j8gtID4MYaSijZW9Fj+Bk/uDSBxRXkuL62A3u1cDXs
         /AqnTzhHIl0Yw1FPi9H1yUY/lhYEV7jKpoJY1HkrLuWVkC+4MEo+VS3ayGYOIRVAy5kM
         aT5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1793720085; x=1794324885; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=s5aCicw6epmugn7az6ivmyY7UTI2/3hniLO+wZT+rb4=;
        b=fBjT818l3N4wJv5qqaIiw/GgBDRKOx6unqNNMYRDxmPq+VNZ4HjExmA65CACY+ZV9w
         Q7iJf144SF4W49Nb0okx7pXQX13TaGz8ESoEeLUdgg8cTPBTVVrBUrRmV04yfH7l6dnu
         Z7ORJYGgcHnwwt9h7Zt+3QX6Fin0e4pMM7m8OXsJ195mP6tLjEDbWzlcxyblQyo2cLnZ
         GAYa5AVuR+MK0Njg7biA49BGFiBDD2bav1odHQBRZ8MmXCj/4Pkze+NXcVF9d/p12ssq
         xwoU1kpXFBNKZq7TSvPjDZNxFfDnpDXrJSUi2TUP10E22N1tWH1yT1NRQhwy6sNSC0MU
         n0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793720085; x=1794324885;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s5aCicw6epmugn7az6ivmyY7UTI2/3hniLO+wZT+rb4=;
        b=MtkPUUf0HQFLCgdrdSrVEMMNGx6G0db0eiHWPJt6IvjwyIlcFxBs95+ImuGG9+IIlO
         daPRzXRFc38gDqmpiaoM8fcXHH7a2sDp1Ehd3jpBRPjvDjTB83iCQ83LsLpwim7VI9MZ
         u84lxQYoOC3jcaLICCIzIe/UgijB7iUfeVQ7aq3u5qn0j7hP3kKGNE7DaNqD/Z5iLVru
         po6DZLHkFPblpqR8+fF5K99m0tNYPqSqRmoTaH3ZAc8lJCzIwEJK/q9d7pbCltr5TQi9
         vPkiiCb9cR9vNmzKaNRSTZDdeYIxKwjpfbvXSiSVLw10CLDyE2rYKkZpy//+47KKFVY2
         Nb3g==
X-Gm-Message-State: APuU4Z9Xd/rrbrmIPeCSKqTKSnxSEIxzynfKlYKyqWvDPa6KlASRaaFD
	FQlHKexftmACrWaRUPFuyU1PvZZqt0NPkKQJxn8Hwnc7Xtip/lUztAc/xx/2WO4ReqjmADIcMvL
	LxjPfisoO5N0bdvSTPh0HcrPe4y/NehHVs7wI
X-Gm-Gg: AYBFou3X6o3pBgaAZeD0fLocLjJOw4xbM5eLfYmHIsiYCQlKnayfs5n6Jc8pAvp807F
	/3EccbxswjQT96pWTc6UwB5XytOzA4m2bordxm3sSepRa/D429Cj8lbbWM1miEABVqWuG8NgZUV
	KTb1Cz/ji7cIxOYZgbxRjQVsfpB/3cHMDSctfWYt9tLxgDGz6gp2F6/J4QjqcS/PQpqaFWeNDY1
	hCKdiihdr4YftedRhecmlj4D7f6eEpB9M4SNUKFvUYBYevKYD3fK43YgdsEz+gnpOxkbGAF/sVh
	UdQFUSkhnbxMEH6cCf2lofAPlM28EIs7TuVDHaurlP3ODcBSjrjESiYP8t+7pttg/IJJUhVqBLd
	aNyucv+UdBesDDTqR1Y59Gwz7KHQMDMDZEOFKeuof/AMjwkMbSoz7p6jAAzvh5d+V7xU34cgKT+
	kK6fZslRs+BaXsQruIhNzZzLtY9+Gs3/ik
X-Received: by 2002:a05:690e:11c2:b0:672:a450:693a with SMTP id
 956f58d0204a3-67ba504184cmr9207322d50.107.1793720085130; Tue, 03 Nov 2026
 07:34:45 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Johannes Welsch <johannes.welsch@googlemail.com>
Date: Tue, 3 Nov 2026 16:34:09 +0100
X-Gm-Features: AclHuK9IYG5orYMw-tP2nGjxSzCe5035fXYU09_GG35JTUlVQCjVChf5WiNfNRM
Message-ID: <CA++gwosYFaOLD5nZjKUUFtp1ryezikqAsD6vu=uqBzOwyszASw@mail.gmail.com>
Subject: [RFC] git branch: add -s/--switch to create and switch to a new branch
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I'd like to propose adding a -s (--switch) option to `git branch`.

It makes sense semantically to create a branch and to also switch to it.

Currently, creating a new branch and immediately switching to it requires:

git switch -c newbranch


I'd like to propose an alternative:

git branch -s newbranch


My reasoning is simple: when I want to create a new branch, git branch
is naturally the command I think of.

I want to create a branch and also switch to it. For me, switching is
an additional action when creating the branch, rather than the primary
operation.

The proposed option would behave like git switch -c, creating the
branch and switching to it in one operation. It would fail if the
branch already exists, just as git switch -c does.

I understand that git switch -c already supports this functionality,
but I think the alternative syntax would be more intuitive for users
who approach the operation from the branch-creation perspective.

Thanks!
Johannes
