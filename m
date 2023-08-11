Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3BFEB64DD
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 17:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235538AbjHKR42 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 13:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjHKR42 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 13:56:28 -0400
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4722706
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 10:56:27 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 37BHs7sl845688
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 17:54:07 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Linus Arver'" <linusa@google.com>
Cc:     "'Oswald Buddenhagen'" <oswald.buddenhagen@gmx.de>,
        <git@vger.kernel.org>
References: <20230428083528.1699221-1-oswald.buddenhagen@gmx.de>        <20230809171531.2564807-1-oswald.buddenhagen@gmx.de>        <20230809171531.2564807-2-oswald.buddenhagen@gmx.de>        <owly8raih8ho.fsf@fine.c.googlers.com> <xmqqsf8ptsqf.fsf@gitster.g>        <xmqq5y5ltqwd.fsf_-_@gitster.g> <xmqq1qg9tqhq.fsf@gitster.g>
In-Reply-To: <xmqq1qg9tqhq.fsf@gitster.g>
Subject: RE: Re* [PATCH v3 2/2] doc: revert: add discussion
Date:   Fri, 11 Aug 2023 13:56:14 -0400
Organization: Nexbridge Inc.
Message-ID: <033a01d9cc7d$2290e600$67b2b200$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIXe1Z/v3BlubTKbCDzAZ+9CTpLLgH601nRAaSYD8oByeES6wHdpP8JAcrE3tkBivQD0q8VHcMg
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Friday, August 11, 2023 1:54 PM, Junio C Hamano wrote:
>Junio C Hamano <gitster@pobox.com> writes:
>
>> +
>> +		if (starts_with(msg.subject, "Reapply \"Reapply \""))
>> +			/* fifth time is too many - force reference format*/
>> +			use_reference = 1;
>
>Come to think of it, as the documentation patch in the series cited double
reapply as
>too unwieldy, we probably should stop before producing such commit.  We can
>update "Reapply \"Reapply" above to "Revert \"Reapply" and then "fifth" ->
"fourth".
>The test update below must also be adjusted, if we want to take that route.

May I suggest a potential quick solution. Perhaps we could leave this up to
users by putting in an --amend or --reword option to cause a prompt for a
comment for the reverted commit instead of trying to come up with a
one-size-fits-all solution.

