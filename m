Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04D5C433EF
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 03:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EEE6608FE
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 03:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhKQDHC convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 16 Nov 2021 22:07:02 -0500
Received: from elephants.elehost.com ([216.66.27.132]:47877 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhKQDHC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 22:07:02 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 1AH33oNj079541
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 16 Nov 2021 22:03:51 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'brian m. carlson'" <sandals@crustytoothpaste.net>
Cc:     "'Jeff King'" <peff@peff.net>, <git@vger.kernel.org>
References: <20211116033542.3247094-1-sandals@crustytoothpaste.net> <20211116033542.3247094-2-sandals@crustytoothpaste.net> <YZPOzqU0UQDVA57R@coredump.intra.peff.net> <009d01d7db03$354ecae0$9fec60a0$@nexbridge.com> <YZQzqjWMzaWVkkfP@camp.crustytoothpaste.net> <00e001d7db40$985c61a0$c91524e0$@nexbridge.com> <YZRUzHVS32W4Flo/@camp.crustytoothpaste.net>
In-Reply-To: <YZRUzHVS32W4Flo/@camp.crustytoothpaste.net>
Subject: RE: [PATCH 1/2] wrapper: add a helper to generate numbers from a CSPRNG
Date:   Tue, 16 Nov 2021 22:03:45 -0500
Organization: Nexbridge Inc.
Message-ID: <010801d7db5f$bfb25330$3f16f990$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHRZsJQSwQVxvA803MGEaqTSKtEHwGUCvbjAr89fOoBugavkgK/mpqhAVhqoPgCDdPdaKuyWHOQ
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On November 16, 2021 8:03 PM, brian m. carlson wrote:
> On 2021-11-16 at 23:20:45, rsbecker@nexbridge.com wrote:
> > We do link with libcurl and use OpenSSL as a DLL to handle TLS. The
> > underlying random source for the nonstop-* configurations as of
> > OpenSSL 3.0 are PNRG supplied by the vendor (HPE) on ia64 and the
> > hardware rdrand* instructions on x86. I know that part of the OpenSSL
> > code rather intimately.
> 
> Great, as long as you don't define NO_OPENSSL, I think I can make this work
> with OpenSSL by calling RAND_bytes, which will use whatever OpenSSL uses.
> I'll work on that for a v2 to see if that will meet the needs for your platform,
> and if not, I'll try something else.
> 
> That should also have the pleasant side effect of making this more portable
> even for those people who do have less common platforms, since OpenSSL
> will likely be an option there.

I checked config.mak.uname. We should be fine with that qualification.

Regards,
Randall

