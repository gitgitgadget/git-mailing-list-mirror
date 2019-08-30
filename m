Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67F9F1F461
	for <e@80x24.org>; Fri, 30 Aug 2019 16:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbfH3QiR (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Aug 2019 12:38:17 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51249 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbfH3QiQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Aug 2019 12:38:16 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 750686E4C4;
        Fri, 30 Aug 2019 12:38:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ygOEaOoasETDvGKTLVLi4S5lUT0=; b=U0eZg3
        xRYXi6UVD6/0N2CsGnydLicnXCezsZ3JI59hgobwiFPFTlbKS6+nqtpLGHLodnXL
        6nhaq+ZQIjMhgIEOjqMiryaCq5Nbwv1uN6eV+1uLIt+4XT6t/3WBe14PfTMOxkcy
        6jXGFrhE924BuxZhi1dvntRsT36IOxsVaiGXk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rU72WI3ieLVbGzdE42AQIDwEA7YsDShC
        CVBYvUQbVhW+962+O1kpDhCgvA58h+SbjNBeswCL11T17jn0U1UsQbJRL59wSbEc
        6U6wq8A8qc+srPvRgXQ02irOCYrNN05dpMLA9tkxOmPhhrQhLs4334O5yAiZ3J18
        j2n2M4ntUZQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6DA4E6E4C2;
        Fri, 30 Aug 2019 12:38:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9B6496E4C1;
        Fri, 30 Aug 2019 12:38:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Albert Vaca Cintora <albertvaka@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: [Feature Request] Option to make .git not read-only in cloned repos
References: <CAAQViEsZW4PzHr5BrkDHU2kSd_e04n02McGPgrmXGZMpgaTePg@mail.gmail.com>
        <d31b871a-5c2d-99e7-5616-6f43759bb948@kdbg.org>
        <CAAQViEv1_YXPxLRN=eT7yQhro55K4audnouzAjjbHhJsU7pgQA@mail.gmail.com>
        <34935414-4e69-114b-7a32-f94514e3679d@iee.email>
        <xmqq5zmkkn4a.fsf@gitster-ct.c.googlers.com>
        <CAAQViEsL+X5ZYmmSjG1JBksGjthHCUyWa3525b8dN7u1XAbvJg@mail.gmail.com>
        <xmqq4l224d0x.fsf@gitster-ct.c.googlers.com>
        <CAAQViEv1wWGTzQ29t0qi9rYoRY=Y86GL7E5rR4XySOBoeRx2pg@mail.gmail.com>
Date:   Fri, 30 Aug 2019 09:38:11 -0700
In-Reply-To: <CAAQViEv1wWGTzQ29t0qi9rYoRY=Y86GL7E5rR4XySOBoeRx2pg@mail.gmail.com>
        (Albert Vaca Cintora's message of "Fri, 30 Aug 2019 14:49:30 +0200")
Message-ID: <xmqqd0gmzk0c.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8F757436-CB44-11E9-A678-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Albert Vaca Cintora <albertvaka@gmail.com> writes:

> On Tue, Aug 27, 2019 at 9:35 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Ah, your "rm" command needs to learn "-f" option, too, then?
>
> The whole point of this thread was to remove the need of -f forcing the removal.

OK, I misunderstood what you wanted to do.

If an implementation of Git were making everything under .git/
read-only, including directories, then it is veriy much reasonable
to complain against such an implementation.  The usual "I know I am
doing something unusual and forcing it" safety given by "rm -rf" is
not enough to remove such a clone, and user would need "chmod -R u+w"
beforehand to be able to remove---that is being unreasonably paranoid
in the name of protecting against mistakes.

But requiring an additional single "f" when doing "rm -rf .git"?  Is
that realy too much of a hassle?  The option "-f" is to allow people
deal with an unusual situation, while preventing everyday use from
doing something harmful unintendedly.  And removing a cloned
repository is an unusual situation that would not happen every day,
no?
