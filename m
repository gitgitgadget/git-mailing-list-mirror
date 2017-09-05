Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C149C208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 20:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753216AbdIEU6G (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 16:58:06 -0400
Received: from mail-qt0-f180.google.com ([209.85.216.180]:35573 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752146AbdIEU6F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 16:58:05 -0400
Received: by mail-qt0-f180.google.com with SMTP id k2so15315486qte.2
        for <git@vger.kernel.org>; Tue, 05 Sep 2017 13:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aerotech.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dMKoYGkKySLIW/6AqK8bQe8GvsfZVGvdGI6+aOCnLdY=;
        b=GCO3EYqPaUXOXYMTY9GOjEoAs6FedyGYx9l1oSl6Dl5BFwy33F9i3DXWFwgsFJryo/
         Z/qYXTLRymNReCADbGZPvv0MVscThIFubB1WVUCsWjNrW593g0+WN+nuQi3mry9g3KxX
         bL4gPfT+YVStkqDytnZFJfMwyd21rbarXZehw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dMKoYGkKySLIW/6AqK8bQe8GvsfZVGvdGI6+aOCnLdY=;
        b=hm3+b2NJAF/H+S9HYWnzlOKQdTNQ6K5G64PEEEY6xP+rpXRUKjLmlyNHuDriOK5HJI
         BlevYZEX2gAKNw/0SzpOdbz3Pm+NMRTMf95lwVuchupMS7+tn6uU13tsgQWZToTBeduu
         cTG3tB/mWKXgz+9DD8eBZ5ks1wuXT+6yRxXYCHgij+owONon8D2jBqPirfwDja1VsLDX
         cP83+dsxkSWvbvyP1n5m2hDhVz6eBDk3V701bxPaqPt2ywAW6OfNA61bYyweKITPpmzI
         sKRFkToZC10p+V9Fxa9+aHZ5oF7GY0vqET1joT6IenjJk4/AtN7KSHemfeI2nIiUzv/C
         i9gQ==
X-Gm-Message-State: AHPjjUiBL765coK2tWHCjcvKQem8gSk+BvZfwxjo0kf4p6VqvL3mdTOv
        yUVRSKMgkfMjSaUdUc4RYzLmgi79KW8s
X-Google-Smtp-Source: ADKCNb5e1G2G1B8ok/B+D9NdEP1QJGwhc0uQjiioszI7aRAEkkxIsjKmMpxajZff5cq15Z7lB/Y5id+o3SEB4guWy7w=
X-Received: by 10.237.47.230 with SMTP id m93mr514655qtd.277.1504645084767;
 Tue, 05 Sep 2017 13:58:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.130.35 with HTTP; Tue, 5 Sep 2017 13:57:24 -0700 (PDT)
In-Reply-To: <20170905170311.yhcksrw2bxevd3hk@sigill.intra.peff.net>
References: <CAEVs+za9do_wXC12SSRznF9v9oGw3_Grq2EFDVf8nH1CRgM-Qw@mail.gmail.com>
 <20170902083319.lcugfpkkk5lahieb@sigill.intra.peff.net> <CAEVs+zbbWQuM-=5d04bkpTu38Mr4PyczskNhni5K1u_nzh-2Qw@mail.gmail.com>
 <20170905153636.tsmlq3wv7ztpc67z@sigill.intra.peff.net> <CAEVs+zbCj0Zv0t4_WG6y2jcLoXwHy-Mu-LH31c_QgFaE9i3HtQ@mail.gmail.com>
 <20170905170311.yhcksrw2bxevd3hk@sigill.intra.peff.net>
From:   Ross Kabus <rkabus@aerotech.com>
Date:   Tue, 5 Sep 2017 16:57:24 -0400
Message-ID: <CAEVs+zZRw3kW0C56NcJNXieCSTOa=uMxg6tDPjU2u+WDzhTLfw@mail.gmail.com>
Subject: Re: [Bug] commit-tree shouldn't append an extra newline to commit messages
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ross Kabus <rkabus@aerotech.com>
Date: Tue, 5 Sep 2017 13:54:52 -0400
Subject: [PATCH] commit-tree: don't append a newline with -F

This change makes it such that commit-tree -F never appends a newline
character to the supplied commit message (either from file or stdin).

Previously, commit-tree -F would always append a newline character to
the text brought in from file or stdin. This has caused confusion in a
number of ways:
  - This is a plumbing command and it is generally expected not to do
    text cleanup or other niceties.
  - stdin piping with "-F -" appends a newline but stdin piping without
    -F does not append a newline (inconsistent).
  - git-commit has the --cleanup=verbatim option that prevents appending
    a newline with its -F argument. There is no verbatim counterpart to
    commit-tree -F (inconsistent).
---
 builtin/commit-tree.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 19e898fa4..2177251e2 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -102,7 +102,6 @@ int cmd_commit_tree(int argc, const char **argv,
const char *prefix)
  if (fd && close(fd))
  die_errno("git commit-tree: failed to close '%s'",
   argv[i]);
- strbuf_complete_line(&buffer);
  continue;
  }

-- 
2.13.1.windows.2
