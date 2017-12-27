Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 032A91F404
	for <e@80x24.org>; Wed, 27 Dec 2017 19:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752062AbdL0TQk (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 14:16:40 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:46651 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751145AbdL0TQk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 14:16:40 -0500
Received: by mail-io0-f195.google.com with SMTP id x129so36236605iod.13
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 11:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Pt8peTqmsPs5QKAw/YT4WdBrbUULzUq18Ysc6jze31M=;
        b=CEhtBSR3tJIqNBpFiYTMRZ1IvilKXEMKeAMU8gwION6YE2zX4+lFtXJxaMQyb1Jxvm
         XDZVlAKdJDq0Zd3O0niOE8ptG7jTt+JNxtZMmo0nSTle1xQOOmQZ56KbBK7B+q7Cvuen
         iNNmW/whGM8bs7LMZxc33EZu654mt/PJpHz7ys4JWU0OzrdbI9+b84o0Z7FbgTWZPDEf
         lPI8oIiuC19XJhp9zTR1QL5a8pxrQbPpfww6PE2Ec6RGSxAurlfMdXxJfEvNSKq2y5P8
         iucyBlLtqd1RVwE8iSMJ3TLjvmQBFIUnYYIVWNvVmoi2noNzAZd4weO3cV+EqOp35GMj
         xiNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Pt8peTqmsPs5QKAw/YT4WdBrbUULzUq18Ysc6jze31M=;
        b=djrOSqcMcLzS9OBJeO5ROIGqxlbo4XNP1CvstiFhJvaZ1HeFo7EAw6FLtZFFdwGnbh
         0oosnpZ0rDAJWP4i9MqJLPv/3xgq5E9+m7aOS6yx+xz+AuqdrGWBudiqBRLZGxJ9iHoj
         68fOpKMGkkEyTAnn5/ucDVfFvjitjvcTGQf40/CP3+5BCSHcvtD92bzgMzpSo37BwQ1a
         KoF1zA3FGTxokstv1ufZWsvKJkjrdlAs9aJMbp2zgoxA2DXQeb8in50iUxFMOdY6B7fk
         ADSwtm+n5bRTpoKAnbPSJw9xAMS+/iiW66nvKPaYSfVJe9gk3yYz8iJRYnv2qF7dBj1d
         J+yw==
X-Gm-Message-State: AKGB3mKlDRrISdKa3S+JyTYWpO9CSfiJTyFLGZpQuCYGABLm/29521Yj
        wJnzx2tZavMcUjPT4bNuuZc=
X-Google-Smtp-Source: ACJfBoscIdEw2jd87PpTtxOf04Qtp7LDVfxtQaZp9EYeHuCL7jLgyLatMlMS2y324E4Ls3Kt5drP9Q==
X-Received: by 10.107.170.194 with SMTP id g63mr35590196ioj.175.1514402199388;
        Wed, 27 Dec 2017 11:16:39 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id e36sm10881977itd.27.2017.12.27.11.16.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Dec 2017 11:16:38 -0800 (PST)
Date:   Wed, 27 Dec 2017 11:16:36 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>, Jakub Narebski <jnareb@gmail.com>,
        Petr Baudis <pasky@suse.cz>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [RFC/PATCH] perl: bump the required Perl version to 5.10.0 from
 5.8.0
Message-ID: <20171227191636.GF149622@aiede.mtv.corp.google.com>
References: <20171223174400.26668-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171223174400.26668-1-avarab@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ævar Arnfjörð Bjarmason wrote:

> This is similar to Jeff King's jk/drop-ancient-curl series in that
> we're dropping perl releases that are rarely tested anymore, however
> unlike those patches git still works on e.g. 5.8.8 (I couldn't build
> anything older).

FWIW I think this is a good change.  If someone is affected and offers
help with keeping git working well with older perl (e.g. setting up CI
for us) then we can keep supporting it, but it seems more likely to me
that there will just not be anyone affected.

And being able to assume a newer baseline perl version seems
beneficial both from a security point of view and from a developer
experience pov.

Some minor nits:

[...]
>  contrib/diff-highlight/DiffHighlight.pm | 2 +-
>  contrib/examples/git-difftool.perl      | 2 +-
>  contrib/mw-to-git/Git/Mediawiki.pm      | 2 +-

I'm less opinionated about these.  They're already using the same perl
baseline as the rest of git, so I suppose it's good to keep them
consistent, but if any of them gives you trouble then I think you can
just ignore it and let the relevant contrib maintainer take care of
it. :)

[...]
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -1,6 +1,6 @@
>  #!/usr/bin/perl
>  
> -use 5.008;
> +use v5.10.0;

As brian carlson mentioned, 'use 5.010' would produce a clearer error
message on ancient perl, which could result in happier users on
ancient platforms or clearer bug reports.

That said, I don't have a strong opinion there.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
