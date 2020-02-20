Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FD7C11D0C
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 17:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E117C20722
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 17:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="w4LFYlT2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgBTRtY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 12:49:24 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57156 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbgBTRtY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 12:49:24 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1FCAE4FBAD;
        Thu, 20 Feb 2020 12:49:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xVXb0hziBmS16LiOsPm191QTkn8=; b=w4LFYl
        T2H5cL1V5Kcr+dBuY7+ivTDKWwnSiPf5evrmzKQLYa4SlD3VKHgWx/xGDqtHMZyl
        W/rweIQ0eM4AkmpWXu3/ry19+lN4nXyknjXjbWcvIpzle0vTQsGbqUEdo4PaqjGp
        sVAW2Z3se+N0XoH2Yuat8mkphzG7Wgzw6SoAg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OmK+CE7uoK+FDS2ynlm+ZZDP/zPyOHSc
        S3H7O1i0xHWBOrKyCaaOwmg6RlTaad3HIIGYVGOEqdxXm7Ml8W28B9nGLHP948gq
        mRQMy4jkf9BsXuoKpLL+YwnfcvA3mJlcwGEOBI/Ia0nWCFb0/C17OzkBXNx3uFBz
        U+HmXAb6UPM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 182D44FBAC;
        Thu, 20 Feb 2020 12:49:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7AD004FBAB;
        Thu, 20 Feb 2020 12:49:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC PATCH v2 1/2] lib-log-graph: consolidate test_cmp_graph logic
References: <20200216134750.18947-1-abhishekkumar8222@gmail.com>
        <20200220091528.28472-1-abhishekkumar8222@gmail.com>
        <20200220091528.28472-2-abhishekkumar8222@gmail.com>
Date:   Thu, 20 Feb 2020 09:49:17 -0800
In-Reply-To: <20200220091528.28472-2-abhishekkumar8222@gmail.com> (Abhishek
        Kumar's message of "Thu, 20 Feb 2020 14:45:27 +0530")
Message-ID: <xmqqsgj5b142.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5164E674-5409-11EA-A3B9-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Abhishek Kumar <abhishekkumar8222@gmail.com> writes:

> Logic for comparing log graphs is duplicated across test scripts.
>
> This patch consolidates such logic into lib-log-graph.

The proposed log message is a bit thin.  It does a bit more than
"conslidates", doesn't it?

> Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> ---
>  t/lib-log-graph.sh           | 22 +++++++++++++++
>  t/t3430-rebase-merges.sh     |  5 ++--
>  t/t4202-log.sh               | 53 ++++++++++--------------------------
>  t/t4214-log-graph-octopus.sh | 46 ++++++++++---------------------
>  t/t4215-log-skewed-merges.sh |  5 ++--
>  5 files changed, 54 insertions(+), 77 deletions(-)
>  create mode 100755 t/lib-log-graph.sh
>
> diff --git a/t/lib-log-graph.sh b/t/lib-log-graph.sh
> new file mode 100755
> index 0000000000..97cde44dc7
> --- /dev/null
> +++ b/t/lib-log-graph.sh
> @@ -0,0 +1,22 @@
> +# Helps shared by the test scripts for comparing log graphs.
> +
> +sanitize_log_output () {
> +	sed -e 's/ *$//' \
> +	    -e 's/commit [0-9a-f]*$/commit COMMIT_OBJECT_NAME/' \
> +	    -e 's/Merge: [ 0-9a-f]*$/Merge: MERGE_PARENTS/' \
> +	    -e 's/Merge tag.*/Merge HEADS DESCRIPTION/' \
> +	    -e 's/Merge commit.*/Merge HEADS DESCRIPTION/' \
> +	    -e 's/index [0-9a-f]*\.\.[0-9a-f]*/index BEFORE..AFTER/'
> +}

For example, discarding the singular/plural compat stuff from the
t4202's version is OK, but we should record that is what we did in
the log message to allow readers to notice.

> +lib_test_cmp_graph () {

Nicely named.

> +	git log --graph "$@" >output &&
> +	sed 's/ *$//' >output.sanitized < output &&

Lose SP not just on the output redirection but also on the input
redirection.  I.e.

	sed 's/ *$//' >output.sanitized <output &&

Or you can lose the input redirection altogether as "sed" knows to
treat remaining command line arguments as names of its input files,
i.e.

	sed 's/ *$//' output >output.sanitized &&

People may find the latter easier to read.  I personally do not have
strong preference either way as long as it is consistent.

> +	test_i18ncmp expect output.sanitized
> +}
> +
> +lib_test_cmp_short_graph () {
> +	git log --graph --pretty=short "$@" >output &&
> +	sanitize_log_output >output.sanitized < output &&

	sanitize_log_output <output >output.sanitized &&

(I won't repeat)


>  check_graph () {
>  	cat >expect &&
> -	git log --graph --pretty=tformat:%s "$@" >actual.raw &&
> -	sed "s/ *$//" actual.raw >actual &&
> -	test_cmp expect actual
> +	lib_test_cmp_graph --format=%s "$@"
>  }

Hmm, is this correct?  The input goes to expect but the new helper
you wrote, lib_test_cmp_graph, won't see it.

