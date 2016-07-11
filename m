Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C380C1F744
	for <e@80x24.org>; Mon, 11 Jul 2016 15:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030889AbcGKPaa (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 11:30:30 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:36087 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030735AbcGKPa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 11:30:28 -0400
Received: by mail-io0-f194.google.com with SMTP id y34so396890ioi.3
        for <git@vger.kernel.org>; Mon, 11 Jul 2016 08:30:28 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cQT21ZG6VPsyAlyIy4cCZwvWTlluuxcLrigpWmXaMuY=;
        b=0jUgetKNUcmcpQiyx1xm5IVWfTdCC6iDRzDHb26HElL594TKK4pFP1yY6p/w+2lHUe
         rE6mkn8IiBjYTrMpUUEz1/rpIC0IfkaMDeBYuk+gtYs4k5X9WMiNp9lBbqlXl1rPeT9b
         cC6qVLB3pE9Y+liHgwLaKrhepXlD5C//gIuWHBm6S5175LyRSxX1Jf7EYR0XJT8ja60F
         9NdcTarfdh8jt3VN1x2He2kEVeLSxk4GvoGFs8+9Ev9U43UIjzmcW6wdzeJrMwk1crJE
         9HxgAVwnGQv4BULWd3D1kb+PTokZTCvrzF2GRnysl4w0GqROA/3/mu8bTMpeSsdBR6wG
         jMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cQT21ZG6VPsyAlyIy4cCZwvWTlluuxcLrigpWmXaMuY=;
        b=U1CFxVFgj/se4YgoCH0aN4X22nMOU4qR1RLz7PvgPJGkrmW1eu0vKMzQqR0NR3kCSn
         B+27x/6aW3n0iqobKVNrJ+uUJQ1UvuuOJWzIthYizZzCMmeWCQctVgWupGDWlMU1rY5o
         d320fzxSmBtP+IbqqN8Xy4ypM0dC7/idJdHHHzqh0sFW+Q2ccTVrMrljwbJoSnwvxE7m
         HxuLBYOpTs3pgi2AnI03wMzaJ3ahJ/mrfSU5SNmn937fge7U+6I7J9c+cCETcrz/AVJW
         BrzvePX5ZnklLvydmmW0+gs+TqZ5C96INOriSg+jpn1RRI/dd4hzaMeME+Dm6uCqHiNX
         6dJg==
X-Gm-Message-State: ALyK8tKz4ZFaCWnJPdvUqz34p+4yPus036ua3fYuZMkKsTe/s/ReH+cYPMznGYbCTFOhJ5mwdCOEOZ+jaZsrWA==
X-Received: by 10.107.8.140 with SMTP id h12mr11756519ioi.95.1468251028029;
 Mon, 11 Jul 2016 08:30:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Mon, 11 Jul 2016 08:29:58 -0700 (PDT)
In-Reply-To: <80e5a1b53844d82c48eb16c88a962d9d693e0491.1468237495.git.johannes.schindelin@gmx.de>
References: <80e5a1b53844d82c48eb16c88a962d9d693e0491.1468237495.git.johannes.schindelin@gmx.de>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Mon, 11 Jul 2016 17:29:58 +0200
Message-ID: <CACsJy8D5K5rbpXXrf-JXVrJCBXXgf78+_QeYUhOcAZW1hM=6CA@mail.gmail.com>
Subject: Re: [PATCH] Fix running tests with --valgrind
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jul 11, 2016 at 1:45 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> We forgot to adjust this code path after moving the test helpers to
> t/helper/.

Oops. Yet it looks like the right thing to do.

>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> Published-As: https://github.com/dscho/git/releases/tag/valgrind-and-test-helpers-v1
>  t/test-lib.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 0055ebb..493a92b 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -798,7 +798,7 @@ then
>         # override all git executables in TEST_DIRECTORY/..
>         GIT_VALGRIND=$TEST_DIRECTORY/valgrind
>         mkdir -p "$GIT_VALGRIND"/bin
> -       for file in $GIT_BUILD_DIR/git* $GIT_BUILD_DIR/test-*
> +       for file in $GIT_BUILD_DIR/git* $GIT_BUILD_DIR/t/helper/test-*
>         do
>                 make_valgrind_symlink $file
>         done
> --
> 2.9.0.278.g1caae67
>
> base-commit: 5c589a73de4394ad125a4effac227b3aec856fa1



-- 
Duy
