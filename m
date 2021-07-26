Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93012C4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 10:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FB5560234
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 10:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbhGZJ7h (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 05:59:37 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:13590 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231639AbhGZJ7d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 05:59:33 -0400
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1m7y1f-0003Gj-7j; Mon, 26 Jul 2021 11:39:59 +0100
Subject: Re: Files modified, even after: git reset --hard
To:     Martin <git@mfriebe.de>, Chris Torek <chris.torek@gmail.com>
Cc:     Git List <git@vger.kernel.org>
References: <dd4aca2c-9ca2-e489-d78f-9d2a5580f1a5@mfriebe.de>
 <4e9b54b4-8e40-7fd3-ae65-d33390f3af43@mfriebe.de>
 <04f3b300-3ccf-c91b-6406-6a998b473a24@mfriebe.de>
 <bfc257c7-bf74-06be-ac62-9a6d27f565c9@mfriebe.de>
 <CAPx1GvcHiaGsuOybOijRYpmivO0dLvUFacAeOrM4DfY-uuXB2Q@mail.gmail.com>
 <070f7f5e-0e6c-2edc-1403-9265c810df17@mfriebe.de>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <fd2f2e6b-0ced-8eb7-b908-956b084f23c7@iee.email>
Date:   Mon, 26 Jul 2021 11:39:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <070f7f5e-0e6c-2edc-1403-9265c810df17@mfriebe.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/07/2021 02:34, Martin wrote:
> I figured that is the reason why they show modified.
>
> Not a problem. Until I am in the middle of a rebase, and i cannot run
> (after a conflict)
>   git rebase --continue
>
> The modified files are not part of the original series of commits.
> they are just random files from somewhere else in the tree.
> I can not reset/restore them.
> So I must now "git add" files entirely unrelated to continue rebasing.
> Well or apparently change my config for the duration of the rebase.

Is this 'mid-rebase' the core case for the 'Files modified' problem? -
does it happen at other times (excepting maybe cherry-pick)

i.e. you are rebasing a series of commits where some files had 'old'
line endings in the repository, but your current line ending setting
wants the line endings in those un-related, un-changed files to change
their line endings, and the rebase command can't cope with these
incidental differences?

Philip
