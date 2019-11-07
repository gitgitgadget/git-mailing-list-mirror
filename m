Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D11C01F454
	for <e@80x24.org>; Thu,  7 Nov 2019 05:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfKGFye (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 00:54:34 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65033 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfKGFyd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 00:54:33 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5F5F291814;
        Thu,  7 Nov 2019 00:54:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pTPgmA4qXJ/Dv1A548da8Z6pUZI=; b=oHOb/K
        I2ZmhFaWoarS1J7azErmZYHX+YiFG+A7e4EdBpY4qZOilb987lqZXXYAfdCQcc8U
        qTbRcefNZ1VUmb2JibqitOJCMWmge+/BFmVdtECH0paE5PWGuO0Zf9j8DymWLTov
        cpQLc5ZECz+dRl4bongbo9MpsItAt9pGJCGrI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aJQmZd0j/I8VIsMF1IwBNOOvTjVB3Zws
        O78VEiU9cLPgkT1Nq+n90vct9PJVg9PXj09luwySCLiryvkJ+egKfpbbpwuD2Js2
        hNNuCZFQzhwyxJgcM35CiLSHwvo1cDUblkrJYRpvDPgc7u+CG2Gf8HtY3hJycXC6
        06bPr5DKk9M=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 57C8891813;
        Thu,  7 Nov 2019 00:54:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8343891811;
        Thu,  7 Nov 2019 00:54:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Cc:     Alexandr Miloslavskiy via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 4/5] doc: commit: unify <pathspec> description
References: <pull.445.git.1572895605.gitgitgadget@gmail.com>
        <251d06e27f6bc93b190450ae6e1087a3126b5e52.1572895605.git.gitgitgadget@gmail.com>
        <xmqq8sotvcar.fsf@gitster-ct.c.googlers.com>
        <6cd64094-d229-ef96-86fd-e64accd759d4@syntevo.com>
Date:   Thu, 07 Nov 2019 14:54:28 +0900
In-Reply-To: <6cd64094-d229-ef96-86fd-e64accd759d4@syntevo.com> (Alexandr
        Miloslavskiy's message of "Wed, 6 Nov 2019 16:56:54 +0100")
Message-ID: <xmqqk18cqlij.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 10CC3C72-0123-11EA-BD97-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com> writes:

> I think I have implemented most suggestions in PatchV2. Thanks!
>
>> I am not sure if we want to repeat this all over the place.
>>
>> We do not say "For details about the <commit> syntax, see the
>> 'SPECIFYING REVISIONS' section of linkgit:git-rev-parse[1]" for
>> every command that takes <commit> from the command line.
>>
>> Is your urge to suggest adding this sentence coming from that you
>> are much more familiar with <commit> than <pathspec>?  In other
>> words, if you were more familiar with Git, would you still be adding
>> this (and not corresponding one for <commit>)?
>
> Commit is a well known term, dating from ancient times like CVS or
> even older.

That's more or less irrelevant.  

I am reacting to this from your change that you omitted quoting in
your reply:

> +For more details about the <pathspec> syntax, see the 'pathspec' entry
> +in linkgit:gitglossary[7].

That sentence is for those who have some notion of <pathspec> but
does not know enough about its syntax.

CVS does not let you specify <commit> like "master^{/^fix frotz}~4";
A user a user who is familiar with CVS's commits would still want to
refer to the section "For details about the <commit> syntax".

I am not advocating to add the reference to SPECIFYING REVISIONS
section; instead we should let readers know that every time they see
<defined word>, they can refer to the glossary for more details.

> Pathspec, however, is something new.

Compared to CVS, everything in Git may be new, but that was a news
in 2010, not this year.
