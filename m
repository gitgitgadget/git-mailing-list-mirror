Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A60AC1F404
	for <e@80x24.org>; Tue, 27 Mar 2018 16:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754407AbeC0Q63 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 12:58:29 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:42326 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754218AbeC0Q61 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 12:58:27 -0400
Received: by mail-pf0-f194.google.com with SMTP id a16so9089880pfn.9
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 09:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ukbPWuT5q4lwiUMiYZ4S8UEfrB8ssAF4HukS37Jbvig=;
        b=QxWTDp/HNk/QeMwlb6gB6MfXg20zQRIjj9mJqJn5mG1NVW0s54+mwFBj9vGoFljhHN
         6ZcxZnK8/aDahnCtR1KMEZCl7H5cJacwqhzJ6tjrFoTGKXyomhpYwYwDo86NzeDI9vIH
         VzNBwr4MYomtuvXqvuNLTlUSq2GiiAGcrgqdgE9F6qKB8UjYvYYU2clszxmyRyJspCGn
         Fd1k+p9gr3NZ8SOeS8pBVZa9qXPFCrAoaxdU+kawgSjSL5A951hnFpGnEIE9CdK0Q7yy
         N3Pig8qDf28Sg5u1YWfeGyT5R9xbh5ijRNcnGuwq6Dryu7INnMs0lSSJ/j76kJeyo2b5
         f50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ukbPWuT5q4lwiUMiYZ4S8UEfrB8ssAF4HukS37Jbvig=;
        b=Yrv9h8rpisHJRY64X+jiu0ff1GOsFTkhBSwSZJfgsLFGGr4OiV8cFcbKpGKEwkQjaa
         DEA511VnoHqbWA9NrQb6GdcYaxyKnS/F2Wt0IjGDZW16cwxI+CWnDu/Gk3ff+H2LGQy+
         +xsufz6ZFTtOudxQG3OweDkI3VAz5pmEwoyp4dGIpurHqvc/j5sRtQ41Ia4wxJBsOqMi
         VIuCPvsv+maAQ4/MC1zpmCTbdz0jNH/0IuCdB/7MzZVFjz/NO+TK5iPMXjArx1BwJ6Bv
         Fg6gEepo0eN7hVIpaiywaGc+o4cHy+bYHn6mG6hJnUBGiJgmlsX35di43XKZ6AFaQ8lw
         cnHA==
X-Gm-Message-State: AElRT7GkzEmsWmCvoikrhPcpnuCWrAyYG6nSQOHiDtWymEReOKbN+5ip
        ovnP5mQtlBNKxbJhdW7zbLI=
X-Google-Smtp-Source: AIpwx491VY8JCyFgJ4KL1jYE4HloccDsf+pBaQGlCz4E+bXgG8UcuNsQyk91US3xdBNu0YwiZTtfdA==
X-Received: by 10.98.32.134 with SMTP id m6mr90262pfj.27.1522169906831;
        Tue, 27 Mar 2018 09:58:26 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id s78sm4001267pfa.161.2018.03.27.09.58.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Mar 2018 09:58:26 -0700 (PDT)
Date:   Tue, 27 Mar 2018 09:57:51 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Alexandre Julliard <julliard@winehq.org>,
        Dorab Patel <dorabpatel@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
        Kyle Meyer <kyle@kyleam.com>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Ami Fischman <fischman@google.com>
Subject: Re: [PATCH v3] git{,-blame}.el: remove old bitrotting Emacs code
Message-ID: <20180327165751.GA4343@aiede.svl.corp.google.com>
References: <EKzyQbDEJGG4Lm5YboF8xg@mail.gmail.com>
 <20180310184545.16950-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180310184545.16950-1-avarab@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ævar Arnfjörð Bjarmason wrote[1]:

> The git-blame.el mode has been superseded by Emacs's own
> vc-annotate (invoked by C-x v g). Users of the git.el mode are now
> much better off using either Magit or the Git backend for Emacs's own
> VC mode.
>
> These modes were added over 10 years ago when Emacs's own Git support
> was much less mature, and there weren't other mature modes in the wild
> or shipped with Emacs itself.
>
> These days these modes have few if any users, and users of git aren't
> well served by us shipping these (some OS's install them alongside git
> by default, which is confusing and leads users astray).
>
> So let's remove these per Alexandre Julliard's message to the
> ML[1]. If someone still wants these for some reason they're better
> served by hosting these elsewhere (e.g. on ELPA), instead of us
> distributing them with git.

The trouble with removing these so abruptly is that it makes for a bad
user experience.

  Warning (initialization): An error occurred while loading ‘/home/jrn/.emacs’:

  File error: Cannot open load file, No such file or directory, git

In some sense that is the distributor's fault: just because Git
upstream stops removing the git.el file doesn't mean that the
distributor needs to.  But the same thing would happen if the user
symlinked git.el into a place that emacs could find when using
upstream Git directly.  And we are putting the distributor in a bad
place.

Ami Fischman (cc-ed) writes:

| IMO a placeholder git.el that did something like:
|
|   (error "git.el is no more; replace (require 'git) with (require 'magit) or
|   simply delete the former in your initialization file(s)")
|
| ideally with a pointer to a short URL explaining the rationale would have
| been fine.
| (note that though I've seen
| https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=893734 I'm _still_ unclear
| as to why the change was made; you might want to clarify in that bug and
| point to it from this, or something else)

What do you think?  Would adding such a placeholder during a
transitional period work well for you?

Thanks,
Jonathan

[1] https://public-inbox.org/git/20180310184545.16950-1-avarab@gmail.com/
