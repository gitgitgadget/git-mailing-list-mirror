Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76440C433DB
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 07:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E161230FB
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 07:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725813AbhAFHGJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 02:06:09 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61075 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbhAFHGJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 02:06:09 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3E2EF11073C;
        Wed,  6 Jan 2021 02:05:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=Sg2fcVjjWcBB4q/i8hLVTRuu9
        /4=; b=e42Rgow1+ElXAyfvN/XTAXSdUxD2qmk9BPXz6LvqsFVN/SfQDV7ZTi6P9
        nvhFOOGUJ/3t0UmdHNwxExJVLx4NacRBWyVjy/VFw89fjGvz+s5d2CMPbCXlyNal
        Ryiokqcv70mmuealrKdXxaTyNJ4J1bZushOc7Vt0PyUSVoj0Jc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=n/kESSuwFv0Ms7dEK9c
        sJ+Sbc/B2ExALIW3zltPoKxms1CxYDOymU+Njd219JHdozw/mBGvKMwViV0TTrMP
        q89S3Z2RyDSaPP8YByhro3cXeSAVk7jQKrInVl0GpD1ZYwQUzEwyBMHxf5GZ3W21
        xSx18+OaBwHkx4AuxuBfCemM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 27B3011073B;
        Wed,  6 Jan 2021 02:05:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5AE9F11073A;
        Wed,  6 Jan 2021 02:05:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?=E9=98=BF=E5=BE=B7=E7=83=88_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?6Zi/5b6354OI?= <adlternative@gmail.com>
Subject: Re* [PATCH] builtin/*: update usage format
References: <pull.822.git.1609232114080.gitgitgadget@gmail.com>
Date:   Tue, 05 Jan 2021 23:05:22 -0800
Message-ID: <xmqqwnwqtuj1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8C4185DC-4FED-11EB-8B82-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"=E9=98=BF=E5=BE=B7=E7=83=88 via GitGitGadget"  <gitgitgadget@gmail.com> =
writes:

> From: ZheNing Hu <adlternative@gmail.com>
>
> According to the "Error Messages" section of
> Documentation/CodingGuidelines, we should not end in a full
> stop or start with a capital letter.

Yup, error("message"), die("message") and warn("messages") lack the
final full stop and starts with lowercase.

>  		OPT_CMDMODE(0, "abort", &resume.mode,
> -			N_("restore the original branch and abort the patching operation.")=
,
> +			N_("restore the original branch and abort the patching operation"),
>  			RESUME_ABORT),

But is this an error message?  I do not think so.

> ...
>  	struct option options[] =3D {
> -		OPT__QUIET(&quiet, N_("Suppress output for setting url of a submodul=
e")),
> +		OPT__QUIET(&quiet, N_("suppress output for setting url of a submodul=
e")),
>  		OPT_END()
>  	};

Having said that, I do not *mimd* standardising the usage help
strings in the same way.  I do not think the "Error Messages"
section is the one we want to use for the justification of this
patch.

Perhaps a preparatory patch like the attached would be a good way
forward?  I dunno.

---- >8 -------- >8 -------- >8 -------- >8 -------- >8 ----
Subject: parse-options: format argh like error messages

"Keep it homogeneous across the repository" is in general a
guideline that can be used to converge to a good practice, but
we can be a bit more prescriptive in this case.  Just like the
messages we give die(_("...")) are formatted without the final
full stop and without the initial capitalization, most of the
argument help text are already formatted that way, and we want
to encourage that as the house style.

Noticed-by: ZheNing Hu <adlternative@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 parse-options.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git c/parse-options.h w/parse-options.h
index 7030d8f3da..ff6506a504 100644
--- c/parse-options.h
+++ w/parse-options.h
@@ -82,9 +82,9 @@ typedef enum parse_opt_result parse_opt_ll_cb(struct pa=
rse_opt_ctx_t *ctx,
  *   stores pointers to the values to be filled.
  *
  * `argh`::
- *   token to explain the kind of argument this option wants. Keep it
- *   homogeneous across the repository. Should be wrapped by N_() for
- *   translation.
+ *   token to explain the kind of argument this option wants. Does not
+ *   begin in capital letter, and does not end with a full stop.
+ *   Should be wrapped by N_() for translation.
  *
  * `help`::
  *   the short help associated to what the option does.
