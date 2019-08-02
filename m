Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B3431F731
	for <e@80x24.org>; Fri,  2 Aug 2019 16:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391481AbfHBQyH (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 12:54:07 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62739 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728856AbfHBQyH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 12:54:07 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 77DD371FCC;
        Fri,  2 Aug 2019 12:54:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xUy4wo8scAEeWMWoS9hCHQaeiKM=; b=nJMBR8
        R0b5SQXhBAhIk8gNzTnMZqK0xGfzsjyYNqfT/8lnifzjDylSn0eFEgRwbAv1/GBx
        AtGNO5yisNnzP9RmExXU+Nqx1uMfCs6K5m9zal0/mV5Ac2qSNyUr1ea7+sst+cq9
        2iicVMVioxYv7UmKJxkTQ9RyXowXR29gc9MJY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RZ3wJUsktJTp6Ubc+a474tmxXkUkZkR5
        hnC8c9deNFcNBCa/GeI+7Hz8jQ+5MI2iCw9QuwvqMgyUlCk2BQLqn9byJ8mN+D/x
        ETrW5jvTZSxHM0/jPUB/CdGA6vuvVJRKGUYDgtifOP2xUmn4i8HHCP+iOrdyGAJp
        IrlkSYM5wGM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6E4C871FCB;
        Fri,  2 Aug 2019 12:54:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9566971FC8;
        Fri,  2 Aug 2019 12:53:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com,
        Ariadne Conill <ariadne@dereferenced.org>
Subject: Re: Git for Windows v2.23.0-rc0, was Re: [ANNOUNCE] Git v2.23.0-rc0
References: <xmqqh874tssp.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1907311440130.21907@tvgsbejvaqbjf.bet>
        <20190731231848.GC1933@sigill.intra.peff.net>
        <20190801002125.GA176307@google.com>
        <xmqqlfwcopn1.fsf@gitster-ct.c.googlers.com>
        <20190802022709.GB54514@google.com>
Date:   Fri, 02 Aug 2019 09:53:55 -0700
In-Reply-To: <20190802022709.GB54514@google.com> (Jonathan Nieder's message of
        "Thu, 1 Aug 2019 19:27:09 -0700")
Message-ID: <xmqqblx7ld98.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1E8B5470-B546-11E9-B12F-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> We'll also want to update the docs.  And as Todd suggests, we should
> cover how to disable mailmap in tests.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---

I avoided the "don't bother initializing use_mailmap_config to
unknown" simplification, but I guess the change is clear enough.

> diff --git i/Documentation/config/log.txt w/Documentation/config/log.txt
> index 7798e10cb0..e9e1e397f3 100644
> --- i/Documentation/config/log.txt
> +++ w/Documentation/config/log.txt
> @@ -41,4 +41,4 @@ log.showSignature::
>  log.mailmap::
>  	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
>  	linkgit:git-whatchanged[1] assume `--use-mailmap`, otherwise
> -	assume `--no-use-mailmap`. False by default.
> +	assume `--no-use-mailmap`. True by default.

Good.  Thanks for being extra careful.

> diff --git i/builtin/log.c w/builtin/log.c
> index 02fa179077..44b10b3415 100644
> --- i/builtin/log.c
> +++ w/builtin/log.c
> @@ -47,7 +47,7 @@ static int default_follow;
>  static int default_show_signature;
>  static int decoration_style;
>  static int decoration_given;
> -static int use_mailmap_config = -1;
> +static int use_mailmap_config = 1;
>  static const char *fmt_patch_subject_prefix = "PATCH";
>  static const char *fmt_pretty;
>  
> @@ -160,7 +160,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
>  			 struct rev_info *rev, struct setup_revision_opt *opt)
>  {
>  	struct userformat_want w;
> -	int quiet = 0, source = 0, mailmap = 0;
> +	int quiet = 0, source = 0, mailmap;
>  	static struct line_opt_callback_data line_cb = {NULL, NULL, STRING_LIST_INIT_DUP};
>  	static struct string_list decorate_refs_exclude = STRING_LIST_INIT_NODUP;
>  	static struct string_list decorate_refs_include = STRING_LIST_INIT_NODUP;
> @@ -204,9 +204,6 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
>  	memset(&w, 0, sizeof(w));
>  	userformat_find_requirements(NULL, &w);
>  
> -	if (mailmap < 0)
> -		mailmap = 1;
> -
>  	if (!rev->show_notes_given && (!rev->pretty_given || w.notes))
>  		rev->show_notes = 1;
>  	if (rev->show_notes)



> diff --git i/t/t4203-mailmap.sh w/t/t4203-mailmap.sh
> index ede0c292af..918ada69eb 100755
> --- i/t/t4203-mailmap.sh
> +++ w/t/t4203-mailmap.sh
> @@ -442,6 +442,34 @@ test_expect_success 'Log output with log.mailmap' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'log.mailmap=false disables mailmap' '
> +	cat >expect <<-\EOF &&
> +	Author: CTO <cto@coompany.xx>
> +	Author: claus <me@company.xx>
> +	Author: santa <me@company.xx>
> +	Author: nick2 <nick2@company.xx>
> +	Author: nick2 <bugs@company.xx>
> +	Author: nick1 <bugs@company.xx>
> +	Author: A U Thor <author@example.com>
> +	EOF
> +	git -c log.mailmap=False log | grep Author > actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '--no-use-mailmap disables mailmap' '
> +	cat >expect <<-\EOF &&
> +	Author: CTO <cto@coompany.xx>
> +	Author: claus <me@company.xx>
> +	Author: santa <me@company.xx>
> +	Author: nick2 <nick2@company.xx>
> +	Author: nick2 <bugs@company.xx>
> +	Author: nick1 <bugs@company.xx>
> +	Author: A U Thor <author@example.com>
> +	EOF
> +	git log --no-use-mailmap | grep Author > actual &&
> +	test_cmp expect actual
> +'
> +
>  cat >expect <<\EOF
>  Author: Santa Claus <santa.claus@northpole.xx>
>  Author: Santa Claus <santa.claus@northpole.xx>
