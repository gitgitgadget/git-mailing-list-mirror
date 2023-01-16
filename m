Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCAAC54EBE
	for <git@archiver.kernel.org>; Mon, 16 Jan 2023 12:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjAPMfK convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 16 Jan 2023 07:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjAPMez (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2023 07:34:55 -0500
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614F91E1F0
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 04:34:54 -0800 (PST)
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 30GCYluM058606
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 16 Jan 2023 07:34:48 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Hans Petter Selasky'" <hps@selasky.org>,
        "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        <git@vger.kernel.org>
References: <9c0fda42-67ab-f406-489b-38a2d9bbcfc2@selasky.org> <Y8NB21PExmifhyeQ@tapette.crustytoothpaste.net> <3b0af57c-a144-b0e4-d353-6028b3939291@selasky.org>
In-Reply-To: <3b0af57c-a144-b0e4-d353-6028b3939291@selasky.org>
Subject: RE: Gitorious should use CRC128 / 256 / 512 instead of SHA-1
Date:   Mon, 16 Jan 2023 07:34:43 -0500
Organization: Nexbridge Inc.
Message-ID: <017901d929a6$ec180f50$c4482df0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHTa2iI6WI7r9JWJtwuSXW3VRG3CwGfSDb7AW3s/+qulATJQA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 16, 2023 2:24 AM, Hans Petter Selasky wrote:
>On 1/15/23 00:59, brian m. carlson wrote:
>> However, Git is moving in the direction of stronger cryptographic
>> algorithms, rather than insecure hashing algorithms.  I don't think
>> your proposal is a good idea, nor do I think it's likely to be adopted.
>
>I disagree. There is no need for signing in a version control system. It just makes it
>harder to change things, like the right-to-repair. In my eyes there is a high chance
>of abuse, by vendors that do no want others to flash or edit their device
>firmwares.

The two matters are completely isolated and distinct. In the OpenSource community, anyone typically has the right to modify. Please refer to the GPLv3, ECLIPSE, and MIT licenses for example. Those are the governing documents that permit modification and define intellectual property rights. Please consult those licenses with regards to right-to-repair statements that have no legal bearing on git or any other GPL-governed software product. In my view, the issue raised is a red herring that keeps getting brought up, which does not contribute positively to this request's discussion, but would presumably would increase the hit rate on web searches, to which this reply unfortunately contributes.

The assertion of no need for signing can apply to a centralized version control system, like SVN, because users are authenticated centrally, and the contribution can be made definitive without a separate signature, providing no one with root authority on the server hacks the repository. In the architecture of a distributed version control system (specifically git for this discussion), there is no evidence of origin of changes because the commit identity is cooperative rather than being enforced by a central authority and hacking the repository by root is detectible. The assertion of signing as abuse of rights is also an opinion that, so far, has no supporting evidence given. Perhaps a paper in a refereed journal might give this position some credibility.

My point is that signing is critical in a DVCS and a major function point used by DevOps architects for adopting git in new organizations. In the regulated world, FinTech, FDA, Aviation, etc., signing contributes to the evidence of origin of changes required by PCI and SWIFT (ref: section 6 in each regulation). Without signed tags (which the establishes the change origins for releases for production use), deployment becomes less certain and less acceptable to the audit community with whom I interact on a regular basis.

--Randall


