Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F5B61FAE2
	for <e@80x24.org>; Sun, 18 Mar 2018 21:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754354AbeCRVb0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Mar 2018 17:31:26 -0400
Received: from mail-qt0-f182.google.com ([209.85.216.182]:41279 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754242AbeCRVb0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Mar 2018 17:31:26 -0400
Received: by mail-qt0-f182.google.com with SMTP id j4so16094931qth.8
        for <git@vger.kernel.org>; Sun, 18 Mar 2018 14:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=88k0TeIklKXlVlI/W31RlX/iN+DRLLJ3WhjsE2p5Z18=;
        b=g8FzEp1FxRswXyXzCLLT5ZqOQdL2vGwUxoJU1wv2F0/Z9lxQeA/B0gFhxhMDs3jq+c
         YM0+PJUFe+elN0em3h0Bm3Iv6XHiiqo+HDifTsWJHDYtdSrlX2pMS6z8X3dtjOcQxLhk
         cdSfarSfFnT7rq1YpgPsQQC/Xs20pePJ6eyf6qFYFnslOp2D56FuJ9I/etdbyxqCoRLT
         atiB1dOvFASKwFyZBLp5Sm5PnA4NJ0yJ+KZ6AW35cqfgyYSIfkDgW7gDtksnQbGDYTlY
         01FH4WQ4XqG7Ps/DXAiiBSIwn7Ri7Smapk1Wp/S21tPfKc6GcIyZeRsWZcpGus1fDnEQ
         y4rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=88k0TeIklKXlVlI/W31RlX/iN+DRLLJ3WhjsE2p5Z18=;
        b=Zf1jlwkSf1GJ1PFPAOaNcKyWtlF/NPnn4+aI8J5Qfq3134Cr4HX0/ZNHvFRaB07iuz
         h2ZZ/WuwsHu4cs8yn6DO/WcZUuP7wE/2ANanf/S36bOCZvxthakDeCGA3WEG0ORUNxaN
         vAAMZyVzDzBKoKLPw6IlHVmb/UaJ1UHFrCCGKr8Q9ZDnudc5Xx5zXUtCW6w2nl2rhxvB
         o17E6Sij5x6MW1YRv9CpjYS7Cu7jQ4VvKcW0oMVdGgDK1FXjWzzdihLhxE/E7BAE91e7
         U7zQbVSTC+g3tkggp7lbWCZgq6n80plNPOHPgPNkHMA414A3oYs8nqM0BsWsVVpKduPe
         SzrA==
X-Gm-Message-State: AElRT7EaOeoH7OkOSvvi7+HGhJITHvxd1rnf9SRRzUdLTUZvlZ0bInIU
        yOOCYljEyHwrfOhibtjZMz5vkQdEqsGi0w6+FZ8=
X-Google-Smtp-Source: AG47ELsSbT/D2RN6bX6lwKdmHmamYZcnxT7dja1qGZxhI1Ez0XUmeViXiHj8IDJhJzeNeq13QWJBs5+Bb5+bg2oHOqg=
X-Received: by 10.200.1.2 with SMTP id e2mr9699203qtg.121.1521408685324; Sun,
 18 Mar 2018 14:31:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.190.196 with HTTP; Sun, 18 Mar 2018 14:31:24 -0700 (PDT)
In-Reply-To: <bf90b92a-d982-df89-7b01-b4a233181cb2@gmail.com>
References: <20180304112237.19254-1-asheiduk@gmail.co> <20180311135835.9775-1-asheiduk@gmail.com>
 <bf90b92a-d982-df89-7b01-b4a233181cb2@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 18 Mar 2018 17:31:24 -0400
X-Google-Sender-Auth: E3sj5-oPvJq7zFKTW1LqEEEbwPY
Message-ID: <CAPig+cQ1Si-AvazF_1Kf4yX9+eGD9tGUdvP7npJ3uYxy1pLy2w@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] git-svn: --author-prog improvements
To:     Andreas Heiduk <asheiduk@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Eric Wong <e@80x24.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 18, 2018 at 5:19 PM, Andreas Heiduk <asheiduk@gmail.com> wrote:
> No comments on this one?

I can't speak for Eric W., but my impression was that v2 did not
address his concern that patch 2/2's unconditional change of behavior
was unacceptable[1]. He didn't say so explicitly, but perhaps the
implication was that he might be more open to the behavior change
being an opt-in.

[1]: https://public-inbox.org/git/20180305202017.GA26533@whir/
