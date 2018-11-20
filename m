Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 105171F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 03:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730474AbeKTNvC (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 08:51:02 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56771 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbeKTNvC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 08:51:02 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1050B12AF1B;
        Mon, 19 Nov 2018 22:24:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=gl7CvuFlI0vC
        LzCvmk9yOLdrM68=; b=W8grJX6gzcYQ1IlNKshRxBrsAt79W82hEQMUOH9fiaL+
        C0Nao8p/zXFpT5oAWwAXiUfvn33OkII8FZCEFSIqctP56k5ZwMhPdYuJw6mLPjwz
        JYSxfW7VLWa3x4WWdJTpHoy9O+S6qar5rni/kPWpgCogcRTTvWKfjmhoFa0RZ6k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=VXEVQA
        cMRzi7/hZxgzW8OaYSjRcpEmFMp2KuOi/dB9ag/T30w2gBGx+8h4jLsX5uRzUunh
        gYxsiYypeJx76pDDYFznYx2KP3dXT4q9wMW+t0BS39QezlyIFiTRRrpNib0k1TBG
        WHRQIYcGkS83NzMb/fB2DWzTidVuKsALNIDXs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F415212AF1A;
        Mon, 19 Nov 2018 22:24:00 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F216612AF19;
        Mon, 19 Nov 2018 22:23:59 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org,
        ziade.tarek@gmail.com
Subject: Re: help.autoCorrect prefix selection considered a bit dangerous
References: <87y39oztzf.fsf@evledraar.gmail.com>
Date:   Tue, 20 Nov 2018 12:23:59 +0900
In-Reply-To: <87y39oztzf.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 19 Nov 2018 21:35:00 +0100")
Message-ID: <xmqqftvwbfe8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B8C496CE-EC73-11E8-A38D-063AD72159A7-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I don't have time to poke at this now, but wonder if:
>
>  1) The correction facility shouldn't at least have a list of "this doe=
s
>     stuff over the wire" commands and would then use a more conservativ=
e
>     estimate.

Not limited to 'over the wire' but 'can have consequences that might
cause regret' would be a reasonable list to have.

On a similar topic, it would be a disaster for "git reset --h<RET>"
to complete to "--hard" instead of "--help", for example.  Perhaps
parse-options API also needs to learn a list of possibly regrettable
options.
