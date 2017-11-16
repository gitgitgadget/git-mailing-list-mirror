Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26C70201C8
	for <e@80x24.org>; Thu, 16 Nov 2017 04:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933303AbdKPEGm (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Nov 2017 23:06:42 -0500
Received: from mail-qt0-f171.google.com ([209.85.216.171]:52745 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932401AbdKPEGl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Nov 2017 23:06:41 -0500
Received: by mail-qt0-f171.google.com with SMTP id 31so39594497qtz.9
        for <git@vger.kernel.org>; Wed, 15 Nov 2017 20:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=DxOgaHsKCR1b6EsteqjPfSvLdRfSR3aEfRm12WaGO8Y=;
        b=dSBKnq1GI8uqFVK8cAC9ugbO2rPt2tAcb8icH25qkmjiidk+BiUgviBnpfsJqpPyFj
         X+qf0/FGCyV9GHRprvaBP4f0CtNIXVqY86Dd1ZHkjZLKBSyobW+ErSfzQAlTbzcd49UR
         jjn8Gu9Qg/9ElE/09Jz/XqWCPxjrd+fsjNFdM8RQj4Ib/fhpV48WXL3EvrNK3ntG/qgt
         0SGpwfN8KSfGC7MehcLA/38jOPQ8gv5mNHYGO7ibWL9/aYrVDCWChCPYIYoX6QSppMtE
         2Oz1/7zyWS2Uym/ksU2qAcj4Np7q6v95jrTFD2v0QOfUxCzHZZKoB4ITtTT1NTW1//U+
         5qzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=DxOgaHsKCR1b6EsteqjPfSvLdRfSR3aEfRm12WaGO8Y=;
        b=Cws9ashTZXfdyVOeLfEOedKTcZUKKZIGP82C+PwqQ0F7EXkP/o7PfuqXy8CBng0vTD
         N8Bqu51amdvRGpc5qrMunpZrGRI7yJw2H1Y1THikbbl3ymtMeRTSU3wSrlRYh5N+UArL
         n5LpEaNuiKb9FfD0xeVD2qEmQluiYtg3mAp5nzI9H2aJFSQw/AWA5mqgY9Y5ECeyStyr
         1JDfrRlD8lQVtNjGcyz2hJcbkxrB8pP8gZxpPuQ0FC5jpLg8jBLSIXLvKO/0IKjep8TZ
         bcPyPFfKVK7nvy9QahMY9OJfirT9qU4h0/BjOKnn/bNQhnNSnRuss+dJAMDFzKnKmYGL
         IiRA==
X-Gm-Message-State: AJaThX7GyBfj75+8/yIwiWZh4Irkxa7upNIp/WN9mP2vqFxZaS4HPWYQ
        fu/5RuIZi8+0EiIrNDM1dYARv1DXpHDKZt8loskMzQDH
X-Google-Smtp-Source: AGs4zMZBu8lWLkJkmpemu/Z87de6d06Wy2FaPFB3pUu9y/PN6S7mttcVInMM21Bj6ByWEsypLEjtZe2ALocSw69ED3s=
X-Received: by 10.233.222.135 with SMTP id s129mr449439qkf.261.1510805200395;
 Wed, 15 Nov 2017 20:06:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.176.212 with HTTP; Wed, 15 Nov 2017 20:06:40 -0800 (PST)
From:   Ryan Govostes <rgovostes@gmail.com>
Date:   Thu, 16 Nov 2017 13:06:40 +0900
Message-ID: <CAMtyXZYMU6fR4MTzRqOCgnqdhNhAVbLu7kUqGW6UXf9wq5P1zQ@mail.gmail.com>
Subject: Usability suggestion: Catch `git commit -amend`
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Despite being a native English speaker, I've often typo'd when trying
to invoke `git commit --amend`. Recently I wrote `git commit -ammend`
which of course added everything to the commit and attached the commit
message "mend".

This doesn't seem to be an uncommon error, there are 64,000 commits
like this on GitHub:
https://github.com/search?utf8=3D=E2=9C=93&q=3Dmend&type=3DCommits

The search for simply "end" (as in `-amend`) returns millions of hits
but it's hard to tell how many of those are false positives.

It might be reasonable to try to catch `-amend` (at least) and prevent
an errant commit. Trying to roll back a commit is a place where people
often get into trouble and get confused about the state of their
repository. (Of course, if they just cursor-up and fix the typo, now
they're editing the "end" commit and not the one they were trying to
amend in the first place.)

Git could suggest the user instead pass the commit message as a
separate argument, like `-am end` if they really want to do it.

I'm OK with getting an error if I type `--ammend`, but it is nice that
Git does do spell check on subcommand names. That would make it easier
to figure out which argument I mistyped. (In this case, there's
usually only one.)

Ryan
