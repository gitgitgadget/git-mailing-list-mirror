Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044E7C433EF
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 13:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377767AbiAaNgP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 08:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235633AbiAaNgO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 08:36:14 -0500
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [IPv6:2a01:e0c:1:1599::12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FC2C061714
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 05:36:14 -0800 (PST)
Received: from [IPV6:2a01:e0a:d1:f360:87c4:c3c8:875d:de3a] (unknown [IPv6:2a01:e0a:d1:f360:87c4:c3c8:875d:de3a])
        (Authenticated sender: jn.avila@free.fr)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id 66EEE13F86E;
        Mon, 31 Jan 2022 14:36:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1643636171;
        bh=LBQM2BUWxRsEnG7M3pBJQ4c+ltNztDax3DWksyvQ5Vw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dNIaRfoOb7sw4J57TTifZy7yVpwzaosPKDWWNiGVrSe7C6wH7gWAuvkITSPR+wx6s
         Fzx0JxOP1cTY6lpCGg16QjEnx1RWcMXMz08H/S1zxPH15QxOoHrwSiZA1KF67qqadu
         GMEZc8rh4WtsqA6iBtPYEkHZtXLpufw2CXoeT70KDcLRGar7Ca4qu49HP88f4St2m7
         g8ZPJv5xOXElQ0K2ytRxLMFdeeA4kpcAbBnHakO1sO+5V/hl4JthORM/oadU27FvM8
         +LvdPozRMHah8UJL9Tz/r1DijNbDKG4m12086HUmgI3iG+AQRPOQAOnjrLjyBi4YD2
         hheRtb1h/kxng==
Message-ID: <b8ff5544-6565-79f7-ee1e-0b53fefef94a@free.fr>
Date:   Mon, 31 Jan 2022 14:36:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 4/4] i18n: transfer variables into placeholders in
 command synopsis
Content-Language: fr
To:     phillip.wood@dunelm.org.uk,
        =?UTF-8?Q?Jean-No=c3=abl_Avila_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     Johannes Sixt <j6t@kdbg.org>
References: <pull.1123.v2.git.1643408643.gitgitgadget@gmail.com>
 <pull.1123.v3.git.1643580113.gitgitgadget@gmail.com>
 <b8e80e178eeb2fccd9e10d783c7cf4b5f4cc80e4.1643580113.git.gitgitgadget@gmail.com>
 <3a12de6d-48f6-b1c1-4fca-655c0db648c7@gmail.com>
From:   =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>
In-Reply-To: <3a12de6d-48f6-b1c1-4fca-655c0db648c7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 31/01/2022 à 12:00, Phillip Wood a écrit :
> On 30/01/2022 22:01, Jean-Noël Avila via GitGitGadget wrote:
>> From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
>>
>> This applies the style guide for documentation.
> 
> I don't really understand the title of this patch. Should 'transfer' be 
> 'transform'? All the changes look fine but seem to be two sorts of 
> changes mixed together
>   - adding '<>' around arguments where they are missing
>   - converting plurals followed by '...' into singulars followed by '...'
> 
> Best Wishes
> 
> Phillip
> 

TBH, this patch is a remaining of some changes performed while making 
the preceding one. They are the places that were false positive from the 
grep.

Fair enough, the changes are a little broader than advertised.

As for the plural forms transformed into singular forms, the coding 
guidelines is clear about repeated parameters of the same type, (e.g. 
<file>...), but some subsets of parameters are still preserved with 
plural, such as <options>, in which case they are not "atomic" (they may 
provide several cells in argv). This is not formalized atm.

My heuristic is that when the subset is not an array of a given type, 
but may be a collection of different types, we keep the plural. Maybe 
using another syntax for these "sub-expressions", along with a link to 
where to find them would help.


JN
