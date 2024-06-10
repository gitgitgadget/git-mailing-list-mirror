Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03AA1509A4
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 22:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718058449; cv=none; b=WUDcZ5jhhhJSc/mU/nvSRGB4NPENcyXKQbWl8Z9wb5k7LD5a9N8IZ8SukIRjLiiQXcCjEQslQRkKD0Pg7u+vLBzAL1j9Mab+SS7hmVCdvl1dMCkVgc5GXaB5tIiKfNHIdDnEUw5HZhiJx/TRmbWvZMhD7pEv4rY6BwGYXaus4XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718058449; c=relaxed/simple;
	bh=0TEd/a76GrI2Be9JAxK8dBqs7MddUj+Ejpi33w+wBgY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=rC3Hp5UcwPFnVFD9HaoFNqINAom9/Nn4RvOPYbuLWP1cJXCUxGJoAurLN2CBS9Sc6eOsnl5T/qRjS7COur0/2vqqjb2D43aJN2Vqg7f/FZqJKNnUSqZZGVS2EDAR2XPKRe5R45tqlEcBfb4K3/+mIpFebcSUIM+clVS75ahW1Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LWuFZeW0; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LWuFZeW0"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6f8ef63714cso278581a34.1
        for <git@vger.kernel.org>; Mon, 10 Jun 2024 15:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718058445; x=1718663245; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YSLBaKM3wK2UihnnV+LZlqPu16RLS6iSNFOWwHj5qHE=;
        b=LWuFZeW0ulTVxUvUBoZrSEs1fZRBfM4U8qchqN9WlO/4sgmApqpHRLTB7ogba6ZPf8
         XArJX54zBX5h553IkrFxVtkKfsMsgjYwthwYHdQIgIBDzZg75/oIbWfNLGvb3WWT1BqI
         WJFKNuD3K3IwN4Rnp4SxnlHL6BfhaXgHGxrRZuYk6SV9enmWb+F+HNIcurhUbIww+fAh
         Ix9SScrzr9mokOrzUz0kEw8DrPre3qEK5QI8oEtHdaNs9mGTxb+F7d330P57eQqEaGYs
         OdE4HDe79Cj2MBBZeP2QGthyV7mQokwhynXWruTzzsn+xOjuPAbofLH9L8uaqXc34h8Q
         syAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718058445; x=1718663245;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YSLBaKM3wK2UihnnV+LZlqPu16RLS6iSNFOWwHj5qHE=;
        b=GPZEgXdygZUG3jLWVb3kq56sVTmkQhZB+3OVUKxsd5Bd03UI4bkANkYuIvSyUjueWC
         Tt2rHvjVe3v92bf5vwfqqXxbus5wbwe8R3E56kt7M/U41d/yC2FXX7c5GASGB9mN4ucq
         /Zeli/Bq7FV6Qh/gJwJgyC8Tp8V8XUx2hpAl6CR1iWGzebHvNoszjH6eAIhOYjPCI9aP
         krJZY+bnnC8O7e7lcGdM8rUYtM93Gn6BQY8iUmXAjfZZoN3L7qTbsSZMzwBmk61hNHbk
         fhfTTgjbqKkPeCkB+iQSGo9M6JXll7rXc2fGYKwOEQm+ddLO7gQGm6nmjSIiCKQF4jzA
         uJGw==
X-Gm-Message-State: AOJu0YzTy7UqBtQuuAnOWHUtBJl5HNbUu6rKGdb4HT0gOnhrvAtA85Jc
	wUFURDGXXvBUEsbc5saZfamfh45yXNwccBrXQzp5M05IjCK1fPKAbKbS4C5NO6YzFbwtpiYojwZ
	N8xy1LqsjeouUSUouFLRf0bqml6DCeu4rByk2FBJFElcLQJwJVqnE
X-Google-Smtp-Source: AGHT+IFLcbVpMkVOWrlQP10a/iqTrjL+KKsdi9tJfW6irEmiflkyU6wS7jCJEfUbwoAjhIfIA1QE3D36rSDGq9vEa6M=
X-Received: by 2002:a05:6870:d0c3:b0:254:bd24:de90 with SMTP id
 586e51a60fabf-254bd24e1d4mr5688934fac.9.1718058444825; Mon, 10 Jun 2024
 15:27:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kyle Lippincott <spectral@google.com>
