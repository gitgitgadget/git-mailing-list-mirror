Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 450951F859
	for <e@80x24.org>; Wed, 24 Aug 2016 07:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752353AbcHXH3l (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 03:29:41 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:35561 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751710AbcHXH3k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 03:29:40 -0400
Received: by mail-it0-f67.google.com with SMTP id f6so1275502ith.2
        for <git@vger.kernel.org>; Wed, 24 Aug 2016 00:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=yYDd37T2fJZRffRoHehp4q67dPBf4K9/3068RUdOUrs=;
        b=IB6bOHBiU6eU1JahtoE8Uon56G8I2KWoAi2Ed6yssyRu7moMadjWjdxYq9gBHPg37k
         gDHKoX/OVmhCiRBmsv5SUY3GHaY4Arkv1waKCmk61EO2+aTUhcstEaGBEVv9x2Gc9hJM
         F8h+VSMxQj9ttSUSSgerUtaQA8TJs+4LZmQnnUuHkojk93lSYquJfOoPkAFbJ2Pda+RV
         EoLHCZlNlt7aQOEsNolOfuyErr1DPpTrVUOxI84xs+gA8qOOt1+6QJ9Ij2Owr5R6auDw
         AD0EgbBXt1TqBqPcUAUZ5Mm5s3ro9eXKt/b+v8SmXh7O7vdhHaTPMfTNkKfyldrbVrBV
         GNYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=yYDd37T2fJZRffRoHehp4q67dPBf4K9/3068RUdOUrs=;
        b=icm3I2sHUQ6F92oIkIn5gLoXx+18or8NnDEw5s73t97ELBU/iNbD6/jBcNgZIaTfeE
         my78MH8AU5o7FWI5bEs1xELhojIwmzL3KJ51H+S6BIBAgGeXF36L3YhPf41G/8pmRIvX
         u5/rPmWJ+G0M9U7N6FOE60otbghxG0OttkND9ucVtkIEAT0NBO5YuJSgTjzBrV8ANnww
         6fLSNi9POouIyYwW8hRxX0r8eG+FVojnTnCR9/VqoyHe+7lcnpRXz1G5wvGXqIBcBCjN
         IJSfST1yyYo+1oAXjnJsfUoQFQSymcOhxY3SiKxXZ81i0j2NzuWGMwPv5iQPdWod6jH9
         zNMg==
X-Gm-Message-State: AE9vXwMyPIWsUW4WSqc4zcv0t+rtNADNxpH73epsEj9nYUAovOqZo5cUS+Oa8N3I44zPgtJJDMezp+g3Gtv4xA==
X-Received: by 10.36.80.138 with SMTP id m132mr4758745itb.32.1472023724500;
 Wed, 24 Aug 2016 00:28:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.130.1 with HTTP; Wed, 24 Aug 2016 00:28:44 -0700 (PDT)
In-Reply-To: <80062be27256704617280fdb479176e0d2afb4d4.1471968378.git.johannes.schindelin@gmx.de>
References: <cover.1471968378.git.johannes.schindelin@gmx.de> <80062be27256704617280fdb479176e0d2afb4d4.1471968378.git.johannes.schindelin@gmx.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 24 Aug 2016 03:28:44 -0400
X-Google-Sender-Auth: _5r4qydMpgUi5ZNyf0rg3NVd6zc
Message-ID: <CAPig+cT7fNsyhk1J0Z6evk8xRxa=g8ygUniBB+EHSRMRFcNLcQ@mail.gmail.com>
Subject: Re: [PATCH 09/15] sequencer: lib'ify create_seq_dir()
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 23, 2016 at 12:07 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> To be truly useful, the sequencer should never die() but always return
> an error.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/sequencer.c b/sequencer.c
> @@ -839,8 +839,8 @@ static int create_seq_dir(void)
>                 return -1;
>         }
>         else if (mkdir(git_path_seq_dir(), 0777) < 0)
> -               die_errno(_("Could not create sequencer directory %s"),
> -                         git_path_seq_dir());
> +               return error(_("Could not create sequencer directory %s (%s)"),
> +                         git_path_seq_dir(), strerror(errno));

error_errno()?

>         return 0;
>  }
