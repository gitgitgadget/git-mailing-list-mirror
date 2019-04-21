Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A800320248
	for <e@80x24.org>; Sun, 21 Apr 2019 03:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbfDUDT4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Apr 2019 23:19:56 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:60057 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725882AbfDUDT4 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 20 Apr 2019 23:19:56 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 2FFCE21B74
        for <git@vger.kernel.org>; Sat, 20 Apr 2019 23:01:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Sat, 20 Apr 2019 23:01:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        to:reply-to:from:subject:message-id:date:mime-version
        :content-type:content-transfer-encoding; s=fm2; bh=KT9ODSJNgUBh3
        ZtSqR5+HYjsPeEpP1q+f4qO4BLnXiQ=; b=mrgfFBGtvulYav2yPdAgMNt20D8zf
        U8cBRX/N2HCNXc2gaIsbtqBlNU/XsVbSawK+qt62V0sFFJV0hchV/O5nlObYf2uj
        HprnmMLJZkj8g/x7qno0fvyDCqSWhgXwvGnPc/Y5l8kVZMHB9PSXqxJZwl5eanAC
        nb6+N+3VRoEyl7pb4BeGp1YUpNFY3UZyB1LbKungPAnjIJ0oT/GAxuY85RZjh8ag
        I4RCDEIsdaPb/an6X2x09idH3scSfqfMtLdDecVZuQtVSi3b5X/45F7yeB4vMRad
        3UJXe8nxhduRcXXFYjvFYsEYuh8MxIF0lQzkRkMziyrTOWJCeOq3lVaLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:reply-to:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=KT9ODSJNgUBh3ZtSqR5+HYjsPeEpP1q+f4qO4BLnXiQ=; b=tf8L3uH6
        tpclHGcpsIQoBNOcVgXCbCKRLjLGrTK+V3NbhICLIZWoxZWhGYEAiCh6C90KCW03
        FwTDhkW6oNhC5HKrjtGwxN1woyVoJ+78WgmXQigh5PaIo1Dhwrz73i+/qnVWJoYb
        ToGhqycRoRzZdt8DuJwb43GOgodUyGogk9VJIOvg5b5qEsoKkFvSeIEE4RLJSq4m
        YM6EJiGni2DONqr7HQeLJGBt23Wc/S0vwliOkF13xHPwTvCbuInbEE3iHjYucMG2
        FcDW20ridEhxwYjHvCHyysdwxBbgcMmdQOu2oiR8SmZr15a1+C2zyG7/adYh6kLC
        R5ZD+MKPnF4vXQ==
X-ME-Sender: <xms:9dy7XLLa8zvHEn4oGhzSdLmTL9Zeq9hNFfOyk-CVHPJhISz8YPiXLQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrgedvgdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepvfhrhffukffffgggtgfgsehtkeertd
    dtfeejnecuhfhrohhmpehrohgsuceoughrrhhosgdutddtsehfrghsthhmrghilhdrtgho
    mheqnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepjedvrdekledrleeird
    dukeeknecurfgrrhgrmhepmhgrihhlfhhrohhmpegurhhrohgsuddttdesfhgrshhtmhgr
    ihhlrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:9dy7XE5StMgGmcNUiCd8zWZRjcNsnU_UOepI_mGY9psZBrd9oEmh2A>
    <xmx:9dy7XBxupNbqVGyrFTHBwyV3QyNdMPIAvb-sObmDhJVVBj4zzmRNSA>
    <xmx:9dy7XO_w0_Hk9pVwCZ2Z0JN0qrD7EjQxEPa8z6DwW42jdrhPwyaeqw>
    <xmx:9dy7XLSbObyxO_CcKt9lo4A1afy_v84p0xx7S_U_BYd5_qqQz7gFMg>
Received: from [192.168.1.153] (pool-72-89-96-188.nycmny.fios.verizon.net [72.89.96.188])
        by mail.messagingengine.com (Postfix) with ESMTPA id C57F7E41A1
        for <git@vger.kernel.org>; Sat, 20 Apr 2019 23:01:08 -0400 (EDT)
To:     git@vger.kernel.org
Reply-To: rob@drrob1.com
From:   rob <drrob100@fastmail.com>
Subject: I messed up my own git tree and I don't know how to fix it.
Message-ID: <cb1f725f-1314-d320-104a-726ef1c906fa@fastmail.com>
Date:   Sat, 20 Apr 2019 23:01:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have my own code at a github repository, using Go.  Part of using Go 
libraries not part of the official Go people is by using a system they 
call go get.  This essentially uses git to, well, go get source code.  
Mine are at github.com and golang.org.  My computer runs LinuxMint 19.1.

I used goland IDE from jetbrains to run go fmt on my entire project.  
Now I am getting this message that I cannot get rid of:

changes not staged for commit:

   modified: github.com/alecthomas/gometalinter (modified content)

   modified: github.com/kisielk/errcheck (modified content)

   modified: github.com/rogpeppe/godef (modified content)


I do not want any changes to central repos to be tracked or committed, 
but I cannot undo this.  I tried, for example,

git checkout -- github.com/alecthomas/gometalinter

I don't get an error message but it does not do anything.  The file is 
not changes, and git status show me the same information, ie, these 
files have changes not staged for commit.

I do not know how to restore these files to the state they were in in 
the repo, and to have my own git tree not to flag this as an unstaged 
alteration.  Running rm -rfv on the repos on my computer, then running 
go get to restore them does not change git status. It still sahs changes 
not stated for commit: modified.

This happens for the above 3 tree items.

How do I restore these to the github remote repository condition and not 
have my own git tree mark these as changed?

--rob solomon

