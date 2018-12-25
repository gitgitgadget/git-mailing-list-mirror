Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51F06211B9
	for <e@80x24.org>; Tue, 25 Dec 2018 10:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725841AbeLYKnG (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Dec 2018 05:43:06 -0500
Received: from mout.web.de ([212.227.17.11]:36289 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbeLYKnF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Dec 2018 05:43:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1545734578;
        bh=SbTJoebAcYGynVvhZf/6Jp/oz7YQyYfME+SsgZBlNsE=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=HJdh6rtwt63s+sbK+F9fuoekb6wg2hJilnoEqiMAsRhWFgEZLEqkJlQYGUI7/OMFq
         7CCvhH5+2DwAKB6uHtzUpwcefH63YPnwG8Iu2mFB4ejiqTqTrT0bXlkJO+bjT9vmjo
         dNq+ZfQiBi9V9B8raXuiAkgNASlNCVKiG7320xA0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MN4Oy-1giLsY04jY-006eI7; Tue, 25
 Dec 2018 11:42:58 +0100
Date:   Tue, 25 Dec 2018 11:42:57 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/1] abspath_part_inside_repo: respect core.fileMode
Message-ID: <20181225104256.GA29443@tor.lan>
References: <pull.104.git.gitgitgadget@gmail.com>
 <pull.104.v2.git.gitgitgadget@gmail.com>
 <3eaec10c46bdb1a4a1795ae16a76cef15d541ff5.1545690845.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3eaec10c46bdb1a4a1795ae16a76cef15d541ff5.1545690845.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:pljCiISV77HbrFIpNHWWwitKUKQoqPQU7pdMDAIAkMwQwYnx3Ba
 LAn1Aqoo1VGfi/JaR61mvxwD5VuyGajZZKkx+O5dXQzRnYR4WIfywkDDweFhgi0rFhtLAac
 VRGRwUfHsLAlcdmw6u4UuRSOj0sJAg4LeEJRHfD1hvO3k+Ho0JjabHIOVtM/InWUaVFqt4O
 TmsFNnSqLniCqZePmrAKg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2jQt5YS+YtU=:e78Ai138daEpyRMp116IyE
 Pc5da3BAIfu8q2JLShckWfPZ+/SdQ3/bGfJvkFYy7nX5mf6zaGW/obnqbp7v6lFtYeVbhHWSV
 mRpnXAC/wyL0JyjGhjyY0x9H3wktU+B6HlWpA9LMENneIlZv6/6YTepEtXQJl1y4CxcW61Twb
 4UenwFxuzrqKp6Yhc7pFZyDrlsiCLI3765v/Zn9MAZzXHzsVjbE7E8z5xSicyS7vmtm4r0rWP
 FOyLy1FeSKeczI0QKElyGfDfzfw15nAmgE67LOec8+54+6+pAhmoPHNjTfW74b+iECf418UTe
 Zi70wZm0ZWG166uzcGdYmAIkePw4ZdtnS6dF0oiF6Ixm2ajPBzV++/UjVpt2QcM/rFkIdhS1p
 o8wJBWGF3/cjIiKaBpfUezThiGAZsFmsMwvKTr2x78jF1/bfZZqdTat2SwqqkWLWMOb3MbNFp
 0BQe8dnqRFy/OaIFpUu0DkbaAPYVu4eIrNlkrj9HV6aFUVsDH4rrwAuWj+WGiFOiDqKekrYcd
 HXo7t0AGIAzQb7PbMpKIi9K3zWKbfL+ko5QOVtQbVFrruQ5EgdWuRWfjufa/o1EuA5nPz5PPP
 IvueK+e/ZOa0sZNmUPVQJG4NUjywENxPUKaqtxPZgg+b/ejUBb6zY0XyyrIqUpCWulgJzDNUp
 oH5fPQ/10LlbC0Ba6yopqSQutWjtASdscweYk5gbE5i7cVgCiq+qAoz1ItUSQyB22C4yYy8gm
 UuRkJqaWD/wglT49CEExoPXWaCcy33r7FlYlMsJbanK3yPx0CcZ1lhpGDp5lIiakyIcfo+IWO
 08L+Yv0zmKeoGGT3XZrzBW2w6kcggZgp3TsU9QBdKf2YWZt5cqgwbQxASnmMFGbBXa6KOjfrM
 9iccNxjAY+T7PM/ISayISWk0vb2mu/NBhIb4pUNt4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Should it be
s/respect core.fileMode/respect core.ignoreCase/

in the header line ?
