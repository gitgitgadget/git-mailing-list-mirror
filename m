Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B539ECAAA1
	for <git@archiver.kernel.org>; Fri, 16 Sep 2022 23:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiIPXOL convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 16 Sep 2022 19:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiIPXOI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 19:14:08 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD76979FA
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 16:14:07 -0700 (PDT)
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 28GNE5mP073609
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 16 Sep 2022 19:14:06 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Victoria Dye'" <vdye@github.com>,
        "'Git Mailing List'" <git@vger.kernel.org>
References: <011001d8ca20$bc4d81f0$34e885d0$@nexbridge.com> <5d02d3b8-dc79-a2d8-f5e1-129d2228ff23@github.com>
In-Reply-To: <5d02d3b8-dc79-a2d8-f5e1-129d2228ff23@github.com>
Subject: RE: [BUG] Non-portable Construct Introduced in diagnose.c (dirent) at v2.38.0-rc0
Date:   Fri, 16 Sep 2022 19:14:00 -0400
Organization: Nexbridge Inc.
Message-ID: <011101d8ca22$04b68940$0e239bc0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLQkfK4WEnG2ZgQlNo1Qrr3mlGz6wJjblr5q+AEZTA=
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On September 16, 2022 7:11 PM, Victoria Dye wrote:
>rsbecker@nexbridge.com wrote:
>> The dirent d_type field is not available on every system. This was
>> introduced at 2.38.0-rc0 in diagnose.c
>>
>> diagnose.c, line 79: error(1565): struct "dirent" has no field "d_type"
>>
>>   		    e->d_type == DT_DIR && strlen(e->d_name) == 2 &&
>>
>> (3 more issues in diagnose exist of this form).
>>
>> The code should use the  NO_D_TYPE_IN_DIRENT knob to detect whether
>> this is an existing field as defined in cache.h.
>
>Apologies for missing that, I'll try to send a patch fixing it either later today or
>sometime Monday.

Thanks. If you need it tested in advance "in the wild", please let me know.

Regards,
Randall

