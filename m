Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2ECC2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 18:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0A8C20661
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 18:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ii5DBLM9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbgAaSPq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 13:15:46 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62094 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgAaSPq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 13:15:46 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D3081ABB44;
        Fri, 31 Jan 2020 13:15:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UbrWUGQv/CmoWR2eROj/W7UAJvQ=; b=Ii5DBL
        M9R0KM8tHXQz6bw1gxJ/coe39LFhmMgBD4wUvLO1nEtIPWQ4rLCGS1RIhlfIToeS
        LJezlSVgo/BZaVhCT4N8bBgWtl0BZ+iqJ4lW86mBp/MTY2IwfSKrWQW1P3cZxryt
        N4qFhSE3tc4Owehk3O4Bu2d8PH0CrQ2ss9bxc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=p6/oajw0afACTmd75F5mU9iW63/KaNtn
        LA07m4yx9bi+pu0IJ0gHJhCNvxh/y9M8RWOVqFFH651fvxayZieFoIbh5D7wGgXM
        IdYRqfWSqOtU0xhtzT4ktaHTpuY4onMc04OsDQKkb0WxV7mqhcrBMmZ8LFQAz+qP
        sCuTGl8kIJE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CBCE1ABB43;
        Fri, 31 Jan 2020 13:15:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 063BAABB42;
        Fri, 31 Jan 2020 13:15:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ivan Selin <ivan.selin@toptal.com>
Cc:     Luke Diamand <luke@diamand.org>, Git Users <git@vger.kernel.org>
Subject: Re: git-p4 cannot use perforce client created by p4java
 =?utf-8?Q?=E2=80=94?= "Expected view key View1 missing"
References: <CAPgZwKbZ0g+VXjnD03hGkRXfwU2DpygLhLBFG3xv1W9c8oQ1fQ@mail.gmail.com>
        <CAE5ih79j+o87yEPbj+nFR6b4rx_NU2eLJite69=+qMdpXdEidw@mail.gmail.com>
        <CAPgZwKbYKPbZeEY2O22DJBvDpjHRR2XVW9hQ7-tML-UE2bkXYA@mail.gmail.com>
        <CAE5ih79xWfjLC48y=mSLhdG2zVR5d-XeAbJJFV2SPTew5FGf+Q@mail.gmail.com>
Date:   Fri, 31 Jan 2020 10:15:40 -0800
In-Reply-To: <CAE5ih79xWfjLC48y=mSLhdG2zVR5d-XeAbJJFV2SPTew5FGf+Q@mail.gmail.com>
        (Luke Diamand's message of "Fri, 31 Jan 2020 15:52:08 +0000")
Message-ID: <xmqqa763bigj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B1943E14-4455-11EA-A2DF-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luke Diamand <luke@diamand.org> writes:

> On Fri, 31 Jan 2020 at 13:43, Ivan Selin <ivan.selin@toptal.com> wrote:
>>
>> Yes, that's exactly the way that I've tried it and it worked for me.
>> Can we have that integrated into git-p4? What can I do to make it
>> happen?
>
> A patch would be very welcome!
>
> See Documentation/SubmittingPatches for details, but it's likely
> enough to just make the change, and then use git format-patch and git
> send-email.
>
> Please ensure you add a "Signed-off-by" (git commit -s).

Thanks for helping.  Another area a new person struggles is to
propose a good commit log message.  I'd expect this change to be
explained something like this:

    Subject: git-p4: tighten detection of view names

    The current "git p4" code expects that all keys starting with
    "View" are view names (i.e. "View0", "View1", etc.), but a
    Perforce client created using p4java gets an extra key
    "ViewDepotType", which is not something we want to be treated as
    a view key.

    Tighten the filter of keys to accept only string "View" followed
    by nothing but digits.

    Helped-by: Luke Diamand <luke@diamand.org>
    Signed-off-by: ...

Note that I am not a Perforce person, so the phrase "view names" I
used in the above may totally be wrong as P4-lingo, in which case
please replace them with what is acceptable by our Perforce friends
;-)

Thanks.

>> ...
>> > is_view = re.compile(r'^View\d+$')
>> > view_keys = [ k for k in entry.keys() if is_view.match(k) ]
