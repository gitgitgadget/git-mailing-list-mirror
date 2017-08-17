Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7420920899
	for <e@80x24.org>; Thu, 17 Aug 2017 20:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753746AbdHQU6c (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 16:58:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60794 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753238AbdHQU6b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 16:58:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EF85E904CE;
        Thu, 17 Aug 2017 16:58:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uTqOhxjbv4v+PSD4zRnHyS/FX8c=; b=KWrZRL
        BmJdNDQG7i6ARaUXY+dBGD+eFdnufSTf+T/eHLDdnmfNi+6W51bu/B6vY1jovTw/
        Hl504xLkWJszhkGE2wYLGOuLYjCajc1XiKoYxMW7Wmjp0n/KGRD/tQ8uCtho/jYI
        GpjDiqe0Lk7MAHKudgLTrSRvLl99SvObCYCU4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tpDGo2W4fs4LA7cer6f/xgg7DtK1CAq/
        /GZ3HWai1E4eyWJJy2vmvkLcdT9bviFALXN6Dtk8AX+oxPCtg1ZbzGDEc01Ho5a5
        JMgaS+ehbOYJ5MSB8Du/EOG1FygEnolE8SY4juas5AurZE0tjBMOYWzWhx/ZFq4C
        nSMOR+mYc+k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E7190904CD;
        Thu, 17 Aug 2017 16:58:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5D20F904CA;
        Thu, 17 Aug 2017 16:58:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     ryenus <ryenus@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Andreas Heiduk <asheiduk@gmail.com>
Subject: Re: [PATCH v2] update revisions doc for quoting in ':/' notation
References: <CAKkAvax4Coqa6=jT52dpy4SYycfwoN-6kGfoh3QPLJi2-69Orw@mail.gmail.com>
Date:   Thu, 17 Aug 2017 13:58:29 -0700
In-Reply-To: <CAKkAvax4Coqa6=jT52dpy4SYycfwoN-6kGfoh3QPLJi2-69Orw@mail.gmail.com>
        (ryenus@gmail.com's message of "Thu, 17 Aug 2017 14:54:44 +0800")
Message-ID: <xmqqfucpgbd6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D2D64A20-838E-11E7-9C71-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ryenus <ryenus@gmail.com> writes:

> To make sure the `<text>` in `:/<text>` is seen as one search string,
> one should quote/escape `<text>` properly.
>
> Especially, the example given in the manual `:/fix nasty bug` does not
> work because of missing quotes when used in shell. A note about
> quoting/escaping is added along with a working example, however, the
> original example is left-as-is to be consistent with other examples.
>
> Signed-off-by: ryenus <ryenus@gmail.com>
> ---
>  Documentation/revisions.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
> index 61277469c..d2862d55d 100644
> --- a/Documentation/revisions.txt
> +++ b/Documentation/revisions.txt
> @@ -185,7 +185,9 @@ existing tag object.
>    e.g. ':/^foo'. The special sequence ':/!' is reserved for modifiers to what
>    is matched. ':/!-foo' performs a negative match, while ':/!!foo' matches a
>    literal '!' character, followed by 'foo'. Any other sequence beginning with
> -  ':/!' is reserved for now.
> +  ':/!' is reserved for now. And make sure to quote/escape for the text to be
> +  interpreted as the expected search string/pattern, e.g., for a commit whose
> +  message matches a literal \'`$`', use `git show :/\\\$` or `git show ':/\$'`.

Hmph.  

This seems to miss the most important point Andreas raised, which is
that the way to quote them is entirely up to the shell and other UI
machinery the user is using.

And I am not sure if those who are using CUI should be told about
shell's quoting rules when they are learning about :/ syntax.  There
are tons of other ways that the user needs to pass a string with
whitespace in it as a single argument to commands, many of which may
not even be related to Git at all.  I was actually expecting a much
milder text, perhaps literal copy of what Andreas gave you in his
message <956ccc83-c291-4217-795c-fcef33fac35b@gmail.com>.

By the way, I do not mean to dictate what name and address you use
to communicate with other people, but especially with something that
is supposed to hopefully have some legal value down the line if
somebody starts making SCO noises, it really would be nice to have a
real person to associate things with recorded as the author of a
change and the person who signed off the patch.  It would be
embarrassing later if there is no way to even look you up somehow.

Thanks.
