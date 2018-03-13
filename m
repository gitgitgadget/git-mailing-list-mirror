Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2ABB71F404
	for <e@80x24.org>; Tue, 13 Mar 2018 16:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933601AbeCMQKh (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 12:10:37 -0400
Received: from mail.javad.com ([54.86.164.124]:56744 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932376AbeCMQKU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 12:10:20 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id E850C3E968;
        Tue, 13 Mar 2018 16:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520957419;
        bh=JzbNEbyhiKbppOzH84D1f1lAEkCaATgjIsTHHRhF36I=; l=1431;
        h=Received:From:To:Subject;
        b=foz6yk4hMogeirOB6GFDwGJCa9fWOxp8QEA8doChZ4sVXqMDLFbM2ixbD0Y1/FkgY
         4AkFRvnb3cAs3WKyuRBc9nWoLTETJaFzIbH1X/SK4+4TtRNOrNZJ2TECdLH2HcunmP
         2Hpo+i1BZLsOFM/YL1BDkH3kdQQr8ODcjWvbsKZc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520957419;
        bh=JzbNEbyhiKbppOzH84D1f1lAEkCaATgjIsTHHRhF36I=; l=1431;
        h=Received:From:To:Subject;
        b=foz6yk4hMogeirOB6GFDwGJCa9fWOxp8QEA8doChZ4sVXqMDLFbM2ixbD0Y1/FkgY
         4AkFRvnb3cAs3WKyuRBc9nWoLTETJaFzIbH1X/SK4+4TtRNOrNZJ2TECdLH2HcunmP
         2Hpo+i1BZLsOFM/YL1BDkH3kdQQr8ODcjWvbsKZc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520957419;
        bh=JzbNEbyhiKbppOzH84D1f1lAEkCaATgjIsTHHRhF36I=; l=1431;
        h=Received:From:To:Subject;
        b=foz6yk4hMogeirOB6GFDwGJCa9fWOxp8QEA8doChZ4sVXqMDLFbM2ixbD0Y1/FkgY
         4AkFRvnb3cAs3WKyuRBc9nWoLTETJaFzIbH1X/SK4+4TtRNOrNZJ2TECdLH2HcunmP
         2Hpo+i1BZLsOFM/YL1BDkH3kdQQr8ODcjWvbsKZc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520957419;
        bh=JzbNEbyhiKbppOzH84D1f1lAEkCaATgjIsTHHRhF36I=; l=1431;
        h=Received:From:To:Subject;
        b=foz6yk4hMogeirOB6GFDwGJCa9fWOxp8QEA8doChZ4sVXqMDLFbM2ixbD0Y1/FkgY
         4AkFRvnb3cAs3WKyuRBc9nWoLTETJaFzIbH1X/SK4+4TtRNOrNZJ2TECdLH2HcunmP
         2Hpo+i1BZLsOFM/YL1BDkH3kdQQr8ODcjWvbsKZc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520957419;
        bh=JzbNEbyhiKbppOzH84D1f1lAEkCaATgjIsTHHRhF36I=; l=1431;
        h=Received:From:To:Subject;
        b=foz6yk4hMogeirOB6GFDwGJCa9fWOxp8QEA8doChZ4sVXqMDLFbM2ixbD0Y1/FkgY
         4AkFRvnb3cAs3WKyuRBc9nWoLTETJaFzIbH1X/SK4+4TtRNOrNZJ2TECdLH2HcunmP
         2Hpo+i1BZLsOFM/YL1BDkH3kdQQr8ODcjWvbsKZc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520957419;
        bh=JzbNEbyhiKbppOzH84D1f1lAEkCaATgjIsTHHRhF36I=; l=1431;
        h=Received:From:To:Subject;
        b=foz6yk4hMogeirOB6GFDwGJCa9fWOxp8QEA8doChZ4sVXqMDLFbM2ixbD0Y1/FkgY
         4AkFRvnb3cAs3WKyuRBc9nWoLTETJaFzIbH1X/SK4+4TtRNOrNZJ2TECdLH2HcunmP
         2Hpo+i1BZLsOFM/YL1BDkH3kdQQr8ODcjWvbsKZc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520957419;
        bh=JzbNEbyhiKbppOzH84D1f1lAEkCaATgjIsTHHRhF36I=; l=1431;
        h=Received:From:To:Subject;
        b=foz6yk4hMogeirOB6GFDwGJCa9fWOxp8QEA8doChZ4sVXqMDLFbM2ixbD0Y1/FkgY
         4AkFRvnb3cAs3WKyuRBc9nWoLTETJaFzIbH1X/SK4+4TtRNOrNZJ2TECdLH2HcunmP
         2Hpo+i1BZLsOFM/YL1BDkH3kdQQr8ODcjWvbsKZc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520957419;
        bh=JzbNEbyhiKbppOzH84D1f1lAEkCaATgjIsTHHRhF36I=; l=1431;
        h=Received:From:To:Subject;
        b=foz6yk4hMogeirOB6GFDwGJCa9fWOxp8QEA8doChZ4sVXqMDLFbM2ixbD0Y1/FkgY
         4AkFRvnb3cAs3WKyuRBc9nWoLTETJaFzIbH1X/SK4+4TtRNOrNZJ2TECdLH2HcunmP
         2Hpo+i1BZLsOFM/YL1BDkH3kdQQr8ODcjWvbsKZc=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1evmVF-0002uM-7M; Tue, 13 Mar 2018 19:10:17 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        phillip.wood@dunelm.org.uk, Git mailing list <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road Clear)
References: <87y3jtqdyg.fsf@javad.com>
        <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
        <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
        <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com>
        <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
        <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com>
        <87606hoflx.fsf@javad.com>
        <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com>
        <87a7vss6ax.fsf@javad.com>
        <6c8749ca-ec5d-b4b7-f1a0-50d9ad2949a5@talktalk.net>
Date:   Tue, 13 Mar 2018 19:10:17 +0300
In-Reply-To: <6c8749ca-ec5d-b4b7-f1a0-50d9ad2949a5@talktalk.net> (Phillip
        Wood's message of "Fri, 2 Mar 2018 11:31:02 +0000")
Message-ID: <877eqgardi.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

Phillip Wood <phillip.wood@talktalk.net> writes:

[...]

> Hi Sergey, I've been following this discussion from the sidelines,
> though I haven't had time to study all the posts in this thread in
> detail. I wonder if it would be helpful to think of rebasing a merge as
> merging the changes in the parents due to the rebase back into the
> original merge. So for a merge M with parents A B C that are rebased to
> A' B' C' the rebased merge M' would be constructed by (ignoring shell
> quoting issues)
>
> git checkout --detach M
> git merge-recursive A -- M A'
> tree=$(git write-tree)
> git merge-recursive B -- $tree B'
> tree=$(git write-tree)
> git merge-recursive C -- $tree C'
> tree=$(git write-tree)
> M'=$(git log --pretty=%B -1 M | git commit-tree -pA' -pB' -pC')

I wonder if it's OK to exchange the order of heads in the first merge
(also dropped C for brevity):

git checkout --detach A'
git merge-recursive A -- A' M
tree=$(git write-tree)
git merge-recursive B -- $tree B'
tree=$(git write-tree)
M'=$(git log --pretty=%B -1 M | git commit-tree -pA' -pB')

If so, don't the first 2 lines now read: "rebase (first parent of) M on
top of A'"?

If so, then it could be implemented so that it reduces back to regular
rebase of non-merges when applied to a single-parent commit, similar to
the method in the RFC, striking out one of advantages of the RFC.

-- Sergey
