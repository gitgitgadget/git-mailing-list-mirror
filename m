Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E296820988
	for <e@80x24.org>; Tue, 18 Oct 2016 20:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933384AbcJRUbc (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Oct 2016 16:31:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51321 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753749AbcJRUbb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2016 16:31:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5547C47D3C;
        Tue, 18 Oct 2016 16:31:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=enQvtx5SCkJuX2aD49oG95Dyyjk=; b=g+gGlY
        SZqmt/8jk1GWkRuga6dk42sSXC/VqdsunOYC9kmwF6fDSS+CMN0XY50IweTYRr4Z
        TMNz1Nxz76Ij3ZRwXxA4YiY3AQ78xCzZqivrKJoUG+3Odo+ugLbDnwMtCKVXPh12
        fx2IPupCJu6YfaUPTWZ80wvhS+yyDFofJ5aIM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=a5WTZmFs1AA3RVOgfH6JP6F9Jjju4c3d
        Gd09NaiA5VycV+hJHuigKxd8ROsvBRLi24iljCA0XgOUsc2QbQ1B8MpKskQ0lZA/
        PgFDe0Dzi3oGxcuUGZpn8Rnsb/8rNot52NbGYy4XWiS8aUqpFvV/T40yDTSp+oXs
        aL6WlbSMLe0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4CFE847D3B;
        Tue, 18 Oct 2016 16:31:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BCCC547D38;
        Tue, 18 Oct 2016 16:31:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2016, #04; Mon, 17)
References: <xmqqtwcasj8y.fsf@gitster.mtv.corp.google.com>
        <9F780406-FC77-4B3E-AEEB-7F6215E6702C@gmail.com>
Date:   Tue, 18 Oct 2016 13:31:27 -0700
In-Reply-To: <9F780406-FC77-4B3E-AEEB-7F6215E6702C@gmail.com> (Lars
        Schneider's message of "Tue, 18 Oct 2016 13:27:48 -0700")
Message-ID: <xmqq4m49pffk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D9B93534-9571-11E6-BF01-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>> On 17 Oct 2016, at 15:28, Junio C Hamano <gitster@pobox.com> wrote:
>> ...
>> 
>> * ls/filter-process (2016-10-17) 14 commits
>> - contrib/long-running-filter: add long running filter example
>> - convert: add filter.<driver>.process option
>> - convert: prepare filter.<driver>.process option
>> - convert: make apply_filter() adhere to standard Git error handling
>> - pkt-line: add functions to read/write flush terminated packet streams
>> - pkt-line: add packet_write_gently()
>> - pkt-line: add packet_flush_gently()
>> - pkt-line: add packet_write_fmt_gently()
>> - pkt-line: extract set_packet_header()
>> - pkt-line: rename packet_write() to packet_write_fmt()
>> - run-command: add clean_on_exit_handler
>> - run-command: move check_pipe() from write_or_die to run_command
>> - convert: modernize tests
>> - convert: quote filter names in error messages
>> 
>> The smudge/clean filter API expect an external process is spawned
>> to filter the contents for each path that has a filter defined.  A
>> new type of "process" filter API has been added to allow the first
>> request to run the filter for a path to spawn a single process, and
>> all filtering need is served by this single process for multiple
>> paths, reducing the process creation overhead.
>
> Hi Junio,
>
> what do you think about v11? Do you feel the series is becoming mature
> enough for `next`?

I've already had that feeling a few rounds ago, but I haven't had a
chance to read the most recent one carefully myself to answer that
question honestly.

