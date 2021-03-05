Return-Path: <SRS0=rdad=ID=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE470C433DB
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 18:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78A2565059
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 18:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhCESZT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 13:25:19 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59084 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbhCESZM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 13:25:12 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3F85B120CFA;
        Fri,  5 Mar 2021 13:25:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vX5iAQoVDthI3RnII4CSpTk97Xk=; b=gaXaDq
        IqUdfi3YDOlAq1hSQ2W+uNRdqb9PcZNkokWIHRU1saNUt//ST3rlyPX0a4R8BLoN
        p+Y1LGMGTTe0UeZuj3qcb/evbziwGTWOVEUr999PQbzJUhxhz0MI8WA0sTcm57kT
        BZVg2s9tMox4Qhrrv4I3xCr4U+wc20qDxfr+k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dqzwOOOt1ubph2SkC1UyzJvivufxaZ8S
        EENMqDJWvZTugDgpmlxr/rWdlxYQ+thOggumpvMF6I8szRTd8FH+68w8m+BQ7WME
        M6EPaFAYg+4NLiX7vY8fHRu+epPGaT7DGa3V1kKVszj/LDHifhBNmlkLkoqPHpzj
        j13AzzJZHeM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 24E57120CF9;
        Fri,  5 Mar 2021 13:25:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 17F14120CF3;
        Fri,  5 Mar 2021 13:25:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 6/6] doc/git-commit: add documentation for
 fixup=[amend|reword] options
References: <20210301084512.27170-1-charvi077@gmail.com>
        <20210301084512.27170-7-charvi077@gmail.com>
        <CAPig+cRvwvT7QrO0-aLZX-2vsBPJSq6WO-O7g5A0OjDMNAYmCQ@mail.gmail.com>
        <CAPSFM5c1zR6yz=gATGxih0wL-W18AWgCHQhL_SPno5SeTzGQGg@mail.gmail.com>
        <CAPig+cRiiQyavaMGzgBkXOoGFPhMBC7GbpB61ziFMrckReFbcQ@mail.gmail.com>
        <xmqqczwfg23t.fsf@gitster.c.googlers.com>
        <CAPSFM5cM4fdyWXD33PkT2bH6kM+3ixkxgAnhjUVYFtjUHgwU5g@mail.gmail.com>
        <xmqqpn0ed0m2.fsf@gitster.c.googlers.com>
        <CAPSFM5dM4NMeGqEG7hFLzyhJskqcrNtNqL9=MUCw9SEYYaFLoQ@mail.gmail.com>
Date:   Fri, 05 Mar 2021 10:25:07 -0800
In-Reply-To: <CAPSFM5dM4NMeGqEG7hFLzyhJskqcrNtNqL9=MUCw9SEYYaFLoQ@mail.gmail.com>
        (Charvi Mendiratta's message of "Fri, 5 Mar 2021 11:44:51 +0530")
Message-ID: <xmqq4khpbgqk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1DCE95BA-7DE0-11EB-8E3E-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Charvi Mendiratta <charvi077@gmail.com> writes:

>> The reason I brought it up was not because "--fixup=reword" is not
>> needed as a short-hand for "--only --fixup=amend" (but thinking
>> about it again, I do not think it is so bad), but primarily in
>> response to "would it be easier for users if we had reword! insn in
>> addition to amend! verb in the todo file?" that was raised earlier
>> in the thread.  If we position "--fixup=reword" as a short-hand
>> and/or a syntax sugar for "--fixup=amend" and advertise it as such
>> sufficiently to educate users, it would be easier for users to
>> understand why they both result in "amend!".
>
> Okay, so now if it's Ok to keep the short-hand "--fixup=reword" ? then
> I think making the documentation more clear would be sufficient to
> serve it to the users ?

It would be good 

 (1) to keep "--fixup=reword:<commit>"

 (2) to keep "amend!" but not introduce "reword!" insn

 (3) document "--fixup=reword:<commit>" can be thought of as a mere
     special-case short-hand for "--fixup=amend:<commit> --only",
     and

 (4) make sure "fixup=amend:<commit> --only" is usable as a
     replacement for "--fixup=reword:<commit>".

but if we are not doing (3) and (4), then it would also be OK to

 (1) to keep "--fixup=reword:<commit>"

 (2) to keep "amend!" and introduce "reword!" insn

I would think.
