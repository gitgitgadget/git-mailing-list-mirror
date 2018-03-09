Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19CBC1F404
	for <e@80x24.org>; Fri,  9 Mar 2018 22:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932750AbeCIWd6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Mar 2018 17:33:58 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:53700 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932405AbeCIWdh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Mar 2018 17:33:37 -0500
Received: by mail-wm0-f44.google.com with SMTP id e194so6531556wmd.3
        for <git@vger.kernel.org>; Fri, 09 Mar 2018 14:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=JOui9qzlHZUrmg5C6XQRvJLg+dYJ5LSPlxmxxLZd0/k=;
        b=i6fyWhbVPTajp1cgV8hA0b76Na527lVWh5zYwA+Iq8gGBaalU0daD2fgu3Ps33+31v
         dpJe98lDQU+Zj/3Aay/+pQ6aourK14b51sjIZWsfDFMLXxlQouLb5ArQLfRMe0NUPnTS
         52nfyse6zWqQbEk1yXhM+UFWpttTfQdfnkyE3FKFPIxFDiO5v7tIkHfKZbx1xunndun1
         WpEYnNtghp1YmFzYTBtAZ4xXsSd2o/is1C2oWDrXvmFWRlv88aKqiB4KqaDQEKtrnqiD
         QvCT/TvRLJ6Ya1YMKWC0qSzhmqCgPMet/jhFwv0guJUgoacN70KW301eQO0od9GrXq1P
         6XnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=JOui9qzlHZUrmg5C6XQRvJLg+dYJ5LSPlxmxxLZd0/k=;
        b=JdJ1PCK3XsHBuGN6OWzgY3Nq5ZdFWxXquxMxvPpmsQZBajZutYUGX8TYkuFrIlGr8k
         ie/NE793MvAtsM2TJwKZdSjivnXsoSHBzQivd5+rwQPnTVeZbSFll1LnqG9oYrseOpy9
         vElAe1uKztYlJVXiivwWux5FZTCJeIorwqlA1pamEVlV16VgC91me2+ABW9KaA4jVOA1
         q+wK+9JX2J1AxHYfFdUtd6iK2IeaZ/bh3uhBvTBHO9uDBcjuO1qvNymEPPsEaDYwqX67
         vH87wzHqLfJ4/i6ObmqEwOpfJywPFfNHF8ahNolF5jvman9S9GY6rgiO2ar7C2Vx3dDn
         Ro3A==
X-Gm-Message-State: AElRT7Gs00nl6U5XS9vyGswH/goIZkampctSzSh6Gzw9P6XjO4ZpKWz1
        MofwXL3aUe7Ygo3k5eOa5yuQGfAI4fxLSWgWuEnLWwVu
X-Google-Smtp-Source: AG47ELtHuzgamXlS8qI0gfJa2dWs6WdzbQIN+MoNIrYlgrpVGm/7ytP7di3jS01ZWqhD1MXMHJhmVmREcVX6YpXaCrs=
X-Received: by 10.28.173.198 with SMTP id w189mr317821wme.139.1520634816121;
 Fri, 09 Mar 2018 14:33:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.169.206 with HTTP; Fri, 9 Mar 2018 14:33:35 -0800 (PST)
From:   =?UTF-8?Q?Eddy_Petri=C8=99or?= <eddy.petrisor@gmail.com>
Date:   Sat, 10 Mar 2018 00:33:35 +0200
Message-ID: <CAK0XTWfraH5B+1VkNPqrquLDWac=hB0dAASYXzZbG7oCb4hkkA@mail.gmail.com>
Subject: Is context/directory sensitive config possible or even a god idea?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

In some situations one person could be involved in various
multi-repository projects and need to use different user.email
information, depending on the project.

A simple example can be using the project specific email identity for
all repositories part of Android, while using the personal email for
personal projects on github.

The developer has currently only 2 options, AFAICT:
a) use --global identity for the personal email and set the Android
identity in all project repos
b) use the reverse, store Android identity in --global gitconfig, and
make sure to set the identity at repo level for personal projects.

Both solutions are suboptimal, especially if both the project in
question has many repositories and the number github projects is high,
because the user must remember to set the non-global user identity
either in all github repos or in each Android repos, after checkout.

In my view, there should be a middle ground, having a
context/directory dependent setting could be a solution.

My idea is somehting like "for all repos cloned in subdirs of
directory ~/src/android, use identity johm.doe@android.org", so the
only thing to remember to make this work is to make sure all android
checkouts are done under ~/src/android, which most people already do
because they need a clean home dir.

When I saw he include.path feature I thought this was exactly that,
but when testing it did not work as I would have liked, the inluded
config is simply added to the global config, if I add this to the
~/.gitconfig file and the target file exists.

I understand the use case I am thinking of is not the one that was
addressed by the include.file feature, so I am thinking git would need
some other setting like
'contextsensitive.include=3D/home/johndoe/src/android/.gitconfig' which
could mean include the settings from this config is we're in a dir on
the same level a the file, or a directory which has that dir as parent
or ancestor.


What I see already:
1) it would be a perfomance hit if the test for "do we need to apply
any context sensitive setting" must be done on every git command; for
the identity usecase might be less of a problem if only the subcomands
that need user.* would compare the prefix of the current dir with all
all contextsensitive.inludes settings and applying only the longest
one
2) what if the contextsensitive.inluclude file also includes another
contextsensitive.include, could that lead to ambiguous situations?
3) having the feature could allow the user to set other project
specific settings. Nice usecases:
if Android uses --no-ff merge.ff=3Dfalse in ~/src/andoid/.gitconfig
contextsensitive.inlclude would ensure the expected strategy is used,
and rebase is the preferred behaviour for pull, instead of merge)


--=20
Eddy Petri=C8=99or
