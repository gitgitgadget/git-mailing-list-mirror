Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED40B34E777
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 18:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786733742; cv=none; b=hUi30GeVeEg8vSdZcX/9nj7fpQnVWoittDfHIElNsuGNBX7ptnIqO+SCniAAfQE443auzuS7rbjAPVnOVklr9E8i9PdqQ7ncHtVzKEmyS9iTtUIA3nRuShu1ohQhXcD13nmpAsLS3aZaEeQQwGggZH67E8geqpxvTew4nR6GwtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786733742; c=relaxed/simple;
	bh=qBccR9OxnMPSy1WKyGToEtQYmC1TXpYyDctc0Xq/Sec=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hU7MbVHJyt0c2e9RAHNZVUf37o5vgPRXDronQbna4TFBaT4TbjBm9cU7rgTdbGt4KrNvJn3apt1uLT3Rq9XRqA7Fu4aWQXm8sb1IPAYWBQIDCpYX7GkP3p9un6fdvkvX/3O88rWKh1yE9jwoBj+4LkaX0XHspQ4TCy45LAwM6D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r7A9U5Fp; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r7A9U5Fp"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47f611b3af9so148843f8f.3
        for <git@vger.kernel.org>; Fri, 14 Aug 2026 11:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786733739; x=1787338539; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:to
         :from:date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2KguesrHYWSGgqpf8xr3vzjbLl1c99AyxWbbB7uGUjw=;
        b=r7A9U5Fp6v+McragmMa7QnwPtTzOmy49q/yoe1kWXQzDfG8ZkygsW+ubkKRCD0XzGJ
         iRlNsVBL4Z2cHZsI/0290qBjeLBrQsvInnLYOdSNNKFlj7OVjz3lCzYsqva74gJhSZmm
         bDUAG/1by2MMtQHeCGBl5yDRWVlwDObferYUQhhDpulUoTBny0s2bdAW3V/IvBA5RM8L
         zoBoiI2ZE8W8S/whbFJ9rrhlVFLo+CMQzeN9arZawz27pl4yrMU8vQRLyNbDG4PJL3f2
         cbDySjnA9BVMQ+fH7SErp7qh63TiINDxdb38ZHeoeyqRX9p+RnpHRkAGZyURAYNJQloE
         W1qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786733739; x=1787338539;
        h=content-disposition:content-type:mime-version:message-id:subject:to
         :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2KguesrHYWSGgqpf8xr3vzjbLl1c99AyxWbbB7uGUjw=;
        b=QAj47lpMm5LlCV9XJXwfl4Qjk84AI2le0+q1e5jS42yCcBPBsEU0VK5hN/0MlnFZ0N
         dX/238gfQq3XJjDfUDKYXMAEuMXWajp8a7NnJRl5jNrHRrlJyEV290qURdDE/krtQTI3
         P3a+/hzUoqFyl31OOsSy+etaUAPFOycCTgqXt/as3Fi6ZHwo21MNHQVMmoBbro12pGeQ
         yQdssdm5K6AuixI8d6NkZvL/LgSDvGM6/Du+NdyuErAJmuTkdGQ+Oe/msNXgdbfD3TOs
         CY480b7IVdv9dtYoE5NqiWcNOmIILCKAgesV1JRGJt9+eYFT+vceZ8OWBNdMA4VbdRKw
         LJ0A==
X-Gm-Message-State: AOJu0Yz8Xc3Cskzp/XMRGB9uvI5Gb1yBBKhrqLVudE4vf6JM1A4LxsO3
	dkKvXFhLU3osXYasppYSd9zwJVDWt+Z/PY37tDFdqf7jfqi7OeCd5c1+wfYcbDBYfHE=
