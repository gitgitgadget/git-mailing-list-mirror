Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4F0C433F5
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 14:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234292AbiAJODy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 09:03:54 -0500
Received: from mail1.rz.htw-berlin.de ([141.45.10.101]:64836 "EHLO
        mail1.rz.htw-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234143AbiAJODx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 09:03:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=htw-berlin.de; s=my; h=Subject:To:From:Date:From:To:Date:Subject;
        bh=hwxU1XYg/ZNUDU5CTsS7dniZVLtxECd9AzSlaosSVEk=; b=SfxWvqEGHrhK01NNkfQVjziM5X
        KM/rU2L1ccFH/iR1XwW0+/i/hFYLDZJ91FXlLV3GCd9uPwWBQI4ojkKPjb0/tB3wMYB8ZRvxMAo6S
        RA4fEzmZ4E2hzt8xWwunQ1ubkyuofn5MmUNjOQ9r9Y7AnbZiwwwsms3lfnnF5Uxt0WOxAeadZ310o
        oBseSgQdPraKzlJDNM7j1OuPkckVq9FHyRVHzkNM+AEW1hVteunttTW+pXF6G/F0WM1i/k2v7UK0t
        CJz8yssGSqsMWwDy+Tx42+bXK/xCRs4YS7klKLZ9ilcr7zD0/Y+lkS4xn2lKDkcGAeDon20NTWqEo
        OhjKcSng==;
Envelope-to: git@vger.kernel.org
Received: from webmail.htw-berlin.de ([141.45.70.36])
        by mail1.rz.htw-berlin.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2 (FreeBSD))
        (envelope-from <Sebastian.Richter@HTW-Berlin.de>)
        id 1n6vGk-000CEx-GI; Mon, 10 Jan 2022 15:03:51 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 10 Jan 2022 15:03:51 +0100
From:   Sebastian Richter <Sebastian.Richter@HTW-Berlin.de>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Imi Admin <imiadmin@htw-berlin.de>, git@vger.kernel.org
Subject: Re: Problem with credential.helper=store in git 2.32.0.windows.2
Organization: HTW Berlin
In-Reply-To: <nycvar.QRO.7.76.6.2201101349550.339@tvgsbejvaqbjf.bet>
References: <8838ac786ed46b841e4172824b80564b@htw-berlin.de>
 <nycvar.QRO.7.76.6.2201092246520.339@tvgsbejvaqbjf.bet>
 <1c331bdd51b424022bfd598c71d7d666@HTW-Berlin.de>
 <nycvar.QRO.7.76.6.2201101349550.339@tvgsbejvaqbjf.bet>
Message-ID: <c0d6f26a5e96f12719d5bfa969529ec9@HTW-Berlin.de>
X-Sender: Sebastian.Richter@HTW-Berlin.de
User-Agent: Roundcube Webmail
X-HTW-AUTHENTICATED: yes
X-HTW-DELIVERED-TO: git@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

you are right, but during my (cluster) ssh connections no one else uses 
my systems (hopefully), and i do restore the system file afterwards.

But i'll implement your approach in the next script version.

Thanks & best Sebastian

Am 10.01.2022 13:52, schrieb Johannes Schindelin:
> Hi Sebastian,
> 
> On Mon, 10 Jan 2022, Sebastian Richter wrote:
> 
>> thanks for clarifying this. I'm using 'git config --system --unset
>> credential.helper' before setting the file store in the local 
>> configuration
>> now and it works.
> 
> I am not quite sure whether that is a good solution. You are changing 
> the
> system configuration for the benefit of a local configuration. That 
> would
> potentially break every other user outside of that repository that now
> works.
> 
> My suggestion is to either go with my earlier recommendation and add an
> empty `credential.helper` in the repository's config before the actual 
> one
> (and leave the system config alone), or alternatively change the system
> config instead of the repository config in the first place.
> 
> Ciao,
> Johannes

-- 
Hochschule für Technik und Wirtschaft
Wilhelminenhofstr. 75A
12459 Berlin
Gebäude C Raum 538
tel 030 5019 2945
fax 030 5019 48 2945
mail richter@htw-berlin.de

