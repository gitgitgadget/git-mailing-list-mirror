Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C0FE1F404
	for <e@80x24.org>; Thu,  8 Feb 2018 16:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752116AbeBHQT6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 11:19:58 -0500
Received: from mail-wr0-f172.google.com ([209.85.128.172]:36336 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751848AbeBHQT5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 11:19:57 -0500
Received: by mail-wr0-f172.google.com with SMTP id y3so5316435wrh.3
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 08:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oFNEHpYvAGymN08YhDJzQ8wljdk5pTdmGvB00I21xxE=;
        b=KUFMoKiwaiuYh9nu5a//gqqAwlbinJfZPkDHyezdcoPt0iubCZEMFzIbxQW0MJ4Dl/
         5hM5toHkxLTybhpSA+frr1Ax/L6TCaW5HMU4kOPINEsd5vKCG4VUAKlz3OjRWFzI0w+3
         vw9S4BOJ7RzjdPLIW1LZIRwh2Kb3XjDmvCoYb67j2TW7ANtXnwbNkNHgwHgWBZMgwPSE
         KlA8z+BX5h5LpnBnOk6x69oZEWNrUaAtv0U9Pvcv3q0NvEwCeZrMEZdJ4+7fIo/fGp/h
         S5OtqNR9VFYC336gBoQwPG358t9dakzHyVWgDc7F9o1OzWXJBm28hRMlGDgD9Skbdknu
         Yhdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oFNEHpYvAGymN08YhDJzQ8wljdk5pTdmGvB00I21xxE=;
        b=qfUmPytPdlvSRyP9CK1Gw4WlFmpAzoIkPFUcTIVqOB14WQxtBmfwaqKNY23L09nixK
         Teio6PSdHsHG7f7WallkTD3szH74L6hpOG+U/jzVPWn9riq/jtT7jsg0z+u+kMRW+Q7y
         QxA6b1VOBCRa2VUZxZGC0DPv3PCyf+rYRJCI0eUXI1DouexqnuqKOSQV68Xdav4Tf6Jw
         6puRNIW3O/3+GxhPK7IV5tESZ82n+fkVcao9hZt61SBCdaq3acsPYdtMQfsfZkXuDjoh
         GsJR2+CRzr/99aNAb0LjlNpZeRPm+2on5FHsl/o812ZqU7yXPsZBPC+GBa+nFCUDbvKw
         SMkQ==
X-Gm-Message-State: APf1xPAWKTMoZxscT5N9dRCKOAMxHXl0rc58aLIU8pOVGRzKgNBGwA6b
        lDDySOYNOdEIcQgunOB+5Po3b42w
X-Google-Smtp-Source: AH8x225N/OAQAgFvyzPvWFIU7tHo6prEwoTwSrvlkwpdITM1dDKtqNrRSWKUVLwiJzgpzxoiIYmQ4A==
X-Received: by 10.223.136.6 with SMTP id d6mr1276440wrd.191.1518106795446;
        Thu, 08 Feb 2018 08:19:55 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id m1sm332532wrb.78.2018.02.08.08.19.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Feb 2018 08:19:54 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Daniel Barkalow <barkalow@iabervon.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 00/17] document & test fetch pruning & add fetch.pruneTags
Date:   Thu,  8 Feb 2018 16:19:19 +0000
Message-Id: <20180208161936.8196-1-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180123221326.28495-1-avarab@gmail.com>
References: <20180123221326.28495-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in my 87h8quytmq.fsf@evledraar.gmail.com there was a bug I
noticed in v3 where it would segfault on some git-fetch invocations,
but there were not tests anywhere that caught that.

So in addition to fixing that issue, this fleshens out the testing
being set up as part of this series so we'll test those sorts of
invocations. It would segfault on some `git fetch <url>`, not `git
fetch <name>`.

Ævar Arnfjörð Bjarmason (17):
  fetch: don't redundantly NULL something calloc() gave us

Rephrased commit message.

  fetch: trivially refactor assignment to ref_nr

New, makes a subsequent change smaller.

  fetch: stop accessing "remote" variable indirectly

Typo fix in commit message noted by Junio.

  remote: add a macro for "refs/tags/*:refs/tags/*"

New, makes a subsequent change smaller.

  fetch tests: refactor in preparation for testing tag pruning
  fetch tests: re-arrange arguments for future readability
  fetch tests: add a tag to be deleted to the pruning tests

No changes.

  fetch tests: test --prune and refspec interaction

Changed +refs/tags/*:refs/tags/ to refs/tags/*:refs/tags/. No
functional difference, since git doesn't care. Just to be consistent
with the macro added earlier & doing the same in commit messages &
tests later in the series.

  fetch tests: double quote a variable for interpolation

Now back from an earlier version, needed for a later change.

  fetch tests: expand case/esac for later change

New, makes the next patch smaller / easier to review.

  fetch tests: fetch <url> <spec> as well as fetch [<remote>]

For all `git fetch <name>` we now run another version of the test
where we test an equivalent `git fetch <url>`. This sort of exhaustive
testing was missing in our whole test suite, and would have caught the
segfault in v3.

  git fetch doc: add a new section to explain the ins & outs of pruning
  git remote doc: correct dangerous lies about what prune does
  git-fetch & config doc: link to the new PRUNING section

No changes except omitting the "+" in front of refs/tags/[...] as
noted above.

  fetch tests: add scaffolding for the new fetch.pruneTags

Ditto "+" change + minor changes carried over from previous patches.

  fetch: add a --fetch-prune option and fetch.pruneTags config

The bug in v3 was that the remote->fetch variable needs to chaned in
lockstep with remote->fetch_refspec, but only the latter was
changed. Codepaths that fetched by URL would under --prune-tags expect
as many items in both, and segfault on the access to remote->fetch.

As explained in the amended commit message the API is not amenable to
ALLOC_GROW, so there's now a add_prune_tags_to_fetch_refspec()
function in remote.c which adds the new element to remote->fetch via
xrealloc() + memcpy().

Careful review of that most welcome.

There's lots more tests that catch the case where it segfaulted.

  fetch: make the --fetch-prune work with <url>

The previous patch was changed to document that this wouldn't work:

    git fetch <url of origin> --prune --prune-tag

This makes it work, at the cost of some complexity in fetch_one(). I
think it makes sense to keep this, I just wanted to split it off from
the previous patch to clearly show the hoops we need to jump through
for that one case.

 Documentation/config.txt               |  20 ++-
 Documentation/fetch-options.txt        |  17 ++-
 Documentation/git-fetch.txt            |  87 ++++++++++++
 Documentation/git-remote.txt           |  14 +-
 builtin/fetch.c                        |  54 ++++++--
 contrib/completion/git-completion.bash |   2 +-
 remote.c                               |  15 ++
 remote.h                               |   5 +
 t/t5510-fetch.sh                       | 242 +++++++++++++++++++++++++++------
 9 files changed, 395 insertions(+), 61 deletions(-)

-- 
2.15.1.424.g9478a66081

