Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 033631F453
	for <e@80x24.org>; Wed, 13 Feb 2019 17:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390704AbfBMRlA (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 12:41:00 -0500
Received: from p3plsmtpa06-06.prod.phx3.secureserver.net ([173.201.192.107]:52160
        "EHLO p3plsmtpa06-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393339AbfBMRk7 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 Feb 2019 12:40:59 -0500
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id tyWlg6lHwdWGrtyWngcXlF; Wed, 13 Feb 2019 10:40:59 -0700
Date:   Wed, 13 Feb 2019 19:40:55 +0200
From:   Max Kirillov <max@max630.net>
To:     randall.s.becker@rogers.com
Cc:     'Git List' <git@vger.kernel.org>, max@max630.net
Subject: Re: [BUG] More on t5562 hangs randomly in subtests 6,8 and 13 in
 2.21.0-rc0
Message-ID: <20190213174055.GD3064@jessie.local>
References: <000501d4c3af$1748b100$45da1300$@rogers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000501d4c3af$1748b100$45da1300$@rogers.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CMAE-Envelope: MS4wfDs3XY/lPgHXU0yRuqTlGW1yc4k7pOhW6rEzKWx2FOGR3xnrwo9Eg3NpppaT+HW3Q24zoHP2TaBsPjN6GoPB0H2Df1MbJKKzp8N+QtNhmM69wE+5wmTT
 jVajBwnyGQ9yT6BjR6FhAREYKcBV1AxpMy906BsRLCayiT1GhJzvnUFomE24REbwBFVeOrdnvfMpjpn9dDNFNxJshEQRsgHxOfwZfxofIRuHbl5wPETPAAR0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 13, 2019 at 10:16:26AM -0500, randall.s.becker@rogers.com wrote:
> On 2019-02-13, Max Kirillov, wrote:
> As far as the unintended reuse of the output file, and issues with pipes,
> yes, the NonStop is very sensitive to complex use of pipes and much of the
> compatibility issues we have had relate to those (usually Linux-specific
> pipe assumptions). That is where I have been looking when trying to debug
> this situation (not yet found anything). This could very well be directly
> related.

You mentioned cases 6,8,13. These are all related to gipped
request body. Could it be the git-http-backend does not
clean a sub-process which pervforms the decompression?
