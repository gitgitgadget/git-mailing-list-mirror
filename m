Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BDFB1F462
	for <e@80x24.org>; Sun,  2 Jun 2019 14:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbfFBO17 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 2 Jun 2019 10:27:59 -0400
Received: from elephants.elehost.com ([216.66.27.132]:13163 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfFBO17 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Jun 2019 10:27:59 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x52ERr9Q089668
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 2 Jun 2019 10:27:54 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
References: <xmqqpnnzws9q.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqpnnzws9q.fsf@gitster-ct.c.googlers.com>
Subject: RE: [ANNOUNCE] Git v2.22.0-rc2
Date:   Sun, 2 Jun 2019 10:27:46 -0400
Message-ID: <005f01d5194f$5cb08240$161186c0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQI9ewXcnn13ik5Raf3QyvarMXUJiaW03CAw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just a few small nits from RC2 test results on the NonStop TNS/E platform:

1. t0021 subtest 15 is being flakey. It fails on the first run (make -k test) but succeeds when run in isolation. This is new on the NonStop TNS/E platform. t0021 has been a bit flakey in the past, but not recently. Just thought I'd mention it. It's only slightly disconcerting because I make very heavy use of smudge filters but since it runs fine in isolation, I'm going to assume it is fine. We had one unsubstantiated report of an occasional misfire of smudge filters, but no substantive evidence at this point to reproduce the situation.

2. t7519 subtest 25 still does not pass (previously reported for RC1) when run via "make -k test" the first time. This runs successfully when run in isolation or the second time.

3. t9001, t9020, t9600, t9601, t9602, t9604, fail, but should not run on platform (not new, just a reminder). We do not have sendmail or subversion.

So it looks like we're a go on RC2 on NonStop.

Thanks,
Randall

