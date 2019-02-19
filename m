Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52ECC1F453
	for <e@80x24.org>; Tue, 19 Feb 2019 04:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfBSEVQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 23:21:16 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:55761 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfBSEVP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Feb 2019 23:21:15 -0500
Received: by mail-it1-f193.google.com with SMTP id z131so3098806itf.5
        for <git@vger.kernel.org>; Mon, 18 Feb 2019 20:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w3BIHBkYjP/yUUTO5RFHFSF04w45ET8O0WMyHZPVez8=;
        b=EkRCnCZdLCaHnKzcWRbNOG7KCKZMJ4+JDJNR6zDn3RQH5RWGUZUyyd0lXjpCICVlQp
         isG4W9y4oCyDWA5FcoPtPI74FN7CXUD0WwtOo6+lrPfTn0IikCgNGAOwtDQfmg7bpsQb
         WGFL+utm0skhbaQ4jruvFhOj+54G7SbZu9L9Kc37exWMN/LfE024eUwWbrjl+b9wm4cJ
         f3YSPXMWQbBksezcyndth+pEyo8KRNmhr5cJoVgoerjL6BKAQbCu6yTKZcVzIxUGTcFq
         7glkqj5qGlGLFtbLJ7DnQHZikfgQ/CAhiqT7uMqqRf74FeqCNJA9f6ChSb9jE2T+KEJw
         DCcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w3BIHBkYjP/yUUTO5RFHFSF04w45ET8O0WMyHZPVez8=;
        b=YlntJzgDpk/cBI9JFeflZuiVqdsr82/wWn+ZMZql9D/PtWDSA8YbvQ4i0E6nP6gqfX
         HQi3c4jgozpj10s/KZHfcGOZV8Ytp8+rk3P8gKrrAabsFroN1fxLiuusM73tofS9gVp+
         4kWZaSjq389Qwa2S7leF9PzW5bfVwZNfB5beQnjeFxn6GLTSQUGo6F5Ug4fFW5AuamY4
         CtvOqAdaoyOuanMgrZ+YkeqNYgosKYp3C+O/DpHP8rBdcUCh8Da62TRO/GNG7fq4kdvA
         fiBhs3TTdZlAtgzjNChiXV0oNL41RH948V7CaUi84G1rpE+HLMtV/tL0Vm12pTd2l8J8
         FHSg==
X-Gm-Message-State: AHQUAuaqascThi3B+7aEix/Y99su80SMpeW/PPBWGF1s44GKw1xUdvGA
        nCLfcJ7oAXvpcsJCpu3NWz4neN92SmjOOmWGkNg=
X-Google-Smtp-Source: AHgI3Ibm68oQqg55IRky4kL+1b4jT3Ry4gzsyB1xXP9hrdFglZg4pv3/H5sQGG/jn2FcrIlat4xM3LLGKpLjSvH/rTs=
X-Received: by 2002:a02:568a:: with SMTP id u10mr14624014jad.130.1550550074771;
 Mon, 18 Feb 2019 20:21:14 -0800 (PST)
MIME-Version: 1.0
References: <20181209200449.16342-1-t.gummerer@gmail.com> <20181209200449.16342-7-t.gummerer@gmail.com>
 <CACsJy8CfgJ4NAnbMjBFGhRWscZxJCgxtx0QwSMw7MTjeMT4gDw@mail.gmail.com>
 <xmqqva40lps2.fsf@gitster-ct.c.googlers.com> <CABPp-BGQwtok1T3WmY3ndBG6RjbESSOgmbZxkWiN-avqfUjDVg@mail.gmail.com>
 <CACsJy8AxUxYCO7bzb98EVvO5DU62ukZQNrF-sEktrdR9m6tfvg@mail.gmail.com>
 <CACsJy8Bk=wbgzsE+Vo4w_u0E63PdUxxcvG-7e6Hq-8_jrmSErw@mail.gmail.com>
 <xmqq7eek3ax7.fsf@gitster-ct.c.googlers.com> <CACsJy8CHHT=9e9ti7VA4X4h3FrZcUKvLuzkL56mXLgjk4c5Qcg@mail.gmail.com>
 <xmqqlg2zz90l.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqlg2zz90l.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 19 Feb 2019 11:20:48 +0700
Message-ID: <CACsJy8CQhWeC3b6eGPePuRejfOx7c17X61-wqq5kOiRzYkRESw@mail.gmail.com>
Subject: Re: [PATCH 6/8] checkout: add --cached option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 2, 2019 at 12:57 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Duy Nguyen <pclouds@gmail.com> writes:
>
> > Of course we could just do --index and --worktree, each option
> > restores the respective part. Then it's combinable (and extensible in
> > the future). But then "git restore" means "git restore --index
> > --worktree" and typing "git restore --index" effectively removes the
> > default "--worktree", which seems a bit twisted.
>
> Or "git restore --no-worktree" (essentially, instead of saying
> "keep", say "no" to mean "negation").
>
> Incidentally, "git restore --no-index" does not have a counterpart
> in "git checkout", but I think it is probably a good thing to add;
> as it has to do far more than "git cat-file blob $tree:$path >$path"
> these days.

OK this hopefully will be the final design

(git restore) "[--worktree] <paths>" restores worktree paths from index

"--index <paths>" restores the index from HEAD (aka "git reset")

"--source <tree> (--index|--worktree) <paths>" restores index or
worktree (or both) from <tree>

I'm a bit reluctant to support "git restore --index --worktree
<paths>" without --source, which should default to HEAD, since it's a
bit unclear/inconsistent ("git restore --worktree <paths>" defaults to
index as the source, but here we use a different default source).
-- 
Duy
