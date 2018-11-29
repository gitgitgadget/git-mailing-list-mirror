Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1482211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 15:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbeK3CwS (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 21:52:18 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:50645 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728363AbeK3CwS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 21:52:18 -0500
Received: by mail-it1-f195.google.com with SMTP id z7so4281048iti.0
        for <git@vger.kernel.org>; Thu, 29 Nov 2018 07:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5jCfcL5LcAISe+kKc2sCJvOxtGD0sSGRihw2tOTK28k=;
        b=A05vzdEpRYyIhN9c9AzDScZU+AWZ88lpoPZoSdwmloYXPhvM5HMEDNPNjRmZrFlub7
         O3YI/qM4VZE2+z5IgfZo5qD1N05WMBOhp/xQI8Zi+ilDjicfk9ktJrplS24UHLE21Hfv
         o/ESMqugJKAzIRIJd03UTw+Oz0X/90mi2zj+cesYYZa6P9lgpqbyszPStSxIps4fMB9j
         B8zczbOOyXYHQ+SBjultSbkqhtPjlUYdIMS/uVfgLXXXt+FlXil9JzYF6XHHI8M5pvBB
         /7xidJtiionUVoB98msjapso6IiowRbZVax/vcsbbjqQ6XVIxpOWsRVFuSR9Qn+3PG0z
         kq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5jCfcL5LcAISe+kKc2sCJvOxtGD0sSGRihw2tOTK28k=;
        b=ar/bAjHFtaFTUqktVU7s2sMa13pinpzO4lU0mI4xhWgayRa3g8nZ0W2Dk4yCpYNWzI
         vP4paAtxY3iZabT2uH2Aa/v4Gf+ApExx4qSYrx9VDvImY+gAyK9I9t2PewpN0w8NOcBp
         Dm1mzkXVpSSCnQaZBuSJUBqaitaD43WdfOI6hoHEelZ/HqSpBjcK99Y1FIl+FLUdB9Cs
         dQj7ZTNPNaPL/ZEcux4FHb1xOtFrnUW9fk5qiStCUTVF4bTxclKs5Eoz5nVuEToaKggu
         V5K7P9BmnqW0GujffeOisaSNpLBpZnUV/7UjmscAZSwezMcKSDk6NJBhJLHeXZkbrcDL
         4i8A==
X-Gm-Message-State: AA+aEWaBM58Df4ePTFTOJq0t+v52OVrfIXLanMim9gs2k+oPne7bMWOd
        JrZiaRfSGm5K8j2swijR/dL5aFfIpWTOH6INcYk=
X-Google-Smtp-Source: AFSGD/WsWQzRSRSjSpHrBXGMxgf7zo3T+CwZT7Z2bxMttnDegi9b4nJmwU1S7phFTksR8i3xvkqslsb4/NBT9K6cUhw=
X-Received: by 2002:a05:660c:81a:: with SMTP id j26mr1953422itk.70.1543506390496;
 Thu, 29 Nov 2018 07:46:30 -0800 (PST)
MIME-Version: 1.0
References: <20181120174554.GA29910@duynguyen.home> <20181127165211.24763-1-pclouds@gmail.com>
 <20181127165211.24763-7-pclouds@gmail.com> <xmqqftvlspqn.fsf@gitster-ct.c.googlers.com>
 <CACsJy8Bzs=FYKrR6h1cqVH32eEt2t8rUMtE2yFNvt+W55u=sDA@mail.gmail.com> <CAPL8ZiuaEW5tp8ZMOZtZcb5oi3L-pDF6ajcA7b5wnH3=7Ls7Tg@mail.gmail.com>
In-Reply-To: <CAPL8ZiuaEW5tp8ZMOZtZcb5oi3L-pDF6ajcA7b5wnH3=7Ls7Tg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 29 Nov 2018 16:46:04 +0100
Message-ID: <CACsJy8An2n5yah1UTCJZoC5ucSpCoM0vrXtEXnjg-di7jQZwLA@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] checkout: split into switch-branch and checkout-files
To:     Stefan Xenos <sxenos@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 29, 2018 at 12:22 AM Stefan Xenos <sxenos@google.com> wrote:
> Some behaviors I'd expect to see from these commands (I haven't yet
> checked to see if you've already done this):
>
> git checkout-files <tree-ish>
> should reset all the files in the repository regardless of the current
> directory - it should produce the same effect as "git reset --hard
> <tree-ish> && git reset HEAD@{1}". It should also delete
> locally-created files that aren't present in <tree-ish>, such that the
> final working tree is exactly identical to what was committed in that
> tree-ish.
>
> git checkout-files foo -- myfile.txt
> should delete myfile.txt if it is present locally but not present in foo.
>
> git checkout-files foo -- .
> should recursively checkout all files in the current folder and all
> subfolders, and delete any locally-created files if they're not
> present in foo.

I think all these are the same as the non-overlay mode Thomas
mentioned [1]. Once he implements that in git-checkout, we can make it
default in checkout-files.

Two things though. I plan to get rid of "--" in checkout-files. The
main use case (I think) is reset from index, so you can just write

 git checkout-files somefiles

and if you want to get it from the tree(-ish) "foo", you do

 git checkout-files --from=foo somefiles

This form is easier to read (and even guess before you read man pages)
and leaves no room for ambiguation.

The second thing is, I plan to forbid "git checkout-files" without
arguments. If you want to reset the entire worktree, do

 git checkout-files :/

or just current dir

 git checkout-files .

Which brings us back to your "git checkout-files <tree-ish>" use case
above. It should be treat the same way in my opinion, so we either do

 git checkout-files --from=tree-ish :/

or

 git checkout-files --from=tree-ish .

But "git checkout-files --from=tree-ish" alone is rejected.


[1] https://public-inbox.org/git/xmqqwoowo1fk.fsf@gitster-ct.c.googlers.com/T/#mdb076d178ccf0ae3dba0fd63143f99278047da93

> Suggestion:
> If git checkout-files overwrites or deletes any locally-modified files
> from the workspace or index, those files could be auto-stashed. That
> would make it easy to restore them in the event of a mistyped command.
> Auto-stashing could be suppressed with a command-line argument (with
> alternate behaviors being fail-if-modified or always-overwrite).

Stashing I think is not the right tool for this. When you stash, you
plan to retrieve it back later but here you should rarely ever need to
unstash until the accident. For recovery from accidents like this, I
have another thing in queue to achieve the same (I'm calling it
"backup log" now). So we will have the same functionality, just with
different means.

> Idea:
> If git checkout-files modifies the submodules file, it could also
> auto-update the submodules. (For example, with something like "git
> submodule update --init --recursive --progress").

This one is tricky because we should deal with submodule autoupdate
consistently across all porcelain commands (or at least common ones),
not just checkout-files. I'd prefer to delay this until later. Once we
figure out what to do with other commands, then we can still change
defaults for checkout-files.
-- 
Duy
