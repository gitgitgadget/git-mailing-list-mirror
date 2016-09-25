Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 251E71F4F8
	for <e@80x24.org>; Sun, 25 Sep 2016 22:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938615AbcIYWwv (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Sep 2016 18:52:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52502 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754918AbcIYWwu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Sep 2016 18:52:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 814CB41E01;
        Sun, 25 Sep 2016 18:52:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JNGPFK1C+t8kc2UTJq3+G+yJ7dA=; b=ShQEW5
        vt7Ud0lgRMAY/S+E69oou1q9oxL40nruLMbOPHbrW8CG4PoILAnBIh4ar7xJ0vcK
        Ql1oAJo0oH1PdNCEvCHndZc/AsGqgcVPbLqS0tkpQIhSD82YbhuA/jyL9D6eXOZa
        vapTSPQQD4NDai3KsusHM51BDchLxRbFnLi0M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bF7aPvW4xP62/Vlb7z5Rw/rj5T6Ob267
        JJrChxPe4hMLuWEKB6e7hBmgTdP9a104tMkKn12pOY6nJvsYFLP4Q9GVigAS+aSZ
        sIgd8t9yJmp/87tA+fp78RXu2sGAiIvzbkRPcUgckyv/lnwZgyK1HVxo1ZPH+aOW
        lvS1xQm1cIE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 793D541E00;
        Sun, 25 Sep 2016 18:52:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F0F9741DFF;
        Sun, 25 Sep 2016 18:52:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vasco Almeida <vascomalmeida@sapo.pt>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2 01/11] i18n: add--interactive: mark strings for translation
References: <1472646690-9699-1-git-send-email-vascomalmeida@sapo.pt>
        <1472646690-9699-2-git-send-email-vascomalmeida@sapo.pt>
Date:   Sun, 25 Sep 2016 15:52:45 -0700
In-Reply-To: <1472646690-9699-2-git-send-email-vascomalmeida@sapo.pt> (Vasco
        Almeida's message of "Wed, 31 Aug 2016 12:31:20 +0000")
Message-ID: <xmqqr387y4le.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C79F7130-8372-11E6-A5D2-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> Mark simple strings (without interpolation) for translation.
>
> Brackets around first parameter of ternary operator is necessary because
> otherwise xgettext fails to extract strings marked for translation from
> the rest of the file.
>
> Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
> ---
>  git-add--interactive.perl | 68 +++++++++++++++++++++++++----------------------
>  1 file changed, 36 insertions(+), 32 deletions(-)
>
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index 822f857..fb8e5de 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -4,6 +4,7 @@ use 5.008;
>  use strict;
>  use warnings;
>  use Git;
> +use Git::I18N;
>  
>  binmode(STDOUT, ":raw");
>  
> @@ -252,7 +253,7 @@ sub list_untracked {
>  }
>  
>  my $status_fmt = '%12s %12s %s';
> -my $status_head = sprintf($status_fmt, 'staged', 'unstaged', 'path');
> +my $status_head = sprintf($status_fmt, __('staged'), __('unstaged'), __('path'));

Wouldn't it make sense to allow translators to tweak $status_fmt if
you are allowing the earlier elements that are formatted with %12s,
as their translation may not fit within that width, in which case
they may want to make these columns wider?

>  			prompt_yesno(
> -				'Your edited hunk does not apply. Edit again '
> -				. '(saying "no" discards!) [y/n]? '
> +				# TRANSLATORS: do not translate [y/n]
> +				# The program will only accept that input
> +				# at this point.
> +				__('Your edited hunk does not apply. Edit again '
> +				   . '(saying "no" discards!) [y/n]? ')

Not just [y/n], but "no" in "saying no discards!" also needs to
stay, no?  I wonder if it is a good idea to lose the TRANSLATORS
comment by ejecting "[y/n]" outside the "__()" construct here.
