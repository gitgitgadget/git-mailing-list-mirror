Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C59C1F463
	for <e@80x24.org>; Fri, 27 Sep 2019 13:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfI0Nce (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Sep 2019 09:32:34 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56301 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfI0Nce (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Sep 2019 09:32:34 -0400
Received: by mail-wm1-f67.google.com with SMTP id a6so6621683wma.5
        for <git@vger.kernel.org>; Fri, 27 Sep 2019 06:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xBw2K/tJdc+Wdtg+BSAt7LyIpthl3MPUDmEQlfSuENc=;
        b=N/ghzcu78T95DeI7WuOYzkxaCBKy1WBmy+TliZxl5VyK5ZaNDKWb7xNvdqpCNmBee9
         P/ezMsrRCS24g4dTdZc9mMZl7jWA6cxXtpAXWEZ6MwangWOGjkvBcqOhvquxetdzj7tG
         puk0XSXIWL5RDwf5hyB9r7Oz3uUw4BZIIoNxrlfaND+9acVb2BID2i1+qkj/l/VgE3sS
         eQOPu11Tb7+rb3fbmFgvb31eZmHEwKoGKVH75tpvvebeoAY2DlwUAjKnz87w72b8Gnqc
         Qu9NzxpsdWsGL92sE3sobzXm9MSqHXuKKRh/jW/AgH1k+QF+I+mThi94cqb18LH1rVNq
         cjAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=xBw2K/tJdc+Wdtg+BSAt7LyIpthl3MPUDmEQlfSuENc=;
        b=mmU71eAChwkr6wjSSqHnTScFClzG9cpNjs++k8lYG2XSTamQ7vJytfS7BO5fUrUiwy
         /XjV1Wxa48iDMVxD2ufwoV5s7UlfojWE2dMgII1C9N0He6NWijWE9OTMFSqD3MgWj4Zx
         qJqB6V8Vd2MuIIm9TdC0MItMIH5g2k2dWEzkxf/pAnkkQkKVozBTAPP3i6r//R7uWpEJ
         1ST/Kb5MyEuRZuWJ8xnCjrIMR7IijmK0I1wVRpYcA3Xf0TSc9K3CLHE3mZhfoJjf3gqU
         Rc7jigLQ1cdgiP7YY24nilKNSKSWgHAE6h/iJ6WTKtqZkUDb8Kaonqtf5zHR/Dt1CFTh
         uHWw==
X-Gm-Message-State: APjAAAWDakDEYUNA4sJMh9ktzSSKtTUcuNYCSTXkb7zttKVpETZSvgno
        K/lkCHAHOV/hWL0bMdCEQ0qplOsG
X-Google-Smtp-Source: APXvYqyKZDSfWiVhobrJlwxxpjAcGwLORt0tn7Wah/PWJl0278JDlG7eYtI4jdWDpVMLr+8wg0niKQ==
X-Received: by 2002:a7b:cbd6:: with SMTP id n22mr7700813wmi.39.1569591151459;
        Fri, 27 Sep 2019 06:32:31 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-10-31.as13285.net. [92.22.10.31])
        by smtp.gmail.com with ESMTPSA id z3sm4950564wmi.30.2019.09.27.06.32.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2019 06:32:31 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_v1_0/5=5d_Use_complete=5faction=e2=80=99s_?=
 =?UTF-8?Q?todo_list_to_do_the_rebase?=
To:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>
References: <20190925201315.19722-1-alban.gruin@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <a8e6ba74-8a7a-495a-41fb-b3183f49e070@gmail.com>
Date:   Fri, 27 Sep 2019 14:32:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190925201315.19722-1-alban.gruin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban

On 25/09/2019 21:13, Alban Gruin wrote:
> This can be seen as a continuation of ag/reduce-rewriting-todo.
> 
> Currently, complete_action() releases its todo list before calling
> sequencer_continue(), which reloads the todo list from the disk.  This
> series removes this useless round trip.
> 
> Patches 1, 2, and 3 originally come from a series meaning to improve
> rebase.missingCommitsCheck[0].  In the original series, I wanted to
> check for missing commits in read_populate_todo(), so a warning could be
> issued after a `rebase --continue' or an `exec' commands.  But, in the
> case of the initial edit, it is already checked in complete_action(),
> and would be checked a second time in sequencer_continue() (a caller of
> read_populate_todo()).  So I hacked up sequencer_continue() to accept a
> pointer to a todo list, and if not null, would skip the call to
> read_populate_todo().  (This was really ugly, tbh.)  Some issues arose
> with git-prompt.sh[1], hence 1, 2 and 3.
> 
> Patch 5 is a new approach to what I did first.  Instead of bolting a new
> parameter to sequencer_continue(), this makes complete_action() calling
> directly pick_commits().

Thanks for working on this, these patches all look fine to me modulo the 
confusing wording in the commit message on patch 4

Best Wishes

Phillip

> 
> This is based on master (4c86140027, "Third batch").
> 
> The tip of this series is tagged as "reduce-todo-list-cont-v1" at
> https://github.com/agrn/git.
> 
> [0] http://public-inbox.org/git/20190717143918.7406-1-alban.gruin@gmail.com/
> [1] http://public-inbox.org/git/1732521.CJWHkCQAay@andromeda/
> 
> Alban Gruin (5):
>    sequencer: update `total_nr' when adding an item to a todo list
>    sequencer: update `done_nr' when skipping commands in a todo list
>    sequencer: move the code writing total_nr on the disk to a new
>      function
>    rebase: fill `squash_onto' in get_replay_opts()
>    sequencer: directly call pick_commits() from complete_action()
> 
>   builtin/rebase.c |  5 +++++
>   sequencer.c      | 26 ++++++++++++++++++--------
>   2 files changed, 23 insertions(+), 8 deletions(-)
> 
