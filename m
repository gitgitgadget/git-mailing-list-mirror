Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8699EC433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 03:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E1BB61C12
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 03:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbhKQDIo convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 16 Nov 2021 22:08:44 -0500
Received: from elephants.elehost.com ([216.66.27.132]:12365 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbhKQDIn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 22:08:43 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 1AH35ZQY079587
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 16 Nov 2021 22:05:35 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Carlo Arenas'" <carenas@gmail.com>
Cc:     "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        "'Jeff King'" <peff@peff.net>, <git@vger.kernel.org>
References: <20211116033542.3247094-1-sandals@crustytoothpaste.net> <20211116033542.3247094-2-sandals@crustytoothpaste.net> <YZPOzqU0UQDVA57R@coredump.intra.peff.net> <009d01d7db03$354ecae0$9fec60a0$@nexbridge.com> <YZQzqjWMzaWVkkfP@camp.crustytoothpaste.net> <00e001d7db40$985c61a0$c91524e0$@nexbridge.com> <CAPUEsphYqg4rvvrODL9yYCeL7wkjyR0RcEVaZiYQHy_2D1-oxg@mail.gmail.com>
In-Reply-To: <CAPUEsphYqg4rvvrODL9yYCeL7wkjyR0RcEVaZiYQHy_2D1-oxg@mail.gmail.com>
Subject: RE: [PATCH 1/2] wrapper: add a helper to generate numbers from a CSPRNG
Date:   Tue, 16 Nov 2021 22:05:29 -0500
Organization: Nexbridge Inc.
Message-ID: <010901d7db5f$fdb4f570$f91ee050$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHRZsJQSwQVxvA803MGEaqTSKtEHwGUCvbjAr89fOoBugavkgK/mpqhAVhqoPgBGcrmzau5+TTQ
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On November 16, 2021 7:48 PM, Carlo Arenas wrote:
> On Tue, Nov 16, 2021 at 4:01 PM <rsbecker@nexbridge.com> wrote:
> >
> > We do link with libcurl and use OpenSSL as a DLL to handle TLS. The
> underlying random source for the nonstop-* configurations as of OpenSSL
> 3.0 are PNRG supplied by the vendor (HPE) on ia64 and the hardware
> rdrand* instructions on x86. I know that part of the OpenSSL code rather
> intimately.
> 
> Older versions of OpenSSL exported (AFAIK) a usable version of
> arc4random_buf() that could have helped here; it seems to still be there in
> libressl[1] which is mostly API compatible and might be worth looking into
> IMHO even if as you pointed out will need an implementation similar to what
> OpenSSL does internally.
> 
> [1] https://cvsweb.openbsd.org/src/lib/libcrypto/arc4random/

I do not see arc4random being used in our builds going back to OpenSSL 1.0.2, which is as far back as I go anyway.

