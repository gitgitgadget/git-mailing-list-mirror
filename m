Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D7EC433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 04:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 970DB617C9
	for <git@archiver.kernel.org>; Wed, 12 May 2021 04:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhELErK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 00:47:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56952 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhELErJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 00:47:09 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 02B01C6CB8;
        Wed, 12 May 2021 00:46:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2o3JJFVdUD/FCkjCS/bJmjfO5FU2sbehraHnq0
        u7N18=; b=gs1TGVuMSqFh4LGXXOSUDqubKi8CeOQCgBx6gu2Qdj12YdRVOTOQMD
        ngaa1dA9qOGCD2LbHXNeL3rKSytPw/NDWFI8v6EDRH8FeHX4NStR4Wy36uAd8AI3
        LCOpdRcgXSP5ojOoZwRkgCMTfzurW3F+8JGa7u3LM5QZ6SmzspCuw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CC5DCC6CB7;
        Wed, 12 May 2021 00:46:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E65ACC6CB4;
        Wed, 12 May 2021 00:46:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dave Huseby <dwh@linuxprogrammer.org>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        felipe.contreras@gmail.com, stefanmoch@mail.de
Subject: Re: [PATCH v2] Writing down mail list etiquette.
References: <20210512025447.6068-1-dwh@linuxprogrammer.org>
        <20210512031821.6498-1-dwh@linuxprogrammer.org>
        <20210512031821.6498-2-dwh@linuxprogrammer.org>
Date:   Wed, 12 May 2021 13:46:00 +0900
In-Reply-To: <20210512031821.6498-2-dwh@linuxprogrammer.org> (Dave Huseby's
        message of "Tue, 11 May 2021 20:18:21 -0700")
Message-ID: <xmqqa6p0h853.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F3561236-B2DC-11EB-94B8-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dave Huseby <dwh@linuxprogrammer.org> writes:

> +Mailing List Etiquette
> +======================
> +
> +[[introduction]]
> +== Introduction
> +
> +Open source, community projects such as Git use a mailing list and email to
> +coordinate development and to submit patches for review. This article documents
> +the unspoken rules and etiquette for the proper way to send email to the
> +mailing list. What follows are considered best practices to follow.

Please ensure that we do *not* sound like dictating our rules on
broader open-source community.  The document merely talks about the
rules followed in _our_ community (iow, git@vger.kernel.org mailing
list).

> +[[proper-use-of-to-and-cc]]
> +== Proper Use of To and Cc
> +
> +When starting a new email thread that is not directed at any specific person,
> +put the mailing list address in the "To:" field, otherwise address it to the
> +person and put the mailing list address in the "Cc:" field.
> +
> +When replying to an email on the mailing list, put the person you are replying
> +to in the "To:" field and all other people in the thread in the "Cc:" field,
> +including the mailing list address.

The above two say "do X" but lack "because Y".

Even when starting a new discussion thread, it is perfectly fine to
have specific people on To: while keeping general community members
in the loop by CC:ing the list.  You'd summon area expert that way.

I think the above two items can be viewed from a different angle as
a mere consequence of a single guiding principle.  

"To:" is the place to list the people you want to directly interact
with and request responses from, and "Cc:" is for other people, to
whom you would want to inform this conversation is going on, but you
do not necessarily need to hear their opinion from (they are of
course welcome to chime in).

And as a consequence of that, the two rules you wrote will fall out
naturally.  If you have people in mind that you want to directly
talk to and/or expect their reaction from, list them on "To";
everybody else goes to "Cc:'.  When there is no particular person to
talk to, the mailing list address is a good catch-all address to
reach everybody, hoping there may be some people who are interested
enough to respond.

The above is the "do X" part.  We need to explain why we want
readers to do so, i.e. "because Y".

   This allows recipients to prioritize their incoming messages;
   they can direct their immediate attention to those messages with
   their names on the To: field and the ones with their names on the
   Cc: field can wait.

> +Make sure to keep everyone involved in the "Cc:" field so that they do not have
> +to be subscribed to the mailing list to receive replies.

This one has both "do X, because Y". Good.

> +[[do-not-use-mail-followup-to]]
> +== Do Not Use Mail-Followup-To
> +
> +When posting to the mailing list, your email client might add a
> +"Mail-Followup-To:" field which contains all of the recipients, including the
> +mailing list address, but not the sender's email address. This is intended to
> +prevent the sender from receiving replies twice, once from the replying person
> +and again from the mailing list.
> +
> +This goes directly against the desired "To:" and "Cc:" etiquette (see "Proper
> +Use of To and Cc" above).

... because "Reply to all" will redirect the response to all the
folks that were originally on "cc:", instead of going to the person
who sent the message that is being responded to.

> Most users want to use "group reply" or "Reply to
> +all" in their mail client and create a reply email that is sent directly to
> +author of the email they are replying to with all other recipients, as well as
> +the mailing list address, in the "Cc:" field.
> +
> +The proper thing to do is to never use the "Mail-Followup-To:" field as well as
> +disable honoring any "Mail-Followup-To:" fields in any emails you reply to.
> +Some email clients come with both enabled by default. Mutt is like this (see
> +Disable Mail-Followup-To in the Mutt section below).
> +
> +[[enable-plain-text-mode]]
> +== Enable Plain Text Mode
> +
> +Most email clients automatically reject mailing list email if it is not a
> +text/plain formatted email.

Is this true?  I know that _our_ mailing list will reject text/html
e-mail and that is why we ask people to send text/plain e-mails.  I
doubt that some/many/most clients reject non text messages.

> +For that reason, it is important that your email
> +client is set to create text/plain emails instead of text/enriched or
> +text/html email.
> +
> +[[patches-that-receive-no-response]]
> +
> +From Junio's notes from the maintainer:
> +
> +> If you sent a patch and you did not hear any response from anybody for
> +> several days, it could be that your patch was totally uninteresting,
> +> but it also is possible that it was simply lost in the noise.  Please
> +> do not hesitate to send a reminder message in such a case.  Messages
> +> getting lost in the noise may be a sign that those who can evaluate
> +> your patch don't have enough mental/time bandwidth to process them
> +> right at the moment, and it often helps to wait until the list traffic
> +> becomes calmer before sending such a reminder.
> +
> +[[send-merge-ready-patches-to-the-maintainer]]
> +== Send Merge-Ready Patches to the Maintainer
> +
> +Once a patch has achieved consensus and all stakeholders are staisfied and
> +everything is ready for merging, then you send it to the maintainer: "To:
> +gitster@pobox.com".

This needs to be cc'ed to the list.  But I am not sure if it needs
to be duplicated in this document.  Practically nobody seems to do
this and expect me to pick things up instead.


