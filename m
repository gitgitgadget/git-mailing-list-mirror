Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 911851F404
	for <e@80x24.org>; Fri, 29 Dec 2017 23:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750806AbdL2XTt (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Dec 2017 18:19:49 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:36673 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750709AbdL2XTs (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 29 Dec 2017 18:19:48 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 70B272191F;
        Fri, 29 Dec 2017 18:19:48 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 29 Dec 2017 18:19:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=keith.so; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=mesmtp; bh=Ybe1Tx5qXxwIyvttwtVKxtTRQb
        S8hAIvx0zbWSMyBms=; b=Kj5tQIKF66vuR6+YARkajVsjw41z+PelDabfpxgg7w
        LkHdIAleg1LGEZBDCmKg0YIAGvQQiEc6RzOAYUw4IaQ41TM0ENf9a3Njpzh3LO0m
        DXJow726rKPDUc2M86QyNsi+IZb6oFVNtCHN3108U8+cFGOSj7vSoRER8ymhVmyt
        8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Ybe1Tx
        5qXxwIyvttwtVKxtTRQbS8hAIvx0zbWSMyBms=; b=fQwT9FgB7DM//jh73hzb1I
        d99cgyX2+5rJSlCDcDJi2S93wyIc7dCFUmKUthOPYcspRAg0TGkuwWZ419eP4qbq
        PuXaC9g9vl22ahz3CcpTnGvWMS7o2rNFiROvc1QM8oJyLWbmb5t5i3VivlL9AJZJ
        R9fJrJxicLMD0qYNy+K3HWV3g6T6fBFGbAf6x6F20n0wtyPdEY4UESLyVhFQdEQO
        GQqD/SPQrEF6uZ4+oHgugB/FhrZIg6wEgAnXnI6l5+mxnuSc/5AUJm3Kx/s8JQ9R
        ACBHh0/D28xrnqzatlm4EOsD8gL9D9ghVzwBxpI7uQI6UBlehSi1h3mkpoCJVn1g
        ==
X-ME-Sender: <xms:lM1GWhbr2avTFXY8q59om6W30HZUtNKGwO662bf5l94y0xiHC3R8oQ>
Received: from localhost (unknown [4.14.106.7])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0F4E37E188;
        Fri, 29 Dec 2017 18:19:47 -0500 (EST)
Date:   Fri, 29 Dec 2017 15:19:47 -0800
From:   Keith Smiley <k@keith.so>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     Todd Zullinger <tmz@pobox.com>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Kevin Daudt <me@ikke.info>
Subject: Re: [PATCH] Add shell completion for git remote rm
Message-ID: <20171229231947.GA7698@bryant.local>
References: <20171229135240.GQ3693@zaya.teonanacatl.net>
 <20171229224825.31062-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171229224825.31062-1-szeder.dev@gmail.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The goal of this fix isn't to complete rm itself (although that is a 
side effect), it's to complete the remote names after you type rm.

Without this patch doing this:

git remote rm <TAB>

Attempts to complete the options for `git remote` instead of the remote 
names.

--
Keith Smiley

On 12/29, SZEDER Gábor wrote:
>> Keith Smiley wrote:
>> > It looks like that was just about preferring remove in documentation
>> > and the like, I think it would still make sense to have both for
>> > completion since rm is still supported.
>>
>> I read it as a first step in a long process to eventually
>> remove 'remote rm', but if that's never intended, then sure,
>> restoring completion for it seems reasonable.
>>
>> It would be good to hear from those who know or recall the
>> intention.
>>
>> I think we should only complete the preferred subcommand.
>> That encourages use of 'remote remove' even if 'remote rm'
>> will stay forever to avoid breaking existing scripts.
>
>Quoting from the commit message of e17dba8fe1 ("remote: prefer
>subcommand name 'remove' to 'rm'", 2012-09-06):
>
>  'rm' is still supported and used in the test suite. It's just not
>  widely advertised.
>
>I think adding 'rm' to completion definitely counts as advertisement.
>It doesn't have much practical use, after all: typing 'rm' with
>completion is actually one more keystroke than without (r<TAB>m vs. rm).
>
>
>Gábor
>
