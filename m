Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B58D1F43C
	for <e@80x24.org>; Mon, 13 Nov 2017 09:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751207AbdKMJsY (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 04:48:24 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63398 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751104AbdKMJsX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 04:48:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 51C26B8C4C;
        Mon, 13 Nov 2017 04:48:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lo1oT1IcD5zIndhAJYwjngGvMzU=; b=iuYPT1
        pb7PSqK9cMRDUtsQVdG1r9e16soRrWyB4eiOAreZ9SCTdaMA17ELUBTY4DlGJ9Je
        M1/NCBi1Mv4++kT7tPRAGLgA7tbpuvwwTwDauisVQojUB90j1ZXT+Szr1CkBg1NX
        1o48oPXKs7iFasvj/sa53iIs1T5YBj11IxdMY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=H7nUlcfRyN2+dmF4iDBw/RPoIzRanq7s
        lw5Ilp1fBXJzjn9QoSN5ZasJWC9BuZJSv0nRrHBMKIM0gFmEY4BiJx368B0Cj/Z3
        /m/zvrobaVhY0WvA6T9/EV+4WvthgluheY16ZwsVdDbMuVebmkNcAjW4QuiVJkBE
        jd+v5ROoLhA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 47683B8C4B;
        Mon, 13 Nov 2017 04:48:17 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BFC51B8C4A;
        Mon, 13 Nov 2017 04:48:16 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] doc: Remove explanation of "--" from several man pages
References: <alpine.LFD.2.21.1711121600170.7904@localhost.localdomain>
        <xmqq8tfaak6s.fsf@gitster.mtv.corp.google.com>
        <alpine.LFD.2.21.1711130357190.10471@localhost.localdomain>
Date:   Mon, 13 Nov 2017 18:48:15 +0900
In-Reply-To: <alpine.LFD.2.21.1711130357190.10471@localhost.localdomain>
        (Robert P. J. Day's message of "Mon, 13 Nov 2017 04:22:22 -0500
        (EST)")
Message-ID: <xmqqlgja8q74.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C6049032-C857-11E7-9D5C-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert P. J. Day" <rpjday@crashcourse.ca> writes:

>> > diff --git a/Documentation/git-check-attr.txt b/Documentation/git-check-attr.txt
>> > index aa3b2bf2f..0ae2523e0 100644
>> > --- a/Documentation/git-check-attr.txt
>> > +++ b/Documentation/git-check-attr.txt
>> > @@ -36,10 +36,6 @@ OPTIONS
>> >  	If `--stdin` is also given, input paths are separated
>> >  	with a NUL character instead of a linefeed character.
>> >
>> > -\--::
>> > -	Interpret all preceding arguments as attributes and all following
>> > -	arguments as path names.
>> > -
>>
>> This also has a similar issue.  "--" here is not between revs and
>> pathspecs but is between attributes and pathspecs.
>
>   that can already be seen in the SYNOPSIS for that command, it does
> not require further explanation:
>
>   SYNOPSIS
>        git check-attr [-a | --all | attr...] [--] pathname...

Nah.  With the same logic you could say --all is already on synopsis
and no need for explanation.

If you are shooting for pedantic consistency, adding to pages that
are missing would be less problematic than removing from the ones
that have them, especially given that people thought the use of
double-dash in commands described on these pages are common or
special enough to deserve extra attention.
