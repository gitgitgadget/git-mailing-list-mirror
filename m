Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74DA520899
	for <e@80x24.org>; Wed, 16 Aug 2017 07:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751389AbdHPHqK (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 03:46:10 -0400
Received: from fallback9.m.smailru.net ([94.100.178.49]:36041 "EHLO
        fallback.mail.ru" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751068AbdHPHqK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 03:46:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=list.ru; s=mail;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=x7Gd2X87Zui9BjqpylIosVi0pTzDjRkzY7k6TagFjUQ=;
        b=WAL++1iwZkT0s1bUkehzGRxsRk8bXwfeVjnHPwKVy3DRY1xugoDadojh5kaU5ondi4XsXXhQSdUHni6r53xkze1gnKiL3XDAYaBZhKW903EzGvNSnc3AAyh5Xv34/o9TyH9a6vMKM9H/YsVxtJkRMpsLFw2Km7T8EH/ov8xXYr4=;
Received: from [10.161.64.1] (port=39832 helo=smtp30.i.mail.ru)
        by fallback9.m.smailru.net with esmtp (envelope-from <S-trace@list.ru>)
        id 1dht1k-0004GX-0d
        for git@vger.kernel.org; Wed, 16 Aug 2017 10:46:08 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=list.ru; s=mail;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=x7Gd2X87Zui9BjqpylIosVi0pTzDjRkzY7k6TagFjUQ=;
        b=WAL++1iwZkT0s1bUkehzGRxsRk8bXwfeVjnHPwKVy3DRY1xugoDadojh5kaU5ondi4XsXXhQSdUHni6r53xkze1gnKiL3XDAYaBZhKW903EzGvNSnc3AAyh5Xv34/o9TyH9a6vMKM9H/YsVxtJkRMpsLFw2Km7T8EH/ov8xXYr4=;
Received: by smtp30.i.mail.ru with esmtpa (envelope-from <S-trace@list.ru>)
        id 1dht1i-0002P6-J7; Wed, 16 Aug 2017 10:46:06 +0300
Subject: Re: [BUG] git am sometimes unable to apply git format-patch output
 file
To:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org
References: <a6e69bd1-b91f-3150-c3a6-9378793e5e43@list.ru>
 <20170812162023.GA21045@tor.lan> <20170812170136.GB21045@tor.lan>
From:   Soul Trace <S-trace@list.ru>
Message-ID: <71432224-5ec4-7f48-7e9f-c0a69a75efad@list.ru>
Date:   Wed, 16 Aug 2017 10:45:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170812170136.GB21045@tor.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-7FA49CB5: 0D63561A33F958A53F2D732EA189E5E295C44E367DF1EE92567415DF94956C31725E5C173C3A84C3BFED8EC40EBB00D7B67346C1EA145983D2457FAF19517CF2C4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0FF045C6A0F83C8214574AF45C6390F7469DAA53EE0834AAEE
X-Mailru-Sender: 689FA8AB762F739340FC1C1D984B219275DCC4093ABCAE5C3EA1FDBBF54AD001C04B38030DC5F6DB6FFB196AD8E7F41051581E2F20B473F5545342457E7E468CBFBE8972342AB7EAE8C36B340C48BC2B67EA787935ED9F1B
X-Mras: OK
X-7FA49CB5: 0D63561A33F958A5C8C0DD579B3E1A92953BD67DE692B63D8D244A1CFCF93B02462275124DF8B9C9806C6499444CB6FBBD9CCCA9EDD067B1EDA766A37F9254B7
X-Mailru-Sender: A5480F10D64C9005142DBD8FE6AB06EF54B860299B525F3E206B4890633F25C7BA503CF0A27CDEF36103E94D80588021FD314D6D3A53ECD4D8A1DAC837C659B26417EB27FD622E54A403B7CE190B821AB4A721A3011E896F
X-Mras: OK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

12.08.2017 20:01, Torsten Bögershausen пишет:
> On Sat, Aug 12, 2017 at 06:20:23PM +0200, Torsten Bögershausen wrote:
>> On Sat, Aug 12, 2017 at 07:02:59PM +0300, Soul Trace wrote:
>>> Hello.
>>>
>>> Using git i have found that git am command may sometimes fail to apply patch
>>> file which was created by the git am command.
>>>
>>>
>>> Steps to reproduce:
>> Excellent, thanks so much for the detailed bug report.
>> This kind of information is really appreciated.
>>
>> Why did I say excellent ?
>> Because I am working on a patch, which -should- fix exactly this kind of issues.
>> I send out a patch earlier this day, but it doesn't fix your issue, even if it should.
>> I hope to have a fix soonish.
> I need to correct mysef, a litte bit, this doesn't seem to be a bug, but a feature.
> There are 2 things to be noticed:
> - The xml file has been commited with CRLF
> - git am strips the CR (because they -may- have been added by a mail program)
>
> There are 2 different solutions:
> a) Use git am --keep-cr
> b) "Normalize" the xml file(s), and commit them to have LF in the repo,
>      they can still have CRLF in the work tree, if needed.
>      This is done by
>      echo "*.xml text" >>.gitattributes
>      touch *.xml
>      git add *.xml .gitattributes
>      git commit -m "Normalize xml files"
>
>
> If you really need the xml files with CRLF, use this line instead:
>      echo "*.xml eol=CRLF" >>.gitattributes
>
> HTH
> /Torsten

Thank you.

I will use a) the solution, because I use git am to apply custom patches 
to the Android tree from vendorsetup.sh in my device tree at ". 
build/envsetup.sh" execution and just want git to apply commits what I 
did earlier, when the upstream repositories changes (instead of forking 
the upstream repositories, and then merge the upstream changes to the 
end of the world).

Thanks for your answer, it's really useful. Good luck in patching your 
issue!

