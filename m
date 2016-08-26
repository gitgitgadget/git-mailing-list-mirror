Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE43E1FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 16:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754560AbcHZQPF (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 12:15:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63674 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754553AbcHZQPF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 12:15:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B415F3895E;
        Fri, 26 Aug 2016 12:09:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=lBsnrarkiQ61
        uuoGzbvc/mOgYX8=; b=K9v6nCsT1N3G7ByFp6GsgjGfEYsd09C6dmsxLoCNPIuZ
        gph5f2IylG2vrzIE59vgyY1T+9JY23+zdd5uZw7d3zXoWNAC99dks7DkFlRDC5WP
        5kmDLalMgTrPxWsecVvCmZJhj9U+5qTGUZe7GHd4EZd5Eo1hVoUPBU7OzIAXYCI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Ea6NQ4
        nsWfkAY3U8FaAfwL4Y673j7JpUcRrK86otKJZXHyyRzubzWMKwDRTH7fDI1Elfu0
        VYBjUUqaJBj1n95GgYdsfMqWtq3LBa5ct66Jw74wv59AMpl7gxMwg1JDbnkmaP25
        0hO95F9QchcCeHeXbUZM+hXPBEcC+SZmcDbEI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AAB073895D;
        Fri, 26 Aug 2016 12:09:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2CA593895C;
        Fri, 26 Aug 2016 12:09:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.org>, GitList <git@vger.kernel.org>
Subject: Re: [PATCH v5 01/12] doc: use 'symmetric difference' consistently
References: <20160720211007.5520-1-philipoakley@iee.org>
        <20160811215035.4108-1-philipoakley@iee.org>
        <20160811215035.4108-2-philipoakley@iee.org>
        <eca8d854-9483-ea30-c5a8-71a35c3ca7bd@gmail.com>
Date:   Fri, 26 Aug 2016 09:09:51 -0700
In-Reply-To: <eca8d854-9483-ea30-c5a8-71a35c3ca7bd@gmail.com> ("Jakub
        =?utf-8?Q?Nar=C4=99bski=22's?= message of "Fri, 26 Aug 2016 13:33:08
 +0200")
Message-ID: <xmqq60qnjyuo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 85EC87A6-6BA7-11E6-B5F2-F7BB12518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

>>  --left-right::
>> -	Mark which side of a symmetric diff a commit is reachable from.
>> +	Mark which side of a symmetric difference a commit is reachable from=
.
>>  	Commits from the left side are prefixed with `<` and those from
>>  	the right with `>`.  If combined with `--boundary`, those
>>  	commits are prefixed with `-`.
>
> That's very nice that two^W three related options, namely --left-only,
> --right-only and --left-right now use the same notation.
>
> I guess that "symmetric range" was to mean "symmetric difference range"=
.

By "symmetric difference", we mean a "set difference" operation that
is symmetric.  Contrasting with asymmetric difference that gives a
set of elements that belong to set A but do not belong to set B
(i.e. B..A), symmetric difference of set A and set B gives a set of
elements that belong to either set A alone or set B alone but not
both (i.e. A...B).

So if you really want a fully spelled name, we would not want to
call it with a name with "range".  It is "symmetric set difference",
and "symmetric difference" in the updated sentence is a short-hand
for that.
