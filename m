Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EDAE207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 17:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934559AbcI2RiU (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 13:38:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55454 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934267AbcI2RiS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 13:38:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E5EED40C33;
        Thu, 29 Sep 2016 13:38:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YqFnETRuO4r22roCNi2WKfc2k8I=; b=TQAlHB
        dNQO7gADOGXfIY6uYAe2e+A7I6xhWOfUXyWgoOKmOcODamazpnewMX6WieudhgHH
        uFYW276/xucapNIWpKmRKcvGZ/TszToO6KAFoAZqDOdTYBJChLyYANKshRo9ExDq
        Plz/2ehgXU13O/HAN//rmMS6RjfgDABRrBhQM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kLxYLIINPJo/wvWl6KtvCOoMfZT7m3No
        VNAK0N6cjbzL2ToHkbChGbT2fuEiZfWLq96K4CWIABCm+1rDs0o3pdK1wFh5LBnz
        rzXexvL2FmCAlvKW9pO3wINCD7qwKXbHRd2kiYedh7Dv58B0tQ1+E+cnd/n0LgAW
        h9gEX+KE+0k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DCF6F40C31;
        Thu, 29 Sep 2016 13:38:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 60D3C40C30;
        Thu, 29 Sep 2016 13:38:16 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "Kyle J. McKay" <mackyle@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH/RFC] git log --oneline alternative with dates, times and initials
References: <git-log-times@mackyle-at-gmail-com>
        <20160929083315.vwb3aurwbyjwlkjn@sigill.intra.peff.net>
        <82EE6519-E58F-4382-87A5-55D9D1BBDCA9@gmail.com>
        <20160929125238.hifkxe7cmyebg64u@sigill.intra.peff.net>
Date:   Thu, 29 Sep 2016 10:38:14 -0700
In-Reply-To: <20160929125238.hifkxe7cmyebg64u@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 29 Sep 2016 08:52:38 -0400")
Message-ID: <xmqqy42afvy1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 80EE6740-866B-11E6-B4F9-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> Those patches are missing some of the features like showing root commits,
>> handling two letter initials, showing the weekday, inserting a break where
>> needed to avoid parent-child confusion in graph output and properly handling
>> Duy's initials. :)
>
> I'm not too surprised. I literally looked at the first screenshot from
> your output and thought "surely git can do that with some minor tweaks".
> Nor am I surprised that there are cases where the output is funny (99%
> of the time I spent on it was tracking down that graph-padding bug).
>
> I have no problem taking this in contrib or whatever, until a point when
> Git is capable of doing the same thing itself. I just hoped to trick you
> into working on Git. :)

I thought we stopped adding random things to contrib/, though.

Unlike the earlier days of Git, if a custom command that uses Git is
very userful, it can live its own life and flourish within the much
larger Git userbase we have these days.
