Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2617F1F453
	for <e@80x24.org>; Tue, 12 Feb 2019 13:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729954AbfBLN6V (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 08:58:21 -0500
Received: from elephants.elehost.com ([216.66.27.132]:59066 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbfBLN6V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 08:58:21 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x1CDwEMS053257
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 12 Feb 2019 08:58:15 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
References: <000901d4c0b1$1ea15160$5be3f420$@nexbridge.com>        <000a01d4c0b1$9ef9ea70$dcedbf50$@nexbridge.com>        <xmqqsgwugi21.fsf@gitster-ct.c.googlers.com>        <003501d4c253$05f16fd0$11d44f70$@nexbridge.com> <xmqqd0nxg1a1.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqd0nxg1a1.fsf@gitster-ct.c.googlers.com>
Subject: RE: [Proposed Fix] daemon.c: not initializing revents
Date:   Tue, 12 Feb 2019 08:58:08 -0500
Message-ID: <000201d4c2da$feff72c0$fcfe5840$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHuZCOJOJA2t83onwaMLThpXvGUrQHifX28AeBEHIIBi3XYZgGwiiadpXD2hCA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 11, 2019 21:59, Junio C Hamano wrote:
> "Randall S. Becker" <rsbecker@nexbridge.com> writes:
> 
> >> In any case, no matter what POSIX says, if clearing .revents before
> > calling
> >> poll() helps on platforms in the real world, the patch is worth
> >> taking as
> > a fix, I
> >> would think.
> >
> > That's what my intent was - my explanations are suffering from a
> > little work-induced sleep deprivation. Would you like this as a formal
> patch?
> 
> That depends ;-)
> 
> At this late in the cycle, I do not see much urgency for this patch to be
in the
> upcoming release (after all, this code survived real world for quite a
long
> time, so it's only minority platforms like NonStop that haven't seen
serious
> porting effort until recently that would see improvement---and they have
> survived without reliably working daemon for so long that they can wait
for
> one more release).
> 
> Now, the knowledge that we will have long enough time before the final
> version of the formal patch becomes necessary makes me wonder what the
> best use of that time to polish the patch would be.  Ideally we'd like to
see
> "this definitely fixed (or 'worked around') such and such breakages on
> platform X, Y and Z" instead of my "Well, we could read POSIX that way, so
> there may be some platforms that would require applications to do this,
and
> an extra assignment here would certainly not hurt", which was the hand-
> waving I just did.
> 
> I dunno.

I hear that. I'd rather (not) be working on debugging breakages from other
authors that impact my platform. Honestly, I'd rather work at my $DAYJOB,
although, some days...

Since this topic isn't a breakage per-se (no tests seem to be impacted on
way or another), I agree that this can wait and get through the normal cycle
of events at some point in the future. Now, if I could only get some help on
t5562 ;) that would be time well spent for rc0.

Cheers,
Randall

