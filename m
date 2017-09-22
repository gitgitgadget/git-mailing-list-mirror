Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1749202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 01:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751846AbdIVB6O (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 21:58:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60493 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751602AbdIVB6M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 21:58:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 703F992C83;
        Thu, 21 Sep 2017 21:58:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HZyKuTL1gEPIXC/3gZx1cyefCEA=; b=LfHDPT
        ym2gqitGBjlksGWGMtLhvYlspiZ9zVP5dDiJdFPplcbkeDzMzQSTdJJ+EUQ1RJeR
        p45REWW1U6TLwsOCRUIcIkoOgKl1qHBnv0y43gjElnK3EkNQcHCSp1TaXxp61TJw
        JASvMkW/1aynqxxy9sLyCsm31Bd15C9CPfcV4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vbPsYtqfTdELdOLBoDm5R42r7rPZhkIr
        4D+OzFnUT+SHi1Z1FQYHxkkW/BktPrHbkeMoMpF3CR92UcTFAGR9mMBK1a1IPp17
        Dy1IM96Lmwcm5Yk5C+KOX7/4VXe05YfUmZB7k2/dSpXdV3aI7Ojxze5eASR0mVIv
        cBCOioWo/Mk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6889B92C80;
        Thu, 21 Sep 2017 21:58:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C73B292C7E;
        Thu, 21 Sep 2017 21:58:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     kaarticsivaraam91196@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH] Documentation/githooks: mention merge in commit-msg hook
References: <1505542931.27598.4.camel@gmail.com>
        <20170921202954.7854-1-sbeller@google.com>
Date:   Fri, 22 Sep 2017 10:58:10 +0900
In-Reply-To: <20170921202954.7854-1-sbeller@google.com> (Stefan Beller's
        message of "Thu, 21 Sep 2017 13:29:54 -0700")
Message-ID: <xmqqr2uzlcjx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7D10CCCA-9F39-11E7-895C-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> The commit-msg hook is invoked by both commit and merge now.
>
> Reported-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

Thanks for tying the loose end.  Very much appreciated.

>  Documentation/githooks.txt | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index 623ed1a138..f4e75b9c90 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -127,11 +127,10 @@ help message found in the commented portion of the commit template.
>  commit-msg
>  ~~~~~~~~~~
>  
> -This hook is invoked by 'git commit', and can be bypassed
> -with the `--no-verify` option.  It takes a single parameter, the
> -name of the file that holds the proposed commit log message.
> -Exiting with a non-zero status causes the 'git commit' to
> -abort.
> +This hook is invoked by 'git commit' and 'git merge', and can be
> +bypassed with the `--no-verify` option.  It takes a single parameter,
> +the name of the file that holds the proposed commit log message.
> +Exiting with a non-zero status causes the command to abort.
>  
>  The hook is allowed to edit the message file in place, and can be used
>  to normalize the message into some project standard format. It