Date: Mon, 10 Jun 2024 15:27:11 -0700
Message-ID: <CAO_smVimsHAPbMxy09mcYZY8apFgCbpnS9eSF7UOL6_BLqntNw@mail.gmail.com>
Subject: SEGV (detected by Address Sanitizer) when using `core.abbrev` option
To: Git Mailing List <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"

c8aed5e8dadf (repository: stop setting SHA1 as the default object
hash, 2024-05-07) stopped initializing the_hash_algo, but config.c
references it when it observes a user setting core.abbrev, in two
ways:
- if core.abbrev is detected as a 'no' boolean value, then
default_abbrev is set to the_hash_algo->hexsz
- if core.abbrev is set to an integer, it verifies that it's within
range for the hash algorithm (specifically: it errors out if the value
is < minimum_abbrev or > the_hash_algo->hexsz).

Stack:
==2421488==ERROR: AddressSanitizer: SEGV on unknown address
0x000000000018 (pc 0x56344202585f bp 0x7fff9546fe10 sp 0x7fff9546fcb0
T0)
==2421488==The signal is caused by a READ memory access.
==2421488==Hint: address points to the zero page.
    #0 0x56344202585f in git_default_core_config git/config.c:1466
    #1 0x56344202585f in git_default_config git/config.c:1815
    #2 0x56344202064e in configset_iter git/config.c:2185
    #3 0x563441d531cb in cmd_clone builtin/clone.c:981
    #4 0x563441cebac2 in run_builtin git/git.c:474
    #5 0x563441cebac2 in handle_builtin git/git.c:729
    #6 0x563441ceed0a in run_argv git/git.c:793
    #7 0x563441cf0aea in cmd_main git/git.c:928
    #8 0x563441ce9323 in main git/common-main.c:62
    #9 0x7fa3228456c9 in __libc_start_call_main
../sysdeps/nptl/libc_start_call_main.h:58
    #10 0x7fa322845784 in __libc_start_main_impl ../csu/libc-start.c:360
    #11 0x563441ceb530 in _start (git/git+0x1e0530) (BuildId:
c0e4b09d5b212a201769f1eb8e7592cddbe3af1d)

AddressSanitizer can not provide additional info.

---

My first thought for a fix was to just cap it at 40, with the
assumption that the code would handle it correctly in the unlikely
event that the hash size ever decreased, but I don't think that does
the right thing if `core.abbrev=no`. That's documented as a way of
obtaining the full hashes (with no abbreviation), and if we're using
sha256, capping that at 40 hex (160bits) is incorrect.

My second thought was that we could store the requested value and
validate it on every usage. This complicates usage locations, and can
lead to poor behavior (crashes in the middle of operation when we
finally get around to checking the value).

My third thought was that we could store the requested value and
validate when we have a repository that initializes the hash for us as
part of that initialization. If we attempt to abbreviate some hashes
without that setup, we act as if core.abbrev isn't set at all (so they
get the default behavior). That seems like the best option overall.
Exploring that further ...

I've looked at a semi-random collection of places where
`default_abbrev` or `DEFAULT_ABBREV` are used, and they all seem to
eventually go through `repo_find_unique_abbrev_r`, and they pass in
the len. This also always has a repository available (otherwise it
wouldn't be able to disambiguate). Furthermore, it has `if (len < 0)`.
We could thus carry the "unvalidated" request in default_abbrev by
having special magic values (auto=-1 like today, no=-2 (replaced with
hexsz when we know it), other requests are <= -4, for a requested
length of 4 or higher), or we could have another variable
(requested_default_abbrev) that gets copied to default_abbrev when we
have a repo.

The one potential issue I can think of with this is that setting
`core.abbrev = no`, having that resolve to 64 (sha256) when we set up
the repo, and then if we ever read from a repo that uses 40 hexsz
(such as sha1), then we have to ensure that we tolerate a requested
length greater than the current hash algorithm's maximum length. This
likely wasn't a problem when sha1 was the default, because we're
unlikely to go to a hash algorithm with <160 bits in the future. But
if sha256 becomes the default, then this can be problematic.
