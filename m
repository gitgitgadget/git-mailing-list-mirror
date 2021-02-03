Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84941C433E0
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 21:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4799664F6D
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 21:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbhBCVn3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 16:43:29 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:11934 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229991AbhBCVn2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 16:43:28 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4DWFXQ32t3z5tl9;
        Wed,  3 Feb 2021 22:42:46 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id C0B6D4B80;
        Wed,  3 Feb 2021 22:42:45 +0100 (CET)
Subject: Re: [PATCH] git-gui: remove lines starting with the comment character
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Git List <git@vger.kernel.org>
References: <20210202200301.44282-1-me@yadavpratyush.com>
 <fdfe1661-463b-fc18-02cc-4c6e22ce0463@kdbg.org>
 <CAPig+cTQaPTNnGcd583B=xoVUR1qPb372Y_x9szROfMcA5h+tA@mail.gmail.com>
 <CAPig+cQxASd8YNm+6E4XkiEoR__hAW8nrUbEkaBoJSicpq_rmA@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <ba8baa8c-d308-c7c9-b15c-4582cc41863e@kdbg.org>
Date:   Wed, 3 Feb 2021 22:42:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cQxASd8YNm+6E4XkiEoR__hAW8nrUbEkaBoJSicpq_rmA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.02.21 um 18:58 schrieb Eric Sunshine:
> On Wed, Feb 3, 2021 at 12:48 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>> So, perhaps one way forward is for Pratyush to emulate that behavior
>> and insert some text into the edit box saying "lines beginning with
>> '#' will be ignored", or add a label above or below the edit box
>> stating the same. (Of course, the actual displayed comment-character
>> should be determined dynamically.)
> 
> Even more fancy would be to add a checkbox below the edit field which
> both enables/disables the "stripspace" behavior and allows the user to
> specify the comment-character. For instance:
> 
>     [x] ignore lines beginning with [#]
> 
> where [x] is the checkbox and [#] is a text field in which the user
> can type the comment-character.
> 
> For convenience, the checkbox would be checked by default, and the
> comment-character would default to the user's configured
> comment-character or "#".

While I'm not thrilled by this solution, it's probably the only sensible
way forward. We would have to place the checkbox above the edit field,
where there's still some space; otherwise, it takes away vertical space,
and that I really prefer to use for the commit message and the patch text.

I don't think, though, that we need an edit field to change the comment
character. It's a fairly stable setting, and as long as there's a
preference for it and it's synchronized into the checkbox caption, it is
fine, IMO.

-- Hannes
