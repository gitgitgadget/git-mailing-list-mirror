Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D37AD20229
	for <e@80x24.org>; Thu, 20 Oct 2016 19:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933700AbcJTTye (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 15:54:34 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:36397 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933216AbcJTTyd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 15:54:33 -0400
Received: by mail-qk0-f176.google.com with SMTP id o68so115453922qkf.3
        for <git@vger.kernel.org>; Thu, 20 Oct 2016 12:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XhGRK39QHPg29TmOBOCiCHer+pGZ0+NdHagTW9Ak+vs=;
        b=A9ZWyzkluNafCQnu+oArnkIbcDl++q8aC8AqiqalV+J7DXTWKeainj5RI8kY1iHMFb
         ZJdAfOynDB3aRqarpMIxMZnv/YRwaEvFdbi0B1AAMbzvzfVsXrOI/8g7pOvCxFBYWITJ
         vqFPBmBCutCqFfXnq/lr5a8tg1AzUqs662QJJXpOZJ1FQCftA4qpbvyx+RiNSPr2K1r+
         cccyyXXyaWNrnm8hOPDQfDtaus/LL9D1ostiQvsKvN730X2+ERYnkhgE2nzPrr7CwiRL
         cRsM2/ecZwOMaC9WXoPS/y9/HETow6Fy1ZPCCKEmNd+rnMVxa23Q3TK5KWMzRcPtxSCj
         Qyjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XhGRK39QHPg29TmOBOCiCHer+pGZ0+NdHagTW9Ak+vs=;
        b=DFsmUwDt9kLi5mYX3ic9Uuw1CUENGLPo8KGlSgCThzkiHvhjY28ruNERbCmCe7e+95
         WDZZFDgzvgWoH0ZoQj9R3ZCe49AdIZ+AKZeFHpGcuZhggSCcDgsdTuqLzMDkT5+xeJ+0
         M4twBAERfvM5YcVZWGrByRL1YsE1TxisORhLImxMZRC+gabahNvyZO+M9Qze84rPuCsD
         shhzXTvCJ6rk/qso28jgBW+Pn2WOFQGWT1KkNlSt9mgRMFBT4yveErwOuid/Rn1GaVcE
         7Uvgaw7RDtfKoTwfsfAg1De6gcUvFkRdNXv+Lcecxc6nKQXH/VbzUVHPxqjXORErF3/n
         4Snw==
X-Gm-Message-State: ABUngvfil0JQd6kgPImOqJ7YnxdeeFS7xn3y9Z6ArFIWJoRir63oB1EvYEfJL27vpemk8fA7SV1Vck5X9w8ORhta
X-Received: by 10.55.129.1 with SMTP id c1mr1975673qkd.53.1476993272638; Thu,
 20 Oct 2016 12:54:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Thu, 20 Oct 2016 12:54:32 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1610201218060.3264@virtualbox>
References: <alpine.DEB.2.20.1610191049040.3847@virtualbox>
 <xmqqbmygmehv.fsf@gitster.mtv.corp.google.com> <20161019205638.m3ytxozzmeh47ml2@sigill.intra.peff.net>
 <alpine.DEB.2.20.1610201218060.3264@virtualbox>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 20 Oct 2016 12:54:32 -0700
Message-ID: <CAGZ79kZpj5xXHmnA+JfLKdGmgzp7Mut1OsKMOeowpw8m1+aKGA@mail.gmail.com>
Subject: Re: Drastic jump in the time required for the test suite
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 20, 2016 at 3:50 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi peff,
>
> On Wed, 19 Oct 2016, Jeff King wrote:
>
>> On Wed, Oct 19, 2016 at 10:32:12AM -0700, Junio C Hamano wrote:
>>
>> > > Maybe we should start optimizing the tests...
>> >

Maybe we should stop introducing un-optimized tests.
For other reasons I just stumbled upon t7064
(porcelain V2 output for git status)


This is how an arbitrary test looks like:

test_expect_success 'staged changes in added submodule (AM S.M.)' '
    (    cd super_repo &&
        ## stage the changes in the submodule.
        (    cd sub1 &&
            git add file_in_sub
        ) &&

        HMOD=$(git hash-object -t blob -- .gitmodules) &&
        HSUP=$(git rev-parse HEAD) &&
        HSUB=$HSUP &&

        cat >expect <<-EOF &&
        # branch.oid $HSUP
        # branch.head master
        # branch.upstream origin/master
        # branch.ab +0 -0
        1 A. N... 000000 100644 100644 $_z40 $HMOD .gitmodules
        1 AM S.M. 000000 160000 160000 $_z40 $HSUB sub1
        EOF

        git status --porcelain=v2 --branch --untracked-files=all >actual &&
        test_cmp expect actual
    )
'

Following "modern" Git tests I would have expected:

* heavy use of the "git -C <dir>" pattern. When applying that
  thouroughly we'd save spanning the subshells.
* no `cd` on the same line as the opening paren.
  (This is style and would derail the performance discussion)

test_expect_success 'staged changes in added submodule (AM S.M.)' '
    git -C super_repo/sub1 add file_in_sub &&
    HMOD=$(git -C super_repo hash-object -t blob -- .gitmodules) &&
    HSUP=$(git -C super_repo rev-parse HEAD) &&
    # as a comment: HSUB is equal to HSUP, because ...

    cat >expect <<-EOF &&
    # branch.oid $HSUP
    # branch.head master
    # branch.upstream origin/master
    # branch.ab +0 -0
    1 A. N... 000000 100644 100644 $_z40 $HMOD .gitmodules
    1 AM S.M. 000000 160000 160000 $_z40 $HSUP sub1
    EOF

    git -C super_repo status --porcelain=v2 --branch
--untracked-files=all >../actual &&
    test_cmp expect actual
'

That said I really like the idea of having a helper that would eliminate the cat
for you, e.g. :

git_test_helper_equal_stdin_or_diff_and_die -C super_repo status
--porcelain=v2 --branch --untracked-files=all <<-EOF
1 A. N... 000000 100644 100644 $_z40 $HMOD .gitmodules
1 AM S.M. 000000 160000 160000 $_z40 $HSUP sub1
EOF

Thanks,
Stefan
