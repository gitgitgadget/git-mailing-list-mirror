Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_SBL,URIBL_SBL_A shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B0791F461
	for <e@80x24.org>; Sun, 25 Aug 2019 19:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbfHYT7I (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 15:59:08 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43083 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfHYT7H (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Aug 2019 15:59:07 -0400
Received: by mail-ot1-f66.google.com with SMTP id e12so13304090otp.10
        for <git@vger.kernel.org>; Sun, 25 Aug 2019 12:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bogz9P+Xu8FJ8jeXWr6osMa2eyyZpUvQGjjhcdrX0mM=;
        b=GoP2EpU9ZnnU1s7Q05RI/UdwjPeWeL4/VLYO/+NtctInYaHt09jFEQmFVk6KV6qToI
         EyMX2m4AZ5Oti/uvDqWFoi/kwZQey2WuDiLT/77gx4gW1AWYPS6Ist90GDwEATNAeZNQ
         gCsabrQT+RhquZe2kGQn3Pr4w0ms7KYCooJmyuX7qwktBt6IRYnb2/fETAAZBozpsQwi
         DSa03S3HKZzmH+Y6Oi3n6YRtzPmoZO54ESREjNiIlu+4xpLMyTcqvlUbmdp/G0hCbMOQ
         svTr4UIiCuoiJ125G0a8Lt83MDBD4acc/N0g4IFK3nW8QH4+4luYUIp6DN/8mwCQIR5+
         3R1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bogz9P+Xu8FJ8jeXWr6osMa2eyyZpUvQGjjhcdrX0mM=;
        b=gxGTuwOaQuE6cnhOF3RKj7DWdB02aRyIyYvuOdg9EYdH8agv89qpqR69NUNqIdWvyZ
         tukJhc7SSVETlMQG3aN6yhi8JvKbKsroDUCIR10XKKjiguHu7a4UdMS/N1OH7K73SkSS
         waF/KnJ/RhkiZN/Ek46a0gg0QCmrkLuvmUTdRGI9j+zTxVBM/6KoqSRC87SW2eeLSymS
         eLyoIhoPXCbctS1yZwYToeYTuowvyG9C0CUF+fUyzHVQz7k1x/j4HOpodRC75e/rQBAD
         7Bqk4em8iFfAHVAc+TVlouubdLrl9QqUBZYlhDrOoMuwJRI02ZFae/RBEzIrSPQUOaHH
         2w9g==
X-Gm-Message-State: APjAAAU+zwzIiLUYkhqufvYIC8e5sBqUoUL7gK8ujjiJzD59GkYqDpM3
        aNTvBBLrdevPaFUv+WWEnEyXGftMHqKler4a9vr4koQIDjM=
X-Google-Smtp-Source: APXvYqwejTFJ/LCKshgt2GWthCWC2y63Qz25j4t8WwFiMbdhK1MPALshzi0g3PWxAhlTiy3OLgEkmwF9rKG0h4CM29c=
X-Received: by 2002:a9d:7f92:: with SMTP id t18mr9505645otp.323.1566763146738;
 Sun, 25 Aug 2019 12:59:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAAQViEsZW4PzHr5BrkDHU2kSd_e04n02McGPgrmXGZMpgaTePg@mail.gmail.com>
 <d31b871a-5c2d-99e7-5616-6f43759bb948@kdbg.org>
In-Reply-To: <d31b871a-5c2d-99e7-5616-6f43759bb948@kdbg.org>
From:   Albert Vaca Cintora <albertvaka@gmail.com>
Date:   Sun, 25 Aug 2019 21:58:41 +0200
Message-ID: <CAAQViEv1_YXPxLRN=eT7yQhro55K4audnouzAjjbHhJsU7pgQA@mail.gmail.com>
Subject: Re: [Feature Request] Option to make .git not read-only in cloned repos
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 25, 2019 at 7:54 PM Johannes Sixt <j6t@kdbg.org> wrote:
>
> Am 23.08.19 um 22:43 schrieb Albert Vaca Cintora:
> > However, I'm sure that a large percentage of developers out there will
> > agree with me that having to use force (-f) to delete every cloned
> > repo is annoying, and even worse, it creates the bad habit of always
> > force-deleting everything.
>
> IMO, the bad habit is to delete cloned repositories all the time. If
> your workflow necessitates this, then you are doing something wrong.
> Maybe you have an X-Y-problem?
>
> -- Hannes

There are plenty of valid workflows where one would delete a repo.

What you suggest is like saying I shouldn't delete pictures from my
camera, because in that case I shouldn't have taken them in the first
place.

Sometimes I clone a repo just to grep for an error string and then I
don't need it anymore, or I clone several repos until I find the one
that contains what I want and delete the rest. Sometimes I want to
write a patch for some software I don't develop regularly so I don't
need to keep a clone of it.

In any case, it would be useful to know the reason those files are
read-only in the first place. Do you guys know who might know?

Albert
