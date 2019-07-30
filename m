Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B9201F462
	for <e@80x24.org>; Tue, 30 Jul 2019 20:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbfG3U1u convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 30 Jul 2019 16:27:50 -0400
Received: from elephants.elehost.com ([216.66.27.132]:63728 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728006AbfG3U1u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 16:27:50 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x6UKRdKg031397
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 16:27:39 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Todd Zullinger'" <tmz@pobox.com>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Christian Couder'" <chriscool@tuxfamily.org>,
        "=?iso-8859-1?Q?'SZEDER_G=E1bor'?=" <szeder.dev@gmail.com>,
        "'Jeff King'" <peff@peff.net>, <git@vger.kernel.org>,
        <git-packagers@googlegroups.com>
References: <049a01d546f9$70be7a30$523b6e90$@nexbridge.com> <20190730194938.GZ4545@pobox.com>
In-Reply-To: <20190730194938.GZ4545@pobox.com>
Subject: RE: [ANNOUNCE] Git v2.23.0-rc0 - Initial test failures on NonStop
Date:   Tue, 30 Jul 2019 16:27:33 -0400
Message-ID: <04b301d54715$3b371a90$b1a54fb0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIOLVcRtBsBNXlmTtIvSwfiR5E4KQH9jAfxpmHjAuA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On July 30, 2019 3:50 PM, Todd Zullinger wrote:
> To: Randall S. Becker <rsbecker@nexbridge.com>
> Cc: 'Junio C Hamano' <gitster@pobox.com>; Christian Couder
> <chriscool@tuxfamily.org>; SZEDER Gábor <szeder.dev@gmail.com>; Jeff
> King <peff@peff.net>; git@vger.kernel.org; git-
> packagers@googlegroups.com
> Subject: Re: [ANNOUNCE] Git v2.23.0-rc0 - Initial test failures on NonStop
> 
> Hi,
> 
> [added Christian, SZEDER, and Jeff to Cc as author and helpers on the
newly-
> added t0016-oidmap]
> 
> Randall S. Becker wrote:
> > A preview of the situation with testing 2.23.0.rc0 on NonStop is not
> > great. We have had some new failures right off the bat on our NonStop
> > platforms. This is a preview of what we find within the first bit of
> > testing. The tests run a long time, so more to come.
> >
> > t0016: oidmap
> >
> > Subtest 6 had an ordering issue. We do not know whether the problem is
> > the code or the test result not keeping up with the code changes.
> >
> > --- expect      2019-07-30 16:56:36 +0000
> > +++ actual      2019-07-30 16:56:36 +0000
> > @@ -1,6 +1,6 @@
> >  NULL
> >  NULL
> >  NULL
> > +7c7cd714e262561f73f3079dfca4e8724682ac21 3
> >  139b20d8e6c5b496de61f033f642d0e3dbff528d 2
> >  d79ce1670bdcb76e6d1da2ae095e890ccb326ae9 1
> > -7c7cd714e262561f73f3079dfca4e8724682ac21 3
> 
> I hit the same failure while building for Fedora on the s390x
architecture.  I
> have not dug into it much yet, but perhaps this is an endianess issue?

My platforms are BIGendian, so perhaps that's it. The bucket calculation
uses bit arithmetic so that could contribute.

