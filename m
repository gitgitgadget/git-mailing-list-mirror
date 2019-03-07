Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0656C20248
	for <e@80x24.org>; Thu,  7 Mar 2019 12:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbfCGMew (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 07:34:52 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:52991 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfCGMew (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 07:34:52 -0500
Received: from [192.168.1.12] ([92.29.14.153])
        by smtp.talktalk.net with SMTP
        id 1sEbhXqWWWIpc1sEbhutPM; Thu, 07 Mar 2019 12:34:50 +0000
X-Originating-IP: [92.29.14.153]
X-Spam: 0
X-OAuthority: v=2.3 cv=W6NGqiek c=1 sm=1 tr=0 a=BLrICWmQs9+T7cG0JL9/VQ==:117
 a=BLrICWmQs9+T7cG0JL9/VQ==:17 a=IkcTkHD0fZMA:10 a=ybZZDoGAAAAA:8
 a=oihk3FedAAAA:8 a=vTaVaU2ITsp0LmoDlI4A:9 a=QEXdDO2ut3YA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22 a=hb0pxZ2FmNMkpaS32Bpr:22
Subject: Re: What's cooking in git.git (Mar 2019, #01; Wed, 6)
To:     Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <xmqqa7i8ss4l.fsf@gitster-ct.c.googlers.com>
 <CACsJy8C7F_Ju2F7COUVd9-1FcyQL=mZph7qmkDh9sS-ENb4PEQ@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <f6052ac6-60c4-1e70-b3f4-571885ba9e8d@iee.org>
Date:   Thu, 7 Mar 2019 12:34:48 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <CACsJy8C7F_Ju2F7COUVd9-1FcyQL=mZph7qmkDh9sS-ENb4PEQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfB4NYiynl8VK4HN5k6fd1c0A01aKQnc2sWa+j4eh7H7i/atssJ66rBtew3FF5JFo27Tb05ToWY6cKz0aCPhe2nzNcblJ8MhguQlHiKZUPuUYkAKuM162
 OXewwYvfw0L62eU5U1FX+/BOKOM/Je0tSf4aANv8HjqTshfwtkfKtwjKMVS9xgveykzxzgDBs3bh76JTUNyHLR+D2nqsZ3+47Fh6NbEx6QrnrFdMHN/7qMcK
 1Ixdsb1F4zz0WkgySui6oQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/03/2019 09:44, Duy Nguyen wrote:
> On Wed, Mar 6, 2019 at 8:34 AM Junio C Hamano <gitster@pobox.com> wrote:
>> * tg/checkout-no-overlay (2019-02-04) 9 commits
>>    (merged to 'next' on 2019-02-04 at 9968bcf4fb)
>>   + revert "checkout: introduce checkout.overlayMode config"
>>    (merged to 'next' on 2019-01-18 at 1e2a79ba5c)
>>   + checkout: introduce checkout.overlayMode config
>>   + checkout: introduce --{,no-}overlay option
>>   + checkout: factor out mark_cache_entry_for_checkout function
>>   + checkout: clarify comment
>>   + read-cache: add invalidate parameter to remove_marked_cache_entries
>>   + entry: support CE_WT_REMOVE flag in checkout_entry
>>   + entry: factor out unlink_entry function
>>   + move worktree tests to t24*
>>
>>   "git checkout --no-overlay" can be used to trigger a new mode of
>>   checking out paths out of the tree-ish, that allows paths that
>>   match the pathspec that are in the current index and working tree
>>   and are not in the tree-ish.
>>
>>   Will hold.
>>   Waiting for "restore-files" & "switch-branches" pair.
>>   cf. <20190205204208.GC6085@hank.intra.tgummerer.com>
> If it's ready for master, I'd love to see it merged. Either that or
> topic is rebased on 'master'. There are separate checkout changes in
> 'master' (mine, sadly), and because switch/restore moves lots of code
> around, I need to create a merge of this topic and master as the base,
> or you'll get horrible conflicts.
>
> I should send switch/restore again soon. There are still a few
> unaddressed concerns for git-restore since last time. Probably time to
> refresh those discussions.

Just catching up on back emails:

The one point I noted is that "Overlay" is a new magic term without any 
explanation within the _documentation_.

It would appear worth it to also add something (follow up patch?) to the 
e.g. git glossary to clarify how overlay differs, or is similar to, the 
different merge and reset modes.

--

Philip

