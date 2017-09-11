Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BE9A1FADE
	for <e@80x24.org>; Mon, 11 Sep 2017 08:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751005AbdIKIpr (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Sep 2017 04:45:47 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:46116 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750989AbdIKIpq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2017 04:45:46 -0400
Received: by mail-wm0-f52.google.com with SMTP id i189so33881265wmf.1
        for <git@vger.kernel.org>; Mon, 11 Sep 2017 01:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:newsgroups:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w/yuCFDWsFxxnRtQpTi1aNFz+TB5Tu1jMOc75EscGWM=;
        b=g13WxXCZK+scCgKJnpTl0jAjMbo37pY9EtiJLOYvjS2O6c62aZ0bufhkNWPQW0St3Q
         8EIXdfYAXbKsfSSqq5Rr1Hyov+3cKRwLkqm/j5FyPz/q3rkn8fB+HI0hlPAwIJXwo6CC
         X1fQDtZptsWeMJRlUOuKC7ww8YZRohSNB3JQPQW8Z8loDCXwZ5zyYgkLhwYnpC0/oX9Y
         DsVtH5KQlY7WHi1ogoMlU/QTiXtjyJrJ/ctu5VTfuvykCwlGcpV9yH3gzj/DURDonC7S
         9rpx40k2vW8Hds04yet47ZssXKFLIgFYSQLnzKpXaFlnB/WM0HMf+nS0R/7YVRVxfo4F
         21rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:newsgroups:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=w/yuCFDWsFxxnRtQpTi1aNFz+TB5Tu1jMOc75EscGWM=;
        b=dkmzSBsTERFXB5bQaJTdgytd5QmOfXf2WPcIHAnNDwGmfgotZmVg8QmrNBmNNFrdjQ
         aKX0tULjyEwLQOjbVdRGXN9sdx62pfw+jBh2n9rTZkzWUdXCcyULNNZ+wmae/5JizbYU
         J/cV/GuhWLyeVXYHxPz533TV4JP2di6Hnu3YfPnimvJUeT/2PmVrfTPa0zRYWncpM/t/
         9TYgjOhqGF+NAFFgh2r8pp3RJw7C/nJkn94kjmf7KbVPI3DDJl38Y/ecl3JstTrJwyV4
         bYcXLbsQ02chIrwlUCg5JQrTyhVH6gMsmMfulms1oDTSw0Hi5oU9rh9N0ApXCH2811oo
         Qgyg==
X-Gm-Message-State: AHPjjUi9CloF3REOhl6XqCEM3Aj1G/JbkaI0/Tdulf9HP+bnpInVTkps
        EhuSjnLFUa7S2U6VhbM=
X-Google-Smtp-Source: ADKCNb7BmHQ7SiZbaztj2CmDENthuzd8eCgkGB6so7NAJJTf4QO0fziImtqzenkQuUhGYmEjJsYIuw==
X-Received: by 10.80.142.91 with SMTP id 27mr8157310edx.0.1505119544611;
        Mon, 11 Sep 2017 01:45:44 -0700 (PDT)
Received: from [192.168.178.23] ([95.90.234.92])
        by smtp.gmail.com with ESMTPSA id f20sm3573572edm.39.2017.09.11.01.45.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Sep 2017 01:45:43 -0700 (PDT)
Subject: Re: Commit dropped when swapping commits with rebase -i -p
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Newsgroups: gmane.comp.version-control.git
References: <oo62vr$pvq$1@blaine.gmane.org>
 <CAN0heSqGfxrFTwuaxgppZTx+3U=g_Qs4PyaCBF6ddV_PbvdpTQ@mail.gmail.com>
 <CAHGBnuMC_10krsdZe2KiQ4jjiL43kogn--dWjPgca_p2xgmQMA@mail.gmail.com>
 <20170902000417.GE143138@aiede.mtv.corp.google.com>
From:   Sebastian Schuberth <sschuberth@gmail.com>
Message-ID: <a47058cc-8ffc-4484-c247-3c8d4f827c07@gmail.com>
Date:   Mon, 11 Sep 2017 10:45:40 +0200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12)
 Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
MIME-Version: 1.0
In-Reply-To: <20170902000417.GE143138@aiede.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-09-02 02:04, Jonathan Nieder wrote:

>> Anyway, this should really more explicitly say *what* you need to know
>> about, that is, reordering commits does not work.
> 
> It tries to explain that, even with an example.  If you have ideas for
> improving the wording, that would be welcome.

As a first step, I indeed believe the wording must the stronger / clearer. How about this:

From f69854ce7b9359603581317d152421ff6d89f345 Mon Sep 17 00:00:00 2001
From: Sebastian Schuberth <sschuberth@gmail.com>
Date: Mon, 11 Sep 2017 10:41:27 +0200
Subject: [PATCH] docs: use a stronger wording when describing bugs with rebase -i -p

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 Documentation/git-rebase.txt | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 6805a74aec..ccd0a04d54 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -782,10 +782,11 @@ case" recovery too!
 
 BUGS
 ----
-The todo list presented by `--preserve-merges --interactive` does not
-represent the topology of the revision graph.  Editing commits and
-rewording their commit messages should work fine, but attempts to
-reorder commits tend to produce counterintuitive results.
+Be careful when combining the `-i` / `--interactive` and `-p` /
+`--preserve-merges` options.  Reordering commits will drop commits from the
+main line. This is because the todo list does not represent the topology of the
+revision graph in this case.  However, editing commits and rewording their
+commit messages 'should' work fine.
 
 For example, an attempt to rearrange
 ------------
-- 
2.14.1.windows.1
