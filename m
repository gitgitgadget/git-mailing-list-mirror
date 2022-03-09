Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82398C433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 12:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbiCIMUi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 07:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiCIMUh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 07:20:37 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE0516E7DD
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 04:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646828374;
        bh=R7gPyXKJ3CyYt+LmC1KEI7JIl7Qfx+Axhb0t4BEvMzo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=B/p1KsByPnqhPkS39TcyoFjnQfvYIi5/znWkfYHDkN7DoynEyBejuKVXTg+vQStqZ
         ZW27URqPomGeAIEwRElYw0ozL4QvalgnUwSTxsQ7yaw+WyGWgVkMJlqeGplVEYrfL2
         XdQmHzaXSNiV24b42Rip4CWoT/9xQvN+8Y36dpEM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.147.135] ([89.1.212.224]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MyKHm-1oLvgX3q0a-00yhhQ; Wed, 09
 Mar 2022 13:19:34 +0100
Date:   Wed, 9 Mar 2022 13:19:32 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Git Mailing List <git@vger.kernel.org>, carenas@gmail.com
Subject: Re: [PATCH 4/4] terminal: restore settings on SIGTSTP
In-Reply-To: <20220304131126.8293-5-phillip.wood123@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2203091310080.357@tvgsbejvaqbjf.bet>
References: <20220304131126.8293-1-phillip.wood123@gmail.com> <20220304131126.8293-5-phillip.wood123@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:+3HVjdnr05LBIs6WV04DO39UGJSSJchB9xztXRwzjoYusyS08Sb
 LZ3+xV86a4kn93d9duxMF3KJKnWnKJbwl2FkYAXo0wtxq2Unulu9t0OkGeBBJ9zC9PHLHIW
 cPumlrddwmDXjeCBuDSbPVSALG2FyuZLvGCxQwRbcbU7aOuG7sRVulaH2xelmJ3Xzj8QI0k
 VBFKIGv29FHpMe2Q5wp+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0bcqgXmvuNM=:82fW1ZVyugpsLdo1vMOxZZ
 pCm8IOWEVLzHvoLT9J2093qUevOJ1H41dnAhh/9DoUnYsxjQVP7iPGlteLhfChsHsVkdNr/ru
 V52XjUjgR+iVdHCzFDz85n+u2FQUGCk1P5uqOnkAIzYFRGF/OV4nS/Y0cwrXnZTQSmoxR1mnP
 m9+ewRjQQEO/Wzx9AWoLjzAuWhL1scG1VWdVHoZBDnxhANNhcunduA3DtQsr2VntGhvtQjfdE
 eDuJVkqeMMveumeeRiMoaUOFgtbdgVTDRCSVIg0HGbFd6QxVP3C0RntqnaPEmFvJ7gmsPUQnj
 Cu6l0+2xK/xjfhZe2Wh9n0r39Y419XlWF7knTyoULoKqEe7oCMC9RabSVr8mU6XpWE/LoERPr
 uE/Ex1RvsjoPHs//iPH6B3zOdSCm1/jRdyWkSd2mVX6fzgD4Zl2iY+XrmuqUCdFhG3j98Nt3O
 XqMfjJMnuo4nU+0LiUkzuJyUxUdQ6lawmGEc0PNvTQTEueXvRoW+M4kjDDuz89bAKcXpNjBMD
 R5gAT1pzbrryTmM23rJt0rKuYRXpDppvuV63gJJT1ty8ZRgLx6D2f0IV9Om9LSU0gg0LUOzKj
 LIzV+0m/6+VgvOArS+8fuXyTBl4s/gZr5kyK5CwZxQ1Yc9ScHWBPMDdxjndfBZJcArhefHD0c
 iIhbtRDQ+CqbPXDkHUMjwrSwH15OhtEPx4C+eMBnGXrhVSwJzJvtoWv76TDIlHc6Ve7iWEgXQ
 S91dY/t53v+8A07LehzLr3LeEDyfZ3tUfRBaykjpD5tAFIL9Vn70M9malBHDc62Pfn/Nv512l
 QecEwS2ABGk/Dox9FJmSbpNnCmnbkg/IyeUqD9lkTwxdPR9cMrxjm4t1UyZa6uDPT5MQVy8Vt
 ZeeHaOa1PJll99GhNIwmtNxjsu4ZSkcSoJ+yX+ZF8BMSdCC3it3qotqDmgTH7005dKWdkOML7
 F8Yz7UIqINkA4079M0+tpBDgwFIFqlE8Jg6JP/8LQpKPZVOgIg20yvL6Vm3NjZQWhsf7hrhtj
 isSylAhpzqak1RB3zW1maQ+XnQM0uzOc5dhAXFtHFxJ5WkuAoidCQKRZe8IBlpu++S33YEaSZ
 30rKe/SLMntSKY=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Fri, 4 Mar 2022, Phillip Wood wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> If the user suspends git while it is waiting for a keypress reset the
> terminal before stopping and restore the settings when git resumes. If
> the user tries to resume in the background print an error
> message (taking care to use async safe functions) before stopping
> again. Ideally we would reprint the prompt for the user when git
> resumes but this patch just restarts the read().
>
> The signal handler is established with sigaction() rather than using
> sigchain_push() as this allows us to control the signal mask when the
> handler is invoked and ensure SA_RESTART is used to restart the
> read() when resuming.

This description makes sense. From my understanding of signals, the code
also does make sense, but it is unfortunate that it has to be so much code
to implement something as straight-forward as suspend/resume.

FWIW I tested the `add -p` command with these patches on Windows and it
still works as well as when I had developed it.

Thank you,
Dscho
