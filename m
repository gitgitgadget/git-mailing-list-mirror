Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22EB21F453
	for <e@80x24.org>; Sat, 16 Feb 2019 18:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfBPSYh convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sat, 16 Feb 2019 13:24:37 -0500
Received: from elephants.elehost.com ([216.66.27.132]:18021 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbfBPSYh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Feb 2019 13:24:37 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x1GIOSH5016619
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 16 Feb 2019 13:24:29 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     "'Max Kirillov'" <max@max630.net>,
        "=?utf-8?Q?'SZEDER_G=C3=A1bor'?=" <szeder.dev@gmail.com>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        <git@vger.kernel.org>
References: <001201d4c617$de429540$9ac7bfc0$@nexbridge.com> <xmqqftsn4nik.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqftsn4nik.fsf@gitster-ct.c.googlers.com>
Subject: RE: [ANNOUNCE] Git v2.21.0-rc1 (NonStop Results) - Good News
Date:   Sat, 16 Feb 2019 13:24:23 -0500
Message-ID: <000001d4c624$da8e05d0$8faa1170$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFycQzmW9pNbu02MZcMspejNiBnQQDz28D8pp/H1RA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 16, 2019 13:06, Junio C Hamano wrote:
> "Randall S. Becker" <rsbecker@nexbridge.com> writes:
> > On February 16, 2019 3:27, Max Kirillov wrote:
> >> What you could try is
> >> https://public-inbox.org/git/20181124093719.10705-1-
> max@max630.net/
> >> (I'm not sure it would not conflict by now), this would remove
> >> dependency between tests. If it helps it would be very valuable
> information.
> >
> > Good news. This patch does seem to do the trick. I wonder whether this
> > fixes the Azure build also.
> >
> > I have run the test under the following conditions:
> > Run 1 (system idle): Pass
> > Run 2 (system idle): Pass
> > Run 3 (system idle): Pass
> > Run 4 (system idle): Pass
> > Run 5 (system idle): Pass
> > Run 6 (system mild load, heavy file system): Pass Run 7 (system mild
> > load, moderate file system load - git fetch): Pass Run 8 (heavy system
> > load, heavy file system load): Pass Run 9 (--verbose, heavy system
> > load, heavy file system load): Pass Run 10 (GIT_TRACE=true, --verbose,
> > heavy system load, heavy file system
> > load): Pass
> > Run 11 (very heavy system load, very heavy file system load): Pass
> 
> That indeed is a good news.
> 
> > The current condition of the code is (the generate_zero_bytes delete
> > was previously removed so can be ignored for the patch):
> 
> Just to make sure I do not misunderstand, this result is with Max's patch but
> without the generate_zero_bytes stuff?

Correct.

> Thanks, all.  Hopefully we can get this test failures behind us before -rc2;
> knock, knock...

Once the fix is integrated and in the usual spots, I can verify with haste. The full test cycle is now at 50 hours (argh), which I will rerun in full at rc2, but this one is fast.

