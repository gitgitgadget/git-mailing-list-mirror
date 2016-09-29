Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87371207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 18:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932684AbcI2SuZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 14:50:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57517 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751027AbcI2SuX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 14:50:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7A453418F8;
        Thu, 29 Sep 2016 14:50:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1ojpSdnbnDbMOtMtmdG4tXohEQY=; b=SmQNUO
        +dK3/OeJ1j4vDup6VwrJXFQo45xVKXbpECvK90WwCgoC+j2x8JqKvWEx9pMoy9DD
        JWS4UpLjIx0HRH3qKMgbqxjLMn0I63PSx8GReiQonDYrDQEFoV2i74jvoYMv9+W/
        CLD0eLfLlAkf2x9YeindXZmUKBf2/OMrvnF7k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=J/sc6c6/Tbr0OQqw8aVNoDOeVDPeOAZ9
        8t2pPUzvuUxfqrdn1wFoTFqYG/isDuHhPivvh1Ugw7vphR0jvqq6/rY3K98gczIm
        wfo7P2q10tVCYfX2ekghYriVj7IVzLTU0jqSiuFy/8SqgPOpt0P1NoF1wqlrJ7WD
        FFZ6qBBcdAg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 735E8418F7;
        Thu, 29 Sep 2016 14:50:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E8E20418F4;
        Thu, 29 Sep 2016 14:50:21 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "Kyle J. McKay" <mackyle@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH/RFC] git log --oneline alternative with dates, times and initials
References: <git-log-times@mackyle-at-gmail-com>
        <20160929083315.vwb3aurwbyjwlkjn@sigill.intra.peff.net>
        <82EE6519-E58F-4382-87A5-55D9D1BBDCA9@gmail.com>
        <20160929125238.hifkxe7cmyebg64u@sigill.intra.peff.net>
        <xmqqy42afvy1.fsf@gitster.mtv.corp.google.com>
        <20160929183006.exyaikr4ijiq5tp3@sigill.intra.peff.net>
Date:   Thu, 29 Sep 2016 11:50:19 -0700
In-Reply-To: <20160929183006.exyaikr4ijiq5tp3@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 29 Sep 2016 14:30:06 -0400")
Message-ID: <xmqqeg42fslw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9329B04A-8675-11E6-9037-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> But I also buy the argument that contrib/ is simply a hassle. This
> script can live in its own repository somewhere, and handle
> announcements and patches on the list.

I think the output of this script is largely personal preference,
which can be made to a project preference for a project enough of
whose participant so desires.

For example, I would not be surprised if this appeared next to
checkpatch.pl script in the kernel archive.  When a project that
uses Git to store its sources finds a need to summarize its log in a
standardized way that is not produced natively by Git, such a
project may add this script to its scripts/ area, just like a
project that wants to have a standard way to help its contributors
to avoid common style errors a lot more than our "diff" (which only
highlights whitespace errors) does may ship checkpatch.pl in it.

So in that sense, while I do not mean to say that the script itself
must become a standalone project that has only one script in it, I
do not think it belongs "our" contrib/, as we do not see a need to
standardize its output as the log summary standard we the Git
project uses on its own history.

On the other hand, your illustration of the needed bits to express
this particular output format used by Kyle's script, when polished,
does fit in our codebase.  We are interested in making it possible
for projects and users to do more by using Git with its standard
customization features.
