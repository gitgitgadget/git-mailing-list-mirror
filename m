Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29609CA6B
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 03:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772593328; cv=pass; b=D/mkv/u8kETwNwH+zcgcG3uRpgAMH2qQOyYGPvmQlRgm83HnAiuh3lnRTwH8/SrIFX0hdn6m37m3Q7MJKggXuRH9bGomcXcwAdmOYgZhUoDqW8NzX4GQJCcactucpalCctZ+FvJ8sI9qA9GrbqDCly+mUTzMe+xWAbmwKYG+pgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772593328; c=relaxed/simple;
	bh=a1UZ//RHFfuQ3HGoPBdG4Ckxt83FKVxUwxAjgo542Ak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SVvnsZAWiiTDyaejkD41Deb0cGWZQIFbt3bY7npvYBCDv46A6C8SciNVMHuCROP7lG+sAqr02aR3x5dv81Lp5ojXoNDdpsXLxraB5ZHHuoNHPq6Oa6tuhYMKIVLRoTI61sgtxwQ5cq6oJSODKCFTuAsKXOrr0bhu0jDEcnt9PjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net; spf=pass smtp.mailfrom=gree.net; dkim=pass (2048-bit key) header.d=gree.net header.i=@gree.net header.b=ZQquPoeA; arc=pass smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gree.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gree.net header.i=@gree.net header.b="ZQquPoeA"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso5977211eec.1
        for <git@vger.kernel.org>; Tue, 03 Mar 2026 19:02:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772593326; cv=none;
        d=google.com; s=arc-20240605;
        b=Pzyz495WRZOaJweo2P6syYp1zJ66kR8O1Som59ANsU5HLfnlcw6K1u/OlA+w8Vsy5J
         ahjUH9kRWj0NH/DVwEYbuPe92l4wdvKROaLmOce0Nn7xmvxOsTxtL5ts1FWl0B+HS4pw
         qwVgxQVYu/hq4jFfIeK0G+nAkRnpB2qaojv5zwvx12PesQMjmUCf+n/7j5+41pkyvSRk
         1VK9D9r/nALTMZBkv+A+eFuDnnTYDkEAystTWrZiJi303ZjBvDYiXvSU0JJrATD4kHrz
         2fUNFttV+g5MJacMEinmF48CXNwyBTSQzOHGQup+ZCEc+2tTspz8bpOQMVpimaUvJtGW
         mdog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rDAIJLeynRH+HDTgGERCHSaJT6X8jIp7Ss+BNHfeekw=;
        fh=itp/4CGQQUMRl9Rz0KbGhpV0UW3JW+Ui+mb6ZC1yg7c=;
        b=hapSIpuT+PU1k8o//+D/252b6SWsRznlJsxBY7xiV71ykFTjveHOHV59cVpBwJD5yk
         qCOUos7Dh+WVpwPnBornUtOVeHXXmj+aY9Z3ucpwN7VsdNeylIHRgRahtylPNQXMBANE
         JJePYNEQiqKpvuvIv3VhehJTNWjn+GX/yG0AibZOGkfwwa0f7cu7x2NchXfUS+PWhTsr
         wzyTS1vzeqrM1riteui9WRjP7Er4it9n41DYgDLmpWp2hCy182utJDgiarK4NYTeJUCW
         DcI6MFvpg1acEDGo9OoptHgVBBhhMqFZ8rwItL6TaF693OsQ2EOnMiuw5SfUV6JohDHg
         ChOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gree.net; s=google; t=1772593326; x=1773198126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDAIJLeynRH+HDTgGERCHSaJT6X8jIp7Ss+BNHfeekw=;
        b=ZQquPoeAIUJLrpspgAi+SNIunLSJ427qdpAYExtjsITE1PBoRD/0/okYdxzdec4sHM
         PoZC53THhJWsL0OaajOp/xlExkIHW7Lva55RIspLw3CCRHALUqV44Fc1ZAs09zTju/pE
         j2IwuXxKCilIjEfC36WtXAf2Engtghs8MTSUz4tXsrKV/I2fot1GW7bRAxfyZHdDkHh/
         Ds+xjCCuYkdqbfNIVOv+6OyZfpWbGZzX+N6xyORxqHyqDpWoFsTb+eQkg/P/JTlkO/4M
         MjpcT1vhnXO1EKgw99JeTDiu+5S2AWN2ygHW7a37Lj8KLqyswiGmhBvpRxAz3r3eRlTu
         KkEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772593326; x=1773198126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rDAIJLeynRH+HDTgGERCHSaJT6X8jIp7Ss+BNHfeekw=;
        b=mme4g5lLtuo8x4f85IYR9I9YZ1jikl0+zdTbFfAYK3OXG7o6YkirVhdr6no0qaeJZl
         cl4cwdZ/+kwURF8Rrb0R3351CrInTENyv2gTDozBFyQw0OdKUQjb6tRD09LAjg25DKHe
         RVHNQ0+am5G6juy82GJdZiWd6UWrYr6WtwHL18xN6I3avtNB8Yan/YAHgvfQA3CkgCsv
         8jUTA7SsEuW/j3GA3R0NyXuI/jBUysA311gC0r2VaXQTXnksXfDUAxP1ArKY9lcmH8ld
         hhFrdVZ1kAlE//Yx6SPnHoxJGZeZp06PcPxYfmHSpq5/ETn7+PB7opXhN/GQhUhpr9FT
         8Fhg==
