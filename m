Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96A381F954
	for <e@80x24.org>; Thu, 23 Aug 2018 09:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbeHWNZS (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 09:25:18 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:40483 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbeHWNZR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 09:25:17 -0400
Received: by mail-ed1-f48.google.com with SMTP id e19-v6so3206351edq.7
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 02:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:in-reply-to:user-agent:date:message-id
         :mime-version;
        bh=ppVGpu+tYOdixqB+gDTdXqNhi4fZ9xA1KL6Uc3EFVKI=;
        b=FrATfgQl//670Tir4nqY9fHtx/TZzvxG20ehbKS55j5BK3SLVo2PgQD6u7U51CfTnI
         w/vv57mczuoAR9pJckiCpGJ8+BZuxbUQ7aZBOKfKbQgb+1MtBBEmeJcWXlyCe2czRlGN
         FADEDIdWMCI/Pzh+oFw3QVhXLVhaeB0xhapHbhfj3qbd8HRCzOOiSRnRpGa+wNRLgDC1
         5HTpL5CkstO0L84EyvasLHZIBlFLWtBpqRYDNAa+q8T5EFQQKm5bixDiwhf+njTP9Aen
         z+oKhRIWdHSUynYNEbfCMWqriSCaq40JT4IRD3lfY6s/yr8ahJ6xzDuhpLdxZOKjBvbC
         ptog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:user-agent:date
         :message-id:mime-version;
        bh=ppVGpu+tYOdixqB+gDTdXqNhi4fZ9xA1KL6Uc3EFVKI=;
        b=d9AvRwjyT2tf+9+kH2JoJVJe844z2qbxLczI2KnDVz6uWa6/BRCaWU8SJLFk5F3wuh
         ScvdNI4338r0nKVlOTsxqHrTzjLcy7T/nY+3FRXMR11yTel5jKxnKOSTCjvHpwZekeGw
         FosMSMn30LPTSzB9FvoBe2Ff6Dg14g4aVpIzfqOHghQFwSlV4/EL+cqMAfFfjljvMDjx
         ho8h3ZCvM2S7vIJCEwemHz3iiPgdLFFBnwAUTahAVm9ifw8yMNBiYGQiAFldmf7sEWiq
         gIJXbAPpV67NuIOkOl22MPt+acp4oV76gdXV4YAVkasL2Vso0rxmp3hH5/1MokiX5gxt
         9cZQ==
X-Gm-Message-State: APzg51AfikNmPXEDkwBxlhCapZ7e5cVmOB6LxZDaambdOdXDfDcTVqLh
        2Y3zRRQKXL9tgXbk3SltUgJv+tMOZHQ=
X-Google-Smtp-Source: ANB0Vdb73PzQyRU6iyAWkroN4auzantkmx/20sR+EKNj981og046DNd+K/v9VIRhP4Z0fNklPAE+iQ==
X-Received: by 2002:a50:d9c6:: with SMTP id x6-v6mr1232926edj.63.1535018180067;
        Thu, 23 Aug 2018 02:56:20 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id v1-v6sm1783038edf.3.2018.08.23.02.56.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 02:56:19 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Benoit Lecocq <benoit@openbsd.org>, kn@openbsd.org,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Test failures on OpenBSD
In-Reply-To: <20180823091427.1756-1-avarab@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
Date:   Thu, 23 Aug 2018 11:56:18 +0200
Message-ID: <87a7pdfltp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is on OpenBSD 6.2 amd64 with my "tests: fix and add lint for
non-portable head -c N" patch (which fixes one failure).

    $ for t in t1305-config-include.sh t1308-config-set.sh t5004-archive-corner-cases.sh t5552-skipping-fetch-negotiator.sh; do ./$t --no-color -v -x 2>&1 | grep -B10 "^not ok"; done
    
    + cd bar
    + echo [includeIf "gitdir:bar/"]path=bar7
    + >> .git/config 
    + echo [test]seven=7
    + > .git/bar7 
    + echo 7
    + > expect 
    + git config test.seven
    + > actual 
    error: last command exited with $?=1
    not ok 27 - conditional include, gitdir matching symlink
    --
    + cd bar
    + echo [includeIf "gitdir/i:BAR/"]path=bar8
    + >> .git/config 
    + echo [test]eight=8
    + > .git/bar8 
    + echo 8
    + > expect 
    + git config test.eight
    + > actual 
    error: last command exited with $?=1
    not ok 28 - conditional include, gitdir matching symlink, icase
    	test_cmp expect actual
    
    + echo Error (-1) reading configuration file a-directory.
    + > expect 
    + mkdir a-directory
    + test_expect_code 2 test-tool config configset_get_value foo.bar a-directory
    + 2> output 
    Value not found for "foo.bar"
    test_expect_code: command exited with 1, we wanted 2 test-tool config configset_get_value foo.bar a-directory
    error: last command exited with $?=1
    not ok 23 - proper error on directory "files"
    + make_dir extract
    + tar xf subtree-all.tar -C extract
    tar: Cannot identify format. Searching...
    tar: End of archive volume 1 reached
    tar: Sorry, unable to determine archive format.
    error: last command exited with $?=1
    + rm -rf extract
    + exit 1
    + eval_ret=1
    + :
    not ok 9 - archive empty subtree with no pathspec
    --
    + make_dir extract
    + tar xf subtree-path.tar -C extract
    tar: Cannot identify format. Searching...
    tar: End of archive volume 1 reached
    tar: Sorry, unable to determine archive format.
    error: last command exited with $?=1
    + rm -rf extract
    + exit 1
    + eval_ret=1
    + :
    not ok 10 - archive empty subtree by direct pathspec
    'git <command> [<revision>...] -- [<file>...]'
    fatal: ambiguous argument 'c7': unknown revision or path not in the working tree.
    Use '--' to separate paths from revisions, like this:
    'git <command> [<revision>...] -- [<file>...]'
    No have c7 (c7)
    error: last command exited with $?=1
    + test_unconfig -C client fetch.negotiationalgorithm
    + exit 1
    + eval_ret=1
    + :
    not ok 1 - commits with no parents are sent regardless of skip distance
    --
     Author: A U Thor <author@example.com>
     1 file changed, 1 insertion(+)
     create mode 100644 to_fetch.t
    + git init client
    Initialized empty Git repository in /home/avar/g/git/t/trash directory.t5552-skipping-fetch-negotiator/client/.git/
    + seq 11
    ./t5552-skipping-fetch-negotiator.sh: seq: not found
    + git -C client checkout c5
    error: pathspec 'c5' did not match any file(s) known to git
    error: last command exited with $?=1
    not ok 3 - when two skips collide, favor the larger one
    --
    + git init client
    Initialized empty Git repository in /home/avar/g/git/t/trash directory.t5552-skipping-fetch-negotiator/client/.git/
    + seq 8
    ./t5552-skipping-fetch-negotiator.sh: seq: not found
    + seq 19
    ./t5552-skipping-fetch-negotiator.sh: seq: not found
    + pwd
    + git -C server fetch --no-tags /home/avar/g/git/t/trash directory.t5552-skipping-fetch-negotiator/client b1:refs/heads/b1
    fatal: Couldn't find remote ref b1
    error: last command exited with $?=128
    not ok 6 - do not send "have" with ancestors of commits that server ACKed

Full output at https://gitlab.com/snippets/1747801

Some of this, like the t5552-skipping-fetch-negotiator.sh failures are
new in 2.19.0 (those go away with s/seq/test_seq). But some are
older. E.g. the archive corner cases failure is becuse that test wants
unzip & GNU tar, which OpenBSD upstream has patched already:
https://github.com/openbsd/ports/blob/master/devel/git/patches/patch-t_test-lib_sh
