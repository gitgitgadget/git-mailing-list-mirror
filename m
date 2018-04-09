Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C1A21F404
	for <e@80x24.org>; Mon,  9 Apr 2018 13:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751667AbeDINgx (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 09:36:53 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:56639 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751455AbeDINgw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 09:36:52 -0400
Received: from arbeitsviech ([141.201.13.56]) by mrelayeu.kundenserver.de
 (mreue103 [212.227.15.183]) with ESMTPSA (Nemesis) id
 0MDEgG-1fHbFr3ytI-00GYam; Mon, 09 Apr 2018 15:36:48 +0200
Date:   Mon, 9 Apr 2018 15:36:27 +0200
From:   Florian =?utf-8?Q?Gamb=C3=B6ck?= <mail@floga.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Szeder =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [RFC PATCH 1/1] completion: load completion file for external
 subcommand
Message-ID: <20180409133627.GA25078@arbeitsviech>
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Szeder =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqlgdw67rc.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Provags-ID: V03:K1:XdaJVQtqX+lRrfkvXMXrzbqO04GwGetX++mp8xCIFo2o80l30b8
 GlSVZ//pg99GfWH+JevjsgMbgJ9yctjijuJU2bJMOObgNu3Ov4tUwE5rNuNGec5hdiJXzg2
 x7hXPW21/stTRHGayLcamibEjUo3hwHXg2dISqG4zaWI3TzlSB02UxWkquSx5QNsK0trm3y
 dU38WKMkCD9OkNmB03hDA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iGXXhzrGbwM=:KZkR4pHh82ZsqXCE73pVPX
 K6l9KV/wdIPz/CyIwBGEovXBRkZxb25eqehbGCjSLQfZoD2TsLsuVHKqbwTAWxKAojhuWsas1
 xKd0DS5PkgNTM3k0/Wqc/bIOLroTXhnanIV6mYim3Rq9hfPtOAmcxhhAdQxaxelbpaI3GRnlJ
 Tx/+1uaovR+GLWwPvLtuwsyWOudXj0w9Hj4TBYnXLw3MqI0kcCY3N/53XLx6OTjlgpfhANWg+
 NGVPVCYzDqWDKV+ccqfuUBRveCIz+Ibvhsb+X3+gH8vfZEwhHX7QjoOEeyKLs1ToLbWXWfXkP
 goafisnVe6PBPYkB0Ysfcy8oqtDLk4WE+ZSfe2IZjOX5rrLTnRgsuNU7N6MSJuhXlnDZWw9yi
 2a4U3XqllZ1xTfo6gOt5Kj4CSe4Z/kEhE7r6gAAcBdcr5N4iWwcpCH1Z4krUO6uiBWxrmAFey
 Vk5Qjw9DxWaTcj4W8ITE7zJuku9L+E/+bTWTUSeXQdf5PxboJUFYCmZGDqLDFKcL1RRoaKvxu
 D8Dsi28KcRx7+k5hGRcgyrUNoMEEP66DUB2PGg/oakvZ3qRUr9S7FKb1uqkcLdIVgVHtfwBRU
 ysvzQIeUM95VdOKPYOirXKBoxXLivT1TtMDz6HcHcpzMZTSqT9GJsoHuBBbPItOHPWsvTbA1d
 prFvhvXKm1Gr0M0VBXczlIDV0iU1c70I+6UotQNVLow56suTe6La8h6wcNdXjgP11Ln/s873p
 tivecmYJNXpGKlIna+5P1F2cs+2lzXCf8aH4UQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-04-09 18:36, Junio C Hamano wrote:
> Florian Gamböck <mail@floga.de> writes:
> 
> > Good point. I could go even further and ditch the if-construct:
> >
> >    ! declare -f $completion_func && declare -f __load_completion &&
> >        __load_completion "git-$command"
> 
> I personally find that a lot harder to read than if/then/fi.

Then I mis-understood you the first time. It sounded a bit as if you
wanted to avoid if-fi. After all, the rest of this code block also uses
quite long &&-chains.

Then we are back at the first question:

> >  	local completion_func="_git_${command//-/_}"
> > +	if ! declare -f $completion_func >/dev/null 2>/dev/null; then
> > +		declare -f __load_completion >/dev/null 2>/dev/null &&
> > +			__load_completion "git-$command"
> 
> wouldn't the above be easier to read if it were
> 
> 	if ! declare ... $completion_func ... && declare -f __load_completion
> 	then
> 		__load_completion "git-$command"
> 	fi
> 
> or is there a reason why it is better to &&-chain the check for
> __load_completion with its use?

As for readability, I would prefer my first approach then with the
following reasoning: Checking the existence of a function and actually
calling it can be seen as a unit. Either the function does not exist or
you call it. You could even create a function like "call_if_exists",
that does exactly this. Either way, at the end of the line you are
smarter than before. As for the if-statement, this describes the reason
why you even want to load an external file. If the function in question
($completion_func) already exists, we do not want to load it again. If
you chain the statement with the existence check of __load_completion,
you make it look like those two functions are somehow related, which is
not the case.

To put it in words: "If $completion_func does not already exist, then
load another file (if you know how to do that)." versus "If
$completion_func does not yet exist and you know how to load another
file, then load another file." The difference is subtle, but I think the
first sentence better describes the intention.

Does my reasoning make sense? I mean, the result will be exactly the
same, we are clearly only talking about readability here.
