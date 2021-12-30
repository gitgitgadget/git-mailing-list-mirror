Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B2EC433EF
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 22:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242256AbhL3W0s (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 17:26:48 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54623 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242254AbhL3W0s (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 17:26:48 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9BEBB180DF9;
        Thu, 30 Dec 2021 17:26:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=iyoCSNsQd2KYr4xjPFDGDmUYd
        KEyyy/Pkjxqu2G2VHM=; b=gZ+/P73++zdi0F+OeqhjXD7CRM16BhSNwk8w3npLa
        gAU4LITwN1tPe03oJngg+8zDo+B8El1SLQRt+03JDxDRYYt8t5z1rHTwmUTQM0vf
        STEHiRBvpqTH2L577T8oFQ/zGElIW9ydH28c48wu0I0eD82m5G9d6NJj6pTJmpOj
        GY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 95C21180DF8;
        Thu, 30 Dec 2021 17:26:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E324E180DF6;
        Thu, 30 Dec 2021 17:26:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH v3 02/11] i18n: refactor "%s, %s and %s are mutually
 exclusive"
References: <pull.1088.v2.git.1640647437.gitgitgadget@gmail.com>
        <pull.1088.v3.git.1640804107.gitgitgadget@gmail.com>
        <4accf1629e55ae621053f27994ebc4eb59d6f0ff.1640804107.git.gitgitgadget@gmail.com>
Date:   Thu, 30 Dec 2021 14:26:42 -0800
Message-ID: <xmqqfsq9pw4d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 91533ED4-69BF-11EC-BE79-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jean-No=C3=ABl Avila via GitGitGadget"  <gitgitgadget@gmail.com> writes:

>  	if (use_stdout + rev.diffopt.close_file + !!output_directory > 1)
> -		die(_("--stdout, --output, and --output-directory are mutually exclu=
sive"));
> +		die(_("options '%s', '%s' and '%s' cannot be used together"), "--std=
out", "--output", "--output-directory");

We probably want to preserve the Oxford comma here, and unify the
ones that didn't use Oxford comma to use it.
