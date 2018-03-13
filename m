Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1942B1F404
	for <e@80x24.org>; Tue, 13 Mar 2018 18:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751517AbeCMSXP (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 14:23:15 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:35468 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751362AbeCMSXO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 14:23:14 -0400
Received: by mail-qk0-f170.google.com with SMTP id s188so665380qkb.2
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 11:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:subject:date:message-id:cc:to
         :mime-version;
        bh=Ph2/0Nmfk26FaBnc9M71RVINOAsVpDINL2M4eM4FNmQ=;
        b=Jv5U8bYD8A1XkMTctGp+Sn2oYdI7tfViIHy33HufRlvEXqWk3YZW+TDwz7+LpBp3/E
         7rw8HVRVw0n+YiCPoeC6VtmPHYFk72cr9BtgtYuD4/Mde8/s5fs6y2OhFWDVcjtSjwro
         W7Zi2Dm3+XdaI/vKgxMGd+ULsBVN5QZB5SxU+gAUxDN+k2cZ7DjLXssD9NMfnfWqeYQ9
         lFYWFM25Pu6U65CUy3B+zyXeehetH1q6Lfg94YkL7s0tXefJ8sd4c0Xok46qhmBxdGYJ
         6K4+u3YJ49e6lO6JhmLTS83y/vtBJps9YnTjX8CgurY4jknA0ogQ0qWvb8SFAkg6hVxK
         Pngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:subject:date
         :message-id:cc:to:mime-version;
        bh=Ph2/0Nmfk26FaBnc9M71RVINOAsVpDINL2M4eM4FNmQ=;
        b=YV623jOPkewdTj1Ck9R1e1rD7uwmHUDFdXmU1I/YdBo+M8OT/dipQ/aT5E2RB959NF
         UvBNJQ2qQs7xEMIGQABIQmHikepCxkMYJo3CoDTPeYhcs2UWdZPT1/rvPz3mUR3DFses
         J0xwQUHHxW5glWMoVHbEKK2VEeysF+d3T3sDhbF28Jj8yzZRSXLC+yQSOSXeQaPzAENj
         HCQCOxV7Qcn+t8+WtTxLLyXgOHGowHiiw/eoy7U17C5O+c141IPiqhn/EFfWSZp8WUy4
         CUxABH8+AMgfiP9gF3SD5SoWh5QnhF5meqvKIj1NliTu/t2nZ+luIBeO4GdzDhZ8axHD
         wEUQ==
X-Gm-Message-State: AElRT7Eq2V03NCWPIWnqD/YaEXg3VJi9U44t++VWtFLr2r8cnUAZt4wI
        sXo6ByCQp3+Zaafywygx36g=
X-Google-Smtp-Source: AG47ELtlA9ODMSjNOp4FP4ZsSAxQdHhfPKpCBuFkHxcOERtUvZK0TfYQKWGSLw/qr75FdixxsI4HmQ==
X-Received: by 10.55.103.130 with SMTP id b124mr2489704qkc.244.1520965393496;
        Tue, 13 Mar 2018 11:23:13 -0700 (PDT)
Received: from [10.8.0.14] ([52.177.192.239])
        by smtp.gmail.com with ESMTPSA id h184sm197608qkc.78.2018.03.13.11.23.11
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Mar 2018 11:23:12 -0700 (PDT)
From:   Stan Hu <stanhu@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: Re: Bug in "revision.c: --all adds HEAD from all worktrees" ?
Date:   Tue, 13 Mar 2018 11:23:08 -0700
Message-Id: <C62FA8BB-FDCA-4BD0-A029-74C7AB89441F@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, luke@diamand.org,
        pclouds@gmail.com
To:     avarab@gmail.com
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To be clear, this is how I think we got into this state:

We have worktrees that are created to squash and rebase a branch. They =
were left around inadvertently for one reason or another.

Since we were using git v2.14.3, a git gc would prune dangling objects =
because it never saw that a worktree still had a reference to it. Now, =
in git v2.15+, worktrees are examined, and a git gc won't garbage =
collect any objects referenced by a worktree.

Another words, the failure of git v2.14 to preserve these objects caused =
problems with these stale worktrees with the upgrade to v2.15+.

