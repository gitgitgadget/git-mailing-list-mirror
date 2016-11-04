Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCF4A2022D
	for <e@80x24.org>; Fri,  4 Nov 2016 22:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757323AbcKDWpM (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Nov 2016 18:45:12 -0400
Received: from mail-qt0-f169.google.com ([209.85.216.169]:35158 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754396AbcKDWpK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2016 18:45:10 -0400
Received: by mail-qt0-f169.google.com with SMTP id c47so57195906qtc.2
        for <git@vger.kernel.org>; Fri, 04 Nov 2016 15:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=l5+wc83S9ltjdpPmzE39CsNUfBkkUojp6vo76vIEpbA=;
        b=oGcseyXz/SpKkEOdRbC4t86LSzQHrzh9eJ2+tbY6H32zOlQ92+z1b2RcNNdfPjqI4P
         g66Mlc+inWJKVpH66WEcKgbyIfqJFQOqQewQQnKFJxMX8gM5nWEox8jrnxZUSQ8iUlVv
         n0IBZ5QyouQcJC0GkLDN6phx+91jYqfY0smhxBrtIKNnOsgSPOFGXXyy+28gl51gjYkL
         /5PRXrBmEs6f/tw8b+LOBJYY/BKwjRi2UOrSFfSieKci0CCb1fAJAq8KWSyjLxDbRUUl
         7BI5WQtfF4wO707W+iuRvZagC7hE4RZv3Sa3ZA6iRyRuuAzpVHZh0jZ6pKRMtkSxc+fD
         RESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=l5+wc83S9ltjdpPmzE39CsNUfBkkUojp6vo76vIEpbA=;
        b=UY2QtYKdOhVO7tS/NiyXrsZJiBtFqdp+ybKZvbu2soOPAvziOIiiVKdXYtRAnSHvyW
         lVdHNZecT4+gF2TjQq9VFUnX5PRYoPvaljY1TZ2e4hDNVZzaPtlb3w03cEzdsmIr2wB1
         /LZepxi95wr/Kkf1IpK7jeS8iKeOtrqfMHJp1v8tSyIgpQMNnHpD6iw4oiut/aHhcYOV
         ZtvdenpW02eQFlOVAKJ9Bew7oB0cbhIpXjHumfmd0TakzoDjud0tGPxQHpOssGrK80N+
         77/MnkNRRim3PdYCS7rB5t4AkqUf23lB7unZqsE33o+X6ojEn559rcccbyPF18iMKp7P
         prSQ==
X-Gm-Message-State: ABUngvc5EzXdRgnNY/fceb91BRNDQGh2OuoclE7TxwvqBTCRLRDyz4oShUMG18L1LLXY71I7OE/DrPRtXidnlv4Q
X-Received: by 10.200.44.162 with SMTP id 31mr16408649qtw.1.1478299509952;
 Fri, 04 Nov 2016 15:45:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Fri, 4 Nov 2016 15:45:09 -0700 (PDT)
In-Reply-To: <47c374cf-e6b9-8cd3-ee0d-d877e9e96a62@jump-ing.de>
References: <47c374cf-e6b9-8cd3-ee0d-d877e9e96a62@jump-ing.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 4 Nov 2016 15:45:09 -0700
Message-ID: <CAGZ79kbavzGJ2sAcz5heg+BO+tZ=TgtrhxMH1-kqeJUpNNavyw@mail.gmail.com>
Subject: Re: gitk: avoid obscene memory consumption
To:     Markus Hitter <mah@jump-ing.de>, Paul Mackerras <paulus@samba.org>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 4, 2016 at 12:49 PM, Markus Hitter <mah@jump-ing.de> wrote:
>
> Hello all,

+cc Paul Mackeras, who maintains gitk.

>
> after Gitk brought my shabby development machine (Core2Duo, 4 GB RAM, Ubu=
ntu 16.10, no swap to save the SSD) to its knees once more than I'm comfort=
able with, I decided to investigate this issue.
>
> Result of this investigation is, my Git repo has a commit with a diff of =
some 365'000 lines and Gitk tries to display all of them, consuming more th=
an 1.5 GB of memory.
>
> The solution is to cut off diffs at 50'000 lines for the display. This co=
nsumes about 350 MB RAM, still a lot. These first 50'000 lines are shown, f=
ollowed by a copyable message on how to view the full diff on the command l=
ine. Diffs shorter than this limit are displayed as before.

Bikeshedding: I'd argue to even lower the number to 5-10k lines.

>
> To test the waters whether such a change is welcome, here's the patch as =
I currently use it. If this patch makes sense I'll happily apply change req=
uests and bring it more in line with Git's patch submission expectations.

I have never contributed to gitk myself,
which is hosted at git://ozlabs.org/~paulus/gitk
though I'd expect these guide lines would roughly apply:
https://github.com/git/git/blob/master/Documentation/SubmittingPatches
