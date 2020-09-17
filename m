Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFD9C433E2
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 14:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A451206DB
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 14:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbgIQObA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 10:31:00 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:52087 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbgIQOac (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 10:30:32 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MwjO6-1kge2u0RUg-00y8yA; Thu, 17 Sep 2020 15:35:26 +0200
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id 8912B1E01E7;
        Thu, 17 Sep 2020 13:35:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RZXCxGrj26Pr; Thu, 17 Sep 2020 15:35:25 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (unknown [10.10.5.94])
        by mail.cetitecgmbh.com (Postfix) with ESMTPSA id 5D13A1E01E6;
        Thu, 17 Sep 2020 15:35:25 +0200 (CEST)
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id 348FD8051A; Thu, 17 Sep 2020 15:35:25 +0200 (CEST)
Date:   Thu, 17 Sep 2020 15:35:25 +0200
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Config option to set the transport protocol version for
 network fetches
Message-ID: <20200917133525.GE8079@pflmari>
References: <20200916200203.GA37225@coredump.intra.peff.net>
 <20200917132047.GA14771@pflmari>
 <20200917133153.GA3038002@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917133153.GA3038002@coredump.intra.peff.net>
X-Provags-ID: V03:K1:9Cwgwi9FY7i3O/AF15pOl89r8TLIq2ZrPEJSlnHE4d1E1W2i2Pz
 hXuNStUkgYQOJeuG2VzxXLC6pjDVaZq5jqgzKG7BSufQ3LCGk1uns8fZrEBZFHi+CVpFLbj
 mFQ3cl1ZmkJ+7dg+I75Dyu0EZ2YjhQ+ntbsdPvIdNqT3obr6yGOXbsmXFY1KBfv8gHYcFTm
 cOdzDV4gMv7yFhYznUAEg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ofy9UbhtMxs=:kubBQMoCx9i69RzUq1YNrn
 p8G0kh9uc0H+1Q20c5n/pW383XlfT4H1swkObuM53QmNxAfxrFvIy71J1NVqS26KEO1y3LISw
 9TSvxLW5V0BB/gE2STKpOBAhamI4dCDExfCS4MFILCaA5MM2vsMs8/ya6oH9w7nFnPYnkmNbm
 LJPua2JpFpjuSrFMa66vXkMn+FKLGSwnPDMe5oRKzRJZ9Ssn9MPhbEAtHeMKNkmRnobM6EfTf
 C0yCGaNYRcksJyLQ+D1pAQBY9iWvMVdVZgiyogCgjzr02TVHy3+mIFxDPaearM1BmoECId8E4
 Yf9TkxyeLp4ZbeG0yg9+BtpqmkkQT8VRAvADpRGIc3cSr+tX1zN6OLXZggCz9o0ipu64RH/tL
 rI63Rh2iTO2G/Itj4+XoiXQKbplBX7xV48PMt7v2IdeGqLzqTUQHCOTcaJUiOCLdaDdr0N0yI
 l2OYDhG1+putTLY8OHLoHD+lhaWnqlFOjgS0yEP/lDO5r66rVFd7uXft2MB8Fa9MwFaWIO8hn
 VHeMhtUJATkpntJE9Ja+PQ8+igcQH1PRtqH07wuxtBJwP2jZuYhcpMLtRGnTf7n+D2kiuvoBf
 OVHsX9VNiXRaWKtUrfOe9Qn16ZyUzrbW5cNruCrKGpGBJTCf9HmUuVH8nVE/PAUhfWYLs2Jx2
 KSyozZ5PS/U7Iz1rmVXYELqH5sKz33ssr58sQ+9oMH4W8EwhYKApwC1pb0rnVpcC4WH7Mj6MH
 kzTVbgXd+y0E5QHMBWBLLIrvPCFnvJgLTVMR00imljR4DMBwrqcWWf5eBsafuy7WIvskw1OMh
 SumvxD1R2r/DfWB7yZVgOb9o2JmIWUb+KOaOZs+UFBwTb/E27fN9BHRCKWkT4i/NU2tyWLQTk
 T1PrYSMX3gk9O4YowxBA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King, Thu, Sep 17, 2020 15:31:53 +0200:
> On Thu, Sep 17, 2020 at 03:20:47PM +0200, Alex Riesen wrote:
> 
> > Affecting the transfers initiated by fetch and push,
> > the option allows to control network operations similar
> > to --ipv4 and --ipv6 options.
> > 
> > Suggested-by: Jeff King <peff@peff.net>
> > Signed-off-by: Alex Riesen <alexander.riesen@cetitec.com>
> 
> I think this misses some of the excellent suggestions from Junio
> (naming, and the ability to override from the command line).

It does, sorry. Also the suggestions to the issue of consistently passing the
options to helper programs haven't been collected.
Haven't had the time yet.

