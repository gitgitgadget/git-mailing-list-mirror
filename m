Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FAAD1F454
	for <e@80x24.org>; Fri,  1 Nov 2019 08:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730284AbfKAIZX (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Nov 2019 04:25:23 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35599 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730098AbfKAIZW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Nov 2019 04:25:22 -0400
Received: by mail-pl1-f195.google.com with SMTP id x6so4044080pln.2
        for <git@vger.kernel.org>; Fri, 01 Nov 2019 01:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pyl1/r0bvlx9cWDkEMIAwn0DDlAl0DMZgCtDhaV8K8M=;
        b=j4wOw3RKOPL7N3fnDwWXC9+kl03Blbj2DK8XlhcM+VQ6mqq3XY4J/P2vzxnsoD+v+m
         XAt76Nti3zkimmujK5oUpkTeWvVxc1iYgMjDJa7HJIxWRtddNDDy2jIRR5sXe5b4XjKX
         EgwM5ea1SdZx8Yu3F5puKuxBjQKjFrPq1kM9hUZHiadomtnUo8PDjYMGN9/fmziK6bWN
         05ICrEKQez2YySCfDPqs8zwG3devFHYXw4uujU4xOeGgKCQYzoI0yjsqvZvj7YN60Pgm
         zNakeR6R7FLqlyu2YlLuL2Tq55b7RiaHznMU9W7eYE55JJ4mE0RoTXNPNuBH8pUP7GGl
         M+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pyl1/r0bvlx9cWDkEMIAwn0DDlAl0DMZgCtDhaV8K8M=;
        b=t5yYYV19BA7N8ebiGV+yrMIW1Qy3FFJ/2L/OI4rejFlj96V1gif6m3jvNCJUpuV0Fw
         dnh3A2V0661nx93Uo/tfRBQHV7zxbdDXpjDIInXR205UP7dADdenjQUjoBnUuff5Vc4b
         Y4IKaJ5K5FkFoAnFUiOFwXXjS9NO0SYMfFOMqeMe+BFER/oz6e8EIrsx1cOvyNIf+GZN
         BkGa5rkkm5cPgDo/0BFIMrv7wJTBdpyovjSYySRCjtuxX+vUJs5Ud/Ki6k4TzFqHlbjx
         V2TQ2gISxAKG2QYGPfz1MNZPzKu+AZNa5b6gpNiCYSrtxGDiZRT/rdjFsvfuhVkky+8L
         DCFw==
X-Gm-Message-State: APjAAAWQSUIPRKPvNoidVZ0+xp931Laq9T0qNAW9z0dN5MQHs37yqJHk
        TJTEncJXKmIfKd3OwMB6rDsNQuot
X-Google-Smtp-Source: APXvYqzg4H5wl1gyAjcIl21Ts/1cXwBg/spkUHd8I9PfNMYiGzTXMC0vkZw9C5Vym0/FOVP1MRiFUw==
X-Received: by 2002:a17:902:23:: with SMTP id 32mr11166309pla.205.1572596721419;
        Fri, 01 Nov 2019 01:25:21 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:e1c2:8c5a:c959:6fca:fa1a])
        by smtp.gmail.com with ESMTPSA id q13sm17158395pjq.0.2019.11.01.01.25.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Nov 2019 01:25:20 -0700 (PDT)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH v2 0/3] Linux with musl libc improvement
Date:   Fri,  1 Nov 2019 15:25:08 +0700
Message-Id: <cover.1572596278.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.0.rc2.296.geaf699fcc3
In-Reply-To: <20191031092618.29073-1-congdanhqx@gmail.com>
References: <20191031092618.29073-1-congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series of patch tries to ease the life of musl libc user
and clear those last failure on Linux with musl libc.

The second patch is a complete rewrite.

Doan Tran Cong Danh (3):
  t0028: eliminate non-standard usage of printf
  configure.ac: define ICONV_OMITS_BOM if necessary
  sequencer: reencode to utf-8 before arrange rebase's todo list

 configure.ac                     | 49 ++++++++++++++++++++++++++++++++
 sequencer.c                      |  2 +-
 t/t0028-working-tree-encoding.sh |  4 +--
 3 files changed, 52 insertions(+), 3 deletions(-)

