Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE9CEE499B
	for <git@archiver.kernel.org>; Fri, 18 Aug 2023 23:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242594AbjHRX01 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 18 Aug 2023 19:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242665AbjHRX0B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2023 19:26:01 -0400
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633BC420F
        for <git@vger.kernel.org>; Fri, 18 Aug 2023 16:26:00 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 37INNdpH2386681
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 23:23:40 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>, "'Junio C Hamano'" <gitster@pobox.com>
References: <01b301d9d21e$81c7ff40$8557fdc0$@nexbridge.com> <202308182302.37IN2tgW2384518@secure.elehost.com>
In-Reply-To: <202308182302.37IN2tgW2384518@secure.elehost.com>
Subject: RE: [BUG] Git 2.42.0-rc2 t1092.57 script error
Date:   Fri, 18 Aug 2023 19:25:51 -0400
Organization: Nexbridge Inc.
Message-ID: <01b801d9d22b$5781eea0$0685cbe0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIjI9bVe3jV34UC+t2wPjwFRD2Rp69eCUhw
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

><mailto:rsbecker@nexbridge.com> writes:
>>On Friday, August 18, 2023 5:28 PM, Junio C Hamano wrote:
>><mailto:rsbecker@nexbridge.com> writes:
>>
>>> Is this new test code? The local qualified appears to be a bash
>>> extension, not available across all shells - from what I can
>>> determine. Is it really required here or just fancy?
>>
>>You are asking a wrong person ;-)
>>
>>You know Git well enough to run "git blame" on this code yourself to answer
the first
>>question and find out whom to ask it:
>>
>>  https://github.com/git/git/blame/master/t/test-lib-functions.sh#L1794

>Code has been around 2 years. I will chase this down with the platform
>vendor.

Well, it was investigated. local is not the issue. It is working correctly on ksh and bash on the platform. It is looking like the issue was something in the environment. We are on a new test system that is seriously overloaded, so it is possible that we ran out of resources or were close to the limit when the test started - multiple times earlier in the day, but it is feeling much better now and the subtest passed.

I'm going to write this one off as no factor.

Thanks for the help.
--Randall

