Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7A3C433EF
	for <git@archiver.kernel.org>; Sat, 18 Dec 2021 00:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbhLRAPA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 19:15:00 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59013 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhLRAPA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 19:15:00 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F2B1710443A;
        Fri, 17 Dec 2021 19:14:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=PHsYLPE5WZZK
        E1mbm6wAGjKTz1Hj/1Ov2OQ8SpTs+0o=; b=JaS0FEdZSrHki9TbZay8yVQCKo71
        J17ZHhBYoawvJ/vecZdBzyuibw0hfQRu5f8da9Z4poi2TXcjF6VmEDqu/zbhTTZH
        COE9XSWPdZvkKdNESMDoTv6P1AHJx7+Evapnulg8ORnMLWssfsj06RvGl+eYpPyg
        C0GSczsljVl6V/M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EAC52104439;
        Fri, 17 Dec 2021 19:14:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5E8B2104438;
        Fri, 17 Dec 2021 19:14:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] t4202: fix patternType setting in --invert-grep test
References: <79dcebc0-e569-cc8a-4702-c572b062ed6d@web.de>
Date:   Fri, 17 Dec 2021 16:14:56 -0800
In-Reply-To: <79dcebc0-e569-cc8a-4702-c572b062ed6d@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Fri, 17 Dec 2021 17:48:52 +0100")
Message-ID: <xmqq5yrm22gv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 885BCE18-5F97-11EC-813C-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Actually use extended regexes as indicated in the comment.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  t/t4202-log.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index 7884e3d46b..f51b57b4a2 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -250,7 +250,7 @@ test_expect_success 'log --invert-grep --grep' '
>  	test_cmp expect actual &&
>
>  	# POSIX extended
> -	git -c grep.patternType=3Dbasic log --pretty=3D"tformat:%s" --invert-=
grep --grep=3Dt[h] --grep=3DS[e]c >actual &&
> +	git -c grep.patternType=3Dextended log --pretty=3D"tformat:%s" --inve=
rt-grep --grep=3Dt[h] --grep=3DS[e]c >actual &&
>  	test_cmp expect actual &&

Good eyes.

Thanks.
