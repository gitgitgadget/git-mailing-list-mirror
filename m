Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D83E211B3
	for <e@80x24.org>; Mon,  3 Dec 2018 17:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbeLCRxb (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 12:53:31 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36917 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeLCRxb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 12:53:31 -0500
Received: by mail-lj1-f194.google.com with SMTP id e5-v6so12267251lja.4
        for <git@vger.kernel.org>; Mon, 03 Dec 2018 09:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mL6/sAi+4XQA6sPBfW3B2VHk379HYrrsE9pfpHbp1q4=;
        b=esUJcY4b54JbScSWiR1Yt7uId6tvE0Hwic0/VDbcSgJwzGl/Puoxdke6vTPLTLIQFq
         mdRFsLUg7JBqyQhzfrcs4O2zqJfC92Q/jZBdcTN9JygCdOsk5dacBvsfKamgIg/XICSA
         jE7q+HYm3/jrwg/S8HQBDFk8KnVGk/tZDctJe/AAiO2sdLs1ocBsK7iFq10OkoLYD3xu
         PaKoxBA3NM6hH5uIb2ErT5/1i0Ni+vpHULbRZwicZTnkOR0ah6wOwnDlxiha5Cm99pBR
         wMK/+Fzem8HdyVk4S+aHTeI2bp3r9uOSHwRZ0C5U+m9IE45szgrHT57dyF9eSb5CRdwz
         iIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mL6/sAi+4XQA6sPBfW3B2VHk379HYrrsE9pfpHbp1q4=;
        b=qGzUWjg35ywMEtZt4ewUPHsdfukID/MTKs1phpjeAb6lUFFSHHX3gLhWLlVqM1Ue+j
         4m58bidcC7KOYYjMnnAEyyIEJqM/CN+XhaQ3ml+pMh50egwzD1GYqTT242tYEpbW55+g
         stzpk0n1cDGi/x4RcGv1uaRTLY57KF7bJ0g8svXJCRde+i+WryVpjkaGKPJfDnyXQeu6
         FBDD9RWNrSX/ekAXtoXO/5aS0UHtB18RIr3Z1gs3ofX/MOeKRpS5g2eABZ/07oDrQWiW
         MjZJ51u8SveLDWSEzrbdFaGYEvBn8TuuXljOHUqAnIqw/YN98hbxquHBoNFSUAiGFauN
         tHXg==
X-Gm-Message-State: AA+aEWbU4w4z6iISHP4VHqI8BLH9e/C86cVXjtP3vCYO1xNQVlZMi5zE
        Xzldyw8Luk1PAOXtGlYPkWE=
X-Google-Smtp-Source: AFSGD/VTCLpXq78pa8RaP/5IJjSauxQMkLACkozXch7dmTIXE6s702zIzkiJ7hHInE4jMJ+C6BKW1g==
X-Received: by 2002:a2e:9957:: with SMTP id r23-v6mr10244443ljj.98.1543859605590;
        Mon, 03 Dec 2018 09:53:25 -0800 (PST)
Received: from duynguyen.home (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id e13-v6sm2599385ljk.53.2018.12.03.09.53.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 09:53:24 -0800 (PST)
Date:   Mon, 3 Dec 2018 18:53:22 +0100
From:   Duy Nguyen <pclouds@gmail.com>
To:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Paul Morelle <paul.morelle@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] rebase -i: introduce the 'test' command
Message-ID: <20181203175322.GA3892@duynguyen.home>
References: <3fb5a7ff-a63a-6fac-1456-4dbc9135d088@gmail.com>
 <nycvar.QRO.7.76.6.1811281600240.41@tvgsbejvaqbjf.bet>
 <25e07b91-3089-153c-2ecf-7d2d66bc3b65@gmail.com>
 <nycvar.QRO.7.76.6.1811281935310.41@tvgsbejvaqbjf.bet>
 <20181201200209.GC29120@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181201200209.GC29120@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 01, 2018 at 03:02:09PM -0500, Jeff King wrote:
> I sometimes add "x false" to the top of the todo list to stop and create
> new commits before the first one.

And here I've been doing the same by "edit" the first commit, add a
new commit then reorder them in the second interactive rebase :P

This made me look at git-rebase.txt to really learn about interactive
rebase. I think the interactive rebase section could use some
improvements. Its style looks.. umm.. more story telling than a
reference. Perhaps something like this to at least highlight the
commands.

-- 8< --
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 80793bad8d..c569b3370b 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -637,22 +637,22 @@ The oneline descriptions are purely for your pleasure; 'git rebase' will
 not look at them but at the commit names ("deadbee" and "fa1afe1" in this
 example), so do not delete or edit the names.
 
-By replacing the command "pick" with the command "edit", you can tell
+By replacing the command `pick` with the command `edit`, you can tell
 'git rebase' to stop after applying that commit, so that you can edit
 the files and/or the commit message, amend the commit, and continue
 rebasing.
 
 To interrupt the rebase (just like an "edit" command would do, but without
-cherry-picking any commit first), use the "break" command.
+cherry-picking any commit first), use the `break` command.
 
 If you just want to edit the commit message for a commit, replace the
-command "pick" with the command "reword".
+command "pick" with the command `reword`.
 
-To drop a commit, replace the command "pick" with "drop", or just
+To drop a commit, replace the command "pick" with `drop`, or just
 delete the matching line.
 
 If you want to fold two or more commits into one, replace the command
-"pick" for the second and subsequent commits with "squash" or "fixup".
+"pick" for the second and subsequent commits with `squash` or `fixup`.
 If the commits had different authors, the folded commit will be
 attributed to the author of the first commit.  The suggested commit
 message for the folded commit is the concatenation of the commit
@@ -693,7 +693,7 @@ $ git rebase -i -p --onto Q O
 Reordering and editing commits usually creates untested intermediate
 steps.  You may want to check that your history editing did not break
 anything by running a test, or at least recompiling at intermediate
-points in history by using the "exec" command (shortcut "x").  You may
+points in history by using the `exec` command (shortcut `x`).  You may
 do so by creating a todo list like this one:
 
 -------------------------------------------
-- 8< --
--
Duy
