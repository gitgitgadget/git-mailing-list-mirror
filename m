Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A2FC77B75
	for <git@archiver.kernel.org>; Wed, 17 May 2023 18:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjEQSiX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 14:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjEQSiT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 14:38:19 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72F17EF9
        for <git@vger.kernel.org>; Wed, 17 May 2023 11:38:15 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-4d9b2045e1cso1078a12.1
        for <git@vger.kernel.org>; Wed, 17 May 2023 11:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684348694; x=1686940694;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IPN3JV8fhVzq0lmEXvJbl8ypLiO4J2LP3BuwtLDEWpw=;
        b=l421acRqVdBqycXSCEWOgftqJKl4ajReVUhV6awT3R22oKyAQ4RWZgGlZWboIYtqcy
         5e7muEqu+CTJA3WkNBtPuTmoLsuyS0h4rh+U9ixXbG+NXljcKnubX/t37x+DLXHfLvKV
         s9wUTK7N3faxz1FjN/Kd7oxyykU6DcixipEgCMSNGjqgjhKzkB6C6Fz7d2W2Ozz5VFap
         9O4nw+HbwgK0tIk7KOa20MXyhdT7D37wJMRTQh6HQ3soe513WuSsGVgrg7sXbJ7E+DPn
         8Jc+R4TX3UIPc3AY3jbUfbyLc8TpzCJYj8t43NM+eqYybEvubTB9GNGHI1T6z/+QXEyb
         TM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684348694; x=1686940694;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IPN3JV8fhVzq0lmEXvJbl8ypLiO4J2LP3BuwtLDEWpw=;
        b=fmFTRoDc536+UUpTIONBeExX+DW3VxXqbdZDZu14B6Kuh0baNyPbzEiV0/Z9PjR39Y
         kpJVZPbbHQXt2OZT1y97SRX0SukVSI2z9YBztFwbN67n/PpV/0p8C6J3f4ImZpOHLVDC
         uB9gYVN3WMXGncEF+rjMn6EjQRjbUWfWhIzOwKsj2+yrMJ5TpoZYfC8UgRyIA6KvTwUa
         LqqjJUN5QuMa7B3Y0vt+BBmAWYvug+ablY9C6z74jqmhUOh8j4t5zJt9QnArCluu4sDI
         uGf11vaKZ1FODj8hgREgsyyZa9oM4HoT3H8YU6W62EZpeoWP6a1QjmF/7n4lXjsWowSN
         Y1tw==
X-Gm-Message-State: AC+VfDzP8cQfGiOStyybfhynLWd8dI3mVBUre7cn88U1DkhOiIQZdpe3
        ZytvnyNHmD2x8DG4vO1W2mWYRHU6M8mBRBo8GoZ5MiRpFZI81Ux4kU6DQkWS
X-Google-Smtp-Source: ACHHUZ5dmqB/6eWrsXnMm6hOndKP8E5+0FKqjEyjGmpIxA0rSWfn2smIiOvkFfR1ecKsZAS8JbnGg0fj/VwSkvpJAyE=
X-Received: by 2002:a50:9508:0:b0:50d:bb88:a80c with SMTP id
 u8-20020a509508000000b0050dbb88a80cmr8751eda.3.1684348693297; Wed, 17 May
 2023 11:38:13 -0700 (PDT)
MIME-Version: 1.0
From:   Emily Shaffer <nasamuffin@google.com>
Date:   Wed, 17 May 2023 11:38:01 -0700
Message-ID: <CAJoAoZ=GGgjGOeaeo6RFBO7=6msdRf-Ze6XcnL04K5ugupLUJA@mail.gmail.com>
Subject: bug report: cover letter is inheriting last patch's message ID with send-email
To:     Git List <git@vger.kernel.org>
Cc:     michael.strawbridge@amd.com, dianders@chromium.org
Content-Type: multipart/mixed; boundary="0000000000008b690405fbe7fd92"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--0000000000008b690405fbe7fd92
Content-Type: text/plain; charset="UTF-8"

Following is a report from inside of Google:

