Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BDE81F424
	for <e@80x24.org>; Wed, 25 Apr 2018 17:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754839AbeDYRJc (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 13:09:32 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:49728 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754649AbeDYRJc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 13:09:32 -0400
Received: from [192.168.2.240] ([92.22.38.249])
        by smtp.talktalk.net with SMTP
        id BNv5fV6hdlWlTBNv6fRZGl; Wed, 25 Apr 2018 18:09:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1524676169;
        bh=RSCbvZHHtc7lr182ncI9IUWq2Y636KP7KtUoPrDpL2U=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=fD8h3BIk1jTxnreU/dlRj6xAAsD69YPKJW0QOd0Ks9BINYB/56KDl783nkXpERdxa
         DGeDQBJNY89ii74vUMn0eWQ7WVrWAEFJr0GdVu1BR4ERYtD+eRFdtxVGu2rzanjFpV
         RBBOEdkm5lwtoeltLBfHUol+cyhZ2MF4NylWkg50=
X-Originating-IP: [92.22.38.249]
X-Spam: 0
X-OAuthority: v=2.3 cv=N4gH6V1B c=1 sm=1 tr=0 a=wtPHZgyFiCiZjBlnDI9PZA==:117
 a=wtPHZgyFiCiZjBlnDI9PZA==:17 a=IkcTkHD0fZMA:10 a=5rxgeBVgAAAA:8
 a=pGLkceISAAAA:8 a=nN7BH9HXAAAA:8 a=RzgWyTgW3Bl-xrWcheIA:9 a=QEXdDO2ut3YA:10
 a=PwKx63F5tFurRwaNxrlG:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 0/4] rebase -i: avoid stale "# This is a combinationof"
 in commit messages
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <CAPig+cRrS0_nYJJY=O6cboV630sNQHPV5QGrQdD8MW-sYzNFGQ@mail.gmail.com>
 <cover.1524296064.git.johannes.schindelin@gmx.de>
 <CAGZ79kbK7j0njrZ8-d_Da6+XyH_RVRhBu=hcpzr7EFsOCSFJVQ@mail.gmail.com>
 <12fa9a1f-9dc2-9108-132f-48b75ae5a8d3@talktalk.net>
 <nycvar.QRO.7.76.6.1804251442510.4978@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <949b5749-d721-31ea-77a1-ec6406f3083a@talktalk.net>
Date:   Wed, 25 Apr 2018 18:09:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1804251442510.4978@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLitNr9YvM8f1/oI9WSvnf8pKyJbbQZ5cgttDwCBsuKWLHgbGsOMNgaAcAoys+u5FFSlv3WlSBuP4EAUX2EULH1riQTc53+cEG3/IaXHe/5O23E7qh3X
 oqxr4BZADw+V7ffyN310MXO29rdpY5W4wbvxuMyTH9iNhqfwWc87X85cUvsOW4Kwf7V/K0HSNPoHOemEnW3hvFtLyXBbn2FOopjbglMT1itIZewIQEyeQVyL
 NnPaYVfqJ3MNqeJjZTJl38y5uNpbdbdCVJ0+twRXWpgsg9AX1aZw37A/uVwexs+NrL0NllpjHyQjzh1Ddr3gwl+S3ke8JRnKk6m0rgnUHE7RqD3jxUitBo5y
 ayqU7WXE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/04/18 13:48, Johannes Schindelin wrote:
> Hi Phillip,
> 
> On Mon, 23 Apr 2018, Phillip Wood wrote:
> 
>> On 23/04/18 19:11, Stefan Beller wrote:
>>>
>>> On Sat, Apr 21, 2018 at 12:34 AM, Johannes Schindelin
>>> <johannes.schindelin@gmx.de> wrote:
>>>> Eric Sunshine pointed out that I had such a commit message in
>>>> https://public-inbox.org/git/CAPig+cRrS0_nYJJY=O6cboV630sNQHPV5QGrQdD8MW-sYzNFGQ@mail.gmail.com/
>>>> and I went on a hunt to figure out how the heck this happened.
>>>>
>>>> Turns out that if there is a fixup/squash chain where the *last* command
>>>> fails with merge conflicts, and we either --skip ahead or resolve the
>>>> conflict to a clean tree and then --continue, our code does not do a
>>>> final cleanup.
>>>>
>>>> Contrary to my initial gut feeling, this bug was not introduced by my
>>>> rewrite in C of the core parts of rebase -i, but it looks to me as if
>>>> that bug was with us for a very long time (at least the --skip part).
>>>>
>>>> The developer (read: user of rebase -i) in me says that we would want to
>>>> fast-track this, but the author of rebase -i in me says that we should
>>>> be cautious and cook this in `next` for a while.
>>>
>>> I looked through the patches again and think this series is good to go.
>>
>> I've just realized I commented on an outdated version as the new version was
>> posted there rather than as a reply to v1. I've just looked through it and I'm
>> not sure it addresses the unnecessary editing of the commit message of the
>> previous commit if a single squash command is skipped as outlined in
>> https://public-inbox.org/git/b6512eae-e214-9699-4d69-77117a0daec3@talktalk.net/
> 
> I have not forgotten about this! I simply did not find the time yet, is
> all...

I wondered if that was the case but I wanted to check as I wasn't sure 
if you'd seen the original message as it was on an obsolete version of 
the series

> The patch series still has not been merged to `next`, but I plan on
> working on your suggested changes as an add-on commit anyway. I am not
> quite sure yet how I want to handle the "avoid running commit for the
> first fixup/squash in the series" problem, but I think we will have to add
> *yet another* file that is written (in the "we already have comments in
> the commit message" conditional block in error_failed_squash())...

I wonder if creating the file in update_squash_messages() rather than 
error_failed_squash() would be a better approach as then it is easy to 
only create rebase_path_amend_type() when there has already been a 
squash or fixup. The file is removed in the loop that picks commits in 
pick_commits() so it would be cleaned up at the beginning of the next 
pick if it's not needed.

Best Wishes

Phillip

> 
> Ciao,
> Dscho
> 

