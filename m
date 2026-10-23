Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792761546;
	b=wctU1vpkXZwUmldPR9dJ7WYMUDzRe5bQcBvMDsW9nEPFzbyBxnaXUjIgAzTsX1x4iD0t
	 lKD4gCmA0hTMV6o1vDlLO9gMJtqfQuzn2yFVa+3SnvfzOKhku+5XmgehLpWb8VpwUDCCf
	 fP/tmwMkQYXsO7k3UoKMlrJmRlJrdgHq7j1RS9F0oQnuJK9X016dV5/hFI+jIl4FqF2EQ
	 11sNnk1+QDdoJx8PVp9Z5OqZh6IypKMGmZ9gfBoq7vnSGM5wsabKU0/reWGyvmbAGsQZz
	 Z4AxpS70+DIOvnBfz6aZIOBMkvKwEw7GJoFZFOx25Ieqa+JSLdBqx2CUrurDhR3eAuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792761546;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=uiT+RoCOrpAagEBVHB4qc+drez9WuKYA+QefzHQ518I=;
	b=zApa4NSU3EZID8RNqSSuCzTfYJEwDRaOqbMjm5a7NMIgMZoeeABY9RyIDJ2+gf/XOfQ6
	 ql4DErYLRaq399P/dAVLGQuT274zcroqFRCVVxFBBqz97XHT3l+CcHCzQ+XRfBs3Ma6B5
	 HwtUOKkyk85lXqibIm6JFvFz38OeArpHasRK8nGh0c1AWW9ra2HLkgQi9m6cOZdF3BI80
	 emTYvNG0RQvJI2PrMe7a3oCT9Hg/5f1xSFtsfaUEhH1vT6Qxuq/t2ovGSlip8eDzTOuJv
	 5O2JT1xFweRdO9tXT/W8bFPVepMbsX53mInceZPPWq+KjyVY/vNiRDXJvSCmWEFfY7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jRPcpF7C;
	arc=none smtp.remote-ip=209.85.210.48
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F26606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 13:19:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85F26606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jRPcpF7C
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-8241a56cd70so510085a34.3
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 06:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792761544; x=1793366344; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uiT+RoCOrpAagEBVHB4qc+drez9WuKYA+QefzHQ518I=;
        b=jRPcpF7CVIGfeoN4Piejew12PgrpiVwTURlNrAOwLhfKeP132bRzgtnGlqv71Edk/w
         XSb2HKbUb1dca/PqnuLYjWVpRarNaHWUQBhO6LpaotrKRf+0qEyrQEfgNMS7uHjO+ZZg
         l+WbXtC6JQH0eurQGaMK8rGs+TwNmiNTpwBtI0aOMRrFZ9hvzKhcI7O9+eYtMfbfTQLH
         jQnoivp5afLwBzBYB+1+NKUVfDewGw9V+wlYRe6mNd7yLzDqNyU68wUzbpwxq7kcJnD7
         T7nMx/99Id3dNql9HXNJcNNKSEJKuFQYZKLJZE67KJvW02Sd6ajzmc9YHjXFALR4ioSn
         MEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792761544; x=1793366344;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uiT+RoCOrpAagEBVHB4qc+drez9WuKYA+QefzHQ518I=;
        b=fLntorCdPYiUAKmVDQrrFHbFMLY1TpV+buU9CmpjigbCLL5OFf1nXTm22IdvvGdKcE
         ju19gCanP30/oAgMoudv+0JvJ+/Znky67L4MhEyzWGttDHwrko3Yn9Fn3SPaX995y4xt
         /KOGBMJEcBXTl6rxckkmQc9uEPUSkbVK7i6qnwN010HjVnIRz+vfLXazOTRjzh6fl04+
         OHTkd0hrWPv1pF7oSo5IyzIcysqDyMxYzJl8sA5a7e8dMTLpy82qnnOZLc6XjKrx58DY
         W+/LYHMzDveIxJEHBxHinThGJFNRNYW6sY+K63e28MT/a2mRph7/ENLNFWHcsZjpHtRw
         qbYg==
