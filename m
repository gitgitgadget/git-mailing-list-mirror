Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BE931FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 20:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753081AbcHZUYx (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 16:24:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53280 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751802AbcHZUYv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 16:24:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1BF0539142;
        Fri, 26 Aug 2016 16:21:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3ezOw0JwlMDQhKbLmVIMfP7roYU=; b=rQVD7h
        1IK0NyoBu9vpsSp4HwLQHr9/I0QHG09WpfVFG+C3104kDLonHhh2pd2o5BbdkM+O
        xVvawzHc283uZi459Ab8OCSdfLpn6IPK5KhrTyRVHK8Oh8OVZSxuldFA48yDD1aK
        reNb/YDrDUfhWvGj55Koa7mJXaELywUU1bk34=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rtGJLhSfsunFSAIpivyIszaoelXmi35K
        9JF8GulyvCNPzqj4CtZwpTrErbpG7g+S4hz4GV4nhdWPVDJEFXGR8Rj5Vrnng9wo
        TjNnfLYXwjEweW37UkRURtiQ2UHw0/OG0+RThyi8CRSElUa601VIcYNOuvnuo0DK
        jZoy5tcaTC8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D5FF239141;
        Fri, 26 Aug 2016 16:21:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E6FA939140;
        Fri, 26 Aug 2016 16:20:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ralf Thielow <ralf.thielow@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Joseph Musser <me@jnm2.com>,
        Philip Oakley <philipoakley@iee.org>,
        John Keeping <john@keeping.me.uk>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 2/3] help: introduce option --exclude-guides
References: <20160818185719.4909-1-ralf.thielow@gmail.com>
        <20160826175836.14073-1-ralf.thielow@gmail.com>
        <20160826175836.14073-3-ralf.thielow@gmail.com>
        <xmqq8tvjgxiy.fsf@gitster.mtv.corp.google.com>
        <CAN0XMOKo0VXPZF8ve2e1N5f591Kkz-Gmxt4wJKsev2zj4ubj9w@mail.gmail.com>
Date:   Fri, 26 Aug 2016 13:20:57 -0700
In-Reply-To: <CAN0XMOKo0VXPZF8ve2e1N5f591Kkz-Gmxt4wJKsev2zj4ubj9w@mail.gmail.com>
        (Ralf Thielow's message of "Fri, 26 Aug 2016 22:00:48 +0200")
Message-ID: <xmqqfuprffiu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9A71C8E4-6BCA-11E6-A48C-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ralf Thielow <ralf.thielow@gmail.com> writes:

>>> As we pass a URL, Git won't check if the given path looks like
>>> a documentation directory.  Another solution would be to create
>>> a directory, add a file "git.html" to it and just use this path.
>>
>> I think this is OK; with s|As we pass a URL|As we pass a string with
>> :// in it|, the first sentence can be a in-code comment in the test
>> that does this and will help readers of the code in the future.
>
> Hmm. The "://" is really a URL thing.

Perhaps you thought so, but no, "mailto:ralf.thielow@gmail.com" is a
perfectly valid URL.

Because you are explaining why test://html was chosen, and the real
reason is any path that is !strstr(path, "://") is subject to an
additional "This must be a local path" check and you wanted to avoid
it, "As we pass a URL" is unnecessarily vague (and incorrect--we
cannot use a mailto: URL to sidestep the check).

>> *1* Can you immediately tell why this test is broken?
>>
>> test_expect_success "two commits do not have the same ID" "
>>         git commit --allow-empty -m first &&
>>         one=$(git rev-parse --verify HEAD) &&
>>         test_tick &&
>>         git commit --allow-empty -m second &&
>>         two=$(git rev-parse --verify HEAD) &&
>>         test $one != $two
>> "
>>
>
> I'm afraid I can't.

The reason becomes clear if you put your feet into shell's shues.
Before being ablt to call test_expect_success, you would need to
figure out what strings you give as its parameters.  $1 is clear in
this case, a simple string "two commits do not have the same ID"
(without double quotes).

But what goes in $2?  Especially the part around "one=..."?

Because the whole thing is inside a double-quote pair, $() and $name
are all interpolated even before test_expect_success is called.
So the above becomes equivalent to

>> test_expect_success "two commits do not have the same ID" '
>>         git commit --allow-empty -m first &&
>>         one=5cb0d5ad05e027cbddcb0a3c7518ddeea0f7c286 &&
>>         test_tick &&
>>         git commit --allow-empty -m second &&
>>         two=5cb0d5ad05e027cbddcb0a3c7518ddeea0f7c286 &&
>>         test !=
>> '

(using whatever commit HEAD was pointing at before this test starts
to run), which obviously is not what we expected to see.

