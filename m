Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB211207EC
	for <e@80x24.org>; Sat,  8 Oct 2016 09:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753986AbcJHJgi (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Oct 2016 05:36:38 -0400
Received: from mail-lf0-f51.google.com ([209.85.215.51]:34421 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753460AbcJHJgh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Oct 2016 05:36:37 -0400
Received: by mail-lf0-f51.google.com with SMTP id b81so56712221lfe.1
        for <git@vger.kernel.org>; Sat, 08 Oct 2016 02:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=9oPxQP5957Yb1Xyc5FX1ahQ1j3H925s5ZHP8uWepWds=;
        b=y7EnQTf6pk1E8tiRdoQG3u2EasmY/RgkjNOcnBfZFsTLMZpik4HJ4UB8WUCtNPz9bT
         xutRoWMdMYAj7tE1OOwStWqAzz2q4+LQzGFsg6U8UpHz3x1mTfUwI8s9ckgKTuShv2l0
         Nm2GjYjExarELc/nrAQ/sc48cUz3US9q10BT6wWzTK0NVr11KX4i9rmMBw46GJ/G3Q1h
         HK7lu9kqIjMxM5qYF5WQGctfNC0EAiy5gK3CwaXLmXI6MZhcVrVzLVMTxGqGHEpIZ535
         QoHL/C2dKFLFoFvY0oacEEZ2AxpYpFZXbS82LQyPk3MGr6WIXK0eBK4EtY0B0H72i3Il
         cz+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=9oPxQP5957Yb1Xyc5FX1ahQ1j3H925s5ZHP8uWepWds=;
        b=fEcSRp2Apmyjd5f9OiDWR0icbfGrBNwRc6AmbgBB4Ukj2xN7kR6CgwsOU8SLGen/CP
         F9CE6XX0T6+LsFKIhobH5g0OmpayiS3F7LByZUbUErBa7zx7MdvE52MKT5yW3dWLPKR8
         VoMxsIuEGxYGV9Drp5gv76lrO1wVTk4TEyKrovRt2lXSa/lYUBcUgOoMeOPgfKoZEGVE
         plkUTEDNoW4FgMJTs5tKsZcNOMIVqgYVRNh3AftYZO3Hrfz3V7u6zg5ZyyUZ/OYmPcxo
         m8WApr9MrmC7MSNUq0sgnNn5waxNLY3lxXmJU1SAp39m1Pz+8hORUs3C5hNdNOosBYZS
         XUqw==
X-Gm-Message-State: AA6/9Rmex4JYPYt4TKFQ3CsNnLtVYEXK6aoW/SJrZrRML2t+MRuWGv7np25arpuo/Pp4nP7zrlUBCW5ZQlyaRg==
X-Received: by 10.46.69.212 with SMTP id s203mr8391214lja.72.1475919395786;
 Sat, 08 Oct 2016 02:36:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.165.11 with HTTP; Sat, 8 Oct 2016 02:35:55 -0700 (PDT)
From:   =?UTF-8?Q?St=C3=A9phane_Klein?= <contact@stephane-klein.info>
Date:   Sat, 8 Oct 2016 11:35:55 +0200
X-Google-Sender-Auth: Dunngpyiib81YWdDa3CoyM39l_A
Message-ID: <CADKxhpe3S4L9CPV9yxh2yhrtJMa9wyZAPC45u_S=RiuzY1Xrkg@mail.gmail.com>
Subject: Feature request: use relative path in worktree config files
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

"git worktree add" write absolute path in ".git/gitdir"

The code source is here
https://git.kernel.org/cgit/git/git.git/tree/builtin/worktree.c?h=3Dv2.10.1=
#n256

Is it possible to use relative path in this config files:

* [main_worktree]/.git/worktrees/[worktree_foobar]/gitdir
* [worktree_foobar]/.git

Why:

1. I configure worktree on my host
2. next I use this git working copy in Docker with volume share
3. next I've some git error in Docker because config files use absolute pat=
h

Best regards,
St=C3=A9phane
--=20
St=C3=A9phane Klein <contact@stephane-klein.info>
blog: http://stephane-klein.info
cv : http://cv.stephane-klein.info
Twitter: http://twitter.com/klein_stephane
