Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A44BA20D12
	for <e@80x24.org>; Thu,  1 Jun 2017 04:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751166AbdFAER7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 00:17:59 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:36536 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750895AbdFAER6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 00:17:58 -0400
Received: by mail-io0-f169.google.com with SMTP id o12so26354496iod.3
        for <git@vger.kernel.org>; Wed, 31 May 2017 21:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+n2/5ng7vxkEbAyAXMPZfMTMJjJgGP/wEeEgMhQ4yK0=;
        b=N+bV6TVhZAagTgIEGO5j1PI0VM76I2daCZhp0O86xPDCnjMVNtzWqAngpntVDI9qcX
         RZI7Cyus162mEQUqZKyRMJHdIdaLunViXJIyBkDmmQrVTRGWhsS/FqbgvIQXZTesRhCg
         u19koxR2XhPRy2ulWoGVgq3rwNH+8lsImVaSKGHKl2T4TK4BSOpmZoLexaf2le2WOCG9
         hZUxQL3cLDY9LyZWFBpR1VG5p6OrXkrbCpzJ2R5lw14JTicC7fVpuOx2lgHc0aFwkjVI
         enjnlwYjMJypWXGi57U0YvmhxhJmL25uVnlGSIr3P6iDlWpXZ02ftYDUVSPvfZ+1FEa1
         M54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+n2/5ng7vxkEbAyAXMPZfMTMJjJgGP/wEeEgMhQ4yK0=;
        b=PJb0MCGDuBJSHXXRtYeMpio6lf9tI027Y8zhwtXbB2Iz3eAeop2Wr8QSu/kqEYvCBY
         EAMqhb9wMuTUx0DmUj47qjT3K8wx5Info8l+ZoZWNbGE3K9edqOIneTdelog/p4tpRhR
         IJBEx0gGKWJqn82qMETGfaORwZLlnqSnbLfHo/nCq183/+CunuXIYhhAO+zQQ0P4WZYl
         u7jWXVcGaBghZJCizDMcQ2srZC8aMdyiS6FRIQEPaufBKYYZGv+LHSTbEmC1A6+EjTvN
         YOkCWx5LuAb9kN3jhgthpohPunVrwZ6UjpbBr6Z8MCKyDSTII9ik6CqAuGfBY/AwXsak
         buPg==
X-Gm-Message-State: AODbwcBW40bG+pcybvwYnHcutDvyFSm3Ww9KDcv2IRWguVUvNLNr/iQ/
        9QSFhmjEvbJenw==
X-Received: by 10.107.135.142 with SMTP id r14mr25288171ioi.36.1496290677742;
        Wed, 31 May 2017 21:17:57 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:9c1c:dca9:c6e3:133e])
        by smtp.gmail.com with ESMTPSA id r12sm5050845ita.30.2017.05.31.21.17.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 31 May 2017 21:17:56 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Zero King <l2dy@macports.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 8/8] t0012: test "-h" with builtins
References: <20170530050949.dkgu3u26qj6ycusy@sigill.intra.peff.net>
        <20170530051930.pqywvihwl5klg7hz@sigill.intra.peff.net>
        <xmqqwp8yc255.fsf@gitster.mtv.corp.google.com>
        <20170530060555.ponbsyp4agdo4yau@sigill.intra.peff.net>
        <xmqqshjmc1wm.fsf@gitster.mtv.corp.google.com>
        <20170530061546.tdpuhvq7yk34rvlj@sigill.intra.peff.net>
        <xmqqo9uabhqt.fsf@gitster.mtv.corp.google.com>
        <20170530152756.vs777v6unaxg6otb@sigill.intra.peff.net>
Date:   Thu, 01 Jun 2017 13:17:55 +0900
In-Reply-To: <20170530152756.vs777v6unaxg6otb@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 30 May 2017 11:27:56 -0400")
Message-ID: <xmqqinkg734c.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Anyway, the problem is sk/dash-is-previous, specifically fc5684b47
> (revision.c: args starting with "-" might be a revision, 2017-02-25). It
> looks like the revision parser used to just bail on "-h", because
> revision.c would say "I don't recognize this" and then cmd_rev_list()
> would similarly say "I don't recognize this" and call usage(). But now
> we actually try to read it as a ref, which obviously requires being
> inside a repository.

Heh, I found another ;-)  

95e98cd9 ("revision.c: use refs_for_each*() instead of
for_each_*_submodule()", 2017-04-19), which is in the middle of
Duy's nd/prune-in-worktree series, does this:

#0  die (err=0x6128f8 "BUG: setup_git_env called without repository") at usage.c:114
#1  0x00000000004f9467 in setup_git_env () at environment.c:172
#2  0x00000000004f966c in get_git_dir () at environment.c:214
#3  0x000000000055113b in get_main_ref_store () at refs.c:1544
#4  0x0000000000570ee0 in handle_revision_pseudo_opt (submodule=0x0, 
    revs=0x7fffffffd6a0, argc=1, argv=0x7fffffffe180, flags=0x7fffffffc59c)
    at revision.c:2110
#5  0x00000000005716f5 in setup_revisions (argc=2, argv=0x7fffffffe178, 
    revs=0x7fffffffd6a0, opt=0x0) at revision.c:2254
#6  0x000000000043074a in cmd_diff_files (argc=2, argv=0x7fffffffe178, prefix=0x0)
    at builtin/diff-files.c:29
#7  0x0000000000405907 in run_builtin (p=0x87ba00 <commands+672>, argc=2, 
    argv=0x7fffffffe178) at git.c:376
#8  0x0000000000405bb5 in handle_builtin (argc=2, argv=0x7fffffffe178) at git.c:584
#9  0x0000000000405e04 in cmd_main (argc=2, argv=0x7fffffffe178) at git.c:683
#10 0x00000000004a3364 in main (argc=2, argv=0x7fffffffe178) at common-main.c:43

when jk/consistent-h is merged into it and then "git diff-files -h"
is run.

I guess anything that calls setup_revisions() from the "git cmd -h"
bypass need to be prepared with that

  check_help_option(argc, argv, usage, options);

thing.  Which is a bit sad, but I tend to agree with you that
restructuring to make usage[] of everybody available to git.c
is probably too noisy for the benefit it would give us.


