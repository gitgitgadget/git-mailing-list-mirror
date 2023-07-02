Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD321EB64DA
	for <git@archiver.kernel.org>; Sun,  2 Jul 2023 11:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjGBL5Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Jul 2023 07:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjGBL5X (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Jul 2023 07:57:23 -0400
X-Greylist: delayed 401 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 02 Jul 2023 04:57:20 PDT
Received: from outgoing.fripost.org (giraff.fripost.org [IPv6:2a00:1c20:4089:126c:300f:e2a1:9840:5351])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B92EE72
        for <git@vger.kernel.org>; Sun,  2 Jul 2023 04:57:20 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by outgoing.fripost.org (Postfix) with ESMTP id CD44C2ABCDBD;
        Sun,  2 Jul 2023 13:50:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=x.fripost.org; h=
        content-transfer-encoding:content-type:content-type:in-reply-to
        :content-language:references:subject:subject:from:from
        :user-agent:mime-version:date:date:message-id; s=
        9df9cdc7e101629b5003b587945afa70; t=1688298636; x=1690113037;
         bh=EUd2HrJ0Ia5cw5Skttc1BlU5vF5jbzw5yF9o8oTfFuk=; b=PzY+x2SEVqWo
        L2kJcB1/Mqbz/NB/EgbF7chLcor5xW9IppKp4JLKB0oUNwNKwA8RBHWCgTVnLP6q
        f/G2C1a5WnwmZxdSyVLPqttnJlytbT594iDZpp/V6O0MwP8VHTupCXMsEIjjNHDg
        5aJoosJVUpwedm63yA+9A8D5gjwPNbGHdWNIKzHBSLdhQq5GruYyU7jSWkwy0cLp
        XpytUy4ucICoiP8c3ifL9nkN4gpI++upzIF6v9oi7mokEWnn/H97o/PpWoETJqWk
        GZ3FCz6YY5fjhw4+hgfb4oAk2pKjRQ+2hiuxx0aWUTT4AkQq5u5AWZW0pblFQNcQ
        A9nmveCJYg==
X-Virus-Scanned: Debian amavisd-new at fripost.org
Received: from outgoing.fripost.org ([127.0.0.1])
        by localhost (giraff.fripost.org [127.0.0.1]) (amavisd-new, port 10040)
        with LMTP id 2_gNS8-BJAdB; Sun,  2 Jul 2023 13:50:36 +0200 (CEST)
Received: from smtp.fripost.org (unknown [172.16.0.6])
        by outgoing.fripost.org (Postfix) with ESMTP id A79502ABCDB8;
        Sun,  2 Jul 2023 13:50:36 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        by smtp.fripost.org (Postfix) with ESMTPSA id 485E3963BBAA;
        Sun,  2 Jul 2023 13:50:35 +0200 (CEST)
Message-ID: <a56182cd-722d-1b33-8d8b-a89e99b04ded@lidestrom.se>
Date:   Sun, 2 Jul 2023 13:50:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   =?UTF-8?Q?Jens_Lidestr=c3=b6m?= <jens@lidestrom.se>
Subject: Re: [PATCH 6/9] gitk: add keyboard bind for create and remove branch
To:     Johannes Sixt <j6t@kdbg.org>,
        Jens Lidestrom via GitGitGadget <gitgitgadget@gmail.com>
Cc:     "Paul Mackerras [ ]" <paulus@ozlabs.org>, git@vger.kernel.org
References: <pull.1551.git.1687876884.gitgitgadget@gmail.com>
 <661f098d882e64391ff76647e3764d58c6cbb50a.1687876885.git.gitgitgadget@gmail.com>
 <7c73cc47-302d-8706-dd7f-fd034ef8d945@kdbg.org>
 <36b3ce90d4ecc9eb9fa5174aba0cf9d4@lidestrom.se>
 <e745078f-fa24-6c10-4134-078e7e3f214c@kdbg.org>
Content-Language: en-GB
In-Reply-To: <e745078f-fa24-6c10-4134-078e7e3f214c@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> IMO a selection dialog is the second-best solution. The best one is to
> make the branch labels selectable somehow via keyboard navigation. I am
> not a fan of the here implement behavior, because it is only a
> half-solution.

I added a branch selection dialog to the remove command, triggered when there is more than one branch on the selected commit. It works fine and is convenient to use. However, the implementation is more complicated and the patch is much larger.

Since the patch is larger I felt that it was warranted to clarify some variable names.

The checkout command also has got a branch selection dialog.

Create and remove commands have been put in separate commits.

/Jens


On 2023-06-28 22:30, Johannes Sixt wrote:
> Am 28.06.23 um 09:12 schrieb Jens Lideström:
>> My intention is to always remove the first branch head that is displayed
>> for a single commit in the GUI. This caters to the common use case, with
>> only one branch for a single commit. If there are multiple branch heads
>> on a commit and the users don't want to remove the first one then they
>> need to use the mouse context menu to choose which one to delete.
>>
>> I could change the implementation to display a dialog that lets the user
>> choose in case of multiple branch heads.
> 
> IMO a selection dialog is the second-best solution. The best one is to
> make the branch labels selectable somehow via keyboard navigation. I am
> not a fan of the here implement behavior, because it is only a
> half-solution.
> 
> Also, the order of branch labels on a line is not 100% deterministic:
> when you create a branch, it goes last, but when you refresh the view,
> branch labels are sorted alphabetically (I think). This means you can't
> create a branch and delete it right away if there is already a branch on
> the commit.
> 
>> In that case, should I do that as part of this PR, or as a follow up? I
>> would prefer to finish this one first.
> 
> My preference would be to not implement this behavior until it is clear
> what it should be.
> 
> -- Hannes
> 



