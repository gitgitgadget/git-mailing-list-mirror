Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FECAC54EBE
	for <git@archiver.kernel.org>; Mon, 16 Jan 2023 14:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjAPOBg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Jan 2023 09:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbjAPOBR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2023 09:01:17 -0500
Received: from mail.turbocat.net (turbocat.net [IPv6:2a01:4f8:c17:6c4b::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016C818B14
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 06:01:08 -0800 (PST)
Received: from [10.36.2.145] (unknown [46.212.121.255])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.turbocat.net (Postfix) with ESMTPSA id C2ECB262359;
        Mon, 16 Jan 2023 15:01:06 +0100 (CET)
Message-ID: <85788356-14b1-6afb-c78c-0ab889bbbb59@selasky.org>
Date:   Mon, 16 Jan 2023 15:01:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Gitorious should use CRC128 / 256 / 512 instead of SHA-1
To:     rsbecker@nexbridge.com,
        "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <9c0fda42-67ab-f406-489b-38a2d9bbcfc2@selasky.org>
 <Y8NB21PExmifhyeQ@tapette.crustytoothpaste.net>
 <3b0af57c-a144-b0e4-d353-6028b3939291@selasky.org>
 <017901d929a6$ec180f50$c4482df0$@nexbridge.com>
Content-Language: en-US
From:   Hans Petter Selasky <hps@selasky.org>
In-Reply-To: <017901d929a6$ec180f50$c4482df0$@nexbridge.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/16/23 13:34, rsbecker@nexbridge.com wrote:
> On January 16, 2023 2:24 AM, Hans Petter Selasky wrote:
>> On 1/15/23 00:59, brian m. carlson wrote:
>>> However, Git is moving in the direction of stronger cryptographic
>>> algorithms, rather than insecure hashing algorithms.  I don't think
>>> your proposal is a good idea, nor do I think it's likely to be adopted.
>>
>> I disagree. There is no need for signing in a version control system. It just makes it
>> harder to change things, like the right-to-repair. In my eyes there is a high chance
>> of abuse, by vendors that do no want others to flash or edit their device
>> firmwares.
> 

Hi,

> The two matters are completely isolated and distinct. In the OpenSource community, anyone typically has the right to modify. Please refer to the GPLv3, ECLIPSE, and MIT licenses for example. Those are the governing documents that permit modification and define intellectual property rights. Please consult those licenses with regards to right-to-repair statements that have no legal bearing on git or any other GPL-governed software product. In my view, the issue raised is a red herring that keeps getting brought up, which does not contribute positively to this request's discussion, but would presumably would increase the hit rate on web searches, to which this reply unfortunately contributes.

The use of cryptographic hash tags, allows one party to stay in control 
of and monetize a project, actually by doing nothing more than 
rebranding an existing product.

> The assertion of no need for signing can apply to a centralized version control system, like SVN, because users are authenticated centrally, and the contribution can be made definitive without a separate signature, providing no one with root authority on the server hacks the repository. In the architecture of a distributed version control system (specifically git for this discussion), there is no evidence of origin of changes because the commit identity is cooperative rather than being enforced by a central authority and hacking the repository by root is detectible. The assertion of signing as abuse of rights is also an opinion that, so far, has no supporting evidence given. Perhaps a paper in a refereed journal might give this position some credibility.

 From what I've read the GPLv3 goes pretty far to also provide flashing 
rights for software, but what use is that, when flashing the unsigned 
software on your Samsung phone, for example, some fuse breaks in the 
hardware, and then you can no longer use certain apps on your phone?

> 
> My point is that signing is critical in a DVCS and a major function point used by DevOps architects for adopting git in new organizations. In the regulated world, FinTech, FDA, Aviation, etc., signing contributes to the evidence of origin of changes required by PCI and SWIFT (ref: section 6 in each regulation). Without signed tags (which the establishes the change origins for releases for production use), deployment becomes less certain and less acceptable to the audit community with whom I interact on a regular basis.
> 

It's very clear to me, that supporting signing straight off the VCS, 
will not help the opensource and right-to-repair community at all. It's 
just ripe for abuse, like I say.

Hacking is prevented by using a secure copy mechanism between the 
servers, which you can upgrade separately. You already see the problem, 
SHA-1 is not good enough to prevent hacking. Why not just separate the 
hacking preventing measures and the needs of a good VCS?

--HPS
