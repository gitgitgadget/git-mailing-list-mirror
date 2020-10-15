Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D70FC433DF
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 07:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F300D2224E
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 07:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="mJpI7Kpn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgJOHhC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 03:37:02 -0400
Received: from forward102p.mail.yandex.net ([77.88.28.102]:46286 "EHLO
        forward102p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726103AbgJOHhC (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 15 Oct 2020 03:37:02 -0400
Received: from mxback6j.mail.yandex.net (mxback6j.mail.yandex.net [IPv6:2a02:6b8:0:1619::10f])
        by forward102p.mail.yandex.net (Yandex) with ESMTP id BE7831D40A03;
        Thu, 15 Oct 2020 10:36:58 +0300 (MSK)
Received: from sas8-6bf5c5d991b2.qloud-c.yandex.net (sas8-6bf5c5d991b2.qloud-c.yandex.net [2a02:6b8:c1b:2a1f:0:640:6bf5:c5d9])
        by mxback6j.mail.yandex.net (mxback/Yandex) with ESMTP id P4zuvIqrYY-aws8dcth;
        Thu, 15 Oct 2020 10:36:58 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1602747418;
        bh=fl6+2uz6wefXETxdUdFDKKcRhK0psV5hf3Yys1V6Oqs=;
        h=In-Reply-To:Subject:CC:To:From:References:Date:Message-ID;
        b=mJpI7KpnFWZwylDMg8VffB54/lh2ZC2lCiv9qN4CTgdv0fN2xMPF9MoWsUtHrXTOM
         flAH470X4MVZNFarBNxOupHlM/6biH/OZVwwBLevgCmglWmSqU6N1TcPwyR3dP7Nx0
         gH1s3DspMyB6ovCnGGxvk7v+G5OJRHFREMvS+MkU=
Authentication-Results: mxback6j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by sas8-6bf5c5d991b2.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id 4exAvrknr8-avmmYIn5;
        Thu, 15 Oct 2020 10:36:57 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (Client certificate not present)
Date:   Thu, 15 Oct 2020 10:36:56 +0300
From:   Eugen Konkov <kes-kes@yandex.ru>
Message-ID: <858416875.20201015103656@yandex.ru>
To:     Junio C Hamano <gitster@pobox.com>
CC:     Git Mailing List <git@vger.kernel.org>
Subject: Re: BUG: git rebase shows different commit message
In-Reply-To: <CAPc5daVAJxfZVz0HwTFwhq-EfERrESU2Ta6-0fAyXrzf3YJREg@mail.gmail.com>
References: <703071109.20201014201106@yandex.ru> 
  <CAPc5daVAJxfZVz0HwTFwhq-EfERrESU2Ta6-0fAyXrzf3YJREg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Junio,

>>>These one-line titles are shown to help you identify the commit to futz with,
>>>not to help you review them.

It  would  be  better, if these one-line titles also help me to review them.

>>> but some control characters that take the terminal into an insane state, we
>>> should sanitize the title we'd show here for identification purposes,
I expect they are sanitized in **same way** as it done for `git log ...`

>>> so "show the title as-is" is not
So  it  would  be better if it was shown same as `git log ...` display them

and sorry, "as is" was bad word. I mean if in different places is used
same  formatting,  so  **result should be same**.
I do not expect that commit messages are differ

Thank you.

Wednesday, October 14, 2020, 8:55:45 PM, you wrote:

>> $git log --graph --decorate --pretty=oneline --abbrev-commit
>> * 093010ea (local/dev) Change column 'Label' => 'OPFG' and added column 'comment'
>> * 86221a47  Updated OpenAPI schema according to SCHEMA 193
>> * 6202eb08 Added opfg.html
>>
>> $git rebase -i --autostash --rebase-merges 86221a47^
>> label onto
>>
>> reset onto
>> pick 86221a47 Updated OpenAPI schema according to SCHEMA 193
>> pick 093010ea Change column 'Label' => 'OPFG' and added column 'comment'
>>
>> Here commit message is shown without leading space.
>> I  think  that this is wrong. Because if space was shown then I reword
>> commit message
>>
>> r 86221a47 Updated OpenAPI schema according to SCHEMA 193
>> pick 093010ea Change column 'Label' => 'OPFG' and added column 'comment'
>>
>> but now I just do not see that I shold reword it =(

> These one-line titles are shown to help you identify the commit to futz with,
> not to help you review them. After all, you see only titles here
> without the body
> of the log message [*1*].

> Besides, if the "breakage" in the title were not just an extra
> whitespace but some
> control characters that take the terminal into an insane state, we
> should sanitize
> the title we'd show here for identification purposes, so "show the
> title as-is" is not
> a good idea to begin with.

> So, NAK.

> [Footnote]
> *1* ... and if majority of your commits have a single-liner titles, I cannot
> imagine how these logs can be useful to its consumers (i.e. those who
> use "git show" after identifying an old commit that broke things using
> "git bisect" or "git blame").

> A leading whitespace in such a "git log" output would be the least of your
> problems in such a history, I would have to say.



-- 
Best regards,
Eugen Konkov

