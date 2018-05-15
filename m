Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C5191F406
	for <e@80x24.org>; Tue, 15 May 2018 01:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752094AbeEOBZf (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 21:25:35 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:33665 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752031AbeEOBZe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 21:25:34 -0400
Received: by mail-vk0-f68.google.com with SMTP id q189-v6so8725992vkb.0
        for <git@vger.kernel.org>; Mon, 14 May 2018 18:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0Yo6wjuj5omMyVGQgmS5zuz39ZZ0mfiJdw8J9ms/tm4=;
        b=Q44BIr9Vr9CoZrh5ukw7lotUre9RzV/H5J3WH3Yp8ypit1O9vgvBhSQFfwk3UlrYLC
         wpc40g5bqKEI8pYWOGzEQ004lAdfsTdxJ/1NVXTjV8BKeIasJGCbEBtEtrSmaw6YxfZ/
         CuDyLFQlu/8GzL83j0+qDhIb3ICQfTm3m3zCg4W/91VPeTfY/QyKyZtaUFeAjbu+ObOB
         Hhvol1Ep4U9p2Xxg6393shjXG1ACQHsToPWP5BqwxmyEs4zffC75//hi1HjGDf7P6u6z
         KBodw6TV2P3C5DDm9Qf3geUHSpV0AJk9iHiPJaUMXfHVm5GLp0dqEsFTA+OsZwTs6Tlk
         NSMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0Yo6wjuj5omMyVGQgmS5zuz39ZZ0mfiJdw8J9ms/tm4=;
        b=cHA1lXoA3wzu9tzQhlTmHSI5qsKCA78C55lLFMS3xT0uzs2u0+pPSMaEymr5Bvs2Yh
         2+RcsXIwzeYvmEThOnye3C+oKmgFtZaj+9j3eudtuxlFHPDysrAnB5/C1aPFA9+RXUiB
         Ur2LrtM9lCh5/KBapgQv4VMmYYbU9EuJt6zcBRAw3+9fFQ75i5QzEvmJiSNC+G69Y1t6
         MgcPQXxUFKzSCXVy941wFW/7hvghgIdxrdEPr5e3wicSYr6U4en2Cn6M4CGvqA++NFeN
         2bVVRBGZGy6ixtDNcVAZSOAYqn2YqiTqat7jTh+t4g/Q5G2Pyvpj8DrZjsr12xxkffsI
         uY/A==
X-Gm-Message-State: ALKqPwdawH4vWyuiBShJglBKYJ/BSVQS0s2Ne9P785uHwmA3gRxrbJ8O
        LgZXKJQH66on3Qs5w03BoPKDR+FAD4glozsN1Y4=
X-Google-Smtp-Source: AB8JxZol6Togb5ma/rqxNTesqRJqm449wDTvMUxc0TnjwUlGlLfjSLvnuSwzmxI0PEyXoT4h6DdoKP/7x9XEe00OIwQ=
X-Received: by 2002:a1f:c155:: with SMTP id r82-v6mr12866102vkf.76.1526347533635;
 Mon, 14 May 2018 18:25:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Mon, 14 May 2018 18:25:33 -0700 (PDT)
In-Reply-To: <20180510211917.138518-3-sbeller@google.com>
References: <CANw0+A_T5zDUUWznYBe0m9fkSODPnfQaK1yJKPPawHTxi9+9BQ@mail.gmail.com>
 <20180510211917.138518-1-sbeller@google.com> <20180510211917.138518-3-sbeller@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 14 May 2018 18:25:33 -0700
Message-ID: <CABPp-BFw0g=3i8AoiCDgZR82ScOmiozDQqTggZ4U5kmiurFMdg@mail.gmail.com>
Subject: Re: [PATCH 2/2] merge-recursive: i18n submodule merge output and
 respect verbosity
To:     Stefan Beller <sbeller@google.com>
Cc:     Leif Middelschulte <leif.middelschulte@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I know I said the patches looked okay earlier, but I just noticed something...

On Thu, May 10, 2018 at 2:19 PM, Stefan Beller <sbeller@google.com> wrote:

>         case 1:
> -               MERGE_WARNING(path, "not fast-forward");
> -               fprintf(stderr, "Found a possible merge resolution "
> -                               "for the submodule:\n");
> +               output(o, 1, _("Failed to merge submodule %s (not fast-forward)"), path);

We allow folks to set GIT_MERGE_VERBOSITY to change how much output
they get.  A setting of 1 should only show conflicts or major
warnings.  2 is the default and adds a few more messages (e.g.
"Auto-merging $PATH", "Adding $PATH" for one-sided adds, etc.), higher
levels show even more.

Anyway this output message is correct to use level 1 since this is a
conflict, but...

> +               output(o, 1, _("Found a possible merge resolution for the submodule:\n"));

I think this should use level 2.

>                 print_commit((struct commit *) merges.objects[0].item);
> -               fprintf(stderr,
> +               output(o, 1, _(
>                        "If this is correct simply add it to the index "
>                        "for example\n"
>                        "by using:\n\n"
>                        "  git update-index --cacheinfo 160000 %s \"%s\"\n\n"
>-                       "which will accept this suggestion.\n",
>+                       "which will accept this suggestion.\n"),
>                        oid_to_hex(&merges.objects[0].item->oid), path);

and so should this one (in fact, I'm tempted to say these last two
should use level 3, but since it looks like a command users may have
difficulty finding on their own, I'm okay with going with 2).
