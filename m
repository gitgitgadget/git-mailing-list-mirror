Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4EB82141D
	for <e@80x24.org>; Mon, 11 Feb 2019 23:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfBKXUM (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 18:20:12 -0500
Received: from forward500o.mail.yandex.net ([37.140.190.195]:48922 "EHLO
        forward500o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727150AbfBKXUM (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Feb 2019 18:20:12 -0500
Received: from mxback19g.mail.yandex.net (mxback19g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:319])
        by forward500o.mail.yandex.net (Yandex) with ESMTP id DB13060087
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 02:20:09 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback19g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id QsBntsvLNy-K9raxCnn;
        Tue, 12 Feb 2019 02:20:09 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1549927209;
        bh=XwB2nzMGDtlzky3fm4KcePZn4M67FBvN8RPBzwa3naw=;
        h=From:To:In-Reply-To:Subject:Date:Message-Id;
        b=LUpy3djqtQIho+WjDXTSAWPZ+S03iHNzERQruA7bitbYcsxI+xGvfX3FXtoybqT+S
         hRwbyffLvD0duPYlY/liMxaFoRJoE886wP/2wOIbSXV/eFY4KhKuPqEddTOzPynx8Q
         zGUq9RmiE7WsEoxnt7P2U5+q5+qv70IiD3uRONFo=
Authentication-Results: mxback19g.mail.yandex.net; dkim=pass header.i=@ya.ru
Received: by iva8-3af116a85b74.qloud-c.yandex.net with HTTP;
        Tue, 12 Feb 2019 02:20:09 +0300
From:   Sergey Lukashev <lukashev.s@ya.ru>
Envelope-From: lukashev-s@yandex.ru
To:     git <git@vger.kernel.org>
In-Reply-To: <3307861549925664@iva7-ddadfcd6463f.qloud-c.yandex.net>
Subject: Fwd: git commit --verbose shows incorrect diff when pre-commit hook is used to modify files
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Tue, 12 Feb 2019 02:20:09 +0300
Message-Id: <3762191549927209@iva8-3af116a85b74.qloud-c.yandex.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



-------- Пересылаемое сообщение --------
12.02.2019, 01:54, "Sergey Lukashev" <lukashev.s@ya.ru>:

Indeed. Sorry, this was how I thought it works.

So the hook runs even if the commit is cancelled. A bit odd.

Then let's have someone else from git list to answer your question.

12.02.2019, 01:11, "Fernando Chorney" <djsbx@djsbx.com>:
>  Hmm, so I currently have it set to run vim as my commit editor, and
>  enter the message in there most of the time. I can definitely see
>  output from the hook into the shell before my vim editor loads up that
>  shows me the diff and lets me add in the commit message. This leads me
>  to believe that the pre-commit hook is being run before the editor
>  (with the diff) pops up.
>
>  On Mon, Feb 11, 2019 at 4:04 PM Sergey Lukashev <lukashev.s@ya.ru> wrote:
>>   At the time you see the diff the committing of changes has not yet been initiated. It's only after you type in the message that the ACTUAL committing starts and the hook runs.
>>
>>   You can print the diff of what your hook has changed by running "git diff" in it before adding changes.
>>
>>   12.02.2019, 00:28, "Fernando Chorney" <djsbx@djsbx.com>:
>>   > Hi,
>>   >
>>   > I am trying to use a pre-commit hook to modify files before they are
>>   > to be committed. The problem I am running into is that if I use "git
>>   > commit --verbose", which I often do so that I can see the diff, the
>>   > diff it displays in the editor is the diff before the pre-commit hook
>>   > was run rather than what the diff would be after the pre-commit was
>>   > run.
>>   >
>>   > I would like to note, that the pre-commit hook is definitely running,
>>   > but when git grabs the diff seems to be in the wrong place.
>>   >
>>   > I have set up a simple example on my github to show the problem.
>>   > https://github.com/fchorney/pre-commit-example
>>   >
>>   > Is this intended behaviour, or perhaps an issue?
>>   >
>>   > Thanks,
>>   > Fernando Chorney
-------- Конец пересылаемого сообщения --------
