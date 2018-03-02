Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E8671F576
	for <e@80x24.org>; Fri,  2 Mar 2018 07:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935991AbeCBHEi (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 02:04:38 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:46032 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935925AbeCBHEh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 02:04:37 -0500
Received: by mail-pf0-f174.google.com with SMTP id h19so2730706pfd.12
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 23:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=54GDkVx3L+9fjfCy39Jy0pIUg0ecl6vfvrBnUQ+DYTY=;
        b=CekbzzHvqxnzwNKE388yN1SWHG8lpgPFSoHWLVmjkx6KnJ2lLiPCceEvubdvpUniCa
         jiDnV4ALGxy0O1oGeixtDC6TZ8wA6U9vWvdH+Kuc8cpa6cHViKWc/UQTomShI7nBFPO3
         UP7/vybKd2XI7qlXpA45kMtUc6rAyOUpwdlgE7QjPE92owznK159LpVdWojfhgkL4EKr
         gK12LEo5Ac76YjvYRoURJ1N32KVV/KPgFw5Cgjc0RuCmpBlhCYECzanEuOCbrd7JES7L
         r7tUAvCzhDfs7I+gBpNGdVk/BGZIc0rGYvRz0bft3kb43CrHMr/Tco8WPjXQAKiGZSWR
         1Esw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=54GDkVx3L+9fjfCy39Jy0pIUg0ecl6vfvrBnUQ+DYTY=;
        b=BeY6dfku2x/T1ZHkYPyxbRCJomB267gWNzqPct2FNYpHsfbm/6w2///3kCEgKUFTFG
         Kcq8jf+Bqej1RMOpjZJX9HIHwyNveV5UWHg03iPeQSAzTSCQZWrHVJu4WlZFcYj3wfAU
         mBj/GLzPFurIhRzbXYmNmSVVxSkTPpD4ptjsvp5jTqc7xkbpA9uHMgwZ/2tOYdq4TGG2
         pz+r3X4kJS5OXRgFf6flGT/z2EaHynm9VJ3g0+w8ZikAmtd0pgMc6EuZhm6xYdZ+sOQP
         deQNe9F5BjjJrFS1UjBX9dsbsACyO3bVs5dE3S4i3EQcgYC+Ldmk4yuzA7u1TPkVTexL
         DhQw==
X-Gm-Message-State: APf1xPDR2ke85Is2czL5Fp8k0+tEJFivqahIpLPbvYI6DvXaiaTRsfmL
        0ZgT1yvTGU1x07BF8rklpQX01cVD
X-Google-Smtp-Source: AG47ELvdCbn9Y+wTyQE+WRJ6BlFf9dp0BjQr5QEdNv+ssKUocGLOZgSk7dxdVNKP+UPYvcz5ss9EZg==
X-Received: by 10.99.103.133 with SMTP id b127mr3730346pgc.155.1519974277086;
        Thu, 01 Mar 2018 23:04:37 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id p10sm9571862pgd.28.2018.03.01.23.04.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Mar 2018 23:04:36 -0800 (PST)
Date:   Thu, 1 Mar 2018 23:04:34 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Sam Kuper <sam.kuper@uclmail.net>
Cc:     git@vger.kernel.org
Subject: Re: Bug report: "Use of uninitialized value $_ in print"
Message-ID: <20180302070434.GG238112@aiede.svl.corp.google.com>
References: <CAD-Jur+6m1SjqHVWBxW5HnTjutSVrkP+dEXdYmFHzoUf0FGdNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD-Jur+6m1SjqHVWBxW5HnTjutSVrkP+dEXdYmFHzoUf0FGdNA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Sam Kuper wrote:

> First, background. I encountered a bug on Debian Stretch, using this
> git version:
>
> $ git --version
> git version 2.11.0
>
> The bug is that in the midst of running
>
> git -c interactive.diffFilter="git diff --word-diff --color" add --patch
>
> and after having answered "y" to some patches and "n" to others, git
> suddenly spewed the following output:
>
> Use of uninitialized value $_ in print at
> /usr/lib/git-core/git-add--interactive line 1371, <STDIN> line 74.
> Stage this hunk [y,n,q,a,d,/,K,j,J,g,e,?]? n
> Use of uninitialized value $_ in print at
> /usr/lib/git-core/git-add--interactive line 1371, <STDIN> line 75.
[...]

Strange.  The relevant line, for reference:

$ dpkg-deb --fsys-tarfile git_2.11.0-3+deb9u2_amd64.deb |
  tar Oxf - ./usr/lib/git-core/git-add--interactive |
  sed -n '1370,1372 p'

		for (@{$hunk[$ix]{DISPLAY}}) {
			print; <---- this one
		}

This is a foreach loop, so it's supposed to have set $_ to each value
in the list @{$hunk[$ix]{DISPLAY}).  So why is Perl considering it
uninitialized?

Is this reproducible for you?  Do you have more details about how I
can reproduce it?

What arch are you on?  What perl version do you use?  Can you report
this using "reportbug git"?

Thanks,
Jonathan
