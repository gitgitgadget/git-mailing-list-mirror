Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89DEC1FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 22:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753837AbcHWWAU (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 18:00:20 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:36488 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753198AbcHWWAU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 18:00:20 -0400
Received: by mail-yb0-f196.google.com with SMTP id f60so2890400ybi.3
        for <git@vger.kernel.org>; Tue, 23 Aug 2016 15:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=55ePugXQFOXAFSP6OutQufJzlq/eh8siaPIkGp/8b5c=;
        b=E8Hxr1z6HzBJoUAEkHDi0HZ4mDf9LoAhePzhf4B7tS4n/hNyk9w7R1dXbsidJDAu4j
         OsTcVnwBAFAMOlnekXWk5I/VIpe4LFvwyLjV1bTiTmcgUhb89tS86fA/B0Vxs5BOg5me
         JjxMA5DanfdHQhnyUKITSuH4nZNGCtcHL8gB7bTydaBonxxZad0MBTQplLSkGwI3xh7V
         GOq4C+SzMvumGnR/1Z1mF/9q8U2L4AXaTTgfXv2w0uBi2I4FsM43YFv09Rk38Ix5k+tT
         ZAAVy4Yp0Dhefh+oysf9q4OXE26nEcScW5A2prr/yJddTmO6BPLM9SJ0d+psR0dhmsX2
         pyKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=55ePugXQFOXAFSP6OutQufJzlq/eh8siaPIkGp/8b5c=;
        b=A/BHEEOO8D+PSyxWmiNM09jqi34XWcztdwqoz242sniBFzMB78XZaObF7zdSFQbrdj
         6640f7iHB5EGKKOcp8W5/cWB4/WKMMOqnmP0HRYk6S3QARKGVvZnY0G2SM8lWm1BUUnn
         u0hyZCafG5qxCY5uii1kwKjXGbmCIPJK0jl7HS7cbWVK0l0qxpCH6FGUbFi/zuY0ZsEK
         NwFoOF06iqj88hsfc3tVbdP7O2ow8WcsC3uaizgcShqaG4oPPYsVlQbx5jmYsnBkJhVk
         DBe8SgNf8qE3dEHia34e5ESY8PB5VEP987nWHfhjnzz0EVcL2IK8Xl+/tielQeheiN5L
         rajQ==
X-Gm-Message-State: AEkoout5JrSe1XcOthxYSDaD53xsGxxejR49FmT+FdJMIl5uk2gm6RWCDbEsVRbYgZcpw3W4cZzTXA3/xiKpmg==
X-Received: by 10.37.96.10 with SMTP id u10mr23307744ybb.7.1471986454584; Tue,
 23 Aug 2016 14:07:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.89.132 with HTTP; Tue, 23 Aug 2016 14:07:34 -0700 (PDT)
In-Reply-To: <xmqqmvk3ut4s.fsf@gitster.mtv.corp.google.com>
References: <01020156a48144f8-c0e127c1-8cd9-4295-ac16-449a54315cac-000000@eu-west-1.amazonses.com>
 <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
 <xmqqmvk3ut4s.fsf@gitster.mtv.corp.google.com>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Wed, 24 Aug 2016 02:37:34 +0530
Message-ID: <CAFZEwPPUasJvZO=LHOzu85FwPAsg-OQo57wQckXJdiHTP4_34A@mail.gmail.com>
Subject: Re: [PATCH v14 01/27] bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Roberto Tyley <roberto.tyley@gmail.com>,
        Roberto Tyley <robertotyley@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Junio,

On Wed, Aug 24, 2016 at 1:58 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Pranit Bauva <pranit.bauva@gmail.com> writes:
>
>> `--next-all` is meant to be used as a subcommand to support multiple
>> "operation mode" though the current implementation does not contain any
>> other subcommand along side with `--next-all` but further commits will
>> include some more subcommands.
>>
>> Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>> Mentored-by: Lars Schneider <larsxschneider@gmail.com>
>> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
>> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
>> ---
>
> A series this size really needs a cover letter that describes what
> changes were made relative to the previous round to help reviewers.

I am actually using SubmitGit these days as I am back in my campus and
IMAP/SMTP connections are blocked here. SubmitGit doesn't have the
option to include a cover letter. Though I can describe the changes by
including a separate email as a reply to 1st patch. I will send the
changes according to v12 since v13 wasn't commented on.

> I also noticed something curious.  All of your messages are dated
>
>     Date: Tue, 23 Aug 2016 11:53:53 +0000
>
> and I think that is the same as all the previous series, but how are
> you sending your patches?  The reason why I ask is because this does
> not allow readers to tell their mail reader to sort messages by the
> sender's timestamp in order to see the messages in order (as a
> matter of fact, git-send-email knows that readers are helped by this
> feature, and backdates the first message of 10 patch series by 10
> seconds, stamps the second message as later than the first by one
> second, etc. to help them).

This might be a bug in SubmitGit. I didn't notice this previously.

Regards,
Pranit Bauva
