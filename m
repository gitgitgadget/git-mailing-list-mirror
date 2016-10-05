Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C22DD1F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 20:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753244AbcJEUBk (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 16:01:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50894 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752780AbcJEUBk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 16:01:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 95360453F6;
        Wed,  5 Oct 2016 16:01:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=+Ma9KwUMceJV
        VR71rpKimb6SQ20=; b=ZsTdhW/lk0rmIH+bBoBw9sMf+yjNqEuMT284HFmHCcZT
        5ppOCOKr/Pv9mA7sPA2bki3alktWnIx7MWmfNsDLAUZXpf16MKDAQapXIgmBVAoJ
        Zc3VXE492z4XuVIZRcWg7vYlUdnq/TSqarYXbP6R1FZIZhWpqn1hAyuHyDcKAIk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=km5dw/
        mLSAM9mP2LovDbi6CqWuwo3zSoc4gYxI/Hf12DHLpp/ylzSBIRsIL2akBSu4YgsM
        UENuwy/070mISCPJ78I0n5i5p9UvLKcI1vH2j98p1ntkjTfQsWrWmiuOEMN1s5ZO
        gHyu8cdTGotrit4pCVr5qJw+7pHDmhHcxgd8o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8B2D0453F5;
        Wed,  5 Oct 2016 16:01:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 08AFC453F4;
        Wed,  5 Oct 2016 16:01:37 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Sergey Organov <sorganov@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 5/6] Documentation/git-merge.txt: improve short description in DESCRIPTION
References: <cover.1475678515.git.sorganov@gmail.com>
        <e74ae8afc1bfc4cd9161ccaa56d926a89439551e.1475678515.git.sorganov@gmail.com>
        <e03a84ad-9aa6-8ada-5828-7b28f76baaaf@gmail.com>
Date:   Wed, 05 Oct 2016 13:01:36 -0700
In-Reply-To: <e03a84ad-9aa6-8ada-5828-7b28f76baaaf@gmail.com> ("Jakub
        =?utf-8?Q?Nar=C4=99bski=22's?= message of "Wed, 5 Oct 2016 18:58:10 +0200")
Message-ID: <xmqqr37uo99b.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8662D9AC-8B36-11E6-89F9-F99D12518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

>> +
>> +This command is used by 'git pull' to incorporate changes from anothe=
r
>> +repository, and can be used by hand to merge changes from one branch
>> +into another.
>
> Rather "can be used by 'git pull'", or "is used by 'git pull' (unless
> configured otherwise)"...

I think you are misreading the original and the update (see my
comments in the other message).

>> @@ -31,11 +36,11 @@ Assume the following history exists and the curren=
t branch is
>>      D---E---F---G master
>>  ------------
>> =20
>> -Then "`git merge topic`" will replay the changes made on the
>> -`topic` branch since it diverged from `master` (i.e., `E`) until
>> -its current commit (`C`) on top of `master`, and record the result
>> -in a new commit along with the names of the two parent commits and
>> -a log message from the user describing the changes.
>> +Then "`git merge topic`" will replay the changes made on the `topic`
>> +branch since it diverged from `master` (i.e., `E`) until its current
>> +commit (`C`) on top of `master`, and record the result in a new commi=
t
>> +along with references to the two parent commits and a log message fro=
m
>> +the user describing the changes.
>
> What the happened here!?!  Please do not rewrap documentation, especial=
ly
> not without changes!

Yes, reflowing is bad but you can spot the change from "along with
the names of the parent commits" to "along with references to the
parent commits" if you stare at it long enough ;-)

