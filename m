Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 854F220D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 22:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751122AbdFAWFc (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 18:05:32 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34931 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751078AbdFAWFb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 18:05:31 -0400
Received: by mail-pf0-f174.google.com with SMTP id n23so38636251pfb.2
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 15:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wLn+A7+Bm77eD6RPCM4GCFDMnaGJRVZiuD0wKsgKWUo=;
        b=rRlU923iGOyVEn7bNBlbXhifVzg1Symx6yc6OOfYhdm93j3yvnb+FBxj6Ewy6QcT56
         2gjYVqoKUVB+AlIWjxuJ+LCbxaYFMtp9AW1LTLV1i9melv9BkfXMvKOmjow7nqi+PLDk
         Av1uB/k7cn1e6O5VposuLEWJQyBXMTek14UzNvmjzmZKOxqZ5v8iNq6+GtxGYGxP6AZ9
         HL3P3p9zbhamRsslqA1KzYTWpbGmKhcXYTyNh7fjTunMjE0MjiuJuDuu3G38WniHjB+t
         P+ErNDQFa28l77dHcdljOPG7sYu70ywz5BqADj/nQPFVVJSc4ITcU/BGntQQx0I2Vd5j
         72KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wLn+A7+Bm77eD6RPCM4GCFDMnaGJRVZiuD0wKsgKWUo=;
        b=lz9WxJFl+fvLZ+0uLqy26/CPFnrQ06mTtiuHltmxkVQ5cRaYtbKHN67t2+QxoG65YL
         p24wPqpFW6j/B6IrUhPr4E7Idis696QFL+VjocBDdRJvR214IqqFQkQlphzKuST5gmlr
         Fo7rouU6en5HwMSCzQoJdCSaC8S+4C2ONZuTx2DfrsGkBPRNSHKUMbZI8k62VBkm5nV0
         30+RhtEuUXnZEmn8UBBCy2u4e8I5OVrsWfbOAGnls6wJagdX55NEkKU7OEhJWTMhf4iL
         UvhFNjHh4+FWmbDhSdYXZ1PDaxzoam+yqpqGPJSwFlOIdL61U7QutGAZ+eKiKlXdHYYK
         hxxA==
X-Gm-Message-State: AODbwcBaa/lGASfsRJqlcrWE708YLGpmkmCTiEs8W2Wlg5xTxRn8bays
        1mBB8eDcz+Qt6acbvP4XvX2RhpC9B8KB
X-Received: by 10.99.113.6 with SMTP id m6mr3256797pgc.188.1496354730774; Thu,
 01 Jun 2017 15:05:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.151.14 with HTTP; Thu, 1 Jun 2017 15:05:10 -0700 (PDT)
In-Reply-To: <CACBZZX66dbdxuMx4EWdxYdRiMpBbXSbBCsmEO9uiEZYyyOmnDw@mail.gmail.com>
References: <0102015c64f0dceb-02338e52-74d5-4d6c-9a9d-f41e98ff88bc-000000@eu-west-1.amazonses.com>
 <0102015c64f0dd99-a702d419-2bbb-48a3-b541-296011972e7d-000000@eu-west-1.amazonses.com>
 <CACBZZX66dbdxuMx4EWdxYdRiMpBbXSbBCsmEO9uiEZYyyOmnDw@mail.gmail.com>
From:   Sahil Dua <sahildua2305@gmail.com>
Date:   Fri, 2 Jun 2017 00:05:10 +0200
Message-ID: <CALiud+=voDHiHEwavkvw+r4DEi=9Y6tuzniW=B82G+8zcst_xQ@mail.gmail.com>
Subject: Re: [PATCH/RFC v3 3/3] branch: add copy branch feature implementation
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 1, 2017 at 8:59 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Thu, Jun 1, 2017 at 8:35 PM, Sahil Dua <sahildua2305@gmail.com> wrote:
> > Adds copy branch option available using -c or -C (forcefully).
>
> Commenting on the series in general. I have a fixup branch for you
> with commits to squash:
> https://github.com/avar/git/tree/avar/sahildua-rename-branch-2 issues:
>
>  - There's a mixed variable declaration  with code, should be predeclared=
.
>  - Stuff like printf(_("% branch), "copied") gives bad translations,
> needs to be expanded
>  - Fixed up comment style
>

Thanks for fixing the issues.

> In addition when I try to run the tests I get:
>
>     fatal: cannot lock ref 'refs/heads/a': 'refs/heads/a/b/c' exists;
> cannot create 'refs/heads/a'
>     not ok 45 - git branch -c a a/a should fail
>
> And there's 18 other failures in that test script, although some could
> be from that first failure, doesn't this fail for you? I can't see why
> it wouldn't everywhere, i.e. you're trying to create a "a" ref when
> "a/b/c" exists.

Indeed I see 3 of the tests failing. The issue is the existing
branches. I have the fix for them by changing the branch name. I will
push it and send another patch along with the above changes.

However, I am having problems in getting one test pass - "git branch
-C c1 c2 should add entries to .git/logs/HEAD". I'm trying to figure
it out.

"Branch copied" log is being added to .git/logs/HEAD. However, it
doesn't work in a similar way as -M option. Hence, it's not being
returned when we grep by ^0\{40\}.*$msg$.