X-Gm-Message-State: AFq9FYIPK/Iwt9la1/SDq+lY9HrTQwHfg7BLIHglW9Kx4CAp36etsGGS
	bDO8GnFK5sLDi4OdP4v3mJ8n+U/yatHO6vCPHkT/n0By2a8lcPN1W+7IKFkHllQrfDU=
X-Gm-Gg: AYBFou1UvrcM0JWDDcIQf0kwFLbZc+79pPMerXYSi57wpwwTIZOp32QbgOODYAAdUYu
	kQfm31FFLjjsyPZW6MnrWwn2JQAnLMYrhAUb7Mpvx9Tl87/p220YeHz0YqT47nDBmwGNSWKJkIP
	k1AFciA/a8JOwrVJWVdH0osSyV5npX7lvUi4FNQF4yD66oqpXLA049Ek+FMR1npo9JvVYFPJcMn
	iJbnGBs7efs7fMU6isHta7o0bkzGYswlBuOTQuQFrAGGVqPBLItWkp/RZSdcKBYa4XfiNbnFeAg
	O8mUHZG3ciSjpJh0cNcUXj7RkSl7+p0LWjHaQbTQP+4tM3KKsYopni7U2EcISAxmxgA5Ojez2PP
	Ukgr7lgh4ehts5WB8s0CTk1z1CVQW6ZFKrxrDhX5fs70MSMluJKoMrTVbX7PkX3jgvkXmsrA4S9
	Wj0wk++U30B2mgMv134fCBU3iqzLnoU8iiZOEGXtzXr+okf4xCvIxFYrMK4Fcqx1spKxrwMR4v/
	WRaMjXWvhMgnKcnH3iqg0JTYal4zUp93zJq0aJyi/P5Ti6BUSTr/0PZ4qliQA==
X-Received: by 2002:a05:6830:4486:b0:84e:4a6e:5ce6 with SMTP id 46e09a7af769-84faf870c66mr1527262a34.17.1792761544074;
        Fri, 23 Oct 2026 06:19:04 -0700 (PDT)
Received: from [127.0.0.1] ([130.131.204.232])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-84fbdf594fcsm2046873a34.14.2026.10.23.06.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 06:19:02 -0700 (PDT)
Message-Id: <pull.2272.v2.git.1792761542.gitgitgadget@gmail.com>
In-Reply-To: <pull.2272.git.1792520353.gitgitgadget@gmail.com>
References: <pull.2272.git.1792520353.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 23 Oct 2026 13:19:00 +0000
Subject: [PATCH v2 0/2] Two hook configuration changes
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>,
    Patrick Steinhardt <ps@pks.im>,
    Emily Shaffer <nasamuffin@google.com>,
    Junio C Hamano <gitster@pobox.com>,
    Thomas Bachem <mail@thomasbachem.com>

Two small changes to hook configuration. With the first,
hook.pre-commit.enabled=false also stops the pre-commit hook in the hooks
directory. With the second, hook.*.enabled and hook.*.parallel can be given
without a value, which means true, as for any other boolean.

Changes since v1:

 * The documentation of hook.<event>.enabled now says that it covers
   configured hooks and the hook in the hooks directory alike. The subject
   and message of patch 1 present this as a change in behavior rather than a
   fix (Adrian, Junio).

 * The test that hook.<event>.enabled=false leaves the hooks of other events
   alone now has a hookdir hook too.

Thomas Bachem (2):
  hook: make hook.<event>.enabled cover the hookdir hook
  hook: accept .enabled and .parallel given without a value

 Documentation/config/hook.adoc |  3 +-
 builtin/hook.c                 |  6 ++--
 hook.c                         | 17 ++++++----
 hook.h                         |  8 ++++-
 t/t1800-hook.sh                | 57 ++++++++++++++++++++++++++++++++--
 5 files changed, 78 insertions(+), 13 deletions(-)


base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2272%2Fthomasbachem%2Fhook-event-enabled-hookdir-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2272/thomasbachem/hook-event-enabled-hookdir-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2272

