Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D1CC43334
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 01:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242412AbiFOBZz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 21:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233337AbiFOBZy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 21:25:54 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF915183B5
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 18:25:53 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CA6541A19D5;
        Tue, 14 Jun 2022 21:25:52 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=+lLbRaW+++ahW60ZP244EB3v3cN6PlKqw25fhtQ
        F4XU=; b=r79yAzMseotnQ48lRpPVb0GlKoOWFX5cAjP7K9OjEUP7E6rUa4KOYdn
        Xfo8WIPhmbgaD/8uZPSXy0KHncYtdwQ5/LIVDUUFypaC1xG0zapEu5oHgxlsarNm
        nMzEBldlm2gls+3jgRZg80QdT7kB3QwLoiw31IiKzQ6vuzziZal8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C1B0C1A19D4;
        Tue, 14 Jun 2022 21:25:52 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [71.254.192.78])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 31ABE1A19D1;
        Tue, 14 Jun 2022 21:25:48 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Date:   Tue, 14 Jun 2022 21:25:44 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t3701: two subtests are fixed
Message-ID: <Yqk1GCPkfauGHQQB@pobox.com>
References: <cf6aee9acadfb666de6b24b9ed63e1a65bfc009e.1655220242.git.git@grubix.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf6aee9acadfb666de6b24b9ed63e1a65bfc009e.1655220242.git.git@grubix.eu>
X-Pobox-Relay-ID: 161EE1C4-EC4A-11EC-864E-C85A9F429DF0-09356542!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber wrote:
> 0527ccb1b5 ("add -i: default to the built-in implementation", 2021-11-30)
> switched to the implementation which fixed to subtest. Mark them as
> expect_success now.
> 
> Signed-off-by: Michael J Gruber <git@grubix.eu>
> ---
> I did check the ML but may have missed a series which contains this. (I
> only found one which tries to make the test output clearer in CI.)

I sent a patch (<20220614185218.1091413-1-tmz@pobox.com>) as
well.  I mentioned the commits which added these tests, but
didn't call out 0527ccb1b5 (add -i: default to the built-in
implementation, 2021-11-30) explicitly, which is a good
addition.

I'm just happy to see the builtin `add -i` as the default.

>  t/t3701-add-interactive.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index 94537a6b40..9a06638704 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -538,7 +538,7 @@ test_expect_success 'split hunk "add -p (edit)"' '
>  	! grep "^+15" actual
>  '
>  
> -test_expect_failure 'split hunk "add -p (no, yes, edit)"' '
> +test_expect_success 'split hunk "add -p (no, yes, edit)"' '
>  	test_write_lines 5 10 20 21 30 31 40 50 60 >test &&
>  	git reset &&
>  	# test sequence is s(plit), n(o), y(es), e(dit)
> @@ -562,7 +562,7 @@ test_expect_success 'split hunk with incomplete line at end' '
>  	test_must_fail git grep --cached before
>  '
>  
> -test_expect_failure 'edit, adding lines to the first hunk' '
> +test_expect_success 'edit, adding lines to the first hunk' '
>  	test_write_lines 10 11 20 30 40 50 51 60 >test &&
>  	git reset &&
>  	tr _ " " >patch <<-EOF &&

-- 
Todd
