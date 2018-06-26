Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DFAA1F516
	for <e@80x24.org>; Tue, 26 Jun 2018 21:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752622AbeFZVnc (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 17:43:32 -0400
Received: from mout.gmx.net ([212.227.17.20]:41887 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752520AbeFZVnb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 17:43:31 -0400
Received: from [192.168.0.129] ([37.201.195.74]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MQ6oB-1fTEdy1mp1-005Flb; Tue, 26
 Jun 2018 23:43:25 +0200
Date:   Tue, 26 Jun 2018 23:43:24 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Alban Gruin <alban.gruin@gmail.com>
cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v4 2/2] rebase--interactive: rewrite append_todo_help()
 in C
In-Reply-To: <20180626161643.31152-3-alban.gruin@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1806262343050.21419@tvgsbejvaqbjf.bet>
References: <20180607103012.22981-1-alban.gruin@gmail.com> <20180626161643.31152-1-alban.gruin@gmail.com> <20180626161643.31152-3-alban.gruin@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ITsBCt4KBFIL3cM8IdnSBWv2/JL8TlY9Vcstylc0YyXR6qJu3U+
 sMaPcRowt6azpeuG7fQgeSbYcU3kbkW2leYsKv3zbsbaL3fLvx+UnVg9Eut+0O64r4rGI5s
 MAicQCrRbWDNp4yACq5ziFpFw6xXEwIi6hEIuOQnzdo5ttOwXF4jKnyvsdv4RfBlw667F+8
 XDL5xWdFGEq4fE2I2UvcQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WThaV95JISk=:9WM5tKxY9LI1AnWdIdzio9
 XRw0eOwCK0YwQhPMh1PAeDrTVtJr3YXGR850cmwMXYNeLdMxz++ezdJj0ovZXRT0nMFxgRQtr
 6Xw6dEz2kHDQ9PZDQYs72uHTCHnMszNngHZQhS/LmpS9NQ8WaM/Xaj5jv0yHftCNQb021MNsD
 SQ9zDNbC50e2fwmdEJBDHRj7ZXFVDYP4vBD+SibzxFPtfrKxevXy62LOcPm3dT3aLigIThyHS
 /cTUPfmdjB6tdgNq9waPlqJc5ltSQrRO+//picc5/79hmTXp8d8Kk7SeLbYh9LsB+cmk5W8ht
 nCID3+/YurOHpMkqqppFi5KT7MbLDNTrKxUzm/NvNqDFlhBqezfZxK9YQQRljsRRKW+HXdFtK
 mOARkpTMNnp6LkXbBofN/DyB9Yos4LkstY9DnqBA0sgvS+DQujzO9v2Ho0G12xe/BG5VhxdJf
 Z+zHx+4yxPt616nbpsSM0d0exbMe5gp/E7gzryGehqBn5qVTDyqTkkyBgJYq1vAlZNz1pHy0m
 2RYMqiVwE7apUWKwO0MGS0WwDuHwQL33Kb8upW521+/jHrtznLrMAb1zlnxPLJcZEVkt6E7st
 LtcqQykg3KsQi/FfFJqzhD8Ld1ieEMRNQnA/B4WIOib+1MATy2cYlRuh5CWISO6IGoEGktc82
 JIK5PIpclnt1jgzHnAfcsdfnOaLEqssanGkzTHD7yxrcFV6li7ubZ3fTlkVNh+SjjsUBdZKLZ
 8wqCRSedLAVQPN67voxYAsDk2mt44plTdWLvjG79VAw20gctBPbx3E9LOFIsMka/jUXEfv8GQ
 CoYmMlE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban,

On Tue, 26 Jun 2018, Alban Gruin wrote:

> This rewrites append_todo_help() from shell to C. It also incorporates
> some parts of initiate_action() and complete_action() that also write
> help texts to the todo file.
> 
> This also introduces the source file rebase-interactive.c. This file
> will contain functions necessary for interactive rebase that are too
> specific for the sequencer, and is part of libgit.a.
> 
> Two flags are added to rebase--helper.c: one to call
> append_todo_help() (`--append-todo-help`), and another one to tell
> append_todo_help() to write the help text suited for the edit-todo
> mode (`--write-edit-todo`).
> 
> Finally, append_todo_help() is removed from git-rebase--interactive.sh
> to use `rebase--helper --append-todo-help` instead.

Looks good!

Thanks,
Dscho
