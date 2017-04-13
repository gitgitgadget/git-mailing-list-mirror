Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79DED20970
	for <e@80x24.org>; Thu, 13 Apr 2017 07:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756099AbdDMHVb (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 03:21:31 -0400
Received: from mail-lf0-f42.google.com ([209.85.215.42]:34745 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753286AbdDMHV3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 03:21:29 -0400
Received: by mail-lf0-f42.google.com with SMTP id t144so25298226lff.1
        for <git@vger.kernel.org>; Thu, 13 Apr 2017 00:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AD1fRxY5ro+/EL0cwfWSmBMXDETUiAHa/gW23+8/KNM=;
        b=komwSBROSc+iipWkCemRDcqubBxOAjEF1B3xezEMTivUZ6KsSOfs1UNwu1NWWkeF8w
         NAD4r5n39nKg4dOIfW3ufSqST6k1lzHzgQqT0MtpgqtcF/sTU1OwmbHb8mp6O+stMKYg
         z+D2UVJZ3Iaq3CWEKcP5/uqImdm383YOi5HH3zm9dTcRgHcxzm+rAWSmJrJ4EcxIFsAJ
         wrWAaNGtbSwoIhuH24nrWlE49F4rK5TnbBckiSu8ZXgGf3hOWMT2dwtDSJ0lXK80xmoM
         oAppxHl/zHL2Xogv1Vxo0aE4G4AkQi4mSR7dcmvbsiFJ5TNvWU4bTM7OP6hA64KI3WEn
         Gr0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AD1fRxY5ro+/EL0cwfWSmBMXDETUiAHa/gW23+8/KNM=;
        b=Ua7qMcTvAwdAzJSOeXJb9xX/t0eIqbzp2p+9Tt81Cth6YHavrlLXL7UvMDSJKcJNzW
         grjnhr8khIpTdRIHWkWs5ycJ+EsRrBSHHA+kjFvlcxk1FAJo9B5nRKlh6Na7Nl+Bcl6q
         MWJuGfXTbUnW2BKzy3CJ/Ckajkzysf4/D2JtUtxTlGHVa+S0CmV1xgWw8zjdpSdPDtL2
         l4mi94BGJXUpRqXYQYQelOtvDdRP3iMW7llB/kDLjuBa29fzchskTQXWR4RMFLNS0XTX
         kOEq5kXk4LnbPd4OJbHEwVC2SRvhoUbQLpCXys9Hu50179H5FCuMB0YO8HPwNyswovw2
         ZR8A==
X-Gm-Message-State: AN3rC/57pZE4fIWHKMlbC1eQmULo5V6cS6KTm/645Tgl09oBQ6kNmVjx
        9sE4QJAl42hBRGLwwfnGNjBykZTOB0TM
X-Received: by 10.25.100.5 with SMTP id y5mr579884lfb.58.1492068088378; Thu,
 13 Apr 2017 00:21:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.17.155 with HTTP; Thu, 13 Apr 2017 00:21:07 -0700 (PDT)
In-Reply-To: <xmqqmvbkq1nn.fsf@gitster.mtv.corp.google.com>
References: <2c3c8028cd057428758bb1e21a064a264936de90.1490968428.git.git@grubix.eu>
 <xmqq8tnlz53m.fsf@gitster.mtv.corp.google.com> <CA+P7+xr37owZbCnwVKh0y_vUny9_pP380Y8sFA+7A-hv0Oc6AA@mail.gmail.com>
 <xmqqmvbkq1nn.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 13 Apr 2017 00:21:07 -0700
Message-ID: <CA+P7+xrCbMrun4TZtAniBY5ehObrcYHtL3XYycMaJiT0EJ9fmA@mail.gmail.com>
Subject: Re: [PATCH] status: show in-progress info for short status
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael J Gruber <git@grubix.eu>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 12, 2017 at 11:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>> Personally, I would want this to become the default and not have a new
>> option to trigger it. I think we could also extend the porcelain
>> format to include this information as well, but I'm not too familiar
>> with how the v2 format extends or not.
>
> I think the general rule of thumb for --porcelain is that we can
> freely introduce new record types without version bump, and expect
> the reading scripts to ignore unrecognised records (we may need to
> describe this a bit more strongly in our document, though), while
> changes to the format of existing records must require a command
> line option that cannot be turned on by default with configuration
> (or a version bump, if you want to change the output format by
> default).
>
> I am getting the impression that this "we are doing X" is a new and
> discinct record type that existing readers can safely ignore?  If
> that is the case, it may be better to add it without making it
> optional.

I think we are safe in extending porcelain v2.

Thanks,
Jake
