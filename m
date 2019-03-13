Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 903FA20248
	for <e@80x24.org>; Wed, 13 Mar 2019 17:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfCMR5p (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 13:57:45 -0400
Received: from mail-ot1-f73.google.com ([209.85.210.73]:33967 "EHLO
        mail-ot1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfCMR5p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 13:57:45 -0400
Received: by mail-ot1-f73.google.com with SMTP id r22so1156270otk.1
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 10:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=X+O00ng2/v9UmtzCOdaGMiaEXWkXvXeB/tyGw/oap2s=;
        b=BtHri0QcPhqiA1/t8H0qfBR4EbkxUdfsDhRwWb0myslepC9ZnM//KZGyQHrEyjFZB3
         /GpeC3IAA8ZcAezqyeaTgJC9tskiuYQm8WGwgFx3969sBCj18lsArX87YVjuKPornKy8
         LY04v3wXxG8vRgEknQp0Q9LE8imYdHVOHBB3KmhZudqmJEGfLpbcalH8dTb/egfQcN4/
         hjAzwwNxIMVQnMS0lnJqRnrp/spxxejLY6x1jlTXKIG8dy/T7+ncE2GT33ayCBqRpgjD
         1xRtdcRPq9B9SoRXV+s7qs+m9QywrlrN6/3eQsd4NNG3Y8m5kqHTwNfcnj7XooScSvgg
         7QXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=X+O00ng2/v9UmtzCOdaGMiaEXWkXvXeB/tyGw/oap2s=;
        b=gEZh8mZHjWkZcjypYQZr3ez4iWcncPHMnB2q+bSJP7HDGpKjwY0/9dBYDk+D06nwr9
         5c/ycQfLwoa7ADtu6efkyXD76CAOcMzdp25LLHhswMpu2n1xAPSEhMA5AiXZmAnZG8z0
         bl+VF3aue5BDTnvX/4/aIPoca45iBYQcFbP+8ScUsWNfzhTERnZXtGGuFO/y8PeyMY84
         6LgL4KRTtFYDVECQfVmIbAO0uiI4Mna9GOxEWKnWY7e3LMqW9vIse7pGt1SSXM6SLSdk
         dQQ+gPlNoCm9WsZPVUWzGYCUblSKp1UH2oHZi0CtZFMzqCqZdlW/XS9jmxRwQIcop8H5
         9HwQ==
X-Gm-Message-State: APjAAAWeDF032SlDU7lFXIP5P9EhdW6FZTE//uMm9/3++3cY4MEXheWJ
        NCiVgw6iGvGu02mCwKxF7UdVQVslhGHsTgadXLajRd2XdXQIF33LK0Zu+BJgKCq0y2hjFi7aLWL
        nXG4PVxr50Cu3wyWSd66+ruJqK3InO3nbnYhSey4+uEddmhcvODlIbUyb9IOA0Den0A/zxoES1h
        on
X-Google-Smtp-Source: APXvYqwf0j9dtaxPWQtxFBRB0NtjJkFyIUTwXhXm4B4R8riT4H2EAAeaLvx+6R+j0rHj07ne0OpVXSCxwfHqQxCA08Wb
X-Received: by 2002:a9d:65d5:: with SMTP id z21mr23721210oth.37.1552499864207;
 Wed, 13 Mar 2019 10:57:44 -0700 (PDT)
Date:   Wed, 13 Mar 2019 10:57:38 -0700
In-Reply-To: <20190312174522.89306-1-jonathantanmy@google.com>
Message-Id: <20190313175738.252961-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190312174522.89306-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.21.0.155.ge902e9bcae.dirty
Subject: [PATCH v2] submodule: explain first attempt failure clearly
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When cloning with --recurse-submodules a superproject with at least one
submodule with HEAD pointing to an unborn branch, the clone goes
something like this:

	Cloning into 'test'...
	<messages about cloning of superproject>
	Submodule '<name>' (<uri>) registered for path '<submodule path>'
	Cloning into '<submodule path>'...
	fatal: Couldn't find remote ref HEAD
	Unable to fetch in submodule path '<submodule path>'
	<messages about fetching with SHA-1>
	From <uri>
	 * branch            <hash> -> FETCH_HEAD
	Submodule path '<submodule path>': checked out '<hash>'

In other words, first, a fetch is done with no hash arguments (that is,
a fetch of HEAD) resulting in a "Couldn't find remote ref HEAD" error;
then, a fetch is done given a hash, which succeeds.

The fetch given a hash was added in fb43e31f2b ("submodule: try harder
to fetch needed sha1 by direct fetching sha1", 2016-02-24), and the
"Unable to fetch..." message was downgraded from a fatal error to a
notice in e30d833671 ("git-submodule.sh: try harder to fetch a
submodule", 2018-05-16).

This commit improves the notice to be clearer that we are retrying the
fetch, and that the previous messages (in particular, the fatal errors
from fetch) do not necessarily indicate that the whole command fails. In
other words:

 - If the HEAD-fetch succeeds and we then have the commit we want,
   git-submodule prints no explanation.
 - If the HEAD-fetch succeeds and we do not have the commit we want, but
   the hash-fetch succeeds, git-submodule prints no explanation.
 - If the HEAD-fetch succeeds and we do not have the commit we want, but
   the hash-fetch fails, git-submodule prints a fatal error.
 - If the HEAD-fetch fails, fetch prints a fatal error, and
   git-submodule informs the user that it will retry by fetching
   specific commits by hash.
   - If the hash-fetch then succeeds, git-submodule prints no
     explanation (besides the ones already printed).
   - If the HEAD-fetch then fails, git-submodule prints a fatal error.

It could be said that we should just eliminate the HEAD-fetch
altogether, but that changes some behavior (in particular, some refs
that were opportunistically updated would no longer be), so I have left
that alone for now.

There is an analogous situation with the fetching code in fetch_finish()
and surrounding functions. For now, I have added a NEEDSWORK.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
Change from v1: No code change; commit message change can be seen from
the range-diff below.

> "additional" is relative to something.  Is it additional to status-quo?
> >
> >  - If the HEAD-fetch succeeds and we then have the commit we want, no
> >    extra messages are printed.
> >  - If the HEAD-fetch succeeds and we do not have the commit we want, but
> >    the hash-fetch succeeds, no additional messages are printed.
> 
> For example, the user would be helped to be told that we succeeded
> doing a pointless fetch and we now are going to make a more specific
> "give me that commit" fetch to see if it helps.  These may already
> be given with the current code, or may not be (I don't know
> offhand), but "no additional messages" does not help me in knowing
> if the code with this patch would give such a hint to the users.

It is additional to what fetch prints. To make it clearer, I have
removed all mentions of "additional" from the commit message. But right
now I'm not sure if that whole section is important (since what happens
can be deduced quite easily by reading the fewer than 10 lines of code).

(Also, to answer your question, we currently don't tell the user that we
succeeded in a pointless fetch and will make another one.)

> A more fundamental question is why these submodule repositories do
> not have HEAD to recommend from which branch to fetch by default,
> and if we can do something about it so that HEAD-fetch fails less
> often for the users.

If you mean a recommendation to the repository administrator, I guess we
can recommend that their HEAD points to something, even if it's just a
single orphan commit with a .txt file explaining what's going on.

Range-diff against v1:
1:  1e3fd22f33 ! 1:  d7399fc35e submodule: explain first attempt failure clearly
    @@ -28,19 +28,22 @@
         submodule", 2018-05-16).
     
         This commit improves the notice to be clearer that we are retrying the
    -    fetch, and that the previous messages do not necessarily indicate that
    -    the whole command fails. In other words:
    +    fetch, and that the previous messages (in particular, the fatal errors
    +    from fetch) do not necessarily indicate that the whole command fails. In
    +    other words:
     
    -     - If the HEAD-fetch succeeds and we then have the commit we want, no
    -       extra messages are printed.
    +     - If the HEAD-fetch succeeds and we then have the commit we want,
    +       git-submodule prints no explanation.
          - If the HEAD-fetch succeeds and we do not have the commit we want, but
    -       the hash-fetch succeeds, no additional messages are printed.
    +       the hash-fetch succeeds, git-submodule prints no explanation.
          - If the HEAD-fetch succeeds and we do not have the commit we want, but
    -       the hash-fetch fails, this is a fatal error.
    -     - If the HEAD-fetch fails, we print the notice, and if the hash-fetch
    -       succeeds, no additional messages are printed.
    -     - If the HEAD-fetch fails, we print the notice, and if the hash-fetch
    -       fails, this is a fatal error.
    +       the hash-fetch fails, git-submodule prints a fatal error.
    +     - If the HEAD-fetch fails, fetch prints a fatal error, and
    +       git-submodule informs the user that it will retry by fetching
    +       specific commits by hash.
    +       - If the hash-fetch then succeeds, git-submodule prints no
    +         explanation (besides the ones already printed).
    +       - If the HEAD-fetch then fails, git-submodule prints a fatal error.
     
         It could be said that we should just eliminate the HEAD-fetch
         altogether, but that changes some behavior (in particular, some refs

 git-submodule.sh | 2 +-
 submodule.c      | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 514ede2596..2c0fb6d723 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -594,7 +594,7 @@ cmd_update()
 				# is not reachable from a ref.
 				is_tip_reachable "$sm_path" "$sha1" ||
 				fetch_in_submodule "$sm_path" $depth ||
-				say "$(eval_gettext "Unable to fetch in submodule path '\$displaypath'")"
+				say "$(eval_gettext "Unable to fetch in submodule path '\$displaypath'; trying to directly fetch \$sha1:")"
 
 				# Now we tried the usual fetch, but $sha1 may
 				# not be reachable from any of the refs
diff --git a/submodule.c b/submodule.c
index 21cf50ca15..b16c0ecc95 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1548,6 +1548,13 @@ static int fetch_finish(int retvalue, struct strbuf *err,
 	struct oid_array *commits;
 
 	if (retvalue)
+		/*
+		 * NEEDSWORK: This indicates that the overall fetch
+		 * failed, even though there may be a subsequent fetch
+		 * by commit hash that might work. It may be a good
+		 * idea to not indicate failure in this case, and only
+		 * indicate failure if the subsequent fetch fails.
+		 */
 		spf->result = 1;
 
 	if (!task || !task->sub)
-- 
2.21.0.155.ge902e9bcae.dirty

