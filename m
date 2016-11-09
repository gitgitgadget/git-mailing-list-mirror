Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2F8E2035F
	for <e@80x24.org>; Wed,  9 Nov 2016 05:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751036AbcKIFze (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Nov 2016 00:55:34 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64007 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750803AbcKIFzd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2016 00:55:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 379684D8F0;
        Wed,  9 Nov 2016 00:55:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZnTBhs8VDN0huCMSOjF5trsUoqU=; b=W0XpCJ
        uhUx9bQrovSBAp4//Jdzon27M5idvhtazrQ/l2AFVCVV/TD7JQcn3kMN+J3UnaU9
        L5egISYFzvS6Ebt2U1TApeCbAz5jHFpOmR64ERAdAM0HwkBXQqdnIj2gCjlzaYBA
        oL8Tsp8VO8yxHbgVNzsUE1kbfwDjV7MAmtjYo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ANefVWv1e5XwTP7tlpxEFbVQ5jXo9i5y
        WvvT4nemblOfb+G5d3dtxCT6/nSq1H8yHV7vBYlq+WS48FNtvXuEloadMuW/H9Wq
        fmJAIQss0wcx+vEo467D20oLmPVdr21Ezei1EWS1IzTlNXTn7Bf+MW0I+ppFh+Cg
        GtDDZaTh2Cc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 276A84D8EF;
        Wed,  9 Nov 2016 00:55:32 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A74E94D8ED;
        Wed,  9 Nov 2016 00:55:31 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ian Jackson <ijackson@chiark.greenend.org.uk>
Cc:     Jeff King <peff@peff.net>, Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 5/6] config docs: Provide for config to specify tags not to abbreviate
References: <20161108005241.19888-1-ijackson@chiark.greenend.org.uk>
        <20161108005241.19888-6-ijackson@chiark.greenend.org.uk>
        <CA+P7+xoQFsN1tPvKCA6+aRMChFwpMs73D=2kwvVRcxALWK0mZQ@mail.gmail.com>
        <22561.44597.59852.574831@chiark.greenend.org.uk>
        <20161108215709.rvmsnz4fvhizbocl@sigill.intra.peff.net>
        <22562.32428.287354.214659@chiark.greenend.org.uk>
Date:   Tue, 08 Nov 2016 21:55:30 -0800
In-Reply-To: <22562.32428.287354.214659@chiark.greenend.org.uk> (Ian Jackson's
        message of "Wed, 9 Nov 2016 01:41:00 +0000")
Message-ID: <xmqqa8d9b3jh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1FBDD69A-A641-11E6-889A-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ian Jackson <ijackson@chiark.greenend.org.uk> writes:

>> I think the two things I found weird were:
>> 
>>   - it's in the "log" section, which makes me think it's an option for
>>     git-log. But it's not. I'm not sure what the _right_ section is, but
>>     hopefully it would make it clear that this is command-agnostic.
>> 
>>     Something like "gui.abbrevTags" might be OK (and as you note, has
>>     precedence). But of course it's possible that a command like "tig"
>>     could learn to support it.  I'm not sure if that counts as a GUI or
>>     not. :)
>
> I don't really have an opinion about the name.  gui.abbrevTags would
> be a possibility.  (It's a bit odd that implicitly, the default would
> be `*'.)

I have trouble with both "log" and "abbrev" in the name.  Perhaps I
am biased by our recent discussion on a feature in the core that we
use the word "abbrev" to describe, but I fear that most Git users,
when told the word, would imagine the act of shortening 40-hex full
object name down to shorter but still unique prefix, not the "this
refname is too long, so let's show only the first few letters in GUI
label".

And I do not think we would want "log" or any core side Porcelain
command to have too many "information losing" options like this
"truncate refnames down to a point where it is no longer unique and
meaningful".  GUI tools can get away with doing sos because they can
arrange these truncated labels to react to end-user input (e.g. the
truncated Tag in the history display of gitk could be made to react
to mouse-over and pop-up to show a full name, for example), but the
output from the core side is pretty much fixed once it is emitted.

So my first preference would be to teach gitk such a "please
clarify" UI-reaction, if it does not know how to do so yet.  There
is no need for a configuration variable anywhere with this approach.

If you do want to add a configuration to show fuller name in the
tag, which would make it unnecessary for the user to do "please
clarify, as I am hovering over what I want to get details of"
action, that may also be a good way to go.  But I think the right
place to do so would be Edit -> Preferences menu in Gitk, and the
settings will be stored in ~/.gitk or ~/.config/git/gitk or whatever
gitk-specific place.

