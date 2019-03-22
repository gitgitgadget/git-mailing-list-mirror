Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A6F020248
	for <e@80x24.org>; Fri, 22 Mar 2019 08:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbfCVIVa (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 04:21:30 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:60393 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727535AbfCVIV3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 04:21:29 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 44Qc7V0tcJz1rFtW
        for <git@vger.kernel.org>; Fri, 22 Mar 2019 09:21:26 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 44Qc7V0n9Xz1rVxD
        for <git@vger.kernel.org>; Fri, 22 Mar 2019 09:21:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id OPPdTl971GPD for <git@vger.kernel.org>;
        Fri, 22 Mar 2019 09:21:25 +0100 (CET)
X-Auth-Info: 0xE1aoQ3bKCPI1b7zqveUl+OPKoINU2zkBC5CKAbZjQ=
Received: from janitor.denx.de (unknown [62.91.23.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA
        for <git@vger.kernel.org>; Fri, 22 Mar 2019 09:21:25 +0100 (CET)
Received: by janitor.denx.de (Postfix, from userid 119)
        id B9467A2C49; Fri, 22 Mar 2019 09:21:24 +0100 (CET)
Received: from gemini.denx.de (gemini.denx.de [10.4.0.2])
        by janitor.denx.de (Postfix) with ESMTPS id 74BAFA2B86;
        Fri, 22 Mar 2019 09:21:17 +0100 (CET)
Received: from gemini.denx.de (localhost [IPv6:::1])
        by gemini.denx.de (Postfix) with ESMTP id BC19924013C;
        Fri, 22 Mar 2019 09:21:14 +0100 (CET)
To:     Jeff King <peff@peff.net>
cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>, git@vger.kernel.org,
        Eric Wong <e@80x24.org>, Junio C Hamano <gitster@pobox.com>,
        Takahiro Akashi <takahiro.akashi@linaro.org>
From:   Wolfgang Denk <wd@denx.de>
Subject: Re: [BUG] Cloning with git HEAD fails for some repositories
MIME-Version: 1.0
Content-type: text/plain; charset=UTF-8
Content-transfer-encoding: 8bit
In-reply-to: <20190322071231.GA26114@sigill.intra.peff.net>
References: <7e4a2f1d-2b3a-eb83-d3f1-9ac63d68991b@gmx.de> <20190322005107.GL9937@linaro.org> <017964a9-bd75-5e36-0de7-57d4467d6a7e@gmx.de> <20190322071231.GA26114@sigill.intra.peff.net>
Comments: In-reply-to Jeff King <peff@peff.net>
   message dated "Fri, 22 Mar 2019 03:12:31 -0400."
Date:   Fri, 22 Mar 2019 09:21:14 +0100
Message-Id: <20190322082114.BC19924013C@gemini.denx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Jeff,

In message <20190322071231.GA26114@sigill.intra.peff.net> you wrote:
>
> However, so does the parent of 17966c0a63d. So I don't know if the
> u-boot-efi repo is just broken, or if there's some other different bug
> at play.

git fsck reports a number of dangling tags, but no other issues:

$ git fsck --strict --full
Checking object directories: 100% (256/256), done.
Checking object directories: 100% (256/256), done.
Checking objects: 100% (602062/602062), done.
Checking connectivity: 602001, done.
dangling tag 452ba0c37615d650cbbc4ce5051b4e8519b8720c
dangling tag 3d6dc0f31fc91f6263419bc954423fe648beb4a3
dangling tag 89e1e16d51cbe039c31fc4e8c86650c02e312f8c
dangling tag f3e3a1693b231fc5da7055537365fac458efc6cd
dangling tag fc41a2b55bf9c9e17cda5bd72ba187ba9196d9d2
dangling tag c4bb2215f2197b3a9db43f32bab969747d5bc8e6
dangling tag c0fee2657d53f7db7d5b0f6824497e46b06f1791
dangling tag 732ec3af41614a70816aa8afcb04a7680e23bd6e
dangling tag aedf24f63bbc92c8168aa0f0b73dd9fb0db4a1b6
dangling tag f3e6c43dcc094d8578951b08b58f4c243ffafb2a
dangling tag 979de5a0a39c596dfa210b19c85a838fa8634052
dangling tag f3b8c6c66c184a8430796cb57394afdd2e541070
dangling tag d2c8c619152019515d9489457345449755535562
dangling tag dadde645865cd3280b1fdd3b575419f4c09573f7
dangling tag 6ed5270bfcb7d38d0c8d88df03c2885462f5f40a
dangling tag 765f888560c78a7d8460fe99faf3e4cbfa61b6b0
dangling tag 3d920830d3809d3cdda14f7546b4ae8285a58842
dangling tag 80a0080837b5c62e40258413b147e8328ca170f5
dangling tag ecbe2871435ac1c56c2a8089f450b469e6a9f9cc
dangling tag 09c5a89a796d2e3d6308f9dce6050c7d4ec5d9df
dangling tag c9d3285563b2b2481d9c771ce0c72481a0af64eb
dangling tag 5483e951b4c87224edafa663cde59fc841664ebf
dangling tag 254f4a15b35151f062ac304ccf199d07910b7c2a
dangling tag 358baae41f3b5cb07aeca741e7d0d791e861a528
dangling tag 95d24ae1624e3eff49ca7d5476d7f5124c489b3a
dangling tag e154abe2a1d1ef87e2a24d2941a877417d2ca3da
dangling tag 04204d1f0467fcef54791c07933002462b954e25
dangling tag abdf4d2a98fb450377c8b45c2aa4cee7f3b3b903
dangling tag 47132ee1703118762a0a26b80586ef544eaaf43e
dangling tag 651f6f06d36957b3ced288b4111d7c6f20764094
dangling tag eb38cf862652e60fa1a3056eab6a9e8f60acb28c
dangling tag b3dd30be5ccae9567d55bcbeaad73e8b94d38ae9
dangling tag 1c511176d278dbbd826c30d6e8dfd483d6eee207
dangling tag 01a35101e2b5279b7bab7c48f80b69dce1863451
dangling tag 1abb11a56c69c935be145b76bba763d3d37b5008
dangling tag a613b2d185434171de1623e5eac2aefac4bf480b
dangling tag 8693d3dc28232d4a10a5538ad840becdd8333923
dangling tag 0f3d74c6bccd90854910781247810a8ec6b2ddc3
dangling tag 4e49f4c5c8dcb02f7920b70e6543d82cae0643c2
dangling tag 0782f493db029eae862eb21d574584d30da73d48
dangling tag f0a414959f25f7ab33cf4ba24a7ff81642e20dd5
dangling tag bd7f95c6689c0c7ed10bd1dafca9d335c239afab
dangling tag 5a1ff6e103ac132ea5d3b2ef768c035f0c83cb9e
dangling tag af4cd6c6c6584e66958bc7ef394ed629c8bb1803
dangling tag 4567960734b2f1349d79057e092c9aac03fb551d
dangling tag e9807710b1d02bce52d0fe31bfbdb2f593833689
dangling tag ba9bd7caa0d05843752fcfe6460131e8f1378606
dangling tag f6443869d551d0d5a6e20ba9970c6c5461788a44
dangling tag bf46b888957dd3c4fa91df0c1988dff7ac06e7a6
dangling tag d2521813943774ea8d0c248b97706cc4fedefb9c
dangling tag 566ab8f50a43a2fd3d2fc830df89b1545ae59532
dangling tag 15ea987e7b8596c2b20a63bc2a5e9adfff48d455
dangling tag 427c593ee160344cecb6d0da72130bc3146cf9a5
dangling tag 4a1cda6347d5db4e51e3b8c86b079abd46caee46
dangling tag a757fc49ca3df6c66f8bcde3b5bff624d764e395
dangling tag 0f6a7c7ea77c2464155aaa5deba8b9d0d5b77403
dangling tag 9219fdc80e88b08ae1f6f5dd49a82d8f63fb8d35
dangling tag 20331ed567cbdd9d55491b9bae022d07b0506d68
dangling tag 82719e3e08a3b6e0b6e309776f18798b01109f22
dangling tag 8d42df34d510ca2e948d3c670d385ee824eccf49
dangling tag a8a39f377012bda355330cf2c6b04497d2f709ef

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Houston, Tranquillity Base here.  The Eagle has landed.
                                                    -- Neil Armstrong
