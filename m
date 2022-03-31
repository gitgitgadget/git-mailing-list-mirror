Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1D9C433EF
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 22:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242225AbiCaWE4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 18:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241607AbiCaWEz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 18:04:55 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D75F240587
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 15:03:07 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0538418995F;
        Thu, 31 Mar 2022 18:03:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=iJ58V4DCGaN9
        F6IX8UYsSqLhC94YpwA3oUCVsQHRLpk=; b=jBCmDLoSHNpYyypT2bwFGgUNZEVT
        8Pr5NPL8M8/tanoBIooQj05EGpqB45J33n4L0esHIjSzQx1CClhG7uCGQbPENT+x
        1xx11hoBMzYMsupeHoRsRl6C5tB9WvVh3Q2hfQUPd+QWCVID6hHuH2tSAqN/uKvY
        SnPbGM81V+ZIl+0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F2C9018995E;
        Thu, 31 Mar 2022 18:03:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5E47018995C;
        Thu, 31 Mar 2022 18:03:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v4 1/6] run-command.h: remove always unused
 "clean_on_exit_handler_cbdata"
References: <cover-v3-0.7-00000000000-20220326T171200Z-avarab@gmail.com>
        <cover-v4-0.6-00000000000-20220331T014349Z-avarab@gmail.com>
        <patch-v4-1.6-fc55b203474-20220331T014349Z-avarab@gmail.com>
Date:   Thu, 31 Mar 2022 15:03:03 -0700
In-Reply-To: <patch-v4-1.6-fc55b203474-20220331T014349Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 31 Mar
 2022 03:45:50
        +0200")
Message-ID: <xmqqh77dzso8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 56CD5468-B13E-11EC-8C71-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Remove a "struct child_process" member added in
> ac2fbaa674c (run-command: add clean_on_exit_handler, 2016-10-16), but
> which was never used.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  run-command.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/run-command.h b/run-command.h
> index 07bed6c31b4..5bd0c933e80 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -142,7 +142,6 @@ struct child_process {
>  	unsigned clean_on_exit:1;
>  	unsigned wait_after_clean:1;
>  	void (*clean_on_exit_handler)(struct child_process *process);
> -	void *clean_on_exit_handler_cbdata;
>  };
> =20
>  #define CHILD_PROCESS_INIT { \

Thanks for digging.  Looks good.
