Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AF7D1F461
	for <e@80x24.org>; Tue, 25 Jun 2019 11:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbfFYLbI (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 07:31:08 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51854 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728940AbfFYLbI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 07:31:08 -0400
Received: by mail-wm1-f67.google.com with SMTP id 207so2437928wma.1
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 04:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=niw9KDnpy+R4vf83lGYcPyPQSGdan+2tdnfVis4hbH8=;
        b=lRNa70LuQ+UM6JpKxWlajOyiIrSzAHSBLlqiHtbFxP3Oah933xEXUNE2CdiNgvzc7w
         lkZorZUId5fWP05EHkZZB3EgFWMu+OAC/3iIj0SXwxULmArwo0qAlAY5P6XTx0MnJEsn
         bUmI7GicE/Q2WGHW1LV/klkIlzjkkrOtafR9UOUFlrPEhuBmpVgtMxoXdfQaR8+g9sqd
         oEKyLWCJKUhwHBtaQi+1Sr16oBMrZwlWhNXHsd7ypZkTrVtAteOkDZMKTGWC9jsgAKYg
         mjdIL0CQDvnJIvjmbupP935AG1xQBCGGAzBs4tb0mw4KdNwqjBIp5ekZO5A1Ncvw3bdI
         9zLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=niw9KDnpy+R4vf83lGYcPyPQSGdan+2tdnfVis4hbH8=;
        b=IGIkOZR+FkeU2GbNLStPMPX+EHDuwp/d7rCp/fAya/3HSncKmF+XVmPjey40vEn1et
         vyjliZCiMpRZvdRyGyVNNTp0jpROTXYuxlvIclZWJVQ+qG4ulQucoBWIKJZP7jtjbx3k
         dHhwAPfVmVwVLWQgCGyaueYHrFTngHhLfB7szfP6zSVjtxC0t/pGEMWiIK0pRpoHndZO
         6z+CmpuL7QvpiEFLTyrsqMMPIUBRDmDBQRIzni3Hwwb7Pvw2IwnTYuz6TvuoGc1n38+/
         wlq9dLCOQf9UucTThlKB/lO+w4GVkNAa1v7P0epbAvPL4oHWDlOMonhKsON1uwmSNFA2
         p1TQ==
X-Gm-Message-State: APjAAAVJI0GL7+Zk/hEC3M6NcMat2wBtPkeLjwTFCpSEfEjiGMyoz5uc
        kXGvkAjqqWdNIHoZYuwkyrQ=
X-Google-Smtp-Source: APXvYqyIPwl0S6jRE34E12YGAmWHDZNVSCwAA5qh0H2PebjDsD/P1uiN2zohv5YD7qMyjYfgJIgh6w==
X-Received: by 2002:a1c:b457:: with SMTP id d84mr21012700wmf.153.1561462266412;
        Tue, 25 Jun 2019 04:31:06 -0700 (PDT)
Received: from szeder.dev (x4d0c7556.dyn.telefonica.de. [77.12.117.86])
        by smtp.gmail.com with ESMTPSA id x8sm30563820wre.73.2019.06.25.04.31.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 04:31:05 -0700 (PDT)
Date:   Tue, 25 Jun 2019 13:31:03 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 3/4] rebase: fix garbled progress display with '-x'
Message-ID: <20190625113103.GB10853@szeder.dev>
References: <20190430142556.20921-1-szeder.dev@gmail.com>
 <20190611130320.18499-1-szeder.dev@gmail.com>
 <20190611130320.18499-4-szeder.dev@gmail.com>
 <xmqq36kflv0f.fsf@gitster-ct.c.googlers.com>
 <20190611211151.GG4012@szeder.dev>
 <nycvar.QRO.7.76.6.1906122056570.789@QRFXGBC-DHN364S.ybpnyqbznva>
 <20190624183927.GA10853@szeder.dev>
 <efc4a141-071a-6549-f25d-21cc6256832a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <efc4a141-071a-6549-f25d-21cc6256832a@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 25, 2019 at 11:08:04AM +0100, Phillip Wood wrote:
> >> Rebasing (1/4)QRebasing (2/4)QRebasing (3/4)QRebasing (4/4)QQ                                                                                QSuccessfully rebased and updated refs/heads/missing-commit.


> >> May I please *strongly* suggest to fix this first? It should
> >>
> >> - completely lose that last line,
> >> - be inserted into the test case itself so that e.g. disk full problems are
> >>   caught and logged properly, and
> >> - the `test_i18ncmp expect actual` call in the test case should be replaced
> >>   by something like:
> >>
> >> 	sed "\$d" <actual >actual-skip-progress &&
> >> 	test_i18ncmp expect actual-skip-progress
> >>
> >> This should obviously be made as a separate, introductory patch (probably with
> >> a less scathing commit message than my comments above would suggest).
> >>
> >> And that would also remove the double-yuck.
> > 
> > Unfortunately, this addresses only one of the "Yuck"s; see v3 of this
> > patch series [1].
> > 
> > The other yucks affect the following four tests in
> > 't3420-rebase-autostash.sh':
> > 
> >   16 - rebase --merge --autostash: check output
> >   23 - rebase --merge: check output with conflicting stash
> >   26 - rebase --interactive --autostash: check output
> >   33 - rebase --interactive: check output with conflicting stash
> > 
> > These tests come from commits b76aeae553 (rebase: add regression tests
> > for console output, 2017-06-19) and 7d70e6b902 (rebase: add more
> > regression tests for console output, 2017-06-19), and are specifically
> > about checking the (whole) console output of 'git rebase', so I left
> > the updates to them as they were.
> > 
> > In any case, Cc-ing Phillip to discuss whether something could be done
> > about them (now perhaps preferably (for me :) as a follow-up, and not
> > another preparatory patches).
> 
> Those tests were added to check that `git stash` was being silenced (see
> 79a6226981 ("rebase -i: silence stash apply", 2017-05-18)).

Hmm, so would it then be possible/sensible to do something like this
instead:

  git rebase --options... >out &&
  test_i18ngrep ! "<something specific that only 'git stash' would print if it wasn't silenced>" out

> I can have a
> think about a better way to do that, but is it still a problem? I just
> tried to take a look at your CI output and
> https://dev.azure.com/gitgitgadget/git/_build/results?buildId=11406
> seems to be all green - have I missed something or has Gábor fixed the
> issue?

No, it was Dscho who fixed the Azure CI issue, see

  https://public-inbox.org/git/nycvar.QRO.7.76.6.1906141356140.44@tvgsbejvaqbjf.bet/

elsewhere in this thread (it's a long one, but well worth the read
IMO).

However, the point here is not that Azure CI failure, but rather the
fact that tests had to be updated to include the new line clearing
sequence in the expected output, and that "Q<...80 spaces...>Q" looks
yuck indeed.

