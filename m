Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2CB91F424
	for <e@80x24.org>; Wed,  9 May 2018 15:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965293AbeEIP7v (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 11:59:51 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:38085 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965206AbeEIP7u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 11:59:50 -0400
Received: by mail-ot0-f196.google.com with SMTP id n3-v6so4431806ota.5
        for <git@vger.kernel.org>; Wed, 09 May 2018 08:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zMhagM2w2H5Ux9DUDiYogZiYTtpwe3Q/r8+qF+4pCjI=;
        b=fc8KkKuXv5PslogWIFOjrKcM8Fyu88IsuRhUvlDv+eQq8AP/qeO7fNWbp60vyvHTGH
         /m4K7Df+ShaxmhHrdV8f2osExXISCcxqYbUKd6SoD9pTbfr7tqpep0fMnpx0qmzaSm32
         3ntOyYdtY2qteKc1yFmtLDfxgDoqXIBCD76PF8atwPXut/EHc/Ka0hlJoBS3S85nBA5Q
         +a1hiAq99lSU/p1/XSVdjTDpr0PYgPHCBfPUS0ZtndDzILRuKmc2OTY3jJ61tZnEdi6A
         VeUa0ZnladsbJSWk1AiY5erhNmrXSo1qU8/P+EE5FeKQC7ea7Ok6rUvh8yzE3frlTKyH
         S+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zMhagM2w2H5Ux9DUDiYogZiYTtpwe3Q/r8+qF+4pCjI=;
        b=dNNQnwwKrl6fyqtT5usUjKEgqG2GhhklnlB3bh5Qh979ba/A8fcDzAFIzTxqut0R2y
         BvBfILEBWRMAiJpM8hEkC1MteuaLkO/yHGXVV4pOdthFd+m35u5CHjiR6dYlsWTSD3qi
         Y3qgNHT/+9iQTOx6ON2XcrMCfxkqqNkLe9NkjDuefSim2SaQsc6llgLU+FP950Qy/S2b
         FNJ6F+L5ttOIZHzVO1bQAWvMFt9Dhda+03JjTc3UnGnmwanEXQZoNOqoWsOvsA1kaODZ
         7V9OISry24SCpEH7M4fCzwsPo1gKSgFAA07gISqd8iW3kn/lpIm5sLhWmXqjsNBg7cxo
         AYJw==
X-Gm-Message-State: ALKqPwfBpL+YFGT0I0bhrsweQWAiO+9afH5JW1lbltZPQwXlUQNymYDB
        8r/N4JJMPBR9H3GJvR08r597xNzMC4ycgKga3Pk=
X-Google-Smtp-Source: AB8JxZqzj69ZKydvVNL+vmLGptJRdUsIk8UCynFiY8JR7x0nm3WvCuz+CRG3kqQgpYKyN1Amm2ev/sjIiSiX+wFXogk=
X-Received: by 2002:a9d:c61:: with SMTP id 88-v6mr5936633otr.173.1525881590432;
 Wed, 09 May 2018 08:59:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Wed, 9 May 2018 08:59:19 -0700 (PDT)
In-Reply-To: <20180509144213.18032-1-benpeart@microsoft.com>
References: <20180509144213.18032-1-benpeart@microsoft.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 9 May 2018 17:59:19 +0200
Message-ID: <CACsJy8CdvKO3aityyP3Ax0ZqaS6JzwH_i2Gn_8NmCUDKHMMQrw@mail.gmail.com>
Subject: Re: [PATCH v1] add status config and command line options for rename detection
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "newren@gmail.com" <newren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Alejandro Pauly <alpauly@microsoft.com>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>,
        "eckhard.s.maass@googlemail.com" <eckhard.s.maass@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 9, 2018 at 4:42 PM, Ben Peart <Ben.Peart@microsoft.com> wrote:
> Add a new config status.renames setting to enable turning off rename detection
> during status.  This setting will default to the value of diff.renames.

Please add the reason you need this config key in the commit message.
My guess (probably correct) is on super large repo (how large?),
rename detection is just too slow (how long?) that it practically
makes git-status unusable.

This information could be helpful when we optimize rename detection to
be more efficient.

>
> Add a new config status.renamelimit setting to to enable bounding the time spent
> finding out inexact renames during status.  This setting will default to the
> value of diff.renamelimit.
>
> Add status --no-renames command line option that enables overriding the config
> setting from the command line. Add --find-renames[=<n>] to enable detecting
> renames and optionaly setting the similarity index from the command line.
>
> Origional-Patch-by: Alejandro Pauly <alpauly@microsoft.com>
> Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
-- 
Duy
