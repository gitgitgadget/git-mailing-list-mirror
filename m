Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29853C433E0
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 20:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2EB164E35
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 20:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240150AbhBDU00 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 15:26:26 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56223 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239974AbhBDU0M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 15:26:12 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3849CB4A4E;
        Thu,  4 Feb 2021 15:25:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZY6EwDZoUC47IWf+pyq2GNdvu7U=; b=GVkbLC
        Soaa8ccSZ8quXVGeSdvq/N4kkfzGr6D6WzcvDmCtJQEvZTQF+uIIV4pjdagXXQnp
        IGRWvx1oLSPV7qhS0mW4uFsyTjx7lGvSvfeybDi7G2OaNuryv5uRSh2r5O8aq6xH
        IV++gCN+1j+yFL1EvCbtigBcP4hk2XeS6JrWE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RGui7ujN/4f+LbHMlAvCQn8RKPrWCA0F
        79Ntv5n7qcUjxwT6eQdr/3ilBS2rDSOf2RxxacTSKUNTEI4LMhhQ6Lm/i5UmiiNC
        C0IRL3JposMdlV1NnAyHC7xl72mP2Wkm53CakfC8Fx47BvCE02rugfM7kZ6Cs0rq
        czXk7U9uWf8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 31148B4A4D;
        Thu,  4 Feb 2021 15:25:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9A581B4A4C;
        Thu,  4 Feb 2021 15:25:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Feb 2021, #01; Wed, 3)
References: <xmqqy2g4ad92.fsf@gitster.c.googlers.com>
        <CAPSFM5cY6WcH+Mj64pvk_8vQeufj4BT6XOz_qjsCDPk8SvN2oQ@mail.gmail.com>
Date:   Thu, 04 Feb 2021 12:25:27 -0800
In-Reply-To: <CAPSFM5cY6WcH+Mj64pvk_8vQeufj4BT6XOz_qjsCDPk8SvN2oQ@mail.gmail.com>
        (Charvi Mendiratta's message of "Fri, 5 Feb 2021 00:52:53 +0530")
Message-ID: <xmqqft2b60nc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1F015ECE-6727-11EB-9CB5-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Charvi Mendiratta <charvi077@gmail.com> writes:

> On Thu, 4 Feb 2021 at 06:00, Junio C Hamano <gitster@pobox.com> wrote:
>
>> * cm/rebase-i (2021-01-29) 9 commits
>>   (merged to 'next' on 2021-02-01 at 4f9aa6cec3)
>>  + doc/git-rebase: add documentation for fixup [-C|-c] options
>>  + rebase -i: teach --autosquash to work with amend!
>>  + t3437: test script for fixup [-C|-c] options in interactive rebase
>>  + rebase -i: add fixup [-C | -c] command
>>  + sequencer: use const variable for commit message comments
>>  + sequencer: pass todo_item to do_pick_commit()
>>  + rebase -i: comment out squash!/fixup! subjects from squash message
>>  + sequencer: factor out code to append squash message
>>  + rebase -i: only write fixup-message when it's needed
>>
>>  "rebase -i" is getting cleaned up and also enhanced.
>>
>>  Will merge to 'master'.
>>
>
> Received reviews and suggestions on this patch series. So, updated
> those changes and have sent the next version of this patch series (v5).

We incrementally fix shortcomings in the series with additional
patches after a topic gets merged to 'next'.  It no longer is
appropriate to replace with "the net version".

Thanks.
