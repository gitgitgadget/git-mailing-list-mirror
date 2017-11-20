Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78E2020954
	for <e@80x24.org>; Mon, 20 Nov 2017 03:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751072AbdKTDLT (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Nov 2017 22:11:19 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53670 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751029AbdKTDLS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Nov 2017 22:11:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F3E4DB719C;
        Sun, 19 Nov 2017 22:11:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8bhPSYg1vIoEHJ8kaPKI5PJFdNk=; b=OfnWHt
        R7F/3CTDtjN8i3fnALnQp+yInRNrilZR5ulQ8BfigfqmjJaDg1Mb/h0uG6lI2ot+
        KDxg1eXHHK5NjwNog0IkYaXSOVrv26+m6KGy+cp7QrovjZD1jMphsQ5M6qgl9S49
        viU7ysM6Xru9oo85mTQ2JtfcL8+p0V6HtiKX8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=D2tX7stOetXss6t6GtMYFt3HacKxbpFX
        4Ei7BsEQLaRwNh5qxAF5/yLzz/609xh6qsNCNjuhD94L45wq4ke5fTRb0aDOOj4n
        jVVKOtUsVheSZd0Pnh9sIikx3W70apxyjpYzFJLbWMLfOlrvWWbhAnkXGMA+oTL3
        kGaoYL/S0io=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EABC6B719B;
        Sun, 19 Nov 2017 22:11:15 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6B171B7198;
        Sun, 19 Nov 2017 22:11:15 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>, Beat Bolli <dev+git@drbeat.li>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] contrib/git-jump: allow to configure the grep command
References: <20171119230536.1628-1-dev+git@drbeat.li>
Date:   Mon, 20 Nov 2017 12:11:13 +0900
In-Reply-To: <20171119230536.1628-1-dev+git@drbeat.li> (Beat Bolli's message
        of "Mon, 20 Nov 2017 00:05:36 +0100")
Message-ID: <xmqqh8tpmypa.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 784809CA-CDA0-11E7-873D-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Beat Bolli <dev+git@drbeat.li> writes:

> Add the configuration option "jump.grepCmd" that allows to configure the
> command that is used to search in grep mode. This allows the users of
> git-jump to use ag(1) or ack(1) as search engines.
>
> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> ---

Thanks.  The contrib/README file has this to say (also read the
surrounding text):

    ... If
    you have patches to things in contrib/ area, the patch should be
    first sent to the primary author, and then the primary author
    should ack and forward it to me (git pull request is nicer).

Peff, I think we need a clear indication in contrib/git-jump/README
to whom patches to the area should be sent.  I know how to run 

    $ git shortlog -n --no-merges contrib/git-jump

but not everybody does (or bothers).

>  contrib/git-jump/README   | 3 +++
>  contrib/git-jump/git-jump | 7 +++++--
>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/git-jump/README b/contrib/git-jump/README
> index 225e3f095..9f58d5db8 100644
> --- a/contrib/git-jump/README
> +++ b/contrib/git-jump/README
> @@ -63,6 +63,9 @@ git jump grep foo_bar
>  # same as above, but case-insensitive; you can give
>  # arbitrary grep options
>  git jump grep -i foo_bar
> +
> +# use the silver searcher for git jump grep
> +git config jump.grepCmd "ag --column"
>  --------------------------------------------------
>  
>  
> diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
> index 427f206a4..80ab0590b 100755
> --- a/contrib/git-jump/git-jump
> +++ b/contrib/git-jump/git-jump
> @@ -11,7 +11,8 @@ diff: elements are diff hunks. Arguments are given to diff.
>  
>  merge: elements are merge conflicts. Arguments are ignored.
>  
> -grep: elements are grep hits. Arguments are given to grep.
> +grep: elements are grep hits. Arguments are given to git grep or, if
> +      configured, to the command in `jump.grepCmd`.
>  
>  ws: elements are whitespace errors. Arguments are given to diff --check.
>  EOF
> @@ -50,7 +51,9 @@ mode_merge() {
>  # but let's clean up extra whitespace, so they look better if the
>  # editor shows them to us in the status bar.
>  mode_grep() {
> -	git grep -n "$@" |
> +	cmd=$(git config jump.grepCmd)
> +	test -n "$cmd" || cmd="git grep -n"
> +	$cmd "$@" |
>  	perl -pe '
>  	s/[ \t]+/ /g;
>  	s/^ *//;
