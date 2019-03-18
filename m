Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AC7A20248
	for <e@80x24.org>; Mon, 18 Mar 2019 04:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfCREjj (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 00:39:39 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40317 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbfCREjj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 00:39:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id t5so15449336wri.7
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 21:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=h8ctdk+f+HoVQcTn/NAAR4fudqKXoniR2J1/xK7xpEo=;
        b=EtGcT+6XkoHwkDmGtuM6rAiR2hM50Tm6rXTVS9CUOwYWOUQT8DK2SU3wXdKSgnIG7s
         EupVR6y32hTp1Fl2AoM1FgXtBop8S8Yb/q4RknHD3WmdHiV0bWb1Oot1U2c/BgpT/+Jh
         bJX8Fqlif5rLekuJJC/r49DiKFFPoBUbVQrzjx49GSt8QJNFjqDhQPwM+Gj9AKebMRhl
         JL+8/mU1mPZk4XEvkNfCvJ3iGgstl/D8Ibyc0v6ikj+Kzd0JGVl/YHKlCxwNG3bP4WW9
         K37d3veZer+BOKMoYGDRwPbok+iO8P6L4bTdWaqjX3I+wohSr0UbO/6TdoKrCF8Nv73o
         Ij3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=h8ctdk+f+HoVQcTn/NAAR4fudqKXoniR2J1/xK7xpEo=;
        b=AXk4U+zAD5OCoblplmuEOt0BDHTA0skDC4gwtmei4gXcve0B5UWYt/8aiEN2wFP0p5
         lEZWj09p9otXOOOu7TojfBbSXrmoqO28T/vsBjUMBRL99KaKLq7KQ/O75gQzU1EQBLb0
         qTCQHYLQLOCh9VsQmK4nE0+YNSG83Z1F1RUuTec0dqB2iDVIzhRk9sJKW3IxhimQlhre
         SrRU/292+RNW94FroDki70daHEyfo74hFAjpCaAC+v2RqHuFLyM899K52Teo2RQW6TXN
         07v7C+qWjBn0ZYfFM2x387yQrAa6R3qJ/nPuGLmieLFA8Gpyqc/NlgIhnre+AWKf/WO+
         cs9g==
X-Gm-Message-State: APjAAAUJ/XhtmpMmXHHh5iMTs5prnOZ08O1Sot/6Ai5Z4w6yL0sAfhai
        1r+z19RkU4uss82ZorNbn7E=
X-Google-Smtp-Source: APXvYqy9ne4VDdOOIaoElCQKK+gmAKwj7Wg17oFwJnn034jVDTwt1cmgZ6F9yz5e3XOX4J3kjDjk3g==
X-Received: by 2002:a5d:538a:: with SMTP id d10mr10504216wrv.121.1552883977452;
        Sun, 17 Mar 2019 21:39:37 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id y192sm9449458wmc.6.2019.03.17.21.39.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Mar 2019 21:39:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/2] stash: handle pathspec magic again
References: <pull.159.git.gitgitgadget@gmail.com>
        <xmqq5zsukuyj.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1903081709220.41@tvgsbejvaqbjf.bet>
        <xmqqva0rmtrg.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1903111714430.41@tvgsbejvaqbjf.bet>
Date:   Mon, 18 Mar 2019 13:39:34 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1903111714430.41@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 11 Mar 2019 17:25:26 +0100 (STD)")
Message-ID: <xmqq8sxc6bjt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> To appease you enough that you stop complaining about the current, or
> previous, state of `ps/stash-in-c`.
> ...

First of all, you do not have to appease me.  What happened in the
past has happened already, and whether I complain or not, the fact
that the history we came up with before pushing the topic to 'next'
was suboptimal.  Nothing short of kicking it out of 'next' and
redoing as if it were a fresh topic would fix that, but we all
agreed that it is not the best way to spend our developer and
reviewer resources.

> Fine. But in that case, I would appreciate not being reminded of the
> messiness. Not unless you let me do something about it. Don't put me
> between a rock and a hard place, please.

You had been given plenty of chance to do something about it after
you added "oh, it was wrong not to have a legacy fallback, and here
is a patch on the top".  This is not the time to revisit the issue.

Gagging me won't change the fact that the history we ended up is
messy.  Without getting reminded of our past mistake(s) ourselves,
what else encourages us to do better the next time?

The lesson I personally learned is that yielding to the wish to
hastily push things that are not ready to 'next' will leave us mess.
I hope the lesson submitters and mentors have learned is not that by
bombarding reviewers with too many iterations that do not address an
issue, a topic can be pushed through with the issue unresolved with
reviewer fatigue.
