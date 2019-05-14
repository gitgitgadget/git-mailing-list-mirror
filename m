Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A14C1F461
	for <e@80x24.org>; Tue, 14 May 2019 11:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfENL3t (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 07:29:49 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45476 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfENL3s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 07:29:48 -0400
Received: by mail-pg1-f195.google.com with SMTP id i21so8467243pgi.12
        for <git@vger.kernel.org>; Tue, 14 May 2019 04:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Vt2wfmJIliN0Rtag5IjByZxuSwxX96c1PLauCTmal/8=;
        b=R/hyOVgvPbz+xGo/Jo2J42M2Hwea4yf02/msWQBCPy8qT8P4LCYJN8wQscGxV1Xz10
         dTMeUn75HZd9kV6HcMN8KUhAPM5f4I59g0m3iRlvqRozSeq1WOrULwt2aRfCY7JWz2Qx
         6Ne2Zqd3l8mOL3V9GGIi30jbWV8gSEBVFfgXY3xT3IVhTbdMjykT0uVqQ6VXcajpekNK
         avwFPo0tdV1TahSYcx6ljMdJ2N2NKeKOJ1Dg5DPAMZReACmjsTLxsYvd3PWryCEEG7FD
         BJ8/UxPqMkplx/n9k8ltq1u3BHAsngJh5xJdNGMeE9F1s0n59bEkNTeHqn5EGKpRLkfR
         InQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Vt2wfmJIliN0Rtag5IjByZxuSwxX96c1PLauCTmal/8=;
        b=L498lX2cElIBEduPLk+uB1VmgDVfH62rC6Wuikig7157LEiiu6nLLAkQFwDYgChyZ4
         t/5HzhFhsaluUJtf+y1A5aIJijxgdbkb+vsIX1w0KAE4yNPwEgDwHNeny8vetjNVsLyY
         Dr2yqKWHwSO5GAv9RkysS/p2Z8RvZHD0TugY0Ozh1Qy72v5PCtfQ9nfXfObNaP3NmkxA
         /kQT1gXYC0BbGZuuyUmTC/iwQN1YmCa8LpGMqWadFerIChtRzV5bWzmqcUO+IZdAJv7l
         yRpim891edOglI4VQhIqYno8N4UCc0YCZRFT6sVaYOi2XTZI19xLrIa/hJ1C4AQD6wu/
         HQ5Q==
X-Gm-Message-State: APjAAAXGMv8ERI7Cvk4vjB3xvt5UZagvv7v+sMbfk2LOyNtIsbaCmSnL
        X3uk4FxRnhPA7VSlFivfhU8=
X-Google-Smtp-Source: APXvYqwwE1repTNrYi1tHBk4cKgAK7OiPIMHEilgdyfDpNNQYhaXr4OXnIWC5WSCxn4eKEh6qryQOA==
X-Received: by 2002:a65:608a:: with SMTP id t10mr37057453pgu.155.1557833388036;
        Tue, 14 May 2019 04:29:48 -0700 (PDT)
Received: from ash ([115.72.28.243])
        by smtp.gmail.com with ESMTPSA id s5sm10102494pgj.60.2019.05.14.04.29.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 04:29:45 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Tue, 14 May 2019 18:29:41 +0700
Date:   Tue, 14 May 2019 18:29:41 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
        git@vger.kernel.org
Subject: Re: some git confusion (where git's advice didn't help)
Message-ID: <20190514112941.GA23603@ash>
References: <5CDA9063020000A10003131D@gwsmtp.uni-regensburg.de>
 <20190514112115.GA26957@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190514112115.GA26957@sigill.intra.peff.net>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 14, 2019 at 07:21:15AM -0400, Jeff King wrote:
> I also think the "warning: refname ... is ambiguous" message would
> probably be a bit more helpful if it showed _which_ candidates it found
> (and which one it chose!).

Alternatively, just refuse to resolve ambiguous refs. It's not always
printed in a short output that stands out to you. Something like this
perhaps.

It could probably use some improvements, suggesting the ambiguous
candidates too. It's just what I've been using for years.

-- 8< --
Subject: [PATCH] sha1_name.c: add an option to abort on ambiguous refs

There are cases when a warning on ambiguous ref may go unnoticed
(e.g. git-log filling up the whole screen). There are also cases when
people want to catch ambiguation early (e.g. it happens deep in some
script). In either case, aborting the program would accomplish it.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config/core.txt |  3 ++-
 config.c                      |  5 ++++-
 sha1-name.c                   | 10 ++++++++--
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index 7e9b6c8f4c..f81634b642 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -340,7 +340,8 @@ core.sharedRepository::
 
 core.warnAmbiguousRefs::
 	If true, Git will warn you if the ref name you passed it is ambiguous
-	and might match multiple refs in the repository. True by default.
+	and might match multiple refs in the repository. If set to "fatal",
+	the program will abort on ambiguous refs. True by default.
 
 core.compression::
 	An integer -1..9, indicating a default compression level.
diff --git a/config.c b/config.c
index 0f0cdd8c0f..f314caeb87 100644
--- a/config.c
+++ b/config.c
@@ -1158,7 +1158,10 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
 	}
 
 	if (!strcmp(var, "core.warnambiguousrefs")) {
-		warn_ambiguous_refs = git_config_bool(var, value);
+		if (!strcasecmp(value, "fatal"))
+			warn_ambiguous_refs = 2;
+		else
+			warn_ambiguous_refs = git_config_bool(var, value);
 		return 0;
 	}
 
diff --git a/sha1-name.c b/sha1-name.c
index 6dda2c16df..e613c955d7 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -760,6 +760,8 @@ static int get_oid_basic(const char *str, int len, struct object_id *oid,
 				warning(warn_msg, len, str);
 				if (advice_object_name_warning)
 					fprintf(stderr, "%s\n", _(object_name_msg));
+				if (warn_ambiguous_refs > 1)
+					die(_("cannot continue with ambiguous refs"));
 			}
 			free(real_ref);
 		}
@@ -817,8 +819,12 @@ static int get_oid_basic(const char *str, int len, struct object_id *oid,
 
 	if (warn_ambiguous_refs && !(flags & GET_OID_QUIETLY) &&
 	    (refs_found > 1 ||
-	     !get_short_oid(str, len, &tmp_oid, GET_OID_QUIETLY)))
-		warning(warn_msg, len, str);
+	     !get_short_oid(str, len, &tmp_oid, GET_OID_QUIETLY))) {
+		if (warn_ambiguous_refs > 1)
+			die(warn_msg, len, str);
+		else
+			warning(warn_msg, len, str);
+	}
 
 	if (reflog_len) {
 		int nth, i;
-- 
2.21.0.1141.gd54ac2cb17

-- 8< --
