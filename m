Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9204E1F78F
	for <e@80x24.org>; Mon,  1 May 2017 17:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750801AbdEAR7Z (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 13:59:25 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:36841 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750760AbdEAR7Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 13:59:24 -0400
Received: by mail-io0-f174.google.com with SMTP id p80so126819098iop.3
        for <git@vger.kernel.org>; Mon, 01 May 2017 10:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=06TrMAnjo5zclKWghqEjleFN+hL5WKVOiaBONa1a9x8=;
        b=j5Ks9di5pYTxA0/Bd3mIfYTAnAoUG6r9RoJg11N/UQkqjy/NbDKDqxMMcJveca8Sw0
         JQbWhWNtOGT8UsemVAumHhlZ0tm6829m/UPIg+ESYvZE7yZeo5OCTY2owgMK6I4YmaPf
         0eICQQkY6OLCMMmLGm6YB8W//Ijg7NdWYiq7Zf2LkO3DC22CI9w8MwHrJ1okXRVEpbDb
         jxEVFYZRXJJYspE3Gb2G5zd2oduKO9h/59jOOqcEEOgR7nWVyZiO6cdHrc9cNIwdzIH8
         pP456jUIEjt/bolyZYF309oMKZRoj/QkVO6ROIfG8vPaIUiFyTXqbkgD+8fuXajnpE7/
         7g7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=06TrMAnjo5zclKWghqEjleFN+hL5WKVOiaBONa1a9x8=;
        b=AhyZo2Nf7F/9cAthXeB6iRlU/PddDnHsh5cdkEsdbBr6sQUfbKBcy9+1peKqjV858u
         RIGzX0VjSvfX82Menglvaui1PbNG1lnsE4x5V/hWLMwCbUftF0dHe87dHl985qGzInmC
         wTKKcto547fTEg3cGHiUeGZtzWOzU8D8C+sze4Xoutzzv440A50f2n0E8kUlXBBjr6oI
         edIBFqJ/2z2PMzWOk6LRwZMCjfcKJRxbDerOkR4Di2WnsXycGBRlmZ1cc0XKijc/2cG8
         no/7vfx2oxuwCnx8/YTxS7v7lzeUoXBl0D62zYI+cgzbtQq3oyVxYQPw3a4WhQsaLZKI
         Sf+g==
X-Gm-Message-State: AN3rC/63K2HnHVpNRlDMvzEdp1z08T7xFy/UYxYWEHs5jiQMwqdDEN4k
        /j70/9ZnHfW1ja8J8SCKIzeY/YUHdw==
X-Received: by 10.107.140.197 with SMTP id o188mr22899167iod.180.1493661563402;
 Mon, 01 May 2017 10:59:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.150.90 with HTTP; Mon, 1 May 2017 10:58:42 -0700 (PDT)
In-Reply-To: <xmqq60ip1m0f.fsf@gitster.mtv.corp.google.com>
References: <58DE0598020000A1000256CE@gwsmtp1.uni-regensburg.de> <xmqq60ip1m0f.fsf@gitster.mtv.corp.google.com>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Mon, 1 May 2017 12:58:42 -0500
Message-ID: <CAJZjrdUt+=oLt0cDcs2+bJMCFR4h8UUSFmZkx6-1menz4haPig@mail.gmail.com>
Subject: Re: Terrible bad performance for it blame --date=iso -C -C master -- <file>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 31, 2017 at 10:52 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de> writes:
>
>> I was running "vc-annotate" in Emacs for a file from a large
>> repository (>40000 files, a big percentage being binary, about 10
>> commits). For the first file the result was presented rather soon, but
>> for a second file the command did not finish even after about 10
>> minutes!
>>
>> The file in question is a rather short text file (124 kB), and
>> according to git log it has one commit.
>>
>> While being bored, I did an strace of the command to find out that a
>> huge number of files is inspected.
>
> With -C -C the user (vc-annotate?) is asking to inspect huge number
> of files, to find if the contents of the file (except for the part
> that came from its own previous version) came from other existing
> files.  So this is very much expected.
>
> It might not be a bad idea to teach "blame" not to pay attention to
> any path that is marked as "-diff" (e.g. binary files) when trying
> to see if remaining contents appeared by borrowing from them.  We do
> not have that heuristics (yet).

Could you elaborate on this? Do you mean to tell diffcore-rename to
ignore diff_filespec objects if they're binary?
