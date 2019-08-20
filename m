Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28E701F461
	for <e@80x24.org>; Tue, 20 Aug 2019 19:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730764AbfHTTm5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 15:42:57 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:46512 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730669AbfHTTm4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 15:42:56 -0400
Received: by mail-lj1-f175.google.com with SMTP id f9so6238907ljc.13
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 12:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p6VxOHTqnh7gDgnpmiR+7tSNEBL5HuhgzoA9qRs6PWc=;
        b=o5qZCAJb7mi/UW6s5LSWe+bSr9DtxAkU0TtYK5FVU8u01pErNDuF7TODUpcZ2o3yts
         f7BCnUC18xfjyBKnlFP+u6Vr/iic3MzjOiWTTDH4IfEAzkj+D20S/Ux30W4MYmpzgres
         nVhFb7TgicMVCvPZ9aCMT9w2GHyKPeRu6uZ2oLycOs9brp4rKg5C00YvwJcWIvCirY2C
         QSGEXiYaWCW3bK5cfnOofsq/RzDAveSK0Ak4RvHs9/OUsR0v+Ax7gFkwhUmti1r3dcol
         mUs6l45aLxjY1QcY7oqA1Hmpi9nJVNBJKOT8GOSORij4wgFhraWO2e2YEMYerHTcQbKz
         05Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p6VxOHTqnh7gDgnpmiR+7tSNEBL5HuhgzoA9qRs6PWc=;
        b=F3SgLad+QYPFujaM3RAiy4I+FRe0wm61KnjpI9GTwRRNvCH0u0FHUw5M9EQCZVRFMf
         Yo9G+c079R44ZLODo/vl1Fzd6p0yhJ9nNsVP/sItc+kqPsTkPzfWGw1Gi3IglcPzgtpX
         LP19eGlfPkt2ggO4w3KYE9UCJrJzEcR7JKmNhcyaDL+HsHaxohU5QYVjpKZ6EYoi+rcO
         dgOuOM3VrkKpBXXm60Bs1+yZmJZigjWhI4YwZ34hm2TOj5I83bTb4XKwZg+zujQEN7tn
         KYuayKA1I6b3YwJ/JDVEAfA1+/4S3Dg/wSoEin0f8tq3R+IbJJvrRfXPHYvo2wHaNBKj
         6a2Q==
X-Gm-Message-State: APjAAAVoRcp1xEXIcKz/nslRHPmI1JvcSqVoCTnfGvFu2s5GF5Vfvn/f
        9GqUu2V7K5Bg5icRqkSdSZVa2v9lYUV8ulPO8CI=
X-Google-Smtp-Source: APXvYqy+wLcE2IPHnIul78ExZJg2+857JzoAnrfOTrh4s7JB3lIlgmElUVat0xFpc0eAQ0SjsTSxfaiCpLH7UrI3Lho=
X-Received: by 2002:a2e:948:: with SMTP id 69mr15453637ljj.39.1566330174681;
 Tue, 20 Aug 2019 12:42:54 -0700 (PDT)
MIME-Version: 1.0
References: <477295c5-f817-e32b-04fd-a41ddfbbac0a@gmail.com>
 <20190820174640.n3elekpi6l4vwamp@localhost.localdomain> <f899594c-4f57-b941-f4f1-fd3b8f81136a@gmail.com>
In-Reply-To: <f899594c-4f57-b941-f4f1-fd3b8f81136a@gmail.com>
From:   Phil Hord <phil.hord@gmail.com>
Date:   Tue, 20 Aug 2019 12:42:42 -0700
Message-ID: <CABURp0oCvrVxdvkEyBy_Oe-xy7mEM9Yek-Qe9vnxO9MPfR3Vqg@mail.gmail.com>
Subject: Re: Only track built files for final output?
To:     Leam Hall <leamhall@gmail.com>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 20, 2019 at 11:01 AM Leam Hall <leamhall@gmail.com> wrote:
> On 8/20/19 1:46 PM, Pratyush Yadav wrote:

> > So in your case, what's wrong with just tracking the source files needed
> > to generate the other files, and then when you want a release binary,
> > just clone the repo, run your build system, and get the generated files?
> > What benefit do you get by tracking the generated files?
>
> For internal use I agree with you. However, there's an issue.
>
> The generated files are used by another program's build system, and I
> can't guarantee the other build system's build system is built like
> ours. It seems easier to provide them the generated files and decouple
> their build system layout from ours.

It becomes a burden to keep build products in the repo over time, for
the reasons you already mentioned (they don't merge and you shouldn't
try), but also because those build products never go away, leading to
repo-bloat.  Once you realize the cost is too great, it's often too
late to do something about it cheaply.  My advice is to keep your
source repository clean from the beginning, so it contains only source
code.

This means you still have a problem because you want to distribute
certified build artifacts.  I recommend you use some other tool to
handle that, like Artifactory.

I recognize it seems easy to use Git for this because Git already acts
like a reliable, portable, trackable file distribution system. But
that's secondary to Git's purpose; there are better tools for that. If
you must lean on Git for this, I like to isolate the binaries into a
submodule so developers who don't want or need them aren't bothered by
them, and they can stay out of the way of merges.  But submodules
present new workflow challenges and will require some study and
education.  If you want to keep them out of the way of developers, you
can keep your source code repo and your artifact repo completely
separate and make some "superproject" which contains both of those
repos as submodules.  The nice feature about this setup is you can
positively associate the set of build products with the set of source
code that produced them.
