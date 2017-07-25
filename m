Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7F611F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 19:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751379AbdGYTFc (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 15:05:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59700 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750911AbdGYTFc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 15:05:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 85A92A1413;
        Tue, 25 Jul 2017 15:05:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=82BoGvuFtCIWOuB+0oD8OhaJ6sk=; b=isZDJE
        sM1beKCjw3jNjruaVt/slP2JO91QNNsK8lXvsI9nFurjY6kBptW6EBp2Q9y0XAHF
        HV6AdyfJMnJG0Qum0Cw4WHdJNLxMLUdmdOhqOKNteylDbgEhYjgP/cp7euZZHib3
        6KItXKp12fEEmf+KEuN7oOxYnJR/CzmNp7wDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fDDkPlQd6LpGzueKSRJjWhQ0GN+E/SXR
        SpLn48P1ENeZJjjFBsTimGHXdfYXZJUhcKWjvyfKidT6ggyBjWaMWc67WKnlfbE3
        YPJncY1t7Ztf1/skWvosXqUaAzRqsILyBCKLUTnAohjZPYQIa5JiBHRzWHaSZV4o
        IsdMObexoiw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7D554A1412;
        Tue, 25 Jul 2017 15:05:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E0FEBA1411;
        Tue, 25 Jul 2017 15:05:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Heiduk <asheiduk@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] doc: add missing "none" value for diff.wsErrorHighlight
References: <20170724223021.9124-1-asheiduk@gmail.com>
Date:   Tue, 25 Jul 2017 12:05:28 -0700
In-Reply-To: <20170724223021.9124-1-asheiduk@gmail.com> (Andreas Heiduk's
        message of "Tue, 25 Jul 2017 00:30:21 +0200")
Message-ID: <xmqqa83sbamf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3A768D78-716C-11E7-8830-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Heiduk <asheiduk@gmail.com> writes:

> The value has not eluded documentation so far.

I am not sure what "has not eluded" means in this context (did you
mean "has eluded"?).  

The patch text itself is not wrong per-se, but if we are to add
documentation for 'none', diff-options.txt must also document that
it clears the default and previously given values, unlike new, old
and context that are cumulative.  For that matter, we do not list
'default' and 'all' (which also clears the previous ones before
setting their own) in that three-item list, either.

I think we need to either 

 - make it to a six-item list and then describe that 'none', 'all'
   and 'default' clear the slate before taking any effect, or 

 - keep it three-item list of cumulative things, and then in the
   sentence that talks about `all` in Documentation/diff-options.txt
   to also explain what 'default' and 'none' do.

Thanks.

> Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
> ---
>  Documentation/diff-config.txt  | 2 +-
>  Documentation/diff-options.txt | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
> index cbce8ec63..c84ced8f6 100644
> --- a/Documentation/diff-config.txt
> +++ b/Documentation/diff-config.txt
> @@ -200,7 +200,7 @@ diff.algorithm::
>  +
>  
>  diff.wsErrorHighlight::
> -	A comma separated list of `old`, `new`, `context`, that
> +	A comma separated list of `old`, `new`, `context` and `none`, that
>  	specifies how whitespace errors on lines are highlighted
>  	with `color.diff.whitespace`.  Can be overridden by the
>  	command line option `--ws-error-highlight=<kind>`
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index 89cc0f48d..903d68eb7 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -302,7 +302,7 @@ ifndef::git-format-patch[]
>  --ws-error-highlight=<kind>::
>  	Highlight whitespace errors on lines specified by <kind>
>  	in the color specified by `color.diff.whitespace`.  <kind>
> -	is a comma separated list of `old`, `new`, `context`.  When
> +	is a comma separated list of `old`, `new`, `context` and `none`.  When
>  	this option is not given, only whitespace errors in `new`
>  	lines are highlighted.  E.g. `--ws-error-highlight=new,old`
>  	highlights whitespace errors on both deleted and added lines.