**What did you do before the bug happened? (Steps to reproduce your issue)**

```
# With the attached patches, where all of the patches have a
# Message-Id but the cover letter doesn't.
git send-email *.patch
```

Specifically, you can see me doing it:

```
$ git send-email *.patch
0000-cover-letter.patch
0001-dt-bindings-interrupt-controller-arm-gic-v3-Add-quir.patch
0002-irqchip-gic-v3-Disable-pseudo-NMIs-on-Mediatek-devic.patch
0003-arm64-dts-mediatek-mt8183-Add-mediatek-gicr-save-qui.patch
0004-arm64-dts-mediatek-mt8186-Add-mediatek-gicr-save-qui.patch
0005-arm64-dts-mediatek-mt8192-Add-mediatek-gicr-save-qui.patch
0006-arm64-dts-mediatek-mt8195-Add-mediatek-gicr-save-qui.patch
To whom should the emails be sent (if anyone)?
Message-ID to be used as In-Reply-To for the first email (if any)?
(mbox) Adding cc: Douglas Anderson <dianders@chromium.org> from line
'From: Douglas Anderson <dianders@chromium.org>'

From: Douglas Anderson <dianders@chromium.org>
To:
Cc: Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 0/6] irqchip/gic-v3: Disable pseudo NMIs on Mediatek
Chromebooks w/ bad FW
Date: Thu, 11 May 2023 15:25:55 -0700
Message-ID: <20230511151719.6.Ia0b6ebbaa351e3cd67e201355b9ae67783c7d718@changeid>
```

If you look at `0000-cover-letter.patch` you can see that it has no
Message-ID, but the above clearly shows that the cover letter is being
sent with a Message-ID (and the one from the last patch).


**What did you expect to happen? (Expected behavior)**

The cover letter should get an auto-generated Message-Id like it always used to.

**What happened instead? (Actual behavior)**

The cover letter ends up with the same Message-Id as the last patch.

**What's different between what you expected and what actually happened?**

See above.

**Anything else you want to add:**

This happens when using the `patman` tool to send patches with a cover
letter. The individual patches encode the "Change-Id" in the
Message-ID but the cover letter doesn't need any special Message-Id.

I didn't notice this until after I sent a patch series and thus:

https://lore.kernel.org/r/20230511150539.6.Ia0b6ebbaa351e3cd67e201355b9ae67783c7d718@changeid/

...refers to both my cover letter and the last patch in the series.

**Please review the rest of the bug report below.
You can delete any lines you don't wish to share.**

```
[System Info]
git version:
git version 2.40.1.606.ga4b1b128d6-goog
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.1.15-1rodete3-amd64 #1 SMP PREEMPT_DYNAMIC Debian
6.1.15-1rodete3 (2023-03-28) x86_64
compiler info: gnuc: 12.2
libc info: glibc: 2.36
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
commit-msg
pre-auto-gc
pre-commit
prepare-commit-msg
```

The report references an internal build based on 2.40.1, but we were
able to reproduce on upstream git version 2.41.0.rc0.4.g004e0f790f
(without using `patman`).

Note that the internal report did come with the output of `git
format-patch` as a zipped attachment, which I tried to attach and am
hoping won't get filtered. As described in the report, the patches
themselves already contain Message-IDs, but the cover letter does not.
At the mail linked in the bug, you can notice that patch 6 has two
Message-IDs for some reason, and the one that's clearly not generated
by the `patman` helper is appended to patch 6 instead of patch 0.

Bisecting shows that this bug was introduced at a8022c5f7b
(send-email: expose header information to git-send-email's
sendemail-validate hook, 2023-04-19), thanks Josh for bisecting it.

 - Emily

--0000000000008b690405fbe7fd92
Content-Type: application/x-compressed-tar; name="gitpatches.tgz"
Content-Disposition: attachment; filename="gitpatches.tgz"
Content-Transfer-Encoding: base64
Content-ID: <f_lhs1eiwm0>
X-Attachment-Id: f_lhs1eiwm0

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
--0000000000008b690405fbe7fd92--
