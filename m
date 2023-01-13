Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B50C54EBD
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 16:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjAMQFp convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 13 Jan 2023 11:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjAMQFM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 11:05:12 -0500
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8530B6430
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 07:56:43 -0800 (PST)
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 30DFud1I082015
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 13 Jan 2023 10:56:40 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Hans Petter Selasky'" <hps@selasky.org>,
        "'Konstantin Ryabitsev'" <konstantin@linuxfoundation.org>
Cc:     <git@vger.kernel.org>
References: <39dd1a00-786b-acf5-8a40-2425f7dab6cc@selasky.org> <20230113133059.snyjblh3sz2wzcnd@carbon> <446984f6-0d2e-04da-11a3-8b1481fac953@selasky.org> <009701d9275a$678416b0$368c4410$@nexbridge.com> <8a8fbe42-7809-f3e7-b233-6bef790254e1@selasky.org> <20230113154516.jxm2cer4sogatayp@meerkat.local> <6061d012-13b7-ca4b-5556-70875b65c887@selasky.org>
In-Reply-To: <6061d012-13b7-ca4b-5556-70875b65c887@selasky.org>
Subject: RE: Gitorious should use CRC128 / 256 / 512 instead of SHA-1
Date:   Fri, 13 Jan 2023 10:56:35 -0500
Organization: Nexbridge Inc.
Message-ID: <00b201d92767$a0403ee0$e0c0bca0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQG1ruR/R8aOK53MseGE8PcTBMgOqAJK+xVsAv4V3WQBoMSS3wG1CvdaAn0vGXoBZAcctK5/b65A
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 13, 2023 10:50 AM, Hans Petter Selasky wrote:
>On 1/13/23 16:45, Konstantin Ryabitsev wrote:
>> I think you're misunderstanding some of the core principles of git.
>
>Maybe, I'm usually commandering git via the terminal.
>
>But if you say you can already edit stuff, why does the commit hash need to be
>cryptographic? I don't get that part. Yeah, I think of git commits like blockchain.

git is using SHA1/SHA256 (which happen to be coincidentally cryptographic) as message digests with a very low probability of collisions when the hashes are computed. There is never a situation, implied by cryptography, where there is a decode of a git hash.  In order to make git a blockchain, you would need to implement central signing authorities, which would require a fork if the signature mechanism changes. The signature mechanism (SSH, GPG) is distinct from hash computation in git's trees, but depends on hash integrity.

