Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 650401F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 20:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754009AbcJEUdT (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 16:33:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60792 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752869AbcJEUdS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 16:33:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1C71D458AE;
        Wed,  5 Oct 2016 16:33:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iVC+Q0a+Wnq6BcV6gyuwlLaL4Mk=; b=jB8eW1
        09XB6qY2sYThFwO688aeqWq1PHimHqO3UYlReL1pfFJEqd0ND8JbwDKl8in8XOo3
        axo19sOPZ7z5crACWgSl7i+cM5RM5J6hwJzjIYHswgg29YvrgUr26mIQjgtmFV+w
        D6aigbdZ2qhRH3GftiJiaHnKCLZSZ4Cmq/uhI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iRzFXYOAlLxnFSrFSeZx3V6L4FCVDjcR
        LqtazIRKAcGV1nwfm/IxfHDkAnxIV3MlGD55zEaRJ2YaoAekVXO3LHBJccNV12u8
        TBHz15O7wFnx0rQrbljD+I7R+L0KF/N7cilSY0tKbAg6LL8b1Y5S76K8wyQIe70O
        4SJsoWGUNNI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 14034458AD;
        Wed,  5 Oct 2016 16:33:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8D0A5458AB;
        Wed,  5 Oct 2016 16:33:16 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC/PATCH 0/2] place cherry pick line below commit title
References: <cover.1475176070.git.jonathantanmy@google.com>
        <xmqqtwcycqul.fsf@gitster.mtv.corp.google.com>
        <11e41a94-df8c-494a-584b-e2bc8da2de3a@google.com>
        <xmqq8tu99o75.fsf@gitster.mtv.corp.google.com>
        <xmqqtwcx8669.fsf@gitster.mtv.corp.google.com>
        <e03fdabd-6690-5244-5f79-1715b0364845@google.com>
        <xmqqbmz16y42.fsf@gitster.mtv.corp.google.com>
        <d3df0636-1975-1d08-2f34-384984c72e5d@google.com>
        <xmqq8tu55bel.fsf@gitster.mtv.corp.google.com>
        <84f28caa-2e4b-1231-1a76-3b7e765c0b61@google.com>
        <xmqqwphouivf.fsf@gitster.mtv.corp.google.com>
        <a7304731-fa05-92c2-6139-ecd1e6adcefd@google.com>
Date:   Wed, 05 Oct 2016 13:33:14 -0700
In-Reply-To: <a7304731-fa05-92c2-6139-ecd1e6adcefd@google.com> (Jonathan Tan's
        message of "Wed, 5 Oct 2016 12:38:46 -0700")
Message-ID: <xmqqint6o7sl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F200FAB4-8B3A-11E6-852B-F99D12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Sounds reasonable to me. Would the "[" be a bit of overspecification,
> though, since Git doesn't produce it? Also, identifying it as a
> garbage line probably wouldn't change any behavior - in the Linux
> kernel examples, it is used to show what happened in between
> sign-offs, so there will always be one "Signed-off-by:" at the top.

Good thinking.  As "interpret trailers" cannot locate such a line to
manipulate (as it lacks <token>), we can simply treat it as a
garbage line.

>>     struct {
>> 	const char *whole;
>> 	const char *end_of_message_proper;
>> 	struct {
>> 		const char *token;
>> 		const char *contents;
>> 	} *trailer;
>> 	int alloc_trailers, nr_trailers;
>>     };
>>
>> where
>>
>>  - whole points at the first byte of the input, i.e. the beginning
>>    of the commit message buffer.
>>
>>  - end-of-message-proper points at the first byte of the trailer
>>    block into the buffer at "whole".
>>
>>  - token is a canonical header name for easy comparison for
>>    interpret-trailers (you can use NULL for garbage lines, and made
>>    up token like "[bracket]" and "(cherrypick)" that would not clash
>>    with real tokens like "Signed-off-by").
>>
>>  - contents is the bytes on the logical line, including the header
>>    part
>>
>> E.g. an element in trailer[] array may say
>>
>>     {
>> 	.token = "Signed-off-by",
>>         .contents = "Signed-Off-By: Some Body <some@body.xz>\n",
>>     }
>
> I get the impression from the rest of your e-mail that no strings are
> meant to be copied - is that true? (That sounds like a good idea to
> me.)

I was envisioning that "whole", "end-of-message" can point into the
input buffer, while trailer[].contents may have to be copied, if
only to make it to a NUL-terminated string.  But I am fine with
<ptr,len> or <begin,end> pair to avoid copying .contents if that is
desired.  You'd need to worry about differentiating .contents that
need to be freed after "interpret trailers" inserted a new entry or
replaced the contents, though.
