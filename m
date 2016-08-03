Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFBC41F858
	for <e@80x24.org>; Wed,  3 Aug 2016 16:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757974AbcHCPup (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 11:50:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62204 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757966AbcHCPum (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 11:50:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B1FAF2F254;
	Wed,  3 Aug 2016 11:50:30 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bXRAnbj7LXrRQ+g8Bne65Mrvr/E=; b=yVJdnF
	qfYj9QvMdCrFpex9kwkeuGZ7Ey8M8aR8kn0f09TpI8nGuOfx3T5L0eryIfGXGb8V
	Qk7G4hEWD4Nmu4YuGLVD6bgrUTnQLHz059v6o3qLd1UCmAIKBe+qBbFSML+TvU5s
	5p5Nc/LyDsx5xUKkO+vLEiOnPpmxugr2a+MEM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B2AKvvuV+7q5q7j4RG0rZYQnMmTQ90w9
	34qRQaI4anDwq0QnEgUZ24rOYhH7hdurRMJ6D3O0IAEFCjO7sG775toxQcBSZFZo
	1d+8Y9GWtJ7z8GnA/7cOPnlVGQ4xJ6vteLlRzyswPHO6wjFscBgEqMQEu0FXeBSM
	vZBNP8Ll1n4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A9D182F253;
	Wed,  3 Aug 2016 11:50:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2D8852F252;
	Wed,  3 Aug 2016 11:50:30 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Sixt <j6t@kdbg.org>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2] t4130: work around Windows limitation
References: <5bd59ca2f87e388350f3c8fb17c9a287661cd055.1469623136.git.johannes.schindelin@gmx.de>
	<9d167448-84ce-e368-0bb4-41aa4452268d@kdbg.org>
	<CAPc5daW10y_5rat0Au-1NWXUf2QYFrDfQeprqq9NsYPBjdqOTw@mail.gmail.com>
	<alpine.DEB.2.20.1607301011140.11824@virtualbox>
	<244e3458-4a41-49bf-fba2-71da872e7f66@kdbg.org>
Date:	Wed, 03 Aug 2016 08:50:28 -0700
In-Reply-To: <244e3458-4a41-49bf-fba2-71da872e7f66@kdbg.org> (Johannes Sixt's
	message of "Wed, 3 Aug 2016 08:15:03 +0200")
Message-ID: <xmqq4m71c0mz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0138A02A-5992-11E6-B687-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

>  This fell through the cracks, I think. I marked it as v2 because
>  there is a minor fixup in the commit message.

Thanks.  The patch itself seems to got whitespace damaged somewhere
between you and me, which I fixed up, but there may be similar
damage to the proposed log message as well.  What I read may already
have whitespace damaged but I read the message twice and it made
sense to me, so let's assume all is well ;-)

Thanks.

>
>  t/t4130-apply-criss-cross-rename.sh | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/t/t4130-apply-criss-cross-rename.sh b/t/t4130-apply-criss-cross-rename.sh
> index d173acd..f8a313b 100755
> --- a/t/t4130-apply-criss-cross-rename.sh
> +++ b/t/t4130-apply-criss-cross-rename.sh
> @@ -13,9 +13,13 @@ create_file() {
>  }
>   test_expect_success 'setup' '
> -	create_file file1 "File1 contents" &&
> -	create_file file2 "File2 contents" &&
> -	create_file file3 "File3 contents" &&
> +	# Ensure that file sizes are different, because on Windows
> +	# lstat() does not discover inode numbers, and we need
> +	# other properties to discover swapped files
> +	# (mtime is not always different, either).
> +	create_file file1 "some content" &&
> +	create_file file2 "some other content" &&
> +	create_file file3 "again something else" &&
>  	git add file1 file2 file3 &&
>  	git commit -m 1
>  '
