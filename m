Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F69D1FADF
	for <e@80x24.org>; Fri, 19 Jan 2018 00:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932852AbeASABM (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 19:01:12 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35786 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932778AbeASABD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 19:01:03 -0500
Received: by mail-wm0-f66.google.com with SMTP id r78so249129wme.0
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 16:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=jYDVfadgQykUBjdAK+UxRbx3kkSp5vaHrgUeT5bNjrE=;
        b=S2POd8kQAP5RV1LFfGhk4Uz3geK27HfJC5Oh/kCcHd8zOYRu8PO+5qPpvW0YpmOv4y
         zAJcvkDJY1OnJ1zM/Q0mwyG+4nbxjfa7xsSsFFuj6cU/RO2LbxGj0ckfjA/NkfmdPwH+
         seUZ3AGxZZ6pxRbaYAZUKnqOqH5WpmAA8MzlHuxoruSK8PkoIngQ9xw8xP/YdDbAzIaa
         /ndJ/G/sV+AU8HZb62/V/wB49R3BAGAd+evg/VQVQOoMyNbidM04gGiA7ToZ1XbJApIp
         /4sO2k7gqqGntIdsSI24WAuQ17+lewxdb7jhCw/cCpOeo4QUTgEfRpoXN/Qotkvt9xf4
         WbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jYDVfadgQykUBjdAK+UxRbx3kkSp5vaHrgUeT5bNjrE=;
        b=DJTtEUwXbwkG3h9JB5nCASciD0J66/UC5/aRmiLU9bt5GE44v0O6BImqdERljZ4YAm
         jt0k0vG0vguSYlJSe5afF3uEpJxgIzl7wRd0acq4+2N3IEstoyblkeFm7KAI7OH+Xd58
         XhPmpCoMCM86KJZSnVi5yR7d2svWKQTu8JzSyqYeEJqedpMf7Sy6oD65HIppR6vCCc03
         EJagTCdYsoQURb+/oobujbXGa9sshvUl1Xhynd0ruftDrGrXmYLWrgSuDW/R5OiS4vw6
         E8BbeGc/b4Q0CbYhmsY3tyknIqH//aL269zJQWJRMgSfVPxFEdTvyZ5SO5S9eom09PF2
         Y9jg==
X-Gm-Message-State: AKwxytduOW0HKiAE2FfmzTAw3MXVrRkJHPgN0twP0nr6OfmAPtzEzpQb
        rYSHmrGE56Q34CYBuahe3fZuK3we
X-Google-Smtp-Source: ACJfBovR02h5BakVRoX7ZPQXGfVvWACievhZlWh2J9CGufbeEHVLvBjSAn5AJIxbCavB9tuykpZU7Q==
X-Received: by 10.28.196.73 with SMTP id u70mr6128948wmf.116.1516320061698;
        Thu, 18 Jan 2018 16:01:01 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b48sm17706481wrd.69.2018.01.18.16.01.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jan 2018 16:01:00 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 06/11] git fetch doc: add a new section to explain the ins & outs of pruning
Date:   Fri, 19 Jan 2018 00:00:22 +0000
Message-Id: <20180119000027.28898-7-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180119000027.28898-1-avarab@gmail.com>
References: <20180119000027.28898-1-avarab@gmail.com>
In-Reply-To: <87po6ahx87.fsf@evledraar.gmail.com>
References: <87po6ahx87.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new section to canonically explain how remote reference pruning
works, and how users should be careful about using it in conjunction
with tag refspecs in particular.

A subsequent commit will update the git-remote documentation to refer
to this section, and details the motivation for writing this in the
first place.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-fetch.txt | 49 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index b153aefa68..b07b669a1f 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -99,6 +99,55 @@ The latter use of the `remote.<repository>.fetch` values can be
 overridden by giving the `--refmap=<refspec>` parameter(s) on the
 command line.
 
+PRUNING
+-------
+
+Git has a default disposition to keeping data unless it's explicitly
+thrown away, this extends to keeping a hold of local references to
+branches on remotes that have themselves deleted those branches.
+
+If left to accumulate these stale references might make performance
+worse on big and busy repos that have a lot of branch churn, and
+e.g. make the output of commands like `git branch -a --contains
+<commit>` needlessly verbose, as well as impacting anything else
+that'll work with the complete set of known references.
+
+These remote tracking references can be deleted as a one-off with
+either of:
+
+------------------------------------------------
+# While fetching
+$ git fetch --prune <name>
+
+# Only prune, don't fetch
+$ git remote <name>
+------------------------------------------------
+
+To prune references on a remote as part of your normal workflow
+without needing to remember to run that set `fetch.prune` globally, or
+`remote.<name>.prune` per-remote in the config. See
+linkgit:git-config[1].
+
+Here's where things get tricky and more specific. The pruning feature
+doesn't actually care about branches, instead it'll prune local <->
+remote references as a function of the refspec of the remote (see
+`<refspec>` and <<CRTB,CONFIGURED REMOTE-TRACKING BRANCHES>> above).
+
+Therefore if the refspec for the remote includes
+e.g. `refs/tags/*:refs/tags/*`, or you manually run e.g. `git fetch
+--prune <name> "refs/tags/*:refs/tags/*"` it won't be stale remote
+tracking branches that are deleted, but any local tag that doesn't
+exist on the remote.
+
+This might not be what you expect, i.e. you want to prune remote
+`<name>`, but also explicitly fetch tags from it, so when you fetch
+from it you delete all your local tags, most of which may not have
+come from the `<name>` remote in the first place.
+
+So be careful when using this with a refspec like
+`refs/tags/*:refs/tags/*`, or any other refspec which might map
+references from multiple remotes to the same local namespace.
+
 OUTPUT
 ------
 
-- 
2.15.1.424.g9478a66081

