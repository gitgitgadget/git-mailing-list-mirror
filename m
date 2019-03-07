Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32A8120248
	for <e@80x24.org>; Thu,  7 Mar 2019 12:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfCGMym (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 07:54:42 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:54513 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfCGMym (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 07:54:42 -0500
Received: by mail-it1-f195.google.com with SMTP id w18so15029405itj.4
        for <git@vger.kernel.org>; Thu, 07 Mar 2019 04:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KGYyP3T0r/QE+vXmP4eNVaw237zC/muh4EBY5d0ylHs=;
        b=m2sgA6uz6c7EYtHdSbeiP6JakXmQFe7TTAl7mhuiEHBaz6eq7v0M2f0IbV3dpvrbdB
         pqIWqxf/J6MC3WCV1uMNsbNkuCF5l1Ri6bs8CLsdTbgNOUrPDaGlM7mOJb1SeDhOAnUO
         UKYGdN5nVsq5hJuB5jrOc7avFfaurPf9uqgJkRV5VjwJ6WJQKcfM5BRWOiV/BruPL53M
         cWirxF4I4UjsS6CH3DKvsw/D+FihJthJa7qXni+AdbCRXPy2mj3pO9MM7JKHr/gOcTK6
         owFqEkH2KlBGW62h0ilLhi7sOVgS8xgdgi1WZ4l+KV5Dj+/WFV0+Ftaj3hfkxZO7y7HJ
         yGlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KGYyP3T0r/QE+vXmP4eNVaw237zC/muh4EBY5d0ylHs=;
        b=ZqCeng3f13N+KVs8KhnJFeatQcLRY0fRYw+lVFgMD34vPRltcO9zpo/9Z6I870mfHp
         cKYtjgPLo9yPK7lhiw3+U7vganBXrvKJEo9TERoCGOh0hE2USY0lVClOPfdj9EoWZ5LM
         CfZpm2ab/IfGiI/XGP8yps746LiAmwPRbik3N3pcwH7zKIGi9JvO/Jgwxwl9VF7Ef+VG
         NHxBzc37oISvQil3jouMRrI5hs+kqIO3lIgqfC6GCvhAoUNuigTAuqFpwa9bK7VMdzKo
         25JX9t25CjkcbxEo1/ymgLoeh5hOg9zYUs9qdOMb4uLPCZwEf1vUpA6dPZM00WrOur/Q
         5HQA==
X-Gm-Message-State: APjAAAXjSj01jUTfSnB/eE9Kg/tgPgbTBSAB1t2fNu/EUzxOkt5l2xwu
        eBo+3YrqUVORSalgAusV57AS96jPd2cx9EG3wCk=
X-Google-Smtp-Source: APXvYqwqPehpeSaSb/75oKdDT3GmVrr7hsLdH4/4DpirpBfsi342SAKpY/J1M1PpijycEs1uAtuH+AgSWuStZ436Vco=
X-Received: by 2002:a24:ccc5:: with SMTP id x188mr5082003itf.123.1551963281488;
 Thu, 07 Mar 2019 04:54:41 -0800 (PST)
MIME-Version: 1.0
References: <xmqqa7i8ss4l.fsf@gitster-ct.c.googlers.com> <CACsJy8C7F_Ju2F7COUVd9-1FcyQL=mZph7qmkDh9sS-ENb4PEQ@mail.gmail.com>
 <f6052ac6-60c4-1e70-b3f4-571885ba9e8d@iee.org>
In-Reply-To: <f6052ac6-60c4-1e70-b3f4-571885ba9e8d@iee.org>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 7 Mar 2019 19:54:15 +0700
Message-ID: <CACsJy8D48YiWYkuLW8BbeYvRz=yMmb=XWoMJroPXFAcSV2VjHw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Mar 2019, #01; Wed, 6)
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 7, 2019 at 7:34 PM Philip Oakley <philipoakley@iee.org> wrote:
>
> On 06/03/2019 09:44, Duy Nguyen wrote:
> > On Wed, Mar 6, 2019 at 8:34 AM Junio C Hamano <gitster@pobox.com> wrote:
> >> * tg/checkout-no-overlay (2019-02-04) 9 commits
> >>    (merged to 'next' on 2019-02-04 at 9968bcf4fb)
> >>   + revert "checkout: introduce checkout.overlayMode config"
> >>    (merged to 'next' on 2019-01-18 at 1e2a79ba5c)
> >>   + checkout: introduce checkout.overlayMode config
> >>   + checkout: introduce --{,no-}overlay option
> >>   + checkout: factor out mark_cache_entry_for_checkout function
> >>   + checkout: clarify comment
> >>   + read-cache: add invalidate parameter to remove_marked_cache_entries
> >>   + entry: support CE_WT_REMOVE flag in checkout_entry
> >>   + entry: factor out unlink_entry function
> >>   + move worktree tests to t24*
> >>
> >>   "git checkout --no-overlay" can be used to trigger a new mode of
> >>   checking out paths out of the tree-ish, that allows paths that
> >>   match the pathspec that are in the current index and working tree
> >>   and are not in the tree-ish.
> >>
> >>   Will hold.
> >>   Waiting for "restore-files" & "switch-branches" pair.
> >>   cf. <20190205204208.GC6085@hank.intra.tgummerer.com>
> > If it's ready for master, I'd love to see it merged. Either that or
> > topic is rebased on 'master'. There are separate checkout changes in
> > 'master' (mine, sadly), and because switch/restore moves lots of code
> > around, I need to create a merge of this topic and master as the base,
> > or you'll get horrible conflicts.
> >
> > I should send switch/restore again soon. There are still a few
> > unaddressed concerns for git-restore since last time. Probably time to
> > refresh those discussions.
>
> Just catching up on back emails:
>
> The one point I noted is that "Overlay" is a new magic term without any
> explanation within the _documentation_.
>
> It would appear worth it to also add something (follow up patch?) to the
> e.g. git glossary to clarify how overlay differs, or is similar to, the
> different merge and reset modes.

I think Jonathan questions the name "overlay" too. Since this is
similar to "cp -R" mode, another suggestion is --copy-mode.
-- 
Duy
