Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18CFA20898
	for <e@80x24.org>; Mon, 14 Nov 2016 21:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933166AbcKNVKe (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Nov 2016 16:10:34 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57870 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932462AbcKNVKd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2016 16:10:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 338FB4E2A5;
        Mon, 14 Nov 2016 16:10:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=duC7E3P0lXA4S88QEoRogPTEIPc=; b=ZbxcFB
        3VFJHYbLTPgxqodoh3kd/Zz+nWYVprHXgcGoBb2O2oOG7uFLXxAmT5mNrdQb2MMz
        xpM0YPimcJ3ard7BdVucRpjl89NvFbPh5Z9GAm+znk6RemQevjs1U0jTFMYSBk6J
        UaoBSqd/lIW78TAKO7nFXck4HHfURp4hBNaGw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IAYfPnjNehzjKhrGJ7Yf+r8gCnv68lyN
        LqdKUep6FeUHH+O3YMm1y+jNuJA3HkRMBa0HW1b0JgkuDn+hjee1tIbj7ZQQQ0kh
        ampxW+w3+xjBZwq9P7nV0fXcgcbv3wiGxTgdT3GZo5wMXVskGWW34n7ICNiX4Mlk
        +CdvXOCsRtA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 28C504E2A3;
        Mon, 14 Nov 2016 16:10:32 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9EC744E2A2;
        Mon, 14 Nov 2016 16:10:31 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@drmicha.warpmail.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jacob Keller <jacob.keller@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [RFC/PATCH 0/2] git diff <(command1) <(command2)
References: <20161111201958.2175-1-dennis@kaarsemaker.net>
        <xmqqinrt1zcx.fsf@gitster.mtv.corp.google.com>
        <CA+P7+xrFYj7sepdz1xrEEaqmXQWfRkBz3CsWjYK6OZsZRMLbUA@mail.gmail.com>
        <alpine.DEB.2.20.1611121106110.3746@virtualbox>
        <0c39be16-76f8-0800-41a2-b7b1dccdd652@drmicha.warpmail.net>
        <xmqqoa1ix7nq.fsf@gitster.mtv.corp.google.com>
        <a3db4c55-550c-f2e8-83b8-46c2be86f7da@drmicha.warpmail.net>
Date:   Mon, 14 Nov 2016 13:10:30 -0800
In-Reply-To: <a3db4c55-550c-f2e8-83b8-46c2be86f7da@drmicha.warpmail.net>
        (Michael J. Gruber's message of "Mon, 14 Nov 2016 21:23:07 +0100")
Message-ID: <xmqqtwb9wywp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C6C5AE1A-AAAE-11E6-8C23-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Junio C Hamano venit, vidit, dixit 14.11.2016 19:01:
>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>> 
>>> *My* idea of --no-index was for it to behave as similar to the
>>> --index-version as possible, regarding formatting etc., and to be a good
>>> substitute for ordinary diff. The proposed patch achieves exactly that -
>>  ...
> It's not clear to me what you are saying here - 1/2 makes git diff
> follow symbolic links, yes, just like ordinary diff.

Yes, which can be seen as deviating from your earlier "as similar to
the --index version as possible" goal, which I think was where Dscho's
complaint comes from.

I _think_ the no-index mode was primarily for those who want to use
our diff as a replacement for GNU and other diffs, and from that
point of view, I'd favour not doing the "comparing symbolic link?
We'll show the difference between the link contents, not target"
under no-index mode myself.  That is a lot closer to the diff other
people implemented, not ours.  Hence the knee-jerk reaction I gave
in

http://public-inbox.org/git/xmqqinrt1zcx.fsf@gitster.mtv.corp.google.com


