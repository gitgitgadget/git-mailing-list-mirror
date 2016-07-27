Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 044911F855
	for <e@80x24.org>; Wed, 27 Jul 2016 21:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758715AbcG0V2z (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 17:28:55 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:33408 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758585AbcG0V2w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 17:28:52 -0400
Received: by mail-yw0-f195.google.com with SMTP id z8so4710557ywa.0
        for <git@vger.kernel.org>; Wed, 27 Jul 2016 14:28:51 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=8bnMdi6syiuqTm21RvxitP7NDzJq30YsIAfJcHEYnFg=;
        b=nZIpaFQ959FD2R+/w4bL+KZ+AtDW3GPUkklLTfHutUsrr3GMdQXYMbsjanLd0Pjupe
         PboaqAkJPhK/2x33pGR8n6aclytXPe8kGhFy5inOJ1u/QO4B+Yg69FUC1WS7i0SqQDyY
         E7+DE/hjNITenN5PzTdJgTDve9OVve+MZhsl6UEfFkuloQAyOQ4PEg5bfydKcR5WV2oR
         9gE6qI+8Iblnoyppc3uH5ltsHCFXdjfpcVxG/lBAeG8sKFCdTlJ+6O2iDXnGhVCVE/CV
         J2V7+qA3zPa5i2I/UP1+YV2qQPP280Pm9ALX57vDD8t0Xr7H4OVSt8VUbMJcH9xnIoDZ
         kQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=8bnMdi6syiuqTm21RvxitP7NDzJq30YsIAfJcHEYnFg=;
        b=BEJqtXIg1Y8Jql35mFHY4baEhv+MTEs8gxvxMB/+8af8mHH+KTqxfPvbhlNe+r2w3C
         N4K6tO2kjS30ux82wkI0fvSvidcIRwGluFJ7mYK5E8cHIgfqKzmJ2AEDkaB7o6JdQC7B
         S9gFnbwPQcpi9zWH5ihUWMhniXG6UjH8bFSSO+ih/h7uq53+6nUlAqHGh58JhMQc+DgX
         YHqaXPx2v3JpWsGHRNNLr9GXEoPEg/isr06fcjgp/Z8TmUHqH2ONtQl+pY8EzfeCSDuN
         va0ZhvDt6RjunPcyt+Qrqx1lPYMvGNdtiZxYg9OX7Na3zZhxUDXAYOCR3h3lwF1OOCgm
         hh5w==
X-Gm-Message-State: AEkoouvI4/wUtIgahON2mHMqscfsDztIhibyV+dKtugeaBpYzlMIavFkoFXl+R4h1mEy49u6JESp9EyMbRzSYw==
X-Received: by 10.129.82.130 with SMTP id g124mr27863670ywb.208.1469654931380;
 Wed, 27 Jul 2016 14:28:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.250.4 with HTTP; Wed, 27 Jul 2016 14:28:32 -0700 (PDT)
In-Reply-To: <20160727211338.GA20608@sigill.intra.peff.net>
References: <20160725184938.GA12871@sigill.intra.peff.net> <20160725185010.GA12974@sigill.intra.peff.net>
 <xmqqeg6h5w60.fsf@gitster.mtv.corp.google.com> <20160725214113.GA13589@sigill.intra.peff.net>
 <xmqqbn1l4c87.fsf@gitster.mtv.corp.google.com> <20160725221411.GA14131@sigill.intra.peff.net>
 <xmqqshuwyw14.fsf@gitster.mtv.corp.google.com> <20160726204851.GA22353@sigill.intra.peff.net>
 <xmqqr3agxep7.fsf@gitster.mtv.corp.google.com> <20160727211338.GA20608@sigill.intra.peff.net>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Wed, 27 Jul 2016 14:28:32 -0700
X-Google-Sender-Auth: QP28kAFPGtA2NtpNSSkxBJAJSpA
Message-ID: <CAPc5daWjNBazzVrH3jdgur2wC19upjM9A_pWp-u=tPUM_qaK0Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] pack-objects: break out of want_object loop early
To:	Jeff King <peff@peff.net>
Cc:	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 27, 2016 at 2:13 PM, Jeff King <peff@peff.net> wrote:
> ... But two is that I've
> wondered if we can do even better with a most-recently-used cache
> instead of the last_pack_found hack. So I'm trying to implement and
> measure that (both for this loop, and to see if it does better in
> find_pack_entry).

It is always delightful to hear a well constructed description of a
thought process. Thanks.

One thing that made me wonder was what would happen to the
last_found that is static to has_sha1_pack_kept_or_nonlocal()
funciton, when we invalidate the packed_git list, but within the
context of pack-objects it is not likely?