Range-diff against v1:
1:  840c40cea1 ! 1:  8b30028425 t0028: eliminate non-standard usage of printf
    @@ Commit message
            one, two, or three-digit octal number, shall be written as a byte
            with the numeric value specified by the octal number.
     
    -    printf '\xfe\xff' in an extension of some libc.
    +    printf '\xfe\xff' in an extension of some shell.
    +    Dash, a popular yet simple shell, do not implement this extension.
     
    -    With dash:
    -    $ printf '\xfe\xff' | xxd
    -    00000000: 5c78 6665 5c78 6666                      \xfe\xff
    +    This wasn't caught by most people running the tests, even though
    +    common shells like dash don't handle hex escapes, because their
    +    systems don't trigger the NO_UTF16_BOM prereq. But systems with musl
    +    libc do; when combined with dash, the test fails.
     
    -    Correct its usage.
    +    Correct it.
     
         Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
    -    Despite that dash's printf doesn't accept \x escape sequence.
    -
    -    My glibc box (with sh linked to dash) can run the test just fine.
    -    But my musl box couldn't run the test, (because the header).
     
      ## t/t0028-working-tree-encoding.sh ##
     @@ t/t0028-working-tree-encoding.sh: test_lazy_prereq NO_UTF32_BOM '
2:  4a28ee7ef6 < -:  ---------- configure.ac: define ICONV_OMITS_BOM if necessary
-:  ---------- > 2:  7c2c6f0603 configure.ac: define ICONV_OMITS_BOM if necessary
3:  c8da3990e5 ! 3:  b7927b2723 sequencer: reencode to utf-8 before arrange rebase's todo list
    @@ Commit message
     
         Thus, t3900 is failing on Linux with musl libc.
     
    +    This problem wasn't specific to musl libc. On Linux with glibc, this
    +    problem can be observed by:
    +
    +    for encoding in utf-8 iso-8859-1; do
    +            # commit using the encoding
    +            echo $encoding >file && git add file
    +            echo "éñcödèd with $encoding" | iconv -f utf-8 -t $encoding |
    +              git -c i18n.commitEncoding=$encoding commit -F -
    +            # and then fixup without it
    +            echo "$encoding fixed" >file && git add file
    +            git commit --fixup HEAD
    +    done
    +    git rebase -i --autosquash --root
    +
         Reencode to utf-8 before arranging rebase's todo list.
     
         Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
    -    The todo list shown to user has already been reencoded by sequencer_make_script,
    -    without this patch it looks like this:
    -
    -    $ head -3 .git/rebase-merge/git-rebase-todo | xxd
    -    00000000: 7069 636b 2065 6633 3961 3033 201b 2442  pick ef39a03 .$B
    -    00000010: 244f 1b28 421b 2442 246c 1b28 421b 2442  $O.(B.$B$l.(B.$B
    -    00000020: 2452 1b28 421b 2442 245b 1b28 421b 2442  $R.(B.$B$[.(B.$B
    -    00000030: 2455 1b28 420a 7069 636b 2062 3832 3931  $U.(B.pick b8291
    -    00000040: 3336 2073 7175 6173 6821 201b 2442 244f  36 squash! .$B$O
    -    00000050: 1b28 421b 2442 246c 1b28 421b 2442 2452  .(B.$B$l.(B.$B$R
    -    00000060: 1b28 421b 2442 245b 1b28 421b 2442 2455  .(B.$B$[.(B.$B$U
    -    00000070: 1b28 420a 7069 636b 2062 3532 3132 6437  .(B.pick b5212d7
    -    00000080: 2069 6e74 6572 6d65 6469 6174 6520 636f   intermediate co
    -    00000090: 6d6d 6974 0a                             mmit.
     
      ## sequencer.c ##
     @@ sequencer.c: int todo_list_rearrange_squash(struct todo_list *todo_list)
-- 
2.24.0.rc2.296.geaf699fcc3

