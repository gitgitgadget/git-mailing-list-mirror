Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 673472036D
	for <e@80x24.org>; Thu, 23 Nov 2017 07:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751591AbdKWHbg (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Nov 2017 02:31:36 -0500
Received: from mail-wr0-f182.google.com ([209.85.128.182]:45558 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751326AbdKWHbf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Nov 2017 02:31:35 -0500
Received: by mail-wr0-f182.google.com with SMTP id a63so16701008wrc.12
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 23:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jpeNPzmBsO6rEslFG3oW+ChQbuXOlwvbzuI9tJSZFyQ=;
        b=bx+kQiVSIU+P1oS7aXxRktLcXk1KyE+mk4bGj7JAR/XSNOUULk65s8v4p2JcK1nXXU
         aqLtue/Jb/KKHvnZWL66kPP/aGoNXZhPtf0+nZRshyQK863RQ9Y4C9RJAt8eNzYlxTiE
         eKQeBILJWbVQmh6izTy+oJX6J2Solqd5tLyEz+Mjdk6gPPWB99KLVvKIdJJFZaujzyka
         ik6ovrCWgjEWPmQGVZI+nwkQLx0/BGx4ky/bPcLME8OXpiE5r5PuAqZbUH08ftAgaAFl
         3bORzj4SXvKOdA9bHttW8TGVZdZKakiKC/+KgUWiGdLErOHI27F+BBzjHQ/XZ3gxPKpW
         sDsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jpeNPzmBsO6rEslFG3oW+ChQbuXOlwvbzuI9tJSZFyQ=;
        b=sAxz45tcne8byOOcro90RknkwbZ8/jp4UgPlX1UIYt5mJyXoTf/HgAsXqLcBYkM4x1
         YyrMG146Snrh0lip/57u+OEgjBw39OovlKSX+d4PKt+8E/MrU66oUclzpwcnrEaOEJ+r
         gRnGN+Ol4KxalNYh8pYPWckBwFTsI1edewgcg7SgtO9C7cyIxUJEXlhqajYR95d8l1Rd
         ua0lSNY0q/TN3D4hyD0IZEozFES2Ya2e/r22ZMhR4+LIkSy25lhNAQJ2yOHo2VMZCOfq
         byKbM6s9IbKTl66ms2qXYlJXk3IVHz1dQPhqWpOoVtcprz+jH143WH6jf3XYVs8neymh
         52dw==
X-Gm-Message-State: AJaThX6Fc/ucaLF5mhRR4C3uWDw3FC7JzI3rs8kv5wdbJlQnCsFw08iT
        p80hax3vcSDYtXbksCqWbaZEjtSapT3WegnwQow=
X-Google-Smtp-Source: AGs4zMZY5zbhhlWAwPCfWAlrbsG1cjqHVlMEN2Q5/hXXucAYFZ/KGlcYuK71UT/m/khf1nyOKO6ZFQ8SovPemSO6mmM=
X-Received: by 10.223.174.147 with SMTP id y19mr21188519wrc.97.1511422294852;
 Wed, 22 Nov 2017 23:31:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.151.195 with HTTP; Wed, 22 Nov 2017 23:31:14 -0800 (PST)
In-Reply-To: <xmqqh8u1efh5.fsf@gitster.mtv.corp.google.com>
References: <CAPkN8x+MELCnttE+xptKzYXsYPWqbiE59LABrwNBhFroayc+wQ@mail.gmail.com>
 <ec4be1c2-a0cc-cec8-a566-06c11c8abe06@gmail.com> <xmqqh8u1efh5.fsf@gitster.mtv.corp.google.com>
From:   anatoly techtonik <techtonik@gmail.com>
Date:   Thu, 23 Nov 2017 10:31:14 +0300
Message-ID: <CAPkN8xJU74N_kYL9f2v_vuk3C3omhYaz7uPMzbanEU=RTEPOYg@mail.gmail.com>
Subject: Re: Unify annotated and non-annotated tags
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Igor Djordjevic <igor.d.djordjevic@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 11, 2017 at 5:06 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Igor Djordjevic <igor.d.djordjevic@gmail.com> writes:
>
>> If you would like to mimic output of "git show-ref", repeating
>> commits for each tag pointing to it and showing full tag name as
>> well, you could do something like this, for example:
>>
>>       for tag in $(git for-each-ref --format="%(refname)" refs/tags)
>>       do
>>               printf '%s %s\n' "$(git rev-parse $tag^0)" "$tag"
>>       done
>>
>>
>> Hope that helps a bit.
>
> If you use for-each-ref's --format option, you could do something
> like (pardon a long line):
>
> git for-each-ref --format='%(if)%(*objectname)%(then)%(*objectname)%(else)%(objectname)%(end) %(refname)' refs/tags
>
> without any loop, I would think.

Thanks. That helps.

So my proposal is to get rid of non-annotated tags, so to get all
tags with commits that they point to, one would use:

git for-each-ref --format='%(*objectname) %(refname)' refs/tags

For so-called non-annotated tags just leave the message empty.
I don't see why anyone would need non-annotated tags though.
-- 
anatoly t.
