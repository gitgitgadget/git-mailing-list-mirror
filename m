Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD6CC76195
	for <git@archiver.kernel.org>; Mon, 27 Mar 2023 07:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbjC0HFF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Mar 2023 03:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjC0HFD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2023 03:05:03 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E920C40FA
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 00:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1679900660; i=johannes.schindelin@gmx.de;
        bh=GroawwLKP7qHD1Z1aCpPyJKGt/OmY395ovgWD9Y+uBw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=rgni7YTDH5dUGqof2TMWRDYqhZpRJNXYZVbv2rYuPC6aPwgGYqKxFXCi5mVl6+aak
         jEnwaCYXy9OumktwTVSFLGpcLF/XrtYztr3kPdcIvgcXk0NsbgXKuIfm8JKk7zaX3s
         atEG6vczcyXEFuYmMpYYRXmi6dt1PMNtEpwRQvkp0pLaEGO7Qyq4ElcpujiVoDD2Uo
         wxGKx4XGq4DMnf48mXm4W0XtafwxmeAjVQ19kjGa/8q4m5Wte0UNepevcmYi5tUh+4
         ebl2P7O4n+cS+7XGX+quZXlDq4x1sUu0YY7aJXgAhci7eTeRj/hoKOn/hm5P2YsRie
         NHrR8i6vHrUAQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.93]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mwfai-1qeoZC2cos-00y6r1; Mon, 27
 Mar 2023 09:04:20 +0200
Date:   Mon, 27 Mar 2023 09:04:17 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Stefan Haller <lists@haller-berlin.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] rebase -i: do not update "done" when rescheduling
 command
In-Reply-To: <pull.1492.git.1679237337683.gitgitgadget@gmail.com>
Message-ID: <f05deb00-1bcd-9e05-739f-6a30d6d8cf3b@gmx.de>
References: <pull.1492.git.1679237337683.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1580625367-1679900660=:123"
X-Provags-ID: V03:K1:aUd6XHAvShjQEgwgXUfkYcAg13hjbVr9uihSj1GOeEfsQ43OyXr
 OX6Vx84xxndNtrYhST3LqAeuRfM28nlApEfRrgqb+n2V+FX1X+JPgk4OgL0Y4wKhzbp0Hdz
 B1xXgClK35wH0D+wcdEBVZ5ZCSelRHEgffng9bun9IwkqMjb+waCnPqUSC13ooT6jed91l4
 xGcb65nPfRVyv7LXJwLfw==
UI-OutboundReport: notjunk:1;M01:P0:RRk1rFxLWRA=;96XY1VU5d1f7/GgxIxvd4KdeGJQ
 d0pDIlZf/Cm2UqwMt+P0CQ8kw+d7O0X26dYAmM1peyqTOgvlvPLTm1plwj1tKhK8zoMX6fdSx
 /ScxOY7Ft577HI8cKORseU1sM6xjFjjMZ2e2U9qUay2mq2cM0LDbDlcAWQMQnYPa+LfrHOJGH
 rgNRs4OlY3U6dUcbU6Cwgb/rHfjkCYiZ+DhRxNg0SJuxH0SZqlcuXF3pQhhaYPhLN1vfFZ3te
 T3kFrFTK69xfELrlex8Ar+arsUHNvv6vn8zydbwc0sDivjIhc5Vsm/7TSiAkzQxZXouff7MLQ
 N2pYPHI543SHkhEQHNTcfZ4OcEtXBxhJFkI5yv+komR3D4xof00pcsW/cY3hhmLA3JMqZLIYX
 BIl7iqeEk7B8rDVIgfUSs6EoSSOBF4aajfUwYfXvQgJO81ezyyihvmiMjHneOBliUvVjLuPQh
 S3TxPe8TK2IthMi0WdjR2BRAI+3WSsntxrMf08Xz8s5OJQERIGoJkf+n4BnohfuWfz7Q0W3SY
 0OX87eeujA3dYBfEV93+AXLS7nhz2lMcDGBWn2qCHVe/T/ACeTjNnd01o8+JmqAa/ZD+jgGbJ
 jk0Jb0Sok9hnfElRLhoIU0G073w+7b+SRB2fgrz2w3TmhwI/IQ+Hs3kzxLiLo56fAvfsrMGg/
 8HL3/OJRqGfu1euhbfAVSI5npiwjTlYa1zt/SSwTpJP4AaBC7B9CN8CQqjNSdmmGqzt8u0vdy
 3jDnaULj4UR6zm7KpsQ4i3/cAYI6U8XOT1O5qsoCas+CLAmYhRQfNwAUXtxEJP5xNOu7qgzSL
 efCsB6yfYn0jZqi1EyK5d0or2EaOMSgQwpEDVJBus5gjkhoqffYs6x3Xbdofp3XbnYmH6dhhE
 CdwN2MHsz6/C4QQVD00epMhUEHyCCaT93fkuxoGSPkKiRDjO4yr05hWEPJr70enrx11T1Tc5o
 +djwPkwHto87xUDulnzg3uvShFM=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1580625367-1679900660=:123
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Phillip,

On Sun, 19 Mar 2023, Phillip Wood via GitGitGadget wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> As the sequencer executes todo commands it appends them to
> .git/rebase-merge/done. This file is used by "git status" to show the
> recently executed commands. Unfortunately when a command is rescheduled
> the command preceding it is erroneously appended to the "done" file.
> This means that when rebase stops after rescheduling "pick B" the "done"
> file contains
>
> 	pick A
> 	pick B
> 	pick A
>
> instead of
>
> 	pick A
> 	pick B
>
> Fix this by not updating the "done" file when adding a rescheduled
> command back into the "todo" file. A couple of the existing tests are
> modified to improve their coverage as none of them trigger this bug or
> check the "done" file.

I am purposefully not yet focusing on the patch, as I have a concern about
the reasoning above.

When a command fails that needs to be rescheduled, I actually _like_ that
there is a record in `done` about said command. It is very much like a
`pick` that failed (but was not rescheduled) and was then `--skip`ed: it
still shows up on `done`.

I do understand the concern that the rescheduled command now shows up in
both `done` and `git-rebase-todo` (which is very different from the failed
`pick` command that would show up _only_ in `git-rebase-todo`). So maybe
we can find some compromise, e.g. adding a commented-out line to `done` =
=C3=A0
la:

	# rescheduled: pick A

What do you think?

Ciao,
Johannes

--8323328-1580625367-1679900660=:123--
