Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E328E1F453
	for <e@80x24.org>; Sun, 10 Feb 2019 19:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbfBJTTp convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 10 Feb 2019 14:19:45 -0500
Received: from elephants.elehost.com ([216.66.27.132]:21492 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfBJTTo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Feb 2019 14:19:44 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x1AJJOJC033064
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 10 Feb 2019 14:19:24 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Eric Sunshine'" <sunshine@sunshineco.us>,
        <randall.s.becker@rogers.com>
Cc:     "'Git List'" <git@vger.kernel.org>,
        "'Junio C Hamano'" <gitster@pobox.com>,
        "'Jeff King'" <peff@peff.net>,
        "'brian m. carlson'" <sandals@crustytoothpaste.net>
References: <20190209185930.5256-1-randall.s.becker@rogers.com> <20190209185930.5256-2-randall.s.becker@rogers.com> <CAPig+cRARdkKN-wR4EzVSzxuK51VOPf-kFFG57kkEsnFBfe4TA@mail.gmail.com>
In-Reply-To: <CAPig+cRARdkKN-wR4EzVSzxuK51VOPf-kFFG57kkEsnFBfe4TA@mail.gmail.com>
Subject: RE: [Patch v1 1/3] test-lib-functions.sh: add generate_zero_bytes function
Date:   Sun, 10 Feb 2019 14:19:19 -0500
Message-ID: <001201d4c175$88aa8d00$99ffa700$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQGM7GjkJQPJw2ZzFceglcz2DqNUWwDZJf6DAflb4NymUnwLsA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 9, 2019 21:05, Eric Sunshine wrote:
> On Sat, Feb 9, 2019 at 1:59 PM <randall.s.becker@rogers.com> wrote:
> > t5318 and t5562 used /dev/zero, which is not portable. This function
> > provides both a fixed block of NUL bytes and an infinite stream of NULs.
> >
> > Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> > ---
> > diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh @@
> > -116,6 +116,19 @@ remove_cr () {
> > +# Generate an output of $1 bytes of all zeroes (NULs, not ASCII zeroes).
> > +# If $1 is 'infinity', output forever or until the receiving pipe
> > +stops reading, # whichever comes first.
> 
> This is a somewhat unusual API. A (perhaps) more intuitive behavior would be
> for it to emit an infinite stream of NULs when given no argument, and a
> limited number of NULs when given an argument.
> Redefining the behavior like that also fixes the "problem" with the current
> implementation erroring-out if no argument is provided.

At this point, I've supplied three different ways to solve this incompatibility for platforms not Linux and others have also provided fixes and discussed this at length. It is not a specific fix that matters to me, but that there is a fix at all. So thanks for all your comments and I will wait on direction on what the team wants me to do about it, if anything.

Regards,
Randall

