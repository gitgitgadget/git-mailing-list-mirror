Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701FFEB64DC
	for <git@archiver.kernel.org>; Tue, 18 Jul 2023 13:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbjGRNxP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jul 2023 09:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbjGRNxO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2023 09:53:14 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D317698
        for <git@vger.kernel.org>; Tue, 18 Jul 2023 06:53:12 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6478C32C2F;
        Tue, 18 Jul 2023 09:53:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FYjxBZ60dq8+ygxkqUS33YOQqHeN3wJD+asu79
        eMC9k=; b=qdtAnIgk6gPVBE0wQ7nhQNKrgtVq/H6+Cdr6xSRTJULAFJrAhOvsNc
        FfMWDJy1Gd6Y6Hii3SDI5trb3+xi779MINQn2IX2FoUIee6rkcKlYmSOFkFcx8UC
        7NW/Vtguv6AsA0WwdLTDVMMmMhRV/zbJoZ0vOPqEUzSUxUkefVlAs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5522932C2E;
        Tue, 18 Jul 2023 09:53:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EB65F32C2D;
        Tue, 18 Jul 2023 09:53:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "jr via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jr <johan@latehours.net>
Subject: Re: [PATCH] gitignore.txt: use backticks instead of double quotes
References: <pull.1553.git.git.1689685982027.gitgitgadget@gmail.com>
Date:   Tue, 18 Jul 2023 06:53:07 -0700
In-Reply-To: <pull.1553.git.git.1689685982027.gitgitgadget@gmail.com> (jr via
        GitGitGadget's message of "Tue, 18 Jul 2023 13:13:01 +0000")
Message-ID: <xmqqlefdiaws.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6D9122CA-2572-11EE-81FF-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"jr via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Johan Ruokangas <johan@latehours.net>
>
> unifies highlighting with the rest of the documentation

I find "The rest of the documentation" is a bit of overstatement,
but something like

    Among four examples, only this one used "double quoted" sample
    patterns, but all others marked up the patterns in `monospace`.

would be a good justification.  The change is good.

A change in the same vein elsewhere in the same document ...

diff --git i/Documentation/gitignore.txt w/Documentation/gitignore.txt
index 4c17f2356c..bf2d823c94 100644
--- i/Documentation/gitignore.txt
+++ w/Documentation/gitignore.txt
@@ -88,7 +88,7 @@ PATTERN FORMAT
    Put a backslash ("`\`") in front of the first "`!`" for patterns
    that begin with a literal "`!`", for example, "`\!important!.txt`".
 
- - The slash '/' is used as the directory separator. Separators may
+ - The slash "`/`" is used as the directory separator. Separators may
    occur at the beginning, middle or end of the `.gitignore` search pattern.
 
  - If there is a separator at the beginning or middle (or both) of the

... would be sufficient to make the PATTERN FORMAT section
consistent, I think.

> Signed-off-by: Johan Ruokangas <johan@latehours.net>

Thanks, will queue.

> diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
> index 4c17f2356c4..810041acd17 100644
> --- a/Documentation/gitignore.txt
> +++ b/Documentation/gitignore.txt
> @@ -174,10 +174,10 @@ EXAMPLES
>     is not relevant  if there is already a middle slash in
>     the pattern.
>  
> - - The pattern "foo/*", matches "foo/test.json"
> -   (a regular file), "foo/bar" (a directory), but it does not match
> -   "foo/bar/hello.c" (a regular file), as the asterisk in the
> -   pattern does not match "bar/hello.c" which has a slash in it.
> + - The pattern `foo/*`, matches `foo/test.json`
> +   (a regular file), `foo/bar` (a directory), but it does not match
> +   `foo/bar/hello.c` (a regular file), as the asterisk in the
> +   pattern does not match `bar/hello.c` which has a slash in it.
>  
>  --------------------------------------------------------------
>      $ git status
>
> base-commit: 5e238546dc7a232d8998f1cd1ec9d3f4a0add68b
