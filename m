Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD9201F453
	for <e@80x24.org>; Mon, 21 Jan 2019 14:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbfAUOnq (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 09:43:46 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37920 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729279AbfAUOnq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 09:43:46 -0500
Received: by mail-ed1-f65.google.com with SMTP id h50so16768935ede.5
        for <git@vger.kernel.org>; Mon, 21 Jan 2019 06:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ksSeoPGrB8h9k7NsY/0Vxv2xgAue46oHKsG4S+GT4hI=;
        b=ZR07mkSSY1zcXuVNwvAlJ4Ef+JhWcy7RgPgP8I3I4BglXwBApsbFjbxj1Dgy7A9QMP
         Haqy4W9V2ckkhuXcwPEN//XhjAoggfpDY2sMa4HtRM96fzLrLNvH2H1rgesA4YmHCWXF
         216sJmZNudhrmvqyzcbCNXlgFWVXa2nJ/iIgFy+QD0P+oqJHcj8yXzVaRDdgUsm1fblu
         CYc+xmg5jJXZk+6MvDS69uTj0pZ9ZjVPsPDX4bcNIBh+3Y3Tr3hz0+cTZjcmVyJ6rl9A
         GhXxUa9I7S80xDyJlVa2qpYxBRpOOp/tXm74ppDJvyO6LikD0dEHUsycIyFVhbTla9nz
         D/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ksSeoPGrB8h9k7NsY/0Vxv2xgAue46oHKsG4S+GT4hI=;
        b=mvVLnT4La4+HWhlvPHBDqIRHXvRwCpwcbCXtAy/ltyslpA+H6EnMGtvji6dIgdWjSk
         bBWrXS7+EnPx2UYD7QOXGL2HkjfPyZv6OKOAgv/KzD3Xnl/dJOcvtXry4Sj1CDq1PBj3
         1KCsIG6LKJKTUP6T0GDLgYdQHglcaljNcPMSF44B5hdSamFz4+nfwg2EuW5pag51J/zo
         IEjgw+f7zF0L3+TRXbBPSoHxw/4BJCOIQ+3JeNjdwWxVsr9hga/Jvv0433iPxyvOtcFw
         vdwGBxatLKEzwDBfXsDlxJ93XxnTHghCd3mNCe4kvPZBKU+7jHBNErrNhC//efT++VUI
         aX5w==
X-Gm-Message-State: AJcUukeLRESUfIMpYc+UOle5Hs4wWS6yFmhinTv08A6D7C+jNHRWTnv7
        41x7khBYF1FXPn70tcOJBD5JPVtgFNsPsNS9EmQEtytN
X-Google-Smtp-Source: ALg8bN4BZY7Y47317PT+3W+DHWNGE1M9nP4uWgIE/tvtjCS1qBeUen08SFGdPtsZCwBxULEYypiLzKNUbZY5XXjYY6k=
X-Received: by 2002:a17:906:e2c9:: with SMTP id gr9-v6mr25004597ejb.108.1548081823949;
 Mon, 21 Jan 2019 06:43:43 -0800 (PST)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 21 Jan 2019 15:43:32 +0100
Message-ID: <CAP8UFD39=XVHWBjfUQ40236OTPf7ccyA8rtSUZtT3+U4pSVudQ@mail.gmail.com>
Subject: Draft of Git Rev News edition 47
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrn@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Luca Milanesio <luca.milanesio@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Robin Shen <robin@onedev.io>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Slavica Djukic <slawica92@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-47.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/331

You can also reply to this email.

In general all kinds of contribution, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Gabriel and me plan to publish this edition on
Wednesday January 23rd.

Thanks,
Christian.
