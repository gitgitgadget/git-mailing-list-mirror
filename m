Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52E0D20987
	for <e@80x24.org>; Thu, 20 Oct 2016 00:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756026AbcJTANn (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 20:13:43 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35829 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754472AbcJTANm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 20:13:42 -0400
Received: by mail-pf0-f194.google.com with SMTP id s8so3735951pfj.2
        for <git@vger.kernel.org>; Wed, 19 Oct 2016 17:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=BSG0jxpc43vkHgpA/wvF/n0HdrjGD0N4UoapfpP8vbk=;
        b=Sloy0kbQEG+GOVUnSamLPX7dWgPhEkoZ8CYsc+8XMQhMKP49g56uK5fpK5LMd/z9o0
         Ao9A32VSnSueOEs+MAf7Q4JwNRvqCZk0t2MJI2nMS97O6i3dAjykhE9i2DC9jRNizQlJ
         X2M0u2ozX1N4zVAi/k/k9pgzq+59cjlna56Dx1sCAmd0IGqmrgUT1O4uO4T9/KzFFNcr
         XRvff/jXE9mAQNqK+lX8yQb+UZp3aqon1O6El9FKBfQs7Gx4ahAiyhDUOW+7XErPr0Ws
         jSiZk1df7Eg4oG9mbD4QhFsCNAdjpM71nntUgqpWaf1Ixni1MeNhpEJ3DNvjsjMywsat
         ORWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BSG0jxpc43vkHgpA/wvF/n0HdrjGD0N4UoapfpP8vbk=;
        b=ihqGo20TJ8VJTxoLWRdVb69Jpts1WkIX6atkuPtL6RLP90UMy8QB+mhwX+0LiVDLAI
         xbL6Y+Mtb2lgF6dM7FkD31j9w2qOcy2mQfINdTO5wplgrDdeA9QkMxufNdhsODL83oB8
         gYPKHmcIyt0Dk7DDlqAgfQJ2E94EDeMuXkzuEXW8EF0WPhwcZHSsS+c9Vd4xtbi4fRfE
         wv4BpDEZ0du3mopEka/53Cf2UqQNWT+LIx4kZs5yqV3f+34s3mWubTJOD0HPCjzOQw6u
         qNNyRlzBCWKgRiuUmNLHTor3VQMuN48kHGGq9n7j9eYJsy6Tff75T7hrcJj5vAmPyxgk
         zNRw==
X-Gm-Message-State: AA6/9RncAk8+hPPZXeB84zfXca69+mao49SeYmEblJ0rUBJEt9wEE/ch6MZc+BL33xIISQ==
X-Received: by 10.99.110.14 with SMTP id j14mr13171198pgc.135.1476922421670;
        Wed, 19 Oct 2016 17:13:41 -0700 (PDT)
Received: from localhost.localdomain ([2002:46b5:ad14:0:223:12ff:fe05:eebd])
        by smtp.gmail.com with ESMTPSA id x1sm37135961pax.7.2016.10.19.17.13.40
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 19 Oct 2016 17:13:41 -0700 (PDT)
From:   "Kyle J. McKay" <mackyle@gmail.com>
To:     Git mailing list <git@vger.kernel.org>
Cc:     Jakub Narebski <jnareb@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [ANNOUNCE] git-log-compact v1.0
Date:   Wed, 19 Oct 2016 17:13:34 -0700
Message-Id: <git-log-compact-announce-v1@mackyle-at-gmail-com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> NOTE: If you read the excellent Git Rev News [1], then you
> already know all about git-log-compact :)

The git-log-compact script provides a compact alternative to the
`git log --oneline` output that includes dates, times and author
and/or committer initials in a space efficient output format.

`git-log-compact` is intended to fill the gap between the single line
`--oneline` log output format and the multiline `--pretty=short` /
`--pretty=medium` output formats.

It is not strictly a one line per commit output format (but almost) and
while it only shows the title of each commit (like the short format) it
does include author and date information (similarly to the medium format)
except that timestamps are shown very compactly and author/committer
names are shown as initials.

This allows one to get a complete view of repository activity in a very
compact output format that can show many commits per screen full and is
fully compatible with the `--graph` option.

Simple example output from the Git repository:

git log-compact --graph --date-order --decorate --no-merges -n 5 v2.5.3

    === 2015-09-17 ===
  * ee6ad5f4 12:16 jch (tag: v2.5.3) Git 2.5.3
    === 2015-09-09 ===
  * b9d66899 14:22 js  am --skip/--abort: merge HEAD/ORIG_HEAD tree into index
  |   === 2015-09-04 ===
  | * 27ea6f85 10:46 jch (tag: v2.5.2) Git 2.5.2
  * 74b67638 10:36 jch (tag: v2.4.9) Git 2.4.9
                       ..........
  * ecad27cf 10:32 jch (tag: v2.3.9) Git 2.3.9

I have been wanting a compact one line output format that included dates,
times and initials for some time that is compatible with --graph, clearly
shows root commits and eliminates confusion over whether or not two adjacent
lines in the output are related as parent/child (the --show-linear-break
option does not work with --graph).

The git-log-compact utility is the result.  Except for --notes, --pretty and
--format options (which would make the output a non-oneline format) any
other `git log` option may be used (including things like --cherry-mark,
--patch, --raw, --stat, --summary, --show-linear-break etc.),

There are a few new options specific to git-log-compact which are described
in the README and the `git-log-compact -h` output that can be used to alter
the dates, times and/or initials displayed.

The project page with detailed help and many screen shots is located at:

  https://mackyle.github.io/git-log-compact/

Alternatively the repository can be cloned from:

  https://github.com/mackyle/git-log-compact.git

Or the script file itself (which is really all you need) can be
viewed/fetched from:

  https://github.com/mackyle/git-log-compact/blob/HEAD/git-log-compact

The git-log-compact script should work with any version of Git released
in the last several years.

--Kyle

[1] https://git.github.io/rev_news/2016/10/19/edition-20/
