Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1CF81F461
	for <e@80x24.org>; Wed,  3 Jul 2019 08:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbfGCIcS (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jul 2019 04:32:18 -0400
Received: from mail-qk1-f175.google.com ([209.85.222.175]:37744 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfGCIcR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jul 2019 04:32:17 -0400
Received: by mail-qk1-f175.google.com with SMTP id d15so1561275qkl.4
        for <git@vger.kernel.org>; Wed, 03 Jul 2019 01:32:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=2QkD2lE/FMLopnp0I5Ol8rd3iZY+OU6t4IBvS3zmfpY=;
        b=POjOIOzvghcuQZxtcohEoTcaZGjTPLKew04CXAATbRQugFuCrqC8RMNaseIVG81WI8
         jsuB2m1d9/PRd48EAeDBnvquKtUTABrL9DJuoaPTUvlMalJE08L2EMqcdKx+8Mx9NHZi
         8fpDtwAykJfdpT6HiOWcyFiUmTS1Y7/FSxX5smLDvYaNJyLHm5gWC6wlD3ULI0Lo60B4
         zA+Jaz4EkG70nIynIJtGl00ld4S6hvJUGjCbK5xwUn08Xzt3Hcpzaa+Y1pCUbvjg8qfi
         IZH8Am2rWkOJ0skJZzW1SYGkPQN7Fu5U6mANM/up4eTylcdclFT4pM0VjljghP0VI4Av
         6GlQ==
X-Gm-Message-State: APjAAAV2dwgR8Hqv0g4R/4bqh0O1mzxCJzaLMLg9TlxcFXcuvT0ron5d
        2yPr0BxOSJGRiPa7gIGXcg+3QGVlhp3GbClwQ/FT7g==
X-Google-Smtp-Source: APXvYqz/FpippoPgTJTY7MG4iNKmFiPgCmNSvy1J7PNUkXZmaiV/oB/g4I6oH8G3g3k2yPBu8kDmJgG/xhA6BXhnjPo=
X-Received: by 2002:a37:d8b:: with SMTP id 133mr27827619qkn.445.1562142736538;
 Wed, 03 Jul 2019 01:32:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAMPRpjUWBXCEagDB5RwsBTYSJWeypOeY47CGWOO95oZiSCTOjw@mail.gmail.com>
In-Reply-To: <CAMPRpjUWBXCEagDB5RwsBTYSJWeypOeY47CGWOO95oZiSCTOjw@mail.gmail.com>
From:   Julius Smith <jos@ccrma.stanford.edu>
Date:   Wed, 3 Jul 2019 01:31:40 -0700
Message-ID: <CAMPRpjUAKPo-fFeE1R_QjMTrc_RST0y-1Jrhcg2Z-xyH7ubt5A@mail.gmail.com>
Subject: Re: Submodule "git branch" says (HEAD detached at <incorrect-commit>)
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I should add:
> git --version
git version 2.20.1 (Apple Git-117)

On Wed, Jul 3, 2019 at 1:28 AM Julius Smith <jos@ccrma.stanford.edu> wrote:
>
> Greetings,
>
> I have a repo with two branches A and B, say, and a submodule pointing
> to a repo also with two branches, say C and D.  Branch A of the parent
> uses branch C of the submodule, while B uses D.  My clone is in a
> state (that I've seen often) where branch A's submodule directory
> _appears_ to be using a commit for D when really it's a commit for C.
> "git branch" in the the submodule directory says "(detached from
> <commit-for-D>)" but this seems to be wrong.  I did "git diff
> <commit>" in the submodule directory to show that it was the C-commit
> and not the D-commit as it appeared.  Could "git branch" in the
> submodule directory be referring to the commit at the time it was
> first detached and not updating after a "git submodule update --init"
> in the parent?
>
> Thanks,
> - Julius
>
> --
> Julius O. Smith III <jos@ccrma.stanford.edu>