X-Gm-Message-State: AOJu0YwLUfLnoKnWu9P1oSP2FgRt4CgzvDz5pDiLnZ6ErzvZzr4/rklH
	U9iVk94icYySTSfXmse6pp9o50TYpg7AUQAz58S9e3o9yyoq9CjLmkrkaLO0eoKUWg8xRpUJWqB
	6vXW90VCx6ujqhJZQsL6KZSU0vf72N0Un9IJDM9ywJLY93zO0l+FEBkHmJXzPc02lQ9iUFqGRaD
	me4pL4VfWcR+pnaLpKrNUUbCJzNMnXVQk03Z/HaF011VGYBAKbhZMbyRf8zadEex5zqE0J7IUm+
	t+4UajRFfe3dggoqDCZKukby4Czhg8aUliMlZXlv2pfk/C9+h25qiXlG7VgBA9sTm4SicUsTaT4
	ushdAIP9805QEiSNTlrw1vxk/QLf
X-Gm-Gg: ATEYQzyRQatIshNyOpnBL7X2Eb5a8pdn5JTzXAWs/y7vOM8JOylkmAq2Z2uKwzX/o5H
	sBfyWj5/cMbyQlpwpJKJFRju4VPx6eyeR3890VC2GappjdIQdFEd1c6IkJumfhJ8/r7iuasS9pY
	RGCTBWMOL0b/71e4e3qwQVZKZgGTFyUcgG54JuXw4ssXcdmjVUIKKnGZXoWq9VS8rhSFECGKZCc
	bqonWmfrNnWadCOFfputx/IDYaxVjw7K6YfU2KJEEk5J0o0h2qCPRJiJFWFWFqcDft8oXQdQgN3
	vcr41rReF5whvee8Px4=
X-Received: by 2002:a05:7301:128a:b0:2be:8da:3207 with SMTP id
 5a478bee46e88-2be30fd3614mr228505eec.6.1772593325985; Tue, 03 Mar 2026
 19:02:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aac-QdjY1ohAqgw_@desktop>
In-Reply-To: <aac-QdjY1ohAqgw_@desktop>
From: Koji Nakamaru <koji.nakamaru@gree.net>
Date: Wed, 4 Mar 2026 12:01:54 +0900
X-Gm-Features: AaiRm53HKX6FmUcAysF_j0rCD3tQVC7ra695YLXJrW7bjNyzb93Q7mczzrPagek
Message-ID: <CAOTNsDwdS=+4RuAD6pAt-==uE6S4Wq_4cat+0OqmKV2wgoVheQ@mail.gmail.com>
Subject: Re: Crash on git log with -L and -G on file rename
To: Matthew Hughes <matthewhughes934@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 5:42=E2=80=AFAM Matthew Hughes
<matthewhughes934@gmail.com> wrote:
>
> Hi,
>
> I hit a crash (assertion error) running `git log` with both `-L` and `-G`=
 under
> certain conditions. I've created script to reproduce the behaviour in a f=
resh
> git repo:
>
>     #!/usr/bin/env bash
>
>     set -o errexit
>
>     git init .
>     # Note: example is .rs file, but it should work with anything that -L=
 understands
>     echo "fn my_func() {}" > file.rs
>     # 1. file named 'file.rs'
>     git add file.rs
>     git commit --message 'Add the file'
>
>     # 2. separate branch with the file renamed
>     git checkout -b some-branch
>     git mv file.rs new_file.rs
>     git commit --message 'Move the file'
>
>     git checkout -
>     git commit --allow-empty --message 'Some extra commit so we get a mer=
ge commit'
>     # 3. merge: one parent has file.rs, the other has new_file.rs
>     git merge --no-edit some-branch
>
>     # 4. post merge, move the file back
>     git mv new_file.rs file.rs
>     git commit --message 'Move the file back'
>
>     # 5. things go BOOM
>     git log -L:my_func:file.rs -G '.'
>
> I'm not sure if _every_ step in that script is necessary, but it's the si=
mplest
> setup I could figure out to trigger the crash. Running that script I hit =
the
> error:
>
>     git: line-log.c:1056: process_diff_filepair: Assertion `pair->two->oi=
d_valid' failed.
>     Aborted                    (core dumped) git log -L:my_func:file.rs -=
G '.'
>
> The backtrace shows that the failed assertion occurs under
> `process_ranges_merge_commit`, so maybe there's an issue with the file be=
ing
> renamed on both sides of the merge?
>
> The crash requires both flags to trigger, remove either and it will run f=
ine.
>
> I've tested the above on the `git` from my system package manager on Arch
> Linux: git version 2.53.0, and one built from source at
> 2cc71917514657b93014134350864f4849edfc83 (the version of 'master' checked=
 out
> on my machine at the time). I don't think reproduction relies on any spec=
ific
> config since I've had it trigger with both `GIT_CONFIG_GLOBAL` and
> `GIT_CONFIG_SYSTEM` set to `/dev/null`
>
> Just for reference, I originally triggered the bug in the `rustfmt` repo[=
1]
> (checked-out at cebab3e99259be82ff069e5ae89e91855d79e534) running:
>
>     git log -G offset_left -L:format_trait:src/items.rs
>
> Link: github.com/rust-lang/rustfmt [1]
>

The root cause appears to be that diff_might_be_rename() only checks
diff_queued_diff.queue[i]->one. The following change can fix the issue.

diff --git a/line-log.c b/line-log.c
index eeaf68454e..2da7658ba9 100644
--- a/line-log.c
+++ b/line-log.c
@@ -834,6 +834,10 @@ static inline int diff_might_be_rename(void)
            /* fprintf(stderr, "diff_might_be_rename found creation
of: %s\n", */
            /*  diff_queued_diff.queue[i]->two->path); */
            return 1;
+       } else if (!DIFF_FILE_VALID(diff_queued_diff.queue[i]->two)) {
+           /* fprintf(stderr, "diff_might_be_rename found deletion
of: %s\n", */
+           /*  diff_queued_diff.queue[i]->one->path); */
+           return 1;
        }
    return 0;
 }

--
Koji Nakamaru
