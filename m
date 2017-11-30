Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 849EE20C11
	for <e@80x24.org>; Thu, 30 Nov 2017 22:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750890AbdK3Wk3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 17:40:29 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:40048 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750760AbdK3Wk2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 17:40:28 -0500
Received: by mail-lf0-f65.google.com with SMTP id t197so9673289lfe.7
        for <git@vger.kernel.org>; Thu, 30 Nov 2017 14:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=FwNdJon9YRbudK71YaigqVwx5MWeitglxMSm+BNMUwY=;
        b=gTcMq0vBpZZxi9pYVNVF/Up6MnTGkb9p2Xbug6MGxxMQ4Z/nAlvgFYSTSty418GBlZ
         NAeDdy+yJsKqP31HTFdZwuOrlrFMymPmLIFR3WVN6wChSJfTOxW/5zWLW+kvIMDyv/GG
         eRSWIkW6zF/JwN0gS6GnwSVrswKQIEIa6D5JdISsGJ+rHNiscZcT51I5YecAz+XMkGFw
         3MlxaSM6c/2Evg0OWieyo/lwBeYiBdJ5MtyScmCbbmCCTeAfglI7rFmkUrbIbVsUh63S
         bEMO9cCWDgCwWy5QCinU8/YR0QVknhHK3jw+q8+kjkCCXC8BC9XsjhoBMTewkkD3JV+p
         RarA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=FwNdJon9YRbudK71YaigqVwx5MWeitglxMSm+BNMUwY=;
        b=iB4Pza9sqDufwHoKZNtI6Sl313M32zXOmrNQrQ/Os/D4is+J4R+Px1olNg4kZdJMHh
         35HyepgvjE6rJQN56169Wnri5wUvpg7Gx2Lk3QtsGshrUg22e7YYnMaFBsDegv+00eyj
         Es2pZ26pBnugQDwfIdIDddm1a+ZYZuw19fzHVgRw4o2J2Wp/CSn+GoUnas00u154UAOL
         Fx9xgiDEfT3UAFwtqi547gwndwvlf/8riuco4sRLzC4Bwx8jk1a0dPRsDfX5Q5z39HLP
         hU0Be5lX2op385Tt4fIwelCwXYdllabcXMM8jBHvNZtjR176IogX1JfhvrKXxJU2F1MT
         7VbQ==
X-Gm-Message-State: AJaThX7QnicKMmt8cZtVxEXsi6lthqjp8+jsj6UCcGks52Db5O4y+xuA
        pAhKogxZNU9h9N4tqKi7pC4=
X-Google-Smtp-Source: AGs4zMae8wBbswqh1NspFgQH/n9L6SjPAnZ2yJWS1/gZ7i8HEwscAN/xS7oLtOaNETaoS9+bWf/IWQ==
X-Received: by 10.46.77.148 with SMTP id c20mr4303105ljd.156.1512081626741;
        Thu, 30 Nov 2017 14:40:26 -0800 (PST)
Received: from [192.168.0.102] ([46.98.219.48])
        by smtp.gmail.com with ESMTPSA id b84sm1032511ljf.60.2017.11.30.14.40.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Nov 2017 14:40:25 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [SCRIPT/RFC 0/3] git-commit --onto-parent (three-way merge, no
 working tree file changes)
From:   Chris Nerwert <a.lozovsky@gmail.com>
In-Reply-To: <8998e832-f49f-4de4-eb8d-a7934fba97b5@gmail.com>
Date:   Fri, 1 Dec 2017 00:40:21 +0200
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Nikolay Shustov <nikolay.shustov@gmail.com>,
        Johannes Schneider <mailings@cedarsoft.com>,
        Patrik Gornicz <patrik-git@mail.pgornicz.com>,
        Martin Waitz <tali@admingilde.org>,
        Shawn Pearce <spearce@spearce.org>,
        Sam Vilain <sam@vilain.net>, Jakub Narebski <jnareb@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0F30BEF8-A9F7-43B9-BC89-4B9CD7AF3E16@gmail.com>
References: <8998e832-f49f-4de4-eb8d-a7934fba97b5@gmail.com>
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Nov 27, 2017, at 00:35, Igor Djordjevic <igor.d.djordjevic@gmail.com> =
wrote:
> Approach discussed here could have a few more useful applications,=20
> but one seems to be standing out the most - in case where multiple=20
> topic branches are temporarily merged for integration testing, it=20
> could be very useful to be able to post "hotfix" commits to merged=20
> branches directly, _without actually switching to them_ (and thus=20
> without touching working tree files), and still keeping everything=20
> merged, in one go.
I'm actually doing the described workflow quite often with git rebase =
when working on a topic. Given the following structure:

  ---o               (master)
      \
       o---A---B---C (topic)

When I want to make changes to commit A one option is to make them =
directly on topic, then do "git commit --fixup A", and then eventual =
interactive rebase onto master will clean them up:

  ---o                     (master)
      \
       o---A---B---C---f!A (topic)

However, sometimes this breaks when changes in B or C conflict somehow =
with A (which may happen quite a lot during development of a topic), so =
the rebase will not apply cleanly. So sometimes I make a temporary =
branch from A, commit the fixup there:

  ---o               (master)
      \
       o---A---B---C (topic)
            \
             f!A     (temp)

and then use "git rebase --onto temp A topic" to move the topic back on =
track:

  ---o                     (master)
      \
       o---A---f!A         (temp)
                  \
                   B'---C' (topic)

after which the final cleanup rebase is much easier to do.

Obviously, all the branch switching and rebasing does take its tall on =
file modifications.=
