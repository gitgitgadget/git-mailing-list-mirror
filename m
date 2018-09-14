Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B61D1F404
	for <e@80x24.org>; Fri, 14 Sep 2018 23:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbeIOEx2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Sep 2018 00:53:28 -0400
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21821 "EHLO
        sender-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725724AbeIOEx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Sep 2018 00:53:28 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1536968207; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=WK2V9BYrJEkZ2C+vOf2IzyFMTZAqEJ60WG830mrJbSAEUXL8tESWAT2oy3JR4D7chfemD2BOQmEFHdi3IJTYaowdOVnHUgMkl7zFjIs2ti1VenFAzlZVaZfkzXQQQm4aNm7ZRe7wJsi/7cxqkHkbgTa3FfCZ/FXZr/klOisXwbQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1536968207; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=Vj2KNjjUSCDHl/qN0J9giJOYxdPDTpV3x/M6K+mhjlk=; 
        b=RHnzXPm3BHvxs1SGvTnqx52wyQmOIU4K0aLgIK3YWNgmyD5zFjjXFEwqydfUBSb2R+u37aBU0Lr3UBnzIHQdzftH15r3SfmhGSAYRmrjDQS7Jiate+kYsjDXho+vC6JCqNj2cl3AK3Zb/Y8Tbk9WgPlQS0KiolSb0LY/7fQpnTU=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=astrangergravity.com;
        spf=pass  smtp.mailfrom=john@astrangergravity.com;
        dmarc=pass header.from=<john@astrangergravity.com> header.from=<john@astrangergravity.com>
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182]) by mx.zohomail.com
        with SMTPS id 1536968205446457.03560389934705; Fri, 14 Sep 2018 16:36:45 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id u83-v6so8770809lje.12
        for <git@vger.kernel.org>; Fri, 14 Sep 2018 16:36:44 -0700 (PDT)
X-Gm-Message-State: APzg51CIEZhQVx3XVlRnLUPVwtxunYAAqyQxj4mhgtbWv1dMZkM+9zJ+
        EIQUI/ycoUBu/+CCZ9F0o9eg4mX9MXMYYdySSlQ=
X-Google-Smtp-Source: ANB0VdaSyWAU5kqaurFwKVJA8px+lKBBgjlSrU7+sJVzRf9F1q40BBVGQa+M+txft+nvK9vXd0m/f4/+uKZPwKuk0JQ=
X-Received: by 2002:a2e:650e:: with SMTP id z14-v6mr8754244ljb.62.1536968203663;
 Fri, 14 Sep 2018 16:36:43 -0700 (PDT)
MIME-Version: 1.0
References: <CA+AhR6fWpzL1ozt2H=y8TaQrgT-6dvkkK_K_P-pXniXT+xcMuQ@mail.gmail.com>
 <87bm8zlqrh.fsf@evledraar.gmail.com>
In-Reply-To: <87bm8zlqrh.fsf@evledraar.gmail.com>
From:   John Austin <john@astrangergravity.com>
Date:   Fri, 14 Sep 2018 16:36:19 -0700
X-Gmail-Original-Message-ID: <CA+AhR6d4p2N06t-w62A2=wTH0x1ipt3x3hN2mQKK-Cwj0rMX1g@mail.gmail.com>
Message-ID: <CA+AhR6d4p2N06t-w62A2=wTH0x1ipt3x3hN2mQKK-Cwj0rMX1g@mail.gmail.com>
Subject: Re: Git for games working group
To:     avarab@gmail.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-ZohoMailClient: External
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> There's also the nascent "don't fetch all the blobs" work-in-progress
> clone mode which might be of interest to you:
> https://blog.github.com/2018-09-10-highlights-from-git-2-19/#partial-clones

Yes! I've been pretty excited about this functionality. It drives a
lot of GVFS/VFS for Git under the hood. I think it's a great solution
to the repo-size issue.

> Is this just a reference to the advisory locking mode perforce/cvs
> etc. have or is there something else at play here?

Good catch. I actually phrased this precisely to avoid calling it
"File Locking".

An essential example would be a team of 5 audio designers working
together on the SFX for a game. If one designer wants to add a layer
of ambience to 40% of the .wav files, they have to coordinate with
everyone else on the project manually. Without coordination this
developer will clobber any changes made to these files while he worked
on them. File Locking is the way that Perforce manages this, where a
developer can exclusively block modifications on a set of files across
the entire team.

File locking is just one solution to the problem. It's also one that
doesn't play well with git's decentralized structure and branching
model. I would state the problem more generally:
Developers need some way to know, as early as possible, if modifying a
file will cause conflicts upstream.

Optionally this knowledge can block modifying the file directly (if
we're certain there's already a conflicting version of the file on a
different branch).

JA

