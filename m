Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5B781F576
	for <e@80x24.org>; Sat, 24 Feb 2018 08:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751531AbeBXIEW (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Feb 2018 03:04:22 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:33907 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751522AbeBXIEV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Feb 2018 03:04:21 -0500
Received: by mail-qk0-f195.google.com with SMTP id l206so13616224qke.1
        for <git@vger.kernel.org>; Sat, 24 Feb 2018 00:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=4lBaf9iRI4QkbLPOobQlYCHpPPf1QS+Nc06nqaLx+co=;
        b=ckzN9JJB5e/VkgScDk32xs1eEReDLPEchlFVaOSxS5bZjtFm5oxQk6pxt/23ZxS+m3
         30SMDiH3yMEQG6mUG7zBXow1oDDfQ39Bsg3x/tMyU2ZeN7F3D+fWHj1fV4rg02HOOAts
         QcQeMn/ZWd7bXR3oILXl3L/1cKQgAiCOZP+zYSImYa+qZRa1u7cRy6jgaPJXbdaZmOKp
         GPniH97g120ENystF0JC47SKiUs0BmaK7KsoCnzI9kjun9YPlcUuPzCSo3qxwMUsW2Da
         E1vMPrmksYztmJR3XcaAI08WrdlxGoAd5OLy8lX4GqAoWMrgkmy2H8+A5O4H6HgVHaAj
         6bdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=4lBaf9iRI4QkbLPOobQlYCHpPPf1QS+Nc06nqaLx+co=;
        b=rMbIJvg7hu2/A81GDmiLjNPj6EpLFIZukciSfWJN1GBHwuia8AkhebfNLL8Y10GFxE
         V+qRp0C82uX5vzRwTB4CmtHwLeJxQra52iitRCbe2FUUb0R23IAhXZ8Vkg8E+IPAzBuJ
         wLGJQISilJfmW+E3XNmnWc/fTKLEsm+xZ4vrFb8YbCyyb31YrTN238iKxP17qOu2JMlq
         JgaFZZ+rD02AYQgQtCD7UlHjaRe8IWaNhH+j/dnlXK1JIC+oWK4f77dmpUliW1KmR3AT
         UrHBoe57jI99WQNTaO8l8ZYF7IZ5WeAWpf5DNqU4Ot6e88EN/b8uecwN4fZKQaeSY9yi
         U7TA==
X-Gm-Message-State: APf1xPAPwbTJm1bWbRM57ZracOWqe+0RpKmiHCMJ8cq6Uj6+eetuDm67
        DeI35UubRb1wFeduQaKqlbYQZH/NRueI1FFPW/k=
X-Google-Smtp-Source: AG47ELsv1mvUK+/8TeVWeUoMVUirPUt3dMVHFfdSSlnfLwVuTn5lF/WQO+AnEOYLfWCv+rDzA41oVzqMYY5n5Eg/u8U=
X-Received: by 10.55.56.84 with SMTP id f81mr269803qka.176.1519459460455; Sat,
 24 Feb 2018 00:04:20 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Sat, 24 Feb 2018 00:04:20 -0800 (PST)
In-Reply-To: <20180223233951.11154-5-szeder.dev@gmail.com>
References: <20180223233951.11154-1-szeder.dev@gmail.com> <20180223233951.11154-5-szeder.dev@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 24 Feb 2018 03:04:20 -0500
X-Google-Sender-Auth: W1-CpKuNzjeRhv2tl1r8dXcp8ds
Message-ID: <CAPig+cTSGNE_qzP74Bn+JnhvRsVt1-HzAiEf=1w_Rk6rUCrsWg@mail.gmail.com>
Subject: Re: [PATCH 04/11] t3030-merge-recursive: don't check the stderr of a subshell
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 23, 2018 at 6:39 PM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
> The two test checking 'git mmerge-recursive' in an empty worktree in

s/mmerge/merge/, I guess.

> 't3030-merge-recursive.sh' fail when the test script is run with '-x'
> tracing (and using a shell other than a Bash version supporting
> BASH_XTRACEFD).  The reason for those failures is that the tests check
> the emptiness of a subshell's stderr, which includes the trace of
> commands executed in that subshell as well, throwing off the emptiness
> check.
>
> Note that both subshells execute four git commands each, meaning that
> checking the emptiness of the whole subshell implicitly ensures that
> not only 'git merge-recursive' but none of the other three commands
> outputs anything to their stderr.  Note also that if one of those
> commands were to output anything on its stderr, then the current
> combined check would not tell us which one of those four commands the
> unexpected output came from.
>
> Save the stderr of those four commands only instead of the whole
> subshell, so it remains free from tracing output, and save and check
> them individually, so they will show us from which command the
> unexpected output came from.
>
> After this change t3030 passes with '-x', even when running with
> /bin/sh.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
