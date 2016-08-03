Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2C781F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 23:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932669AbcHCXOe (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 19:14:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59798 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753134AbcHCXOd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 19:14:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A4798336B5;
	Wed,  3 Aug 2016 19:13:19 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tXF0isaTVOSe85Jfk+8SUJYywno=; b=H4fuVB
	bQgSXRln0cvDEzkgcq+D7M9OfXOJW9GIi1azgIHiuOcyd1Pl3IqFZaNA3vHm3E8A
	VxcY2eJeTvIERScL65AA2qd40DTFng9y/OSO84EIaCe2N+2KrUq337tHgmYfRleC
	d5OQ4tMP/m8Plr/9S/zjmmKrk8QbvdHTG2ptM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B4X2z7Q/wVCjCfeqlqvGwr385M2fdVXD
	RiqJLFUQ1aDRXInRX/9V+EnKrHkRcqgaZN7qxKm0EyX8RbcfIPDFrVMNgkhm813P
	aiHsHuExNEXrPMNDRvSB/s425F3CeBrBXMjfzyRfh3KlFLHUL/fL2S5YhkaJy7BV
	BplrLVyLwBY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9CB95336B4;
	Wed,  3 Aug 2016 19:13:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 278C7336B3;
	Wed,  3 Aug 2016 19:13:19 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	git@vger.kernel.org, Jens.Lehmann@web.de, apenwarr@gmail.com,
	jrnieder@gmail.com
Subject: Re: [PATCHv4 6/7] submodule--helper: add remote-branch helper
References: <20160803204404.3356-1-sbeller@google.com>
	<20160803204404.3356-2-sbeller@google.com>
Date:	Wed, 03 Aug 2016 16:13:17 -0700
In-Reply-To: <20160803204404.3356-2-sbeller@google.com> (Stefan Beller's
	message of "Wed, 3 Aug 2016 13:44:03 -0700")
Message-ID: <xmqq8twd78fm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DD911736-59CF-11E6-8F80-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index fb90c64..9be2c75 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -899,6 +899,39 @@ static int resolve_relative_path(int argc, const char **argv, const char *prefix
> 	return 0;

I wonder who lost the leading SP before the tab here.  Will manually
fix, so this is not a reason to force resending, but you may want to
make sure there is no systemic cause to corrupt your future patches.

Thanks.
