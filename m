Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 334711F45A
	for <e@80x24.org>; Mon, 12 Aug 2019 15:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfHLPrJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 11:47:09 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64596 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbfHLPrJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Aug 2019 11:47:09 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 22FA77D032;
        Mon, 12 Aug 2019 11:47:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6rcIW7edtoYF3TlLbPVK6IuBCIU=; b=Aj0Juf
        TdY1G5PL23Dux/YXnuT+LXcS0nMh/DvWPu6wfVipIKrqV4kJ9KEcmo8FqSyUxcZD
        HFxP90XRtpwEgcYUces/SE834rjAbTltXxxr9ehPDRfT94m1gCqWr0k81bVghSnw
        gaEpwZntYFR7qidoupx6vBsUplgP0OxnBj7yo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sAFDtkAwsj3TaVxiLbN+ejR6qk8SK9WX
        W8vWpyeHJtxA+Hn8X8BcgRkLLb3rSQsxVsZ7KH9E2bpKuxRIr76HqA1EVjvRelKX
        tUpV9jwLgZoVMPasBrmR3aeAuLfrimv/vsJly68lTKXhZjgDH0l4TmsAG1+BX6WN
        V5ie4n3bZGM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1AD4B7D031;
        Mon, 12 Aug 2019 11:47:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EC2957D02E;
        Mon, 12 Aug 2019 11:47:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Yagnatinsky\, Mark" <mark.yagnatinsky@bofa.com>
Cc:     'Torsten =?utf-8?Q?B=C3=B6gershausen'?= <tboegi@web.de>,
        "'git\@vger.kernel.org'" <git@vger.kernel.org>
Subject: Re: suggestion for improved docs on autocrlf
References: <9c79d35e48df4d28baf995ad3f5b0153@bofa.com>
        <20190808205631.e2647kxq74thotjb@tb-raspi4>
        <3269668c03a8482d8d854ec19dd43907@bofa.com>
        <577a66e0c26545aaa4795de3c5189c9d@bofa.com>
        <20190809033406.5t5ag3qmh36ideec@tb-raspi4>
        <0c1b48c9fad641689ead69fdd9f72d63@bofa.com>
        <20190811121004.guygurnopwwggvsp@tb-raspi4>
        <64c0a35825af4ff3956c6c9a5fb748bb@bofa.com>
Date:   Mon, 12 Aug 2019 08:46:59 -0700
In-Reply-To: <64c0a35825af4ff3956c6c9a5fb748bb@bofa.com> (Mark Yagnatinsky's
        message of "Mon, 12 Aug 2019 13:47:18 +0000")
Message-ID: <xmqqo90ubd3g.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6DC1EE26-BD18-11E9-B60D-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Yagnatinsky, Mark" <mark.yagnatinsky@bofa.com> writes:

> Wait a second... suppose a file is committed with CRLF line
> endings.  You're saying that even if I have autocrlf set to
> "input" or "auto", the file will never get "converted" to LF
> format unless I explicitly renormalize?  That sounds like a fairly
> sensible behavior, but it's not what I've observed in the past at
> all!  There have been plenty of times when I had "autocrlf" set to
> input which resulted in me changing line endings on commit I had
> no intention of changing!

Isn't that merely an effect of the fact that git add does not
bother with paths it knows unmodified, and the decision it makes if
a path is modified does not involve if the path's contents predate
what you have in the current .gitattributes and .git/config?

If you had committed two paths with CRLF, checked them out, flipped
the attribute so that they would be converted upon input, modified
one of them but not the other, and say "git add .", because the
relative age of .gitattributes and file contents do not get in the
picture, "git add ." would say "Ah, you have one modified file, so
we need to add its new contents to the index.  And you are telling
me to convert its line endings to LF while doing so."

