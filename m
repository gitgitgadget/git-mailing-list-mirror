Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC75C1F45A
	for <e@80x24.org>; Fri, 16 Aug 2019 22:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfHPWW3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Aug 2019 18:22:29 -0400
Received: from elephants.elehost.com ([216.66.27.132]:48970 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727724AbfHPWW3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Aug 2019 18:22:29 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x7GMMOso035539
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Fri, 16 Aug 2019 18:22:25 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
Subject: [RFE] Teach hash-object to be able to choose signature types
Date:   Fri, 16 Aug 2019 18:22:17 -0400
Message-ID: <009c01d55481$13d3ce20$3b7b6a60$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdVUgC/jpXb392b1RwepquCHz4p8Qg==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All,

I do not know whether this would be a good enhancement or micro project for
someone (maybe me) to take on, but I'm wondering whether it might be a good
idea to provide an option to hash-object to select the signature being
computed. The use case begins when someone computes an object signature and
stores a pre-converted SHA1 value. Then the repository is changed over to
SHA256. When hash-object is next called, perhaps in a different clone or
some other "next" scenario, the new signature will be SHA256, if I
understand this correctly, and from the perspective of the someone in the
use case, the signature mismatches.

What I am proposing is an option like --signature-type=SHA1|SHA256 or
similar as an option to hash-object to allow the non-default signature to be
selected explicitly. This is not entirely trivial looking through the code
and presumably would require either teaching hash_object_file_literally or
having a separate method to do the alternate calculation.

Thoughts?
Regards,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



