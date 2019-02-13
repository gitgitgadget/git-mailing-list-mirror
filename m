Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABA0B1F453
	for <e@80x24.org>; Wed, 13 Feb 2019 21:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394693AbfBMVDl (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 16:03:41 -0500
Received: from elephants.elehost.com ([216.66.27.132]:28640 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfBMVDl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 16:03:41 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x1DL3bev051663
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 13 Feb 2019 16:03:37 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     "'Eric Sunshine'" <sunshine@sunshineco.us>,
        "'Git List'" <git@vger.kernel.org>
References: <20190209185930.5256-1-randall.s.becker@rogers.com>        <20190209185930.5256-3-randall.s.becker@rogers.com>        <CAPig+cTMoYMmnHVuay_4RGr_FN-HWC1tN4TPDsNM4vKCH3GzXw@mail.gmail.com>        <xmqqh8d9diy8.fsf@gitster-ct.c.googlers.com>        <xmqqh8d7d2ij.fsf@gitster-ct.c.googlers.com>        <004701d4c3c8$8a018d20$9e04a760$@nexbridge.com> <xmqqr2cbbdz6.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqr2cbbdz6.fsf@gitster-ct.c.googlers.com>
Subject: RE: [Patch v1 2/3] t5318: replace use of /dev/zero with generate_zero_bytes
Date:   Wed, 13 Feb 2019 16:03:30 -0500
Message-ID: <009101d4c3df$9616d8b0$c2448a10$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGM7GjkJQPJw2ZzFceglcz2DqNUWwGXJak9AdRbyOoBXWggQALkfM5xAcL2hxcBMTM6WKYY2XEQ
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 13, 2019 16:01, Junio C Hamano wrote:
> "Randall S. Becker" <rsbecker@nexbridge.com> writes:
> 
> > My second attempt was to create the generate_zero_bytes function to
> > replace exactly what the second dd was doing but not user /dev/zero.
> 
> Yes, and I think the patch does that ;-)  It was just the original
> 
>     dd if=/dev/zero of=... bs=1 seek=$there count=$this_many
> 
> would have been impossible to rewrite with the new generate_zero_bytes
> helper unless $there weren't seeking to the end of the file.
> 
> But the other dd before the one the patch rewrites truncates the file to
make
> that seek=$there seeking to the end of the file, so simply appending
output
> from genereate_zero_bytes is sufficient and correct conversion.  I wanted
to
> explain that for future readers who may wonder if the patch is doing the
> exact conversion.

Sounds like we need a documentation patch in the actual test suite rather
than in the commit <ducking>.

Cheers,
Randall


