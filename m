Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D24581F404
	for <e@80x24.org>; Tue, 23 Jan 2018 22:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932230AbeAWWNs (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jan 2018 17:13:48 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:37057 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932146AbeAWWNr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jan 2018 17:13:47 -0500
Received: by mail-wm0-f49.google.com with SMTP id v71so4874475wmv.2
        for <git@vger.kernel.org>; Tue, 23 Jan 2018 14:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v4vpg1oJljmPvBkSpR+F//+PIkb+SUhFD+7vBMGAjhg=;
        b=utjvGjvkl6J8FJUT43k3+CSqlh5UR/ZwtAFHR3NgOPyBcMziD2f5Bp8SDyz5SnPM1M
         FxVy4/UJL9A3aEzUfCSpu9mlVbvHOX3cX1QSvTeuboBBY6UbevjRAH6c4iVDsmkIo3RA
         LoQ81oZPiaKzpaB/xRmlfGeEu4zWMnIU2ky3DxMiRdFSaGD9Xt7K62QKdgNyvOffNaN+
         cftr9erc+cKo3llpE/71dMDzgyjsR/Wh3xmxEuQfvwXpgvYGez3sci6WfnyLizLTuEUd
         aHUf0cGi2xrnA5f8JRwu+YHVXuAXUUEgeQseI4D0mUT8NicWh1OpYyCbFDnUydQWDkJu
         Ebsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v4vpg1oJljmPvBkSpR+F//+PIkb+SUhFD+7vBMGAjhg=;
        b=mj3BQ3GA5JR2/I6Gq55owOnkMm/tOUcA94hDx0VqmnX7aY75M3VYnsuPvrSW7S2ujU
         RGJYW/qpiq5rK5R30DPwptOhqaKBG5uV3uDyB1KTF2GYThTCY5ZfHNKDtIp4E6KSpIOm
         cNcNrd1mMIUhDUV+B0E5XVWrxQHlkUuHdsalfqG2XeqLbp6cqoxzBpUDtqZOntm5RZts
         0WS5CC5bfO5zytzik/UM6iSEgyBq/6y7iQGUp0pZdMMouj2RokZsKFiV0aLezOULNnTo
         uvdtcT28dgTlp+kP2hl1dJOlNo1KcxEQVv5Onwf5CIQhRbn1L9/LuzIo/YFzaCBhfTUF
         aXjA==
X-Gm-Message-State: AKwxytcFL6gEkS/kK5tRG+vbrOpQn07YeEIjC8bAzsOz8FpyjnmCVzDW
        82nhRkozLYppjhZkfCAx9avFZliX
X-Google-Smtp-Source: AH8x224kOh4SUesitByfwMahCUoKaUBBt3bThdo4HHoLyzV3Yj5RMwku/yVWYKHkSkWI3FzZXrXGZQ==
X-Received: by 10.80.129.225 with SMTP id 88mr21057038ede.19.1516745625440;
        Tue, 23 Jan 2018 14:13:45 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id s5sm14321282eda.60.2018.01.23.14.13.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jan 2018 14:13:44 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 00/11] document & test fetch pruning & add fetch.pruneTags
Date:   Tue, 23 Jan 2018 22:13:15 +0000
Message-Id: <20180123221326.28495-1-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180121000304.32323-1-avarab@gmail.com>
References: <20180121000304.32323-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Addresses Junio's comments on v2 + more fixes. The 

Ævar Arnfjörð Bjarmason (11):
  fetch: don't redundantly NULL something calloc() gave us
  fetch: stop accessing "remote" variable indirectly

Moved these patches to the beginning. No changes except a note to the
commit message saying how these trivial changes relate (or not) to
subsequent changes.

  fetch tests: refactor in preparation for testing tag pruning

No changes.

  fetch tests: re-arrange arguments for future readability

s/arrange/re-arrange/ in commit message subject.

  fetch tests: add a tag to be deleted to the pruning tests

No changes.

  fetch tests: test --prune and refspec interaction

I'm now just skipping quoting things like +refs/... on the
command-line, which as grepping the rest of the test suite shows is
fine, this eliminated the need for "fetch tests: double quote a
variable for interpolation" so I've ejected it.

  git fetch doc: add a new section to explain the ins & outs of pruning

No changes.

  git remote doc: correct dangerous lies about what prune does

Rewording of doc per Junio's suggestion.


  git-fetch & config doc: link to the new PRUNING section

No changes.

  fetch tests: add scaffolding for the new fetch.pruneTags

No changes except continuing remove refspec quoting changes noted
above & using +refs/tags/... instead of refs/tags/... for consistency
with the last patch...

  fetch: add a --fetch-prune option and fetch.pruneTags config

We now consistently use a + prefixed refspec for tag pruning, even
though it yields the same result. See the discussion in
87tvvdh2vh.fsf@evledraar.gmail.com, I think it's less confusing.

Fix regex in --replace-all command in the commit message.

Rewording to address Junio's comments.

The short help for --prune-tags is now:

    -           N_("prune local tags not found on remote")),
    +           N_("prune local tags no longer on remote and clobber changed tags")),

Add --prune-tags to the bash completion.

 Documentation/config.txt               |  20 ++++-
 Documentation/fetch-options.txt        |  18 +++-
 Documentation/git-fetch.txt            |  76 +++++++++++++++++
 Documentation/git-remote.txt           |  14 +--
 builtin/fetch.c                        |  37 +++++++-
 contrib/completion/git-completion.bash |   2 +-
 remote.c                               |   5 +-
 remote.h                               |   3 +
 t/t5510-fetch.sh                       | 152 ++++++++++++++++++++++++---------
 9 files changed, 275 insertions(+), 52 deletions(-)

-- 
2.15.1.424.g9478a66081

