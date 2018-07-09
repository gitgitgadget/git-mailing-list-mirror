Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4589F1F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 14:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932921AbeGIOQV (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 10:16:21 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:36971 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932574AbeGIOQU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 10:16:20 -0400
Received: by mail-lj1-f169.google.com with SMTP id v9-v6so3908201ljk.4
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 07:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=1zvBSiG+6YH/Vn2a6jEqt8Czt5o8nGm+vYsqoqsd9DE=;
        b=FvS1BRGsxBCJRnerkJudhGnyl9tdJQ038nfbXhE3Xfq17zAtJbTo7sWlnFg+cHbck7
         PLSm5Wmf2AucNP1s4+ZkLCraNSieZFYFo63QtU/nTibV56y8yijCjtOTNp98dyEg2uL5
         a73hE7RPIYphbkdTknDmJYn0/bbgtdrajZoK0rP7GDrNj4vz31JW/U/FHC/vNd+MrUis
         8Qc/5/xh+T4nuxpsM+7eUHpURWa2kt9Mrj+PYahIlyTWMvYmCqIkjgfnoDmJruC/kIH8
         yW12LK69MBbbZ+4Sz2GdpK3iS9H97JRya3qojeM/lPbIBzkyiMXiyXaLPd0o1fsOKzqg
         yZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=1zvBSiG+6YH/Vn2a6jEqt8Czt5o8nGm+vYsqoqsd9DE=;
        b=ciZSaqFUlBJX1ZBblxzzYF42VyCdJjqk6CIX/M3SHXXBNjneEqGz86v4YwH0CpTpX6
         s9czhgDm3M00zUlbl64gwqiYqN8lziuJyxQAfQuNU4eM36VAsM3zuypKoPIir1GfyKyk
         /UODRM8F/PVzOUVev0taC1tdn5KjepuQyCE0cwrgvzSIG5///s2h95TnMFE1Hgd88JcP
         EYxeFprdKgAdruNte/VxmWQRSxSUpmWmeSTmiG5pJonsWT0VLdsiIOvCfM3JfqixI9EU
         CAV10rnZk4PMTPGyIbNV2zW6io7hNcVk/sPwwqhCLIOwS+4UXaHH0DCUZa5Rp2jX6a5O
         SDfw==
X-Gm-Message-State: APt69E1A6gkmAkmIkKOx/Dw50t/5g3c/U1FrYg6X4XAgV0PmI15Sh70Q
        B4FG9U2I7bBMdBq1scjmWY0=
X-Google-Smtp-Source: AAOMgpdHbttGxVqBAGvY/4wjFFR8sAiy48OqcnZdxN9mw644DB/FKbo+wf390ZC3p0ShI0nwfny+OA==
X-Received: by 2002:a2e:1004:: with SMTP id j4-v6mr12481266lje.2.1531145779058;
        Mon, 09 Jul 2018 07:16:19 -0700 (PDT)
Received: from [192.168.221.164] ([185.79.217.61])
        by smtp.gmail.com with ESMTPSA id g17-v6sm2379835ljg.27.2018.07.09.07.16.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 07:16:18 -0700 (PDT)
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
From:   Andrei Rybak <rybak.a.v@gmail.com>
Subject: [BUG] git cherry-pick does not complain about unknown options
Message-ID: <33d3e45b-1245-9e2f-42ea-a654a593bf10@gmail.com>
Date:   Mon, 9 Jul 2018 16:16:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I was trying to cherry pick commits, while simultaneously changing the
author.  Unfortunately, cherry-pick doesn't have the same --author
option as git-commit.  However, instead of complaining about unknown
option:

- when trying to cherry-pick one commit, it reported a BUG
- when trying to cherry-pick several commits, cherry-pick silently
  did nothing

All commits in tests existed in repository:

    $ git cherry-pick --author='TEST' <one-commit> # case 1
    error: BUG: expected exactly one commit from walk
    fatal: cherry-pick failed
    $ echo $?
    128
    $ git cherry-pick --author='TEST' <commit1> <commit2>  # case 2
    $ echo $?
    0
    $ git --version
    git version 2.18.0.windows.1

I've encountered this issue in Windows version, and  Johannes Schindelin
has confirmed that the issue is also present in Linux version.

Originally reported here: https://github.com/git-for-windows/git/issues/1751

--
Best regards, Andrei Rybak
