Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB32D1F403
	for <e@80x24.org>; Tue, 12 Jun 2018 20:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754329AbeFLUdL (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 16:33:11 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:43965 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754302AbeFLUdK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 16:33:10 -0400
Received: by mail-yb0-f194.google.com with SMTP id w3-v6so106650ybq.10
        for <git@vger.kernel.org>; Tue, 12 Jun 2018 13:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=9yeQFeC3hBqiLwpR6ZUKjZZB0meBNc0eGrCSDxDONAs=;
        b=AZ3Vbe0MOHME58sS8up7s4DhIGxtT+wupxu6+HAJsb9kGSZEYSvajAs9Q+57vVF1JV
         ZrHOIoM8699h2kbUG1hNkMbBrHZ5gGdo5+mqfCJI/aqH8D9LcCerjLLqKBXoVZ7mfrL5
         juFnb9KfpIlUppts3dIxm9Sik3xySR9UpESNEB088gMDY2B8JuwSML7DlVzzxlJD6kl3
         MvA0n+FPC4g5lWDfzo0prMBAIuHbm1XMZnUeKIW9vW8ku3oZy2GiSSrrfBTTpuot88Gg
         4oH9gRVDyUhZyApp2ka4HOR+BiYXLp12fukAUJns6mRRhSVhRys6UetUNZYfYf+pXcX7
         mb5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=9yeQFeC3hBqiLwpR6ZUKjZZB0meBNc0eGrCSDxDONAs=;
        b=SWZhGPaQCr2TGRF/VZ4ppnz3EtE8MwOAbrs+AFwsCv9wxokjiAP345zESGqH0du1hT
         +Xaxca5zKsH7v3tG1kv0kWviV777XD6VGGiGQHqchuZnXewd6/DW27t7mDsqkA7wSV3i
         wLqrmcIqG+2Uqy38Vpw6teBAfkAXTdBFACc483cRfAmvFX2AxQMw1888kXQdtnFt56Hn
         /xkehCIwV+zYlB6lKN16utJccTbiNWL5Us0QuLffVdJma19qKZPwPWIGXA9QtVEsLalw
         Tux+4GSKd45yLw+zQZf/jMIm80OsbpQiy/qYuiGRwZ3bfPv31qepWJkGEYVXzbN2OpZj
         rXrA==
X-Gm-Message-State: APt69E2Az3OyVWMWWIiGUJB8BLyDYmWPOJD015144t2om+K7M7D4BbEM
        rvPGH2mrUBNObadcrzzajlXSmgdm6SqgV0mah30=
X-Google-Smtp-Source: ADUXVKIFIhgu6CDKieB+wmf9fKajVmiuxm2oSfpMfvIcPhUHXsx93ufijxKaFz6hHemOhumXiJiQSWa6jNNZYIRYAqo=
X-Received: by 2002:a25:83c6:: with SMTP id v6-v6mr1003971ybm.263.1528835589665;
 Tue, 12 Jun 2018 13:33:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3dc7:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 13:33:09
 -0700 (PDT)
In-Reply-To: <CAP8UFD38pLbAZce0bS=G62SCeTKvjn2Eao26Dkm5p72CAx3pYw@mail.gmail.com>
References: <20180612154413.3df64441@mydesk.domain.cxm> <CAP8UFD38pLbAZce0bS=G62SCeTKvjn2Eao26Dkm5p72CAx3pYw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 12 Jun 2018 16:33:09 -0400
X-Google-Sender-Auth: FaqXiceVVaxitBc2_j9Wo7miCJc
Message-ID: <CAPig+cSTyz7uG7RJFYKZEcS=+-i_mJh6abT7+ePiNm=D8s3RtQ@mail.gmail.com>
Subject: Re: How to delete files and directories from git commit history?
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Steve Litt <slitt@troubleshooters.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 12, 2018 at 4:26 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Tue, Jun 12, 2018 at 9:44 PM, Steve Litt <slitt@troubleshooters.com> wrote:
>
>> My project (call it myproject) had a directory (call it docs/propdir)
>> that was unnecessary for the project, and I've decided I don't want to
>> offer the files in that directory as free software. So I need to delete
>> docs/propdir from all commits in the repository. I did the following,
>> while in my working repository's myproject directory:
>>
>> git filter-branch --tree-filter 'rm -rf docs/propdir' HEAD
>
>> What command do I do to remove all mention of doc/propdir and its
>> files from my git history?
>
> Did you check the "CHECKLIST FOR SHRINKING A REPOSITORY" section of
> the filter-branch man/help page?

Also see BFG Repo Cleaner for an alternative.
https://rtyley.github.io/bfg-repo-cleaner/
