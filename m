Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DA3C05027
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 18:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbjBNSFL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 13:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbjBNSFH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 13:05:07 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7D52DE7B;
        Tue, 14 Feb 2023 10:05:04 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id fu4-20020a17090ad18400b002341fadc370so4523461pjb.1;
        Tue, 14 Feb 2023 10:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a/30totliODEH86d4s7yTqh1xVH9NfBjaZa+zjnDO/c=;
        b=SiRsmbcm0rYggSVTzIZOA8sZ7SWL0XqG/PuADk+YJzz8eZPcJp3akUS+61rz40V4Cy
         IDA6vopYw9W2GaG2RtI6Su/EggkclvrUprEFshmZKKjs0AKHpfLQse+kwaoxcvlWO3IB
         gK7tNCniHVunkHh5CBqqrxEEuVjsVV9fKzB6wgO2bWF9BY/gx3ORaGf2gUBxha8a8Txm
         Asp2cCcJd3eMPfTH7b0efJEKiuqFV7KRtKKELX4Nu2C4q5lT7Te8pU7IxZT6pNSGj/lh
         Vhf/NbLLB8xNQKSj1LjMAT2s9Ltb88ud0zM3yp9xxjdy3gSta2Jyfbwyo2ZjA+FhAmip
         vfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a/30totliODEH86d4s7yTqh1xVH9NfBjaZa+zjnDO/c=;
        b=fRRo7cUxMaiXcWzJTkn752qnCSQ1hVsbfg3Yxs52DXcG5YB0M2B0yRRUGvYR2lIfM4
         +3mti+pod8sEzSo6V5Bg3ldMFGUt6uPmwiHY1XiuLkgBT0o51cSOEwT7cwdicU/1klbj
         xJF55FxszNL7H5ZYXU+5TY3gLvDc11Ig9481sibzhxvbUUEQsg6ldEl0/dc4JCA9815M
         I9VaQ2z/dXBnwoFwLX8KInW5YcZa0WOWSrOer0BqDJjEQ74Vbq2t9z3nQQbALX7QW2B6
         eC5QZrobK/RoRUIDZ+Rf+4qqMJffiU6p1hDC8JU7EoVqxJ2D9K+lwwCLpha4j5b+dsc8
         YFMQ==
X-Gm-Message-State: AO0yUKUjlTACP1LYp19lem4Vs+YUkuPwePcdSuiVnfqbSk0aWFMDUb7J
        OLwRrFKzxhSKCaaHQOakGgWMARjlgmg=
X-Google-Smtp-Source: AK7set+E8VQg9Jb85Rikix0JLva+MYuPsfcgprmCG3JJ7RGuW/bliCsOwZBZugn2JnelslqQvYms0g==
X-Received: by 2002:a17:902:d48c:b0:199:16c6:8a24 with SMTP id c12-20020a170902d48c00b0019916c68a24mr3907362plg.61.1676397903975;
        Tue, 14 Feb 2023 10:05:03 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id c13-20020a170902c1cd00b0019ab58f47a6sm2002752plc.105.2023.02.14.10.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 10:05:03 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com, oss-security@lists.openwall.com,
        git-security@googlegroups.com
Subject: [Announce] Git 2.39.2 and friends
Date:   Tue, 14 Feb 2023 10:05:03 -0800
Message-ID: <xmqqr0us5dio.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A maintenance release Git v2.39.2, together with releases for older
maintenance tracks v2.38.4, v2.37.6, v2.36.5, v2.35.7, v2.34.7,
v2.33.7, v2.32.6, v2.31.7, and v2.30.8, are now available at the
usual places.

These maintenance releases are to address two security issues
identified as CVE-2023-22490 and CVE-2023-23946.  They both affect
ranges of existing versions and users are strongly encouraged to
upgrade.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.39.2'
tag, as well as the tags for older maintenance tracks listed above.

  url = https://git.kernel.org/pub/scm/git/git
  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git

The addressed issues are:

 * CVE-2023-22490:

   Using a specially-crafted repository, Git can be tricked into using
   its local clone optimization even when using a non-local transport.
   Though Git will abort local clones whose source $GIT_DIR/objects
   directory contains symbolic links (c.f., CVE-2022-39253), the objects
   directory itself may still be a symbolic link.

   These two may be combined to include arbitrary files based on known
   paths on the victim's filesystem within the malicious repository's
   working copy, allowing for data exfiltration in a similar manner as
   CVE-2022-39253.

 * CVE-2023-23946:

   By feeding a crafted input to "git apply", a path outside the
   working tree can be overwritten as the user who is running "git
   apply".

Credit for finding CVE-2023-22490 goes to yvvdwf, and the fix was
developed by Taylor Blau, with additional help from others on the
Git security mailing list.

Credit for finding CVE-2023-23946 goes to Joern Schneeweisz, and the
fix was developed by Patrick Steinhardt.

Johannes Schindelin helped greatly in packaging the whole thing and
proofreading the result.

Thanks.
