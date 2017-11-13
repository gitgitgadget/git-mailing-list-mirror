Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EA801F42B
	for <e@80x24.org>; Mon, 13 Nov 2017 22:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752890AbdKMW5F (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 17:57:05 -0500
Received: from mail-ua0-f171.google.com ([209.85.217.171]:47516 "EHLO
        mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752523AbdKMW5E (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 17:57:04 -0500
Received: by mail-ua0-f171.google.com with SMTP id s28so6493772uag.4
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 14:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TKoELb67ooWHIJYAlzS50H6RDQPZEb2BTl9S6GsjVDE=;
        b=l5C0Z6WtNfwMBtRNSKdWdTGXtlEZsY0eUr6ZvhTnG/kLpYd+IdZWJBe9MYr4BO82uj
         nApqEXnE8q+/piAedKC0Eq1u2Vo9X1pk55ws5095bz1jz8CIWuw+pQp7bxXzx/cUZANu
         YkB7YY7C95Phy5sn7QvP0N7+RJ8Lh5kkK6OdgKw2Rz1sDBJA412MaWk0pqWyQWvAZbzK
         7lsakogMzmsgW66P+YOILLLfglMjLIS/NpZYApM+CSYLhAKOn1zbqWW+KoNXEtduUf/6
         Nm12XSeA+EHd1IaPCgfAsoXfcVTqsBGubhFz+wNobB132c9vvszmhiSczOJY5vycq3MB
         cYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TKoELb67ooWHIJYAlzS50H6RDQPZEb2BTl9S6GsjVDE=;
        b=tvFcrzug7ohSAQmftehpH1cIBUsWYNUzpfcT6txw9Z7PGFPEPR2GwYx7TbrXFigAlh
         cyMGewM46Z4qN+W3T0RU2hAsRUrAGhsjN1dHCuDchoWeo2rVZp4s/dyLse/2l7+hOjvS
         Hyx+dBZShyZVahbIMLCHnVj1Qbo1Q3AhjvmB+JcYd4drXAD1/T7T5TTGqWzzc75PvAU8
         OKVkHRZlDqi8GLX6k0LsfoD4uwlWmtKAM+oT3665rLvaW1Kcvk1cSRTF2YJXQloe2M46
         0u1Oe84tJ4K2e1jjz9LAyOP0a5N3BdJGNt7IYcuv/ewe8G7X7l52DvdLYAILUtX79yY0
         SkAw==
X-Gm-Message-State: AJaThX6Bws9/eQArWTwbKsnl87ez8So6CVjHmR3+PGKULKIs7i963LEg
        otnMar+U56Ly36t86iOwwbnJzXmuY0kKfHwzObc=
X-Google-Smtp-Source: AGs4zMZ8TheP3TacieL8Xa/LBKelTa26XDlGOpSHC4Z6ZBBKyNLAZdbNxElcoCdwZZNU3vVEE9R4qkOHvFha7c+mcDE=
X-Received: by 10.176.85.152 with SMTP id v24mr9669904uaa.147.1510613823236;
 Mon, 13 Nov 2017 14:57:03 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.67.33 with HTTP; Mon, 13 Nov 2017 14:57:02 -0800 (PST)
In-Reply-To: <CAGZ79kZ7d7fMp3Cw3Yy4bq9-Mh5Z_jhM5XDQbkVLoqzm6ONzDg@mail.gmail.com>
References: <20171110190550.27059-1-newren@gmail.com> <20171110190550.27059-4-newren@gmail.com>
 <CAGZ79kZ7d7fMp3Cw3Yy4bq9-Mh5Z_jhM5XDQbkVLoqzm6ONzDg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 13 Nov 2017 14:57:02 -0800
Message-ID: <CABPp-BFSt8NGSzkoJdhst_NHqx_hVGMzO-688SOdYRB413Zd9g@mail.gmail.com>
Subject: Re: [PATCH 03/30] merge-recursive: Add explanation for src_entry and dst_entry
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 13, 2017 at 1:06 PM, Stefan Beller <sbeller@google.com> wrote:
> On Fri, Nov 10, 2017 at 11:05 AM, Elijah Newren <newren@gmail.com> wrote:
>> +       /*
>> +        * Because I keep forgetting every few years what src_entry and
>> +        * dst_entry are and have to walk through a debugger and puzzle
>> +        * through it to remind myself...
>
> This repeats the commit message; and doesn't help me understanding the
> {src/dst}_entry. (Maybe drop the first part here?) I'll read on.

Yep, I'll toss it.

>> +        *
>> +        * If 'before' is renamed to 'after' then src_entry will contain
>> +        * the versions of 'before' from the merge_base, HEAD, and MERGE in
>> +        * stages 1, 2, and 3; dst_entry will contain the versions of
>> +        * 'after' from the merge_base, HEAD, and MERGE in stages 1, 2, and
>> +        * 3.
>
> So src == before, dst = after; no trickery with the stages (the same
> stage number
> before and after; only the order needs to be conveyed:
> base, HEAD (ours?), MERGE (theirs?)
>
> I can understand that, so I wonder if we can phrase it to mention (base,
> HEAD, MERGE) just once.

Perhaps:

  If 'before' is renamed to 'after' then src_entry will contain
  the versions of 'before' from the merge_base, HEAD, and MERGE in
  stages 1, 2, and 3; and dst_entry will contain the respective versions of
  'after' in corresponding locations.  Thus, we have a total of six modes
  and oids, though some will be null.  (Stage 0 is ignored; we're interested
  in handling conflicts.)

?
