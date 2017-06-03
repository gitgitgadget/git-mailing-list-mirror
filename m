Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69E6420D0C
	for <e@80x24.org>; Sat,  3 Jun 2017 00:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751202AbdFCAgF (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 20:36:05 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35114 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751061AbdFCAgE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 20:36:04 -0400
Received: by mail-pg0-f66.google.com with SMTP id f127so3274296pgc.2
        for <git@vger.kernel.org>; Fri, 02 Jun 2017 17:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qFigRH8vIEFYtGHufWhv53V+nGeaupcVCHSYmHVkI8I=;
        b=thK261MrLjYWHNsIL0uPq7DqdJ1Gn6gVDG6waVDlYNCBl65iFaH46ppSk+6hSeFzN0
         43aVaDXKwcLcjCNpvov1ax6U+vBHBc/mRw2ujqf0bUo+7Hv/kOsnWiMOxwGUe3JcYJGw
         tupu8lXp/pq5xBFud+Y0rTZGqy2uXr66MxQeg7btZKdi2Wwgp6KUATzh9M+RblhbhAoU
         h2kPf0AH+tUAtzFuvqqffwcJZjRWCPMMsSxOaTtsV1NbFsrv++Lq3dD+pPMRxb8w09oh
         7DkDn6GxbPySb1xTyrJ6uqmfj9UNQW2sNbWwUCxdpNcUs3GBdu2IO3rUNbmpeQN0Ntc8
         x5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qFigRH8vIEFYtGHufWhv53V+nGeaupcVCHSYmHVkI8I=;
        b=FSfyJZkTUrRdcy2yBQACXSUXE4NeJaw9I1dm1Heo6B+eUIbRwANRk367HfmWwTORBz
         3LijU+ff/ZzHoC5t+3uc6jZZSeKEQIJtbfzLOZg965owjnxVJ52veLNb7omTj/8CCBc+
         f7baxIqBDgff/jZHober58VadOEPvZrHWaLszQvBghz9C5lHHExsmOgdKqaAXya5JTnu
         pf//aNzwmRiPays243a1Icq9vftlkQjJicDAr68UrbgSNuwbZw/g7hxYs3jat9X15Ggx
         xozMB91D2L/lZHvrshJzQJLy0kBgpW7/lvIOiZlr5pVwwMaMhm8PemxiMXGXx1VBq9+Q
         Os8g==
X-Gm-Message-State: AODbwcBcGYOuVqjHXazZ/iisttKqsoY6siVgyAuIGr5o8er4nKxF/uIX
        F/FO4AzKFe0/gQ==
X-Received: by 10.84.236.77 with SMTP id h13mr2618135pln.5.1496450164067;
        Fri, 02 Jun 2017 17:36:04 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:49ac:b4b9:21bb:8989])
        by smtp.gmail.com with ESMTPSA id 80sm41924962pfx.80.2017.06.02.17.36.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Jun 2017 17:36:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: pushing for a new hash, was Re: [PATCH 2/3] rebase: Add tests for console output
References: <20170531104213.16944-1-phillip.wood@talktalk.net>
        <20170531104213.16944-3-phillip.wood@talktalk.net>
        <alpine.DEB.2.21.1.1706011329350.3610@virtualbox>
        <xmqq7f0v46q3.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kaM9ryT1gWx=L6S90HPCaDPNZ6H124HAJscpeJCQFDN8Q@mail.gmail.com>
        <alpine.DEB.2.21.1.1706021442190.171564@virtualbox>
        <20170602175455.GA30988@aiede.mtv.corp.google.com>
Date:   Sat, 03 Jun 2017 09:36:02 +0900
In-Reply-To: <20170602175455.GA30988@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Fri, 2 Jun 2017 10:54:55 -0700")
Message-ID: <xmqqr2z1x5zh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> 2. Hard-coded object ids in tests: As Stefan hinted, many tests beyond
>    t00* make assumptions about the exact values of object ids.  That's
>    bad for maintainability for other reasons beyond the hash function
>    transition, too.
>
>    It should be possible to suss them out by patching git's sha1
>    routine to use the ones-complement of sha1 (~sha1) instead and
>    seeing which tests fail.

One particularly nasty one is t1512-rev-parse-disambiguation that
ensures that the abbreviation and disambiguation works correctly.
It uses a set of objects (tags, commits, trees and blobs) whose
object names all begin with number of "0"; which will of course
become useless once we change the hash function.

No matter what new hash function is chosen, we'd need a similar
test to ensure that disambiguation works correctly, so one of the
tasks for hash migration is to port (not drop) this test.
