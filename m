Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8CD71F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 18:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbeKNEYW (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 23:24:22 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39085 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726459AbeKNEYW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 23:24:22 -0500
Received: by mail-pl1-f194.google.com with SMTP id b5-v6so6415508pla.6
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 10:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RLufwrYMOKwPlqjJZQPtC6BmbA48gbSpX0I/yBC3nDw=;
        b=Icnz3HCciVQYx+Z3N1blIiOlFDC96ev7I/9/tg738L5g4SlcPjjb5DdVPmbTt7BUEd
         rxgdeM6Bxj9hSVzwrBOOb1v3qk1A4W+njVW52lwdznrf6jYVO4zvfUNdLHWvZNhO3Wzj
         D+UiXa+/aKpOyvtJtqtaTbeJ4yu8Icw/SZWZgDZMFynWhWBBvQqi6oUFYnIJzxqm2xD9
         LDeg0q3sorJGW1sbCNWEZR+Lt/WmaHBU+56ev1KzxEbUjOvX/BvFT2qHoRakeu1gTk4I
         1f4BHT7oFh4LR93cPgOayIF9ISlquqJ/q3o90rJ+6Pmedhj7h/8HFBwAk/AvlOuptJ0Y
         /Y6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RLufwrYMOKwPlqjJZQPtC6BmbA48gbSpX0I/yBC3nDw=;
        b=dekFypcokdroPosH20pv+76HTgXRhxFtevmd01EXVChbYucC923a/jG2bSfx0h/Q53
         B1zppzRrv9KTec6IPsyxQhx2OCdJvREBaUy4F/w3G8/JBuihY6j+iPg74kDwPbFys26C
         bnDcASKas5EMi/fqR9EfJuCIm4N2mOaFh34Ueua8sIps/4KKBivD+S+6vfVyBj3KPgiU
         DlX/njMJv56XsSXRzE4QV8c6/qhVO4P+Idglvoc4nxDz5r0nRfJEhp6J2s/f1vUtm2y0
         vwvCRlUEMmHUVxPOESWUBsG/9C7JP7hdw0d1aijal0e9XTzY3TZfNYw/sMt6uE89thm0
         QnHA==
X-Gm-Message-State: AGRZ1gKUWVqbdiESK2Gl+jnyCYFOv7hhe121jwCQG5g18k2ausT4QgXT
        byv6tR8fuxnr7vFZaxeLFWc=
X-Google-Smtp-Source: AJdET5fdIOAQDZyJ9YYpeJd0XmbDlFjk2VNkKn0lUz8JlevrysNYeg/hGlagk89fT6C/8iPBOWiLGw==
X-Received: by 2002:a17:902:74ca:: with SMTP id f10mr6045033plt.273.1542133505264;
        Tue, 13 Nov 2018 10:25:05 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id q128-v6sm22762931pfb.160.2018.11.13.10.25.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 10:25:04 -0800 (PST)
Date:   Tue, 13 Nov 2018 10:25:02 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        pclouds@gmail.com, Ben Peart <benpeart@microsoft.com>
Subject: Re: [PATCH 1/3] eoie: default to not writing EOIE section
Message-ID: <20181113182502.GC68106@google.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20181010155938.20996-1-peartben@gmail.com>
 <20181113003817.GA170017@google.com>
 <20181113003911.GB170017@google.com>
 <xmqqtvklzszv.fsf@gitster-ct.c.googlers.com>
 <5fae19dc-2e77-1211-0086-e7aa9d30562f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fae19dc-2e77-1211-0086-e7aa9d30562f@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ben Peart wrote:

> While I can understand the user confusion the warning about ignoring an
> extension could cause I guess I'm a little surprised that people would see
> it that often.  To see the warning means they are running a new version of
> git in the same repo as they are running an old version of git.  I just
> haven't ever experienced that (I only ever have one copy of git installed)
> so am surprised it comes up often enough to warrant this change.

Great question.  There are a few contexts where it comes up:

 1. Using multiple versions of Git on a single machine.  For example,
    some IDEs bundle a particular version of Git, which can be a
    different version from the system copy, or on a Mac, /usr/bin/git
    quickly goes out of sync with the Homebrew git in
    /usr/local/bin/git.

 2. Sharing a single Git repository between multiple machines.  This is
    not unusual, using NFS or sshfs, for example.

 3. Downgrading after trying a new version of Git.

To support these, Git is generally careful to avoid writing
repositories that older versions of Git do not understand.  The EOIE
extension was almost perfect in this respect: it works fine with older
versions of Git, except for the alarming error message.

> That said, if it _is_ that much of an issue, this patch makes sense and
> provides a way to more gracefully transition into this feature.  Even if we
> had some logic to dynamically determine whether to write it or not, we'd
> still want to avoid confusing users when it did get written out.

Yes.  An earlier version of this patch defaulted to writing EOIE if
and only if the .git/index file already has an EOIE extension.  There
were enough holes in that (commands like "git reset" that do not read
the existing index file) and enough complexity that it didn't seem
worth it.

Really in this series, patch 3/3 is the one I care most about.  I wish
we had had it years ago. :)  It would make patches 1 and 2
unnecessary.

Thanks,
Jonathan
