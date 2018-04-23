Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A8091F424
	for <e@80x24.org>; Mon, 23 Apr 2018 15:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755856AbeDWPyH (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 11:54:07 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:16573 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755388AbeDWPyE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 11:54:04 -0400
Received: from [192.168.2.240] ([92.28.131.105])
        by smtp.talktalk.net with SMTP
        id Admyf3qUr4ZqzAdmyflx2i; Mon, 23 Apr 2018 16:54:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1524498842;
        bh=FPuLMNb+mWtd79h+U1bBRpQ/yeBxj5A3v4BOXDo5GKk=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=TJAnjJcbD6u8A7eW1Bab1wsnqAlwkTD+ZfPZG1aP48hyqYCjkjgL/GAHZuv+lBKpm
         iFFxoXS9IVBq7mr8y6PaBnGpLOT7JOhsYbsAcHSjMp0hhAcam+6MK4Oe3jpCMeVMGL
         kk0SEc2gqIaL7Ncu5kjun/hwPkxYGAt25qVoGm8E=
X-Originating-IP: [92.28.131.105]
X-Spam: 0
X-OAuthority: v=2.3 cv=E/fjW5Vl c=1 sm=1 tr=0 a=D1tPBkQZhJ8hQpCscnDOhQ==:117
 a=D1tPBkQZhJ8hQpCscnDOhQ==:17 a=IkcTkHD0fZMA:10 a=1o7kRuN_d7eZc5pIrcoA:9
 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v8 06/16] sequencer: introduce the `merge` command
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
References: <cover.1524139900.git.johannes.schindelin@gmx.de>
 <cover.1524306546.git.johannes.schindelin@gmx.de>
 <7360a072f6fdd276d30839613434329b645e2cce.1524306546.git.johannes.schindelin@gmx.de>
 <b05915e6-2259-5dee-69d8-90a5a524662d@talktalk.net>
 <nycvar.QRO.7.76.6.1804231405230.15174@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <ec58f482-ffde-1959-ff4a-9b128905ccb0@talktalk.net>
Date:   Mon, 23 Apr 2018 16:54:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1804231405230.15174@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfCQAfJHApkNLGa2Q4J4VMS1AKBid0mmpEYgScLPrBnxoBsdA41tSwEepZOHbn73tauBdzxaIN7wjIffqhfjnDZnwV7NBsRf3zD1jc4mzWvhgxdmBqmI+
 Hd7LsLNKFt/PLaHNUwaDLV35WKWksA3xHyQabavDOqww/tU76uQwuj0nzGbt3UPOsPnSy8ODBCtegyg+xKB8yJKGTsL21zPvf0qF7CbLkdOalzMCw1g7pMwD
 fDE/FXuM70iReED0fDhM4JMR5yFhzubk953aSNOmGV0AgWanqoLiwa1yhvBiGJQZdxtFvRsHOn6zEFJ+g7SRTshVIMY7Odd0CuPb3546krnhEtk9vTZ8NJ/1
 c2kcEVrXVF6L8pVmje4fKJnQjq5wxZVG3m4YcUFglloMLxBLP8zg0VlTXJ8Jy1IxwT/BhVuhfWrpII9w2ufc/fepSoWcqom9DsFc534bFPY7JskuWvDD4pQS
 MLx9VbekQ6NrEkhDdtzk7rwY7l0/LgY1NOuyGvfhQlAPXdLcgZn37/RO+MOEjN6Ty95LQ6ys9yymiuhC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/04/18 13:20, Johannes Schindelin wrote:
> Hi Phillip,
> 
> On Sat, 21 Apr 2018, Phillip Wood wrote:
> 
>> On 21/04/18 11:33, Johannes Schindelin wrote:
>>> This patch is part of the effort to reimplement `--preserve-merges` with
>>> a substantially improved design, a design that has been developed in the
>>> Git for Windows project to maintain the dozens of Windows-specific patch
>>> series on top of upstream Git.
>>>
>>> The previous patch implemented the `label` and `reset` commands to label
>>> commits and to reset to labeled commits. This patch adds the `merge`
>>> command, with the following syntax:
>>
>> The two patches seem to have been fused together in this series.
> 
> Indeed. I have yet to investigate further how that happened, it could be a
> bug in my series after all.
> 
>> If the reset command fails because it would overwrite untracked files it
>> says
>>
>> error: Untracked working tree file 'b' would be overwritten by merge.
>>
>> Followed by the hint to edit the todo file. Saying 'merge' rather 'reset' is
>> possibly confusing to users. Perhaps it could call
>> setup_unpack_trees_porcelain(), though that would need to be extended to
>> handle 'reset'.
> 
> Yes, and it changes global state :-(
> 
> Maybe we can leave it as-is for now? After all, it should be clear to the
> user what is happening. The most important part is the "Untracked working
> tree file"...

I'm fine with leaving it, I've might get round to doing a small series 
to clean things up slightly in a few weeks. At the moment 
setup_unpack_trees_porcelain() leaks memory as it is called for each 
merge and allocates new strings each time. It would also be nice if the 
error messages reflected the command, so it said 'cherry-pick', 'revert' 
or 'reset' rather than 'merge'

>> Also it currently refuses to overwrite ignored files which is either
>> annoying or safe depending on one's point of view.
> 
> Let me think about that. My gut feeling says: if it is easy to do, then
> let's nuke ignored files, but keep untracked files. But I do not think
> that the unpack-trees machinery was taught to know about .gitignore...
> 
> Seeing as `label` and `reset` really are mostly about revisions we see
> along the lines, I think that the common case will *not* overwrite any
> untracked files, ever. You would have to use `reset` on a
> not-previously-seen commit and/or add `exec` commands designed to
> interfere with the `reset`.
> 
> So I tend to want to not bother with discerning between untracked and
> ignored files here.

I don't think it's a pressing concern. In the past I once had a patch 
series that removed some tracked files in favor of having the build 
system generate them and added them to .gitignore. Each time I rebased I 
had to manually remove them at some stage which was annoying but that is 
quite a rare occurrence.

Best Wishes

Phillip


> Ciao,
> Dscho
> 

