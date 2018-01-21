Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D2D91F576
	for <e@80x24.org>; Sun, 21 Jan 2018 18:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750954AbeAUSrL (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Jan 2018 13:47:11 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:42209 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbeAUSrK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Jan 2018 13:47:10 -0500
Received: by mail-qt0-f193.google.com with SMTP id c2so15690832qtn.9
        for <git@vger.kernel.org>; Sun, 21 Jan 2018 10:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=LY3ZGF4l+m6lq+6EtaXfZNIKHtVbqxqJ7aNn+fkQCQ0=;
        b=AH5ZjdwQKQLpmsukxkDJzqJMVlYKpHtlQI1AUKJ3enIx2gLtpA8kMzkyWBlswHn0XC
         ypfXayWmGKaBwNlMVbD8CYnr3DUS2fT7eYpG8G+IP7T8YZq4o9GF/Vrf3qdUWqacfu+H
         Vi9G/AWstRnEsI5nrU+m8d/vuKtXOK0a8QRRrsYT/yWw1/Pho7IN5HzfAuHHMG7LmP+R
         pcW1cE+CJjEGETREvfIEowKwJsR7YZXlGhsb/iPw6liE+vy4tYbN4EIoBUrmot8h69+R
         Hxi5oWQYIbbjOwaHBNwQKbBv6wS/fUvOuwTJnrxwGRGWmmLiicGZi+I8sCE86r2zqaZz
         /neA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=LY3ZGF4l+m6lq+6EtaXfZNIKHtVbqxqJ7aNn+fkQCQ0=;
        b=SAaST0vClSRBI6t3b/iUrBrBlCr9Pu7Giq/6XfilPmffAuc40HipMyERpknM+T+PsX
         MdWD2mJJUu1NFYVGP97SIATa+V8Uim31SFUe2o2YeDWRG9OulBEiO46/IPINjvYl0cB0
         lwCdWz/ypK4bGwPfZ/oCR3Dk3RTOcVmWo3ykDUefXvcWxxsgYCVS7t/dizUgEOcW81af
         Mf/tJHxuBXloWqImewosJVeswBgXcSsJz2Mr3LFG+mPWzPqovwZgfC3BQVbn+ICRRYoZ
         oYWzB2Q5GdrpR+mlaLGoJpru/FA8Rkbia6iR9sajTJWXlI+uk0df+1fmTp2Z287cu0yj
         n57w==
X-Gm-Message-State: AKwxyte3ktBy+M7Ltx62B7Mj7PUzwrGDi+zXKLVSAlyvuLHxu/sVfPQU
        RDrI17RqDp3tdI2tO2eha/XjRAL+qqYNRcBPerE=
X-Google-Smtp-Source: AH8x225oyvIR6ka3Lce+vAGmgStXIk+wT/sQPKacyv9HXygGcIJ9/etj0QvBSpMXbWP3N2zEDmhPd+V7/K5TYk5ZnNI=
X-Received: by 10.200.25.9 with SMTP id t9mr7614505qtj.75.1516560429702; Sun,
 21 Jan 2018 10:47:09 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Sun, 21 Jan 2018 10:47:09 -0800 (PST)
In-Reply-To: <CACsJy8CpfVb546caxP-HGjk9uXa805uayF0A7oMzh+fzEFS_Qw@mail.gmail.com>
References: <20180119041825.727904-1-sandals@crustytoothpaste.net>
 <20180120203324.112522-1-sandals@crustytoothpaste.net> <CACsJy8CpfVb546caxP-HGjk9uXa805uayF0A7oMzh+fzEFS_Qw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 21 Jan 2018 13:47:09 -0500
X-Google-Sender-Auth: W6NTOos22kMVEYTLxkYnoMBoROI
Message-ID: <CAPig+cT-oj2N978Qk3oQ_7wMOccAA80ws62UdFq3PvWkD6xKOg@mail.gmail.com>
Subject: Re: [PATCH] t: add clone test for files differing only in case
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCR0YPQu9Cw0LXQsg==?= 
        <aleks.bulaev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 21, 2018 at 6:50 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, Jan 21, 2018 at 3:33 AM, brian m. carlson
>> +test_expect_success 'clone on case-insensitive fs' '
>
> We have CASE_INSENSITIVE_FS prereq. Should we use it here? I know it
> does not harm running this test on case-sensitive filesystem, but the
> prereq could be useful for grepping.

I'd rather not hide it behind the CASE_INSENSITIVE_FS[1] prerequisite
since the test potentially could catch some sort of future regression
even on case-sensitive filesystems.

[1]: Todd Zullinger suggested the same:
https://public-inbox.org/git/CAPig+cSRN1zHc=zsO1Y_aQ_eO+sbsd0cq5iZ9hYz3ruK_E-0Dw@mail.gmail.com/