Range-diff vs v1:

 1:  1a7d060fae ! 1:  cfcbe80ba5 hook: honor hook.<event>.enabled for the hookdir hook
     @@ Metadata
      Author: Thomas Bachem <mail@thomasbachem.com>
      
       ## Commit message ##
     -    hook: honor hook.<event>.enabled for the hookdir hook
     +    hook: make hook.<event>.enabled cover the hookdir hook
      
     -    The documentation added by dcfb5af67e (hook: add hook.<event>.enabled
     -    switch, 2026-04-10) says that with hook.<event>.enabled set to false
     -    "no hooks fire for that event", but only hooks defined in the
     -    configuration are skipped. With hook.pre-commit.enabled=false,
     -    "git commit" still runs .git/hooks/pre-commit, and "git hook list"
     -    shows that hook without the "event-disabled" mark.
     +    hook.<event>.enabled, added by dcfb5af67e (hook: add
     +    hook.<event>.enabled switch, 2026-04-10), skips only the hooks
     +    defined in the configuration when set to false. With
     +    hook.pre-commit.enabled=false, "git commit" still runs
     +    .git/hooks/pre-commit, and "git hook list" shows that hook without
     +    the "event-disabled" mark.
      
     -    Move the event_disabled flag out of u.configured in struct hook, set
     -    it for the hookdir hook too, and check it for both kinds of hooks.
     +    That was the intent, but the documentation says "no hooks fire for
     +    that event", which reads as covering the hookdir hook too. No other
     +    setting turns off the hookdir hook of a single event either:
     +    core.hooksPath=/dev/null turns off the hookdir hooks of all events.
     +    Make the switch cover the hookdir hook as well, and say so in the
     +    documentation. This changes behavior for anyone who set the switch
     +    and relied on the hookdir hook still running.
      
          The test for hook.<event>.enabled=false looks only at the standard
          output, but "git hook run" sends hook output to the standard error,
     @@ Commit message
          Assisted-by: Claude Fable 5.1
          Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
      
     + ## Documentation/config/hook.adoc ##
     +@@ Documentation/config/hook.adoc: hook.<friendly-name>.parallel::
     + 	the effective job count is greater than 1. {see-git-hook}
     + 
     + hook.<event>.enabled::
     +-	Switch to enable or disable all hooks for the `<event>` hook event.
     ++	Switch to enable or disable all hooks for the `<event>` hook event,
     ++	configured hooks and the traditional hook in the hooks directory alike.
     + 	When set to `false`, no hooks fire for that event, regardless of any
     + 	per-hook `hook.<friendly-name>.enabled` settings. Defaults to `true`.
     + 	{see-git-hook}
     +
       ## builtin/hook.c ##
      @@ builtin/hook.c: static int list(int argc, const char **argv, const char *prefix,
       
     @@ t/t1800-hook.sh: test_expect_success 'hook.<event>.jobs rejects values less than
       '
       
       test_expect_success 'hook.<event>.enabled=true does not suppress hooks' '
     +@@ t/t1800-hook.sh: test_expect_success 'hook.<event>.enabled=true does not suppress hooks' '
     + test_expect_success 'hook.<event>.enabled=false does not affect other events' '
     + 	test_config hook.hook-1.event test-hook &&
     + 	test_config hook.hook-1.command "echo ran" &&
     ++	test_hook test-hook <<-\EOF &&
     ++	echo hookdir ran
     ++	EOF
     + 	test_config hook.other-event.enabled false &&
     + 	git hook run --allow-unknown-hook-name test-hook >out 2>err &&
     +-	test_grep "ran" err
     ++	test_grep "^ran$" err &&
     ++	test_grep "^hookdir ran$" err
     + '
     + 
     + test_expect_success 'hook.<friendly-name>.enabled=false still disables that hook' '
      @@ t/t1800-hook.sh: test_expect_success 'git hook list shows event-disabled hooks as event-disabled'
       	test_config hook.hook-1.command "echo ran" &&
       	test_config hook.hook-2.event test-hook &&
 2:  3db167c9d1 = 2:  53a5a1787a hook: accept .enabled and .parallel given without a value

-- 
gitgitgadget