X-Gm-Gg: AR+sD118dsPX8ymcPMlz1p5fVxJAkPegI/yOvuSfFJ2Gw7yJrC6RYtAWh2OlgTnfjNn
	2UMbu6x7Wi4tovQ5hcli647+JRpMjIg5Rf978ffTbMLshtOrr6mOKjdDzmiaBLLBgr7e2S4JszG
	0y3zknD6agUpwWVGpIUsaBmfTpWvECIyWaTzpPqCTMZQHoZlrZMLXMmOXpzm4hhQ1Ebbs+RTGM8
	NpJjVsXN1yMzHm+E0rA/gcXeN53YvT8NOOtipRaUzX7nOhWcuj+o8RxgUwBgDIrINE54krE+40g
	YCkTKllYd9nqpBaPuM8aHUn5F8S9wwJJkFw2D/B6bho8cXv4nlWGvks66go+XWVgtwF1ppewOay
	/Yh/4Dus7RUC21aHXYAIXGGhp54rP/rwceFphfm3LcXDOBV0ZuzjrLnHNHAuTvp+VP7wz6ZBi5C
	9FmSTukDxBO2RGO5Pb9DEjY83O/o2CN3HMkz1yau1ScwFlG0FVcrcV4oJewk3ny9kJ
X-Received: by 2002:a05:6000:2603:b0:47f:9256:52c0 with SMTP id ffacd0b85a97d-4816075e57emr5402869f8f.3.1786733739069;
        Fri, 14 Aug 2026 11:55:39 -0700 (PDT)
Received: from desktop ([194.127.199.11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2c07d2sm10553060f8f.30.2026.08.14.11.55.37
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 11:55:38 -0700 (PDT)
Date: Fri, 14 Aug 2026 19:55:36 +0100
From: Matthew Hughes <matthewhughes934@gmail.com>
To: git@vger.kernel.org
Subject: Bash completion very slow in large repo
Message-ID: <an9iXOqOOvFfyN4A@desktop>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

While working in a repo with _a lot_ of directories I've noticed a painful
slowdown in some of the bash completion for git. Specifically, for any
completion that calls `git ls-files` and needs to iterate through the
file-system (and not just check the index), e.g. `git add`. Has anyone run into
this? Are there existing solutions or workarounds?

I first ran into it when running something like

    $ git add ./<tab> # hangs for a good second or two

For reference the number of files/directories in the actual repo I work with:

    # this many files
    $ git ls-files | wc --lines
    367628
    # this many directories
    $ git ls-files -z | xargs -0 dirname | sort --unique | wc --lines
    58404

See below for a reproduction and my logic, but I conclude this is because e.g.
in the case of `git add` (with no other args) git will need to look through
every directory in the repo to discover if there any untracked files at any
level.

I'm not sure about potential fixes. Hacking around on it the best I could come
up with was a workaround: add an env var to skip index completion during bash
completion, so the completion falls back to the default Bash file completion
(i.e. complete any time), here that is (just for demonstration):

diff --git i/contrib/completion/git-completion.bash w/contrib/completion/git-completion.bash
index e875787710..7b412e5b74 100644
--- i/contrib/completion/git-completion.bash
+++ w/contrib/completion/git-completion.bash
@@ -727,6 +727,10 @@ __git_index_files ()
 # The exception is --committable, which finds the files appropriate commit.
 __git_complete_index_file ()
 {
+       if test -n "${GIT_COMPLETION_NO_COMPLETE_INDEX-}"
+       then
+               return
+       fi
        local dequoted_word pfx="" cur_
 
        __git_dequote "$cur"

For reproduction: here's a roughly similar setup of a repo, with many
directories at the root:

    $ git init .
    $ for i in {1..25000}; do echo dir_$i/sub_dir/; done | xargs mkdir -p
    $ for i in {1..25000}; do for j in {1..12}; do echo dir_$i/sub_dir/file_$j.txt; done; done | xargs touch
    $ git add .

With that setup I see slow completion e.g. on `git add ./di<TAB>`. Debugging
the completion script I see it hangs for a while on:

    git -C ./ -c core.quotePath=false ls-files --exclude-standard --others --modified --directory --no-empty-directory -- 'di*'

(via `_git_add->__git_complete_index_file->__git_index_files`)

And running that through `strace` (on my Linux/AMD64 machine) tells me for each
directory there is (among other syscalls):

* ~100_000 calls to `getdents64`
* ~75_000 calls to `openat`
* ~50_000 calls to `fstat`

So that explains the slowdown. 

Thanks,
Matt
