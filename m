Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 448A020954
	for <e@80x24.org>; Wed, 22 Nov 2017 21:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751438AbdKVVmi (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 16:42:38 -0500
Received: from mail-io0-f178.google.com ([209.85.223.178]:41182 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751260AbdKVVmh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 16:42:37 -0500
Received: by mail-io0-f178.google.com with SMTP id g73so24640825ioj.8
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 13:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=S1I22nGBixZelyuR9mgsxg4Do1CJ6nqFD0aHyvACvH4=;
        b=XmQGckujO8ekplhDnBnwI7x5liD5jhlbyAZ9lM1TLl+c4wjRr1Vnk22i9qd5FaO8I5
         DMn1D9x7IfUp2DyXSRol+AN5jkh0MtIBVl3eRa5i8sfYIZDRim2iuMu1QKhW0EURAdN4
         yvO3TLdwPLa/7bU3E3Z6rojT/MsX1jnOStKGyxjwKqjtlbOA1V5oUDe8ZfFvlgPoTZYR
         UWWVpNNDOT3A5XNgAVaoJnzAAzFYurxNHfKaZK/wwJQTFsoA63lx/0f3bgti76MyoC2q
         ZpHewWT+2dQk0n7gTzoPhMefcifHvyWDXE0sBrd0/0iybvyVSRD1pXaHgp0TsIEccEPE
         2E0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=S1I22nGBixZelyuR9mgsxg4Do1CJ6nqFD0aHyvACvH4=;
        b=fDH0u9u+aIfJSmV4bsTr2ijygxT1Hvnwb+likrCNmKoEeSCEit4uLF9Ogou+CSrOgU
         IbUPKqDfSmnOtJYtWviSEUmITDrFGrZVbR7gGh/GS+SaA7NbGU06zutEv6WGhdkafhhd
         6SB7w+7Iv7/FFhAXBN+rDfcKoN7dFZl0MFtICjs68DetYHId9kJC/Q2HAbj7IthghBLn
         4me+wCR1l0FOMv3HCSwOlogE3v/R7GF0avpabk/aMNs9qh1eJ0g5Gyb1O0TXcHyu1cCb
         sdixRPfIA6xpIUhbT1frLVUkPPSj/3TGL4WhEZLHYeper4SCsN4Z6iMPlIK5MHjxgtd/
         20Qw==
X-Gm-Message-State: AJaThX7Nl6Y0lzPmNkU3MUDqgnH4IdvvxOAdpI3bEGdGg+OzvezJtGsh
        wDUaaSvyODXokRdkQJGvgLwFeSYCGUgJEfmUOHkX5cZB0U8=
X-Google-Smtp-Source: AGs4zMbIlnnnzzEZtmtE54jJWFjbaNoJESZk6EzYIc9aI11ek66rNqmlVTKg98BbyKE4gUlW9BZw7bbdPBNAQMK9vzk=
X-Received: by 10.107.16.206 with SMTP id 75mr1899569ioq.83.1511386956656;
 Wed, 22 Nov 2017 13:42:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.131.10 with HTTP; Wed, 22 Nov 2017 13:42:36 -0800 (PST)
In-Reply-To: <20171122100014.937f5902c3714e6e26e20a1b@google.com>
References: <20171121210720.21376-1-git@jeffhostetler.com> <xmqqy3myubpi.fsf@gitster.mtv.corp.google.com>
 <20171122100014.937f5902c3714e6e26e20a1b@google.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Date:   Wed, 22 Nov 2017 13:42:36 -0800
Message-ID: <CAGf8dg+UQ7eRxcBNJkzr_tZFMYxO-z4Z5Emi1HefEhtqJebe6Q@mail.gmail.com>
Subject: Re: [PATCH v5 00/10] Partial clone part 2: fsck and promisors
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Git mailing list <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 22, 2017 at 10:00 AM, Jonathan Tan <jonathantanmy@google.com> wrote:
> On Wed, 22 Nov 2017 14:25:13 +0900
> Junio C Hamano <gitster@pobox.com> wrote:
>
>> Thanks, will replace/queue all three series.  I am getting a feeling
>> that the first one is already ready for 'next', while the other two
>> may want to see a bit more comments?
>
> Yes, I think so too.
>
> Jeff Hostetler and I noticed some issues occuring when some other Git
> commands dynamically fetch objects due to the fact that those commands
> and fetch-pack use overlapping object flags. At the very least, we
> should look at that before it goes into next.

In the end, making fetch-pack refrain from setting object flags when
being used to dynamically fetch objects works (see the new "introduce
fetch-object: fetch one promisor object" commit that I just pushed to
[1]). I'll coordinate with Jeff Hostetler about sending v6 to the list
(most likely after the U.S. Thanksgiving holidays).

[1] https://github.com/jonathantanmy/git/commits/pc20171122
