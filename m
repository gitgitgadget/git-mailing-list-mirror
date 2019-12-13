Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BC5C79DCB
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E55D7246B3
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="o1MDc9Q2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbfLMRMJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 12:12:09 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61374 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728413AbfLMRMJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 12:12:09 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ED82F3FF4E;
        Fri, 13 Dec 2019 12:12:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mStRCkq24fP7IU8nf+C7Uu7H7QQ=; b=o1MDc9
        Q2FZWZjo/n3oJV4k4c1tvH3U43AslKwppgonE1y1T4FHDGSBb67aJX1jCOAm9y7I
        N/pczlCBu4H6JWQUoCO3x9VSMlwzuqL44PyU+jq39yaTZv74gfTIxkjxtPvXTvPC
        LZgqAEoEbb3UevHUjeTZLkZxE4C3URhK9cpKY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PFpQoWAOHd+kD+qL42xz2BMYhEbW1iMe
        cyal56Rdxyyyhh42CigY06KUEeJUJnm5N+fqILenAWMp/aQ/Lh9vGH28j81ZqjWR
        WDOA1U27giTgDmnXiucd41ogTlBn1xdYcu9iXFOf+7BgOtIoGxhI3ZYuCK9a53Qx
        IPWXnqlfZ4k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D89BF3FF4D;
        Fri, 13 Dec 2019 12:12:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EDA823FF49;
        Fri, 13 Dec 2019 12:12:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH v2 1/2] gitk: drop quotes in copysummary format
References: <da9321b1bd56aafd16c8dcb99d5d628b79e2244e.1576100147.git.liu.denton@gmail.com>
        <cover.1576197846.git.liu.denton@gmail.com>
        <75dc131f0575cbe5d885af8897cbde054f7c07cf.1576197846.git.liu.denton@gmail.com>
Date:   Fri, 13 Dec 2019 09:12:04 -0800
In-Reply-To: <75dc131f0575cbe5d885af8897cbde054f7c07cf.1576197846.git.liu.denton@gmail.com>
        (Denton Liu's message of "Thu, 12 Dec 2019 16:44:49 -0800")
Message-ID: <xmqqfthom9p7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B034A500-1DCB-11EA-B9BA-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> In an earlier commit[1], git learned the 'reference' pretty format. This
> format was very similar to the format that copysummary used but it omits
> the quotes surrounding the commit's subject. Remove the quotes from the
> format in copysummary in order to match the 'reference' pretty format.
>
> It seems the consensus is that the unquoted form is used more often
> anyway[2] so this change should be acceptable.
>
> [These commits are in git.git.]
> [1]: 1f0fc1db85 (pretty: implement 'reference' format, 2019-11-19)
> [2]: fb2ffa77a6 (SubmittingPatches: remove dq from commit reference, 2019-11-19)

This change to gitk actually can easily be controversial.

The "used more often" census IIUC was done on _this_ project, and
SubmittingPatches is merely a guideline to contribute to _this_
project, but the audience of gitk that wants to use the copysummary
format is a lot wider than that.

This patch alone may not be worth sinking the time on for that
reason.

Having said that, if we teach --pretty=reference to optionally use a
custom format via a configuration variable, it would make quite a
lot of sense to do an update _like_ this patch does to gitk.  It
would probably allow the code to read from the same configuration
variable, instead of replacing a hardcoded format string with
another hardcoded format string, though.

Thanks.

> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  gitk | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/gitk b/gitk
> index abe4805ade..d07e3302de 100755
> --- a/gitk
> +++ b/gitk
> @@ -9429,7 +9429,7 @@ proc mktaggo {} {
>  proc copysummary {} {
>      global rowmenuid autosellen
>  
> -    set format "%h (\"%s\", %ad)"
> +    set format "%h (%s, %ad)"
>      set cmd [list git show -s --pretty=format:$format --date=short]
>      if {$autosellen < 40} {
>          lappend cmd --abbrev=$autosellen
