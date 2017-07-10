Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C1A720357
	for <e@80x24.org>; Mon, 10 Jul 2017 20:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754511AbdGJUPm (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 16:15:42 -0400
Received: from mail-vk0-f48.google.com ([209.85.213.48]:32877 "EHLO
        mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754473AbdGJUPl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 16:15:41 -0400
Received: by mail-vk0-f48.google.com with SMTP id r126so54074568vkg.0
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 13:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=DEz7XFT0Cro4JWOxykQZ5QNTGdUa8wqxcGMYOfM0BQM=;
        b=MsdakY1Bxyyjz+BoOiTcSbTjFfItBGZy87yHowZCVr7ppZVESuUae+AMw5IgJHmpsw
         dBOR1RlIFQ2xW6K40A8vhu0Yg0Rx31Ctcsgtb5J4xVJ+mf9E9LRd8EGK5vJT/TjHWU+B
         aDZG1Ytkkq0Uc9Tau1q2oBjqQpjY6okMttvIj0cUC39NHTqO/b+v9piqRZ5tTIkWtyyK
         15EzuLhS/GfdLkJvaKHnlXRsZUlctbPaUrPwVYjqtbJw4flun4Vc700Ae7Nk1iMwalK3
         PZm1+RQJGOOUVOynX3n0d08cUPaULpY91g0fuJrmoxALjod4RUhBNaF0ZEZqC9Rum5F5
         UiSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=DEz7XFT0Cro4JWOxykQZ5QNTGdUa8wqxcGMYOfM0BQM=;
        b=CMTCacwBUKt8WerrOAfZabeAv7Bx3JO//wN2FZSrYa4qKAtbqc7afwh20ACS+Owr8L
         5UymwHmARFjiO6UcZaIcbg3MxfF5ErOYv13Ht2A3fWnHJqfUjxGKI87eXzkSrD3CfTFr
         ymOEKRXBDS+II2c7wlhKRrxCvT/O5Gmvn7Sa/poaDSBTvRArScKKD3E/oexdnWBpz0sF
         Tj+4xqsYp4esyrc/chNMgUe1eGglsHnkL+etCi0X98Oc3IxIpa+iZ2fh73NZBbrrKg8o
         3BpkFRIKGiit0FeGl4q4mJUXM2thY9pFk2D/TfavhsCadOwdSN4wd9u9ARfqE4H7c6XO
         ph9Q==
X-Gm-Message-State: AIVw111hgjs09LRSLkt7U1BBfJrQQFpOBn28D+Sq5fJZN8h6nRC1CHyw
        MvJF+bUE6RQBgC4jCZwsX2+ch7AU7x94
X-Received: by 10.31.69.82 with SMTP id s79mr7920861vka.118.1499717740404;
 Mon, 10 Jul 2017 13:15:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.44.8 with HTTP; Mon, 10 Jul 2017 13:15:40 -0700 (PDT)
From:   kinchit raja <kinchit15@gmail.com>
Date:   Mon, 10 Jul 2017 13:15:40 -0700
Message-ID: <CAKvSMhhO7RwiZfpcLR3cK2TXF-v9MrO1N33t8BqX=8f9z=Gd0w@mail.gmail.com>
Subject: Bug: Git checkout case Insensitive branch name compare
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bugs Details:

Git checkout case Insensitive branch name compare

Steps to Reproduce:

 I have a remote branch which is as shown below.
Example: feature_12345_write.netCodeForSomeFeature

 I used the git command on git bash and typed
"feature_12345_write.NetCodeForSomeFeature" thinking I am mapping
"feature_12345_write.netCodeForSomeFeature" locally.

So after I got the branch locally, I tried git pull and I see the following
"Your configuration specifies to merge with the ref
'refs/heads/feature_12345_write.NetCodeForSomeFeature' from the
remote, but no such ref was fetched.

 Although when I did "git log", it shows proper history for
"feature_12345_write.netCodeForSomeFeature" branch.

However when I use the command "git pull --rebase origin branch" it
says "fatal: Couldn't find remote ref
feature_12345_write.NetCodeForSomeFeature"
Because the remote branch has 'n' instead of 'N' in '.net' for branch name.

This is because I used "git checkout branch" instead of "git checkout
branch origin/remote branch name" since the local branch name I wanted
was the same as the remote branch name.

I don't see this in other branches.

I think the command is not considering case sensitivity of characters
in the branch name.

Thanks.

-- 
Best Regards,
Kinchit Raja
