Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58CE620899
	for <e@80x24.org>; Sat, 12 Aug 2017 04:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750762AbdHLEjV (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Aug 2017 00:39:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63500 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750743AbdHLEjU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Aug 2017 00:39:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C07BB99BF3;
        Sat, 12 Aug 2017 00:39:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8YBZNDgiXeotLGNS8vgM7hXQTmY=; b=nAcprO
        lSZFTl3g+gtOAQ1BJTJS9JXQBbcUkjcYGR4szb/lXvCZjS46Y4aBm9XlYwzQXtaL
        o/XTIW2I1jTk1OXjumruGsHZ3PkyzE0vXSj6rEduEym+iMD9QphFzzvyqylF4L5w
        DZBTnb43WW8j+xtNPWtEa8ybQMwGgtFvS5pPE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qGiHukgkaG0fKX/VOAk1HezhxRfHygxx
        iLR8/nm/hbsM7l0hP19vStYCnWhL4VV6+zz5y3aMm66QxfhwD1swxkxoSBxeVDPX
        avSdT++NxkrfrnUK88QsP2BuCtUHNbFDdpRfR92nadyjSdKye/q/iJioZmODd2GL
        jp5rZaQ6l7s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B717C99BF2;
        Sat, 12 Aug 2017 00:39:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2A6F699BF1;
        Sat, 12 Aug 2017 00:39:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC] clang-format: outline the git project's coding style
References: <20170808012554.186051-1-bmwill@google.com>
        <20170809130127.ekd4tvyp2rrb7ftk@sigill.intra.peff.net>
        <87y3qsg7ni.fsf@gmail.com>
        <CAGZ79kYEyebHxFO++u5RkPBj16xx5nMcahBPxra4xWUfMrXydA@mail.gmail.com>
        <CAGZ79kZRhTNez1jJq+DcCyERufd_YfWK7L+ujPjRCivzHz7LBw@mail.gmail.com>
        <20170811175237.GC59325@google.com>
        <20170811211845.tpgmafenhahus77o@sigill.intra.peff.net>
Date:   Fri, 11 Aug 2017 21:39:11 -0700
In-Reply-To: <20170811211845.tpgmafenhahus77o@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 11 Aug 2017 17:18:45 -0400")
Message-ID: <xmqq378xxuvk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 30269DCC-7F18-11E7-9260-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Aug 11, 2017 at 10:52:37AM -0700, Brandon Williams wrote:
>
>> On 08/09, Stefan Beller wrote:
>> > On Wed, Aug 9, 2017 at 3:53 PM, Stefan Beller <sbeller@google.com> wrote:
>> > 
>> > > I would think based on these options, a pre commit hook can be
>> > > written that formats precisely the touched lines of code of each file.
>> > 
>> > I did not search enough, "clang-tidy-diff.py --fix" should be all that is needed
>> 
>> I believe clang-tidy is different from clang-format am I mistaken?
>
> Yeah, I just dug in the archive. The script I ran way back when was
> actually clang-format-diff.

I am confident with the competence of people around here that we can
come up with a reasonable checker for obvious style violations. In
the worst case, we could customize and/or tweak checkpatch.pl and
start from there.

Assuming that we can have such a checker, I am more interested in
the way how people envision such a checker fits in our workflow to
help people.  Earlier Dscho floated an idea to integrate with the
GitHub pull requests in a way similar to how Travis and SubmitGit
are triggered, and I can sort of see how it may help, but I haven't
seen ideas from others.
