Return-Path: <SRS0=XbPV=A4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB465C433E2
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 21:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E21220775
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 21:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgGQVVZ convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 17 Jul 2020 17:21:25 -0400
Received: from elephants.elehost.com ([216.66.27.132]:60797 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgGQVVY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jul 2020 17:21:24 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [173.32.57.223])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 06HLLJkK042420
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 17 Jul 2020 17:21:20 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
References: <xmqqv9ildh46.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqv9ildh46.fsf@gitster.c.googlers.com>
Subject: RE: [ANNOUNCE] Git v2.28.0-rc1
Date:   Fri, 17 Jul 2020 17:21:10 -0400
Message-ID: <00d001d65c80$3519c960$9f4d5c20$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQJqtZpURTMUnHUe8X62Ipjt5O1rRqfjkXcQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On July 17, 2020 4:25 PM, Junio C Hamano Wrote:
> A release candidate Git v2.28.0-rc1 is now available for testing at the usual
> places.  It is comprised of 295 non-merge commits since v2.27.0, contributed
> by 43 people, 10 of which are new faces.

The prior commit just before this one, and the rc0 commit both failed t3200.93 and t3200.97 on NonStop. This looks like a recurrence if the situation where a test was written assuming a specific error message that is different on the NonStop platform. The error in both causes is expecting "could not lock config file .git/config: File exists" which is not what the system reports. The strerror proc reports "File already exists".

A similar situation was previously discussed as part of fixes to t1901 (https://public-inbox.org/git/020c01d5f880$1cf7c580$56e75080$@nexbridge.com/#r in the mail archive.

Sincerely,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



