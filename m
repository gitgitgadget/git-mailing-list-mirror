Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30CEC77B7A
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 20:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235939AbjFBUDG convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 2 Jun 2023 16:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235676AbjFBUDE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 16:03:04 -0400
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436671A2
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 13:03:03 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 352K1OtM2045661
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Jun 2023 20:01:25 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     <paul@mad-scientist.net>, <git@vger.kernel.org>
References:     <b6f210da2c3cc7746b984b797ad89687cba2d1f8.camel@mad-scientist.net>       <7aa2ab6714bd14671ba9cfff611dea2fa088c99e.camel@mad-scientist.net>      <000501d99589$358d4850$a0a7d8f0$@nexbridge.com> <679863bd1ed8a54b48472ad310c2bae7f274e1ec.camel@mad-scientist.net>
In-Reply-To: <679863bd1ed8a54b48472ad310c2bae7f274e1ec.camel@mad-scientist.net>
Subject: RE: Anyone know why git ls-remote output might be corrupted?
Date:   Fri, 2 Jun 2023 16:02:42 -0400
Organization: Nexbridge Inc.
Message-ID: <000f01d9958d$347d6220$9d782660$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQL2KkAGw/A66lUpsUPtRMKzBms0zQMbqEhgAN2a4LMBSvrBHq0Uo58g
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Friday, June 2, 2023 3:53 PM, Paul Smith wrote:
>On Fri, 2023-06-02 at 15:34 -0400, rsbecker@nexbridge.com wrote:
>> On Friday, June 2, 2023 3:13 PM, Paul Smith wrote:
>> > On Fri, 2023-06-02 at 14:59 -0400, Paul Smith wrote:
>> > > Also a bunch of the heads are missing.  It's pretty clear that
>> > > right in the middle of printing one of the SHAs we suddenly lost a
>> > > bunch of output, and started printing stuff from later (in the
>> > > last instance 66 out of 131 heads were missing).
>> >
>> > I forgot to mention: git ls-remote does not exit with an error code.
>> > The exit code is 0 (success).
>> >
>> > The reason I get this failure is that as I parse the output I notice
>> > that the SHA is invalid (contains a non-hex character "i") and it
>> > throws this error.
>>
>> Does your CI/CD system use sparse checkout or depth=1 or some other
>> partial clone?
>
>Yes, the local copy of the repo is a sparse checkout.
>
>I'm surprised that matters to ls-remote... I would have expected that the "sparseness"
>of the local repo is irrelevant when listing the state of the remote's heads?  Is that
>the reason for the issue I'm seeing?

I'm just wondering whether this might be an impact somehow and adding info to help the team diagnose. I have seen other commands have some issues in the past with --depth=n
--Randall

