Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB50620248
	for <e@80x24.org>; Fri, 29 Mar 2019 12:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbfC2MNz (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 08:13:55 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:33537 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728704AbfC2MNz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 08:13:55 -0400
Received: by mail-oi1-f173.google.com with SMTP id e5so1481948oii.0
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 05:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ayc5gmkDv0E+aS3B3n3Gv2tetjhKpNkOCy+iJuqFfd8=;
        b=RZCzh0JclG3b6GyXkVhaJo3bkNP9ch7MIEA+ix0lnYPhOLtm4qHPTEKKBoB+dws5y6
         Q8B6vrz8bvJopDA46HTRhfVJ5p9VdYb+DAl6lXsu+/BL3XegejeSdN+lMaeOAh3K5g8m
         aZQ98MhawyzIW5I42d5z5CF/4med0zqKYvq1D7BgnPiz6kKxSVciHNt4O88EjsjA8ZtB
         Aiso6WqtKwRYCq28N8brNSxS8+fVOrQ0yJEr6sdNhvTFjmFWgdIhnsO1Jlqra5NECeu9
         nyGSgl5//aRBUB4BhRXWOcwc+Y3efTtMIE6T1EZHsM2w6J6Zfv+SFAopfaoUQi8yUecc
         lVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ayc5gmkDv0E+aS3B3n3Gv2tetjhKpNkOCy+iJuqFfd8=;
        b=m6N937/VU/S0T7CtLqHmErtOjcAREdS1ZtYyYXm9PaHi0YJ9wRjl2pdwSSGJg77gLe
         GZkD1XTrNNS4RCIGaPZMGZBsHpwdoCzSFtfedkacGNEizyncbC8Spz4tUJbooNpbc160
         jTd9n6iXBuEiefI5LnIQCYnHVM5LFTSftvQmYv2+q8NJIs2yQF/f4L5+mPj0LGa3pniA
         oJwcNgUu8BX6Lxi4ZDuDZxgj5SHkLT67RXPIFsUoL5zERlqB+pNbm8VHjEuCwEMkWuKu
         efXtZr0aHypjbafairvk27HTIePdueUDpfpPztQLaTFcM+Tx+AYuyk2eSgjCXIRtSABo
         Duow==
X-Gm-Message-State: APjAAAWWHH4CCbq4Fls99jEbp56129q+s/agNQELcydRjg4cwZq+h2mh
        LWZAN8I1PC26PEsEnG6Bfrf0vUnLqKQXWf2XkSBIog==
X-Google-Smtp-Source: APXvYqxueAoe8h7he5dbZka41wE57RyFOiXOxig7U8caR+VgZfcG/b+Ctr2LmB3mme6DqBsU/cqpI+63umAIdiJ0KAo=
X-Received: by 2002:aca:ba82:: with SMTP id k124mr3597740oif.110.1553861634201;
 Fri, 29 Mar 2019 05:13:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190322160615.27124-1-jkapil.cs@gmail.com> <CAP8UFD3K4ft7UVSFeaQzKVVGFPwcLcpTKB+sqFN9X9_j_A093w@mail.gmail.com>
 <CAMknYEMBYxp1QJ3Ds9dmuS4ccHKtExx33d_Kv63UOwaUMm5oUQ@mail.gmail.com>
 <CAP8UFD0cWSTZPqqVwTFyYL06S+6aT_EiLPW6jUE0AH9puxevmg@mail.gmail.com>
 <CAMknYENJ+U4urtSEtwDSLpdwGe=x=uq_HdSs-cT9Z+PT5ZQiLg@mail.gmail.com> <20190328213010.GI32487@hank.intra.tgummerer.com>
In-Reply-To: <20190328213010.GI32487@hank.intra.tgummerer.com>
From:   Kapil Jain <jkapil.cs@gmail.com>
Date:   Fri, 29 Mar 2019 17:43:42 +0530
Message-ID: <CAMknYEM3Tff7Z5HcdNT9-RDTf53RHi1_scpO8JVo3pAD3-0xSw@mail.gmail.com>
Subject: Re: [GSoC][RFC/PATCH] userdiff: added support for diffing shell scripts
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 29, 2019 at 3:00 AM Thomas Gummerer <t.gummerer@gmail.com> wrote:
>
>
> I had previously mentioned that this project was attempted already in
> my email at [*1*].  Did you take a look at the thread I linked to
> there, and the regex used?  I still feel like that previous experience
> is something you could learn from.

I saw it, and the regex i have used is a little different from that one.

> But that said, I think your assumption in the other email that the
> output should be
>
> [-$TEST_DIRECTORY-]
> {+$TEST_DIR+}
>
> might not be correct.  The tests are using 'git diff
> --word-diff=color', rather than 'git diff --word-diff=plain'.  Only
> the latter would add the [- -] and {+ +} around the changed words,
> while the former adds the color, which the tests are testing for.

This makes sense, i will write more tests for this.
