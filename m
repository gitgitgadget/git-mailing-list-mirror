Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5171C3DA78
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 18:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbjAQSen (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 13:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbjAQSbp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 13:31:45 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8A8402D4;
        Tue, 17 Jan 2023 10:02:06 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id u1-20020a17090a450100b0022936a63a21so11529042pjg.4;
        Tue, 17 Jan 2023 10:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=06SBabuD60dOHeW+Ln05X7+rSaJ0r5j5hL5snKdE54w=;
        b=CLBaTDHIhQ+3YYF1XoeZKk02D8QYBaZAjlCuBgKLG8hPkQpjROe96ong7hKknhKU0E
         cwNBmIGl+42af2MolMPj+R+OxoM0UD+TyZrejVjmL2tsAYXI4dTfVomTsPdqUHMY5nXv
         qtlyx2Vox/OshXN/CGBm/JHhoW0/JIWPMC0YAjMHy4djchg3F1l4zf9TAYhvuuqNdhn9
         KjRtKE5+7lceiZ/H/mBwCDvVZPSRU1hw4ilcuzfy+b36tAUsaCMVHbpnAtutvnLQqnte
         JtBxaQZwDEiOjHabPtdls9PGluqyRHGl0jMPIV1lAjlNN3a5FzE+qJ/PKaOT04b8nNut
         0QeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=06SBabuD60dOHeW+Ln05X7+rSaJ0r5j5hL5snKdE54w=;
        b=EDNdW3fVgeull+rSQnIfaJNlwx+qtjGxjXi1rhiHCs+C+jYXLC1JmunbGtVHW9nEfP
         Io4u4mURh8GRjgRUo7hVxbDHxx+Z/IpAZePciksh9/p+gMGChm9RM8ITRAzSp0vlXow9
         w5KTic7i9NipcML1gVKWOU9Ta6aYhkSXQbq2EtxK7kqCpxWXj90uHa+4/g3o3c0trhSm
         vfZJiue31cTxW7xgCt+oRZtaZ2PAMqyWU2j5d1OEQVqHJ0Vg/2f+RC9ha09QuhWEQPjB
         vWwa2oow0VHzrUcRzZhDRFH6c6gDFBa17xxsn4d1PJiq+ATTbwB2FPFn7mEGtsCv3Eqz
         /CFg==
X-Gm-Message-State: AFqh2kqYyfkfossR5eQ9q+mvdbgGF1zG05s2YfWjnNV0pgc7DQnlOGxN
        QbcwfTF0voX1L6C+RhjkhIOCrcuhgxw=
X-Google-Smtp-Source: AMrXdXtksnEnIAx5Gh1uhNBCUsfvsGfNk0JwKZ+rhyojx19HF4m9w7zolWZJm0XSJfVqDQEjlZJ97Q==
X-Received: by 2002:a17:902:bb89:b0:194:9b5e:a0a5 with SMTP id m9-20020a170902bb8900b001949b5ea0a5mr6883617pls.43.1673978525740;
        Tue, 17 Jan 2023 10:02:05 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id w19-20020a170902a71300b0019339f3368asm4995536plq.3.2023.01.17.10.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 10:02:05 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, git-packagers@googlegroups.com,
        lwn@lwn.net
Subject: [ANNOUNCE] Git 2.39.1 and others
Date:   Tue, 17 Jan 2023 10:02:05 -0800
Message-ID: <xmqq7cxl9h0i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A maintenance release v2.39.1, together with releases for older
maintenance tracks v2.38.3, v2.37.5, v2.36.4, v2.35.6, v2.34.6,
v2.33.6, v2.32.5, v2.31.6, and v2.30.7, are now available at the
usual places.

These maintenance releases are to address the security issues
identified as CVE-2022-41903 and CVE-2022-23521.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the v2.39.1
tag, as well as the tags for older maintenance tracks for v2.30.7,
v2.31.6, v2.32.5, v2.33.6, v2.34.6, v2.35.6, v2.36.4, v2.37.5, and
v2.38.3.

  url = https://git.kernel.org/pub/scm/git/git
  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git

 * CVE-2022-41903:

   git log has the ability to display commits using an arbitrary
   format with its --format specifiers. This functionality is also
   exposed to git archive via the export-subst gitattribute.

   When processing the padding operators (e.g., %<(, %<|(, %>(,
   %>>(, or %><( ), an integer overflow can occur in
   pretty.c::format_and_pad_commit() where a size_t is improperly
   stored as an int, and then added as an offset to a subsequent
   memcpy() call.

   This overflow can be triggered directly by a user running a
   command which invokes the commit formatting machinery (e.g., git
   log --format=...). It may also be triggered indirectly through
   git archive via the export-subst mechanism, which expands format
   specifiers inside of files within the repository during a git
   archive.

   This integer overflow can result in arbitrary heap writes, which
   may result in remote code execution.

* CVE-2022-23521:

    gitattributes are a mechanism to allow defining attributes for
    paths. These attributes can be defined by adding a `.gitattributes`
    file to the repository, which contains a set of file patterns and
    the attributes that should be set for paths matching this pattern.

    When parsing gitattributes, multiple integer overflows can occur
    when there is a huge number of path patterns, a huge number of
    attributes for a single pattern, or when the declared attribute
    names are huge.

    These overflows can be triggered via a crafted `.gitattributes` file
    that may be part of the commit history. Git silently splits lines
    longer than 2KB when parsing gitattributes from a file, but not when
    parsing them from the index. Consequentially, the failure mode
    depends on whether the file exists in the working tree, the index or
    both.

    This integer overflow can result in arbitrary heap reads and writes,
    which may result in remote code execution.

Credit for finding CVE-2022-41903 goes to Joern Schneeweisz of GitLab.
An initial fix was authored by Markus Vervier of X41 D-Sec. Credit for
finding CVE-2022-23521 goes to Markus Vervier and Eric Sesterhenn of X41
D-Sec. This work was sponsored by OSTIF.

The proposed fixes have been polished and extended to cover additional
findings by Patrick Steinhardt of GitLab, with help from others on the
Git security mailing list.
