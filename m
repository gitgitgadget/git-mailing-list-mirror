Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B807C61DA3
	for <git@archiver.kernel.org>; Tue, 21 Feb 2023 16:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbjBUQI2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 11:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbjBUQI0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 11:08:26 -0500
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A3F1BAF9
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 08:08:23 -0800 (PST)
Received: from host-2-103-194-72.as13285.net ([2.103.194.72] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1pUVBk-0008qv-7o;
        Tue, 21 Feb 2023 16:08:20 +0000
Message-ID: <a856dd16-9876-509b-6a99-11ea0020633c@iee.email>
Date:   Tue, 21 Feb 2023 16:08:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] rebase: add a --rebase-merges=drop option
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>,
        Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, tao@klerks.biz, newren@gmail.com,
        phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de
References: <20230220033224.10400-1-alexhenrie24@gmail.com>
 <xmqqr0ukggk5.fsf@gitster.g>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <xmqqr0ukggk5.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 20/02/2023 21:42, Junio C Hamano wrote:
> Alex Henrie <alexhenrie24@gmail.com> writes:
>
>> Name the new option "drop" intead of "no" or "false" to avoid confusion
> This is traditionally called "flattening the history".  Don't we
> confuse uesrs by introducing a new phrase?

While "flatten.." is used on list, we rarely mention it in our man
pages, and usually only in a cautionary manner via the
rev-list-options.txt under "--show-linear-break".

It's not always clear what is meant by 'flattening' and which aspects
are included/excluded from the flattened display. I suspect that a
recent question on the git-users list [1] originates from the same
confusions.

Maybe it's something that could be included in the Glossary to
supplement the not well known how-to discussion in
keep-canonical-history-correct.txt

>
> rebase-merges is about transplanting the history without flattening,
> i.e. keeping the mergy commit graph topology.  If there are only two
> kinds of rebase (i.e. keeping the topology which is rebase-merges
> and the other "flattening" kind) operation, shouldn't the option be
> called "--no-rebase-merges" instead?  --rebase-merges=no is also
> understandable.
>
>> in the future if --rebase-merges grows the ability to truly "rebase"
>> merge commits by reusing the conflict resolution information from the
>> original merge commit, and we want to add an option to ignore the
>> conflict resolution information.
> I am not sure why such a change "in the future" is not merely a
> bugfix of the current "--rebase-merges", though.  Once it is fixed,
> is there a reason to make the fixed behaviour only available behind
> an option?
[1]
https://groups.google.com/d/msgid/git-users/057bd9e2-b20b-4794-b8a0-bc16ede374c1n%40googlegroups.com

--

Philip

