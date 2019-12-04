Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C66C43603
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 17:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 413A32081B
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 17:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="S/k5wpb8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbfLDRHT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 12:07:19 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64033 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfLDRHT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 12:07:19 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2CE628D52F;
        Wed,  4 Dec 2019 12:07:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OJZpdSUvdOMdpUFVntwcEr4JQsU=; b=S/k5wp
        b8CEIMLxTzv0QGxh+LZjWVSVBwZtgD/uM/AureGqifxrmlGjrIABrS1UNnbn70SF
        tENP7Y9VvA+HdG8U1FsVnt4E7Pu6xiqDYIGVM5Fj1MvevRQ1RYf65k7NmsB+iQY8
        W3ipkoAcPd1luq29VbOVA56rwM0JBz7O6eKYw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dH4wGHRxT1VRwFMp05Pp9SWv5jQYDUCq
        Sr4ThGHdKVzudvRc5A/rO38c+7PbXKJUOFf3sGWESVanXdZ2ndEiTSMTCpQYOVRi
        si8ZtfvEuNEYlSJSBQTI7hpWgFfqEVXg1Edwm1cjmJYmWk4+emzmp1vITrzel4kI
        pM07fxCq6PQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 256278D52E;
        Wed,  4 Dec 2019 12:07:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0F5E88D52D;
        Wed,  4 Dec 2019 12:07:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2] contrib: git-cpcover: copy cover letter
References: <20191203201233.661696-1-mst@redhat.com>
        <20191204044449.GB226135@google.com>
        <CAPig+cTFbpAo5+kahLT+7E1zQe24S5icm0SSB=HF4xqsD2VdAA@mail.gmail.com>
        <xmqqlfrs5acs.fsf@gitster-ct.c.googlers.com>
        <CAPig+cREF8BSVbCoOUaRMPOyfD_bfD5PhxgM4QZgot7sziCNug@mail.gmail.com>
Date:   Wed, 04 Dec 2019 09:07:08 -0800
In-Reply-To: <CAPig+cREF8BSVbCoOUaRMPOyfD_bfD5PhxgM4QZgot7sziCNug@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 4 Dec 2019 11:32:20 -0500")
Message-ID: <xmqqd0d458ar.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 82B3438A-16B8-11EA-8007-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Dec 4, 2019 at 11:23 AM Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>> > I could even imagine a new option -V<n> which has the combined effect
>> > of setting the re-roll count (like -v) and automagically copying the
>> > cover letter material from cover letter v<n-1> located in <dir>.
>>
>> I actually looked into doing something similar but without any new
>> option (i.e. unconditionally --cover-letter with -v<n> would check
>> for v<n-1>-0000-cover.letter and does the right thing) some time
>> ago.
>
> Yes, I like that better than a new option, and wanted to suggest it as
> well, however... (see below)
>
>> But I think that was even before we integrated the range-diff stuff,
>> which does seem to use the "given we are doing <n>, let's compare
>> with <n-1>" thing, so perhaps it is not too difficult.
>
> Yup.
>
>> I am just saying that I think the change would not have to be opt-in,
>> but can be unconditionally made, simply because replacing the BLURB
>> HERE placeholder with *anything* written by human user previously is
>> a 100% improvement ;-)
>
> I had started writing the same in my previous reply but then realized
> that it could break existing tooling which uses -v and --cover-letter
> together and which searches for the well-known BLURB HERE placeholder
> to replace it automatically. If I'm wrong about possibly breaking
> existing tooling, then I'd also vote for this behavior kicking in
> automatically with -v and --cover-letter specified together.

Well, they can now disable that "copy over the material from the
previous" step, which is good.  I actually think we should add the
well-known BLURB HERE string *after* populating the new version of
the coer letter with the materials from old one to *force* users to
proofread and adjust it to the updated reality, so if that happens,
then the existing tooling would also work as before ;-)
