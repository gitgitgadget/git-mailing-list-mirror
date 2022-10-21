Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC53C4167B
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 15:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiJUPOI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 11:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiJUPNt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 11:13:49 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08A610DE41
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 08:13:47 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id bp11so4999443wrb.9
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 08:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQg2Yh/C6qTRM4fuzX0XO0sGqNk7vg22JFBcSfkd4yo=;
        b=nATpSTs3TETlqLBiHCxclHRLTJgI12pZV5NSpdy5Bnh6sJWQoXzAI2frHiMExejCgi
         U39ggIA20+nPyzOibYojC0JTGmPCfrriAH3QpPBz5+GsjffupC4jVegVtd1om3ZK30lK
         wGbmxQENZSEVwoIIrO/ZZrxZ7F6QFl80Cz7SRF0wZblt1qpM9z7UKKD85/l8Wsm45wzG
         yu8i/lWFf+ayFCZobqjzFzcL7j+RE2ZXdSqBjagy9bUGYJoIvM0MlNAWtwGIRvmDu2N+
         Ak3oUcKAvHQFdEN1N0J+WQfFzqHrSFWUEmPqyl2Pg8cheL5IXinoT/n7HtT27vxe7Kz2
         Gh9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dQg2Yh/C6qTRM4fuzX0XO0sGqNk7vg22JFBcSfkd4yo=;
        b=qJKE7y+9BLAoRuBot89j4XTAsFNPxNiIykpwqdthNiPnrQU94xdS44/Tv7qnRmT9wF
         KPY+cKzykJbb/PssVBc67JVMKoyGqyNxsic+OyXzYRH4nSv+dzQJUvVpy+DOu8W4QbyX
         /VG+oP96un5mqLut8QX1VbawduLrEUpRheesf5G88/46Si6432oywvN1XhBBNJiCfMNs
         OJisMqoQ1KlbGNKtUhTe7+1aDPyyLTmf1YShq45qt3KALCQNbYz90pyJzYYs4HFAQkqk
         hQ4vssX0ZJ8q3gs4NNsDog5kNHkoGriB7X9iIas3+bTbOzodd3jJAc4Gw3DJ4r+cWKAD
         cqHw==
X-Gm-Message-State: ACrzQf38z5YXDQZsshEdjbTxkYkflR1mXOpOXPjLPu1gmv7tcJUsPOT3
        j4t51bg/3bs6JUh1kCPaL2Hjip32sP0=
X-Google-Smtp-Source: AMsMyM4Q9KA1MAjS/xtDLksx7k6eYsKCUSPgv3/gHgJmCAgQnWPlqaKZHN6nhKWholA9K7Hslh90Lg==
X-Received: by 2002:a5d:590d:0:b0:236:4ddd:1869 with SMTP id v13-20020a5d590d000000b002364ddd1869mr4202596wrd.709.1666365226035;
        Fri, 21 Oct 2022 08:13:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b7-20020adfe307000000b0022cbf4cda62sm23319113wrj.27.2022.10.21.08.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 08:13:45 -0700 (PDT)
Message-Id: <040bc2224c9e42fb8d6fe6d2c01fcbe57a938613.1666365220.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1390.git.1666365219.gitgitgadget@gmail.com>
References: <pull.1390.git.1666365219.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Oct 2022 15:13:32 +0000
Subject: [PATCH 2/9] subtree: use 'git rev-parse --verify [--quiet]' for
 better error messages
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Luke Shumaker <lukeshu@datawire.io>,
        Thomas Koutcher <thomas.koutcher@online.fr>,
        James Limbouris <james@digitalmatter.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

There are three occurences of 'git rev-parse <rev>' in 'git-subtree.sh'
where the command expects a revision and the script dies or exits if the
revision can't be found. In that case, the error message from 'git
rev-parse' is:

    $ git rev-parse <bad rev>
    <bad rev>
    fatal: ambiguous argument '<bad rev>': unknown revision or path not in the working tree.
    Use '--' to separate paths from revisions, like this:
    'git <command> [<revision>...] -- [<file>...]'

This is a little confusing to the user, since this error message is
outputed by 'git subtree'.

At these points in the script, we know that we are looking for a single
revision, so be explicit by using '--verify', resulting in a little
better error message:

    $ git rev-parse --verify <bad rev>
    fatal: Needed a single revision

In the two occurences where we 'die' if 'git rev-parse' fails, 'git
subtree' outputs "could not rev-parse split hash $b from commit $sq", so
we actually do not need the supplementary error message from 'git
rev-parse'; add '--quiet' to silence it.

In the third occurence, we 'exit', so keep the error message from 'git
rev-parse'. Note that this messsage is still suboptimal since it can be
understood to mean that 'git rev-parse' did not receive a single
revision as argument, which is not the case here: the command did
receive a single revision, but the revision is not resolvable to an
available object.

The alternative would be to use '--' after the revision, as suggested by
the first error message, resulting in a clearer error message:

    $ git rev-parse <bad rev> --
    fatal: bad revision '<bad rev>'

Unfortunately we can't use that syntax because in the more common case
of the revision resolving to a known object, the command outputs the
object's hash, a newline, and the dashdash, which breaks the 'git
subtree' script.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/subtree/git-subtree.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 7562a395c24..49ef493ef92 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -387,7 +387,7 @@ find_latest_squash () {
 			main="$b"
 			;;
 		git-subtree-split:)
-			sub="$(git rev-parse "$b^{commit}")" ||
+			sub="$(git rev-parse --verify --quiet "$b^{commit}")" ||
 			die "could not rev-parse split hash $b from commit $sq"
 			;;
 		END)
@@ -439,7 +439,7 @@ find_existing_splits () {
 			main="$b"
 			;;
 		git-subtree-split:)
-			sub="$(git rev-parse "$b^{commit}")" ||
+			sub="$(git rev-parse --verify --quiet "$b^{commit}")" ||
 			die "could not rev-parse split hash $b from commit $sq"
 			;;
 		END)
@@ -843,7 +843,7 @@ cmd_add_commit () {
 	git checkout -- "$dir" || exit $?
 	tree=$(git write-tree) || exit $?
 
-	headrev=$(git rev-parse HEAD) || exit $?
+	headrev=$(git rev-parse --verify HEAD) || exit $?
 	if test -n "$headrev" && test "$headrev" != "$rev"
 	then
 		headp="-p $headrev"
-- 
gitgitgadget

