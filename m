Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC1CEB64D9
	for <git@archiver.kernel.org>; Thu, 29 Jun 2023 10:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbjF2KyV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jun 2023 06:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbjF2Kx1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2023 06:53:27 -0400
X-Greylist: delayed 644 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 29 Jun 2023 03:53:19 PDT
Received: from mail.zombino.com (c2.zombino.com [65.108.93.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9884835AA
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 03:53:19 -0700 (PDT)
Received: from [10.168.4.114] (unknown [81.95.8.244])
        by mail.zombino.com (Postfix) with ESMTPS id A4AB33E98D;
        Thu, 29 Jun 2023 10:53:17 +0000 (UTC)
Message-ID: <65148753-7071-d5d5-3b4e-bad020e6ab63@zombino.com>
Date:   Thu, 29 Jun 2023 12:53:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: SHA256 support not experimental, or?
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com>
 <xmqqmt0iajww.fsf@gitster.g>
From:   Adam Majer <adamm@zombino.com>
In-Reply-To: <xmqqmt0iajww.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/29/23 07:59, Junio C Hamano wrote:
> Adam Majer <adamm@zombino.com> writes:
> 
>> Is sha256 still considered experimental or can it be assumed to be stable?
> 
> I do not think we would officially label SHA-256 support as "stable"
> until we have good interoperability with SHA-1 repositories, but the
> expectation is that we will make reasonable effort to keep migration
> path for the current SHA-256 repositories, even if it turns out that
> its on-disk format need to be updated, to keep the end-user data safe.

That could be a different definition of stable. But I'm satisfied that 
current sha256 repositories will not end up incompatible with some 
future version of git without migration path (talking about on-disk format).

So maybe my question should be reworded to "is sha256 still considered 
early stage, for testing purposes only with possible data-loss or can it 
be relied on for actual long lived repositories?"


> So while "no-longer-experimental" patch is probably a bit premature,
> the warning in flashing red letters to caution against any use other
> than testing may want to be toned down.

Agreed. I think it should be clear that SHA256 and SHA1 repositories 
cannot share data at this point. The scary wording should be removed 
though, as currently it sounds like "data loss incoming and it's your 
fault" if one chooses sha256

- Adam
