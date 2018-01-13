Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 502661F404
	for <e@80x24.org>; Sat, 13 Jan 2018 19:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752360AbeAMTau convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sat, 13 Jan 2018 14:30:50 -0500
Received: from elephants.elehost.com ([216.66.27.132]:18602 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751026AbeAMTau (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jan 2018 14:30:50 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w0DJUjUV064321
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Sat, 13 Jan 2018 14:30:45 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
References: <003701d38c99$65657830$30306890$@nexbridge.com>
In-Reply-To: <003701d38c99$65657830$30306890$@nexbridge.com>
Subject: RE: Git 2.16.0-rc2 Test Summary on NonStop
Date:   Sat, 13 Jan 2018 14:30:40 -0500
Message-ID: <004701d38ca5$024dec30$06e9c490$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEB2xv+cjZHBANYZwQikwwCgD6UJqUVk3fQ
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 13, 2018 1:08 PM, I wrote:
> Here’s where things are. This is probably the best git release so far
(ever).
> After applying a4cdf02, I had 6 total breakages. 3 existing, 3 new.
> Many reduced. The test took about 24 hours to run on platform, which is
> about 2 hours shorter than 2.13.5.
> 
> t1308-config-set.sh (2 already discussed and expecting a fix, both appear
to
> be issues in the test script, not code) t1404-update-ref-errors.sh # 52 –
> reported but not discussed:
>    not ok 52 - delete fails cleanly if packed-refs file is locked.
>      The lock detection worked, but the test assumed the detection would
> occur in a different spot.
> t9001-send-email.sh (2 have existed for 2 years. 1 is new. We have not
used
> send-email on platform to this point).
>    not ok 31 - reject long lines
>      This is a new fail since 2.8.5
>   not ok 106 - sendemail.transferencoding=7bit fails on 8bit data
>      Still to be investigated. This may be a tooling issue on Platform.
>   not ok 107 - --transfer-encoding overrides sendemail.transferEncoding
>      Still to be investigated. This may be a tooling issue on Platform.

I missed one:
not ok 134 - --dump-aliases must be used alone
#
#               test_must_fail git send-email --dump-aliases
--to=janice@example
.com -1 refs/heads/accounting
#

This one has been around at least since 2.5.6.

