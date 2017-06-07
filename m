Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45B6C1FAE5
	for <e@80x24.org>; Wed,  7 Jun 2017 09:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751523AbdFGJrY (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 05:47:24 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37346 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751473AbdFGJqu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 05:46:50 -0400
Received: by mail-wm0-f43.google.com with SMTP id d73so7198591wma.0
        for <git@vger.kernel.org>; Wed, 07 Jun 2017 02:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=6F5bx9R/8v/Q2aIVN6/0QP15YT4T6M4O4/ws6oCDoL0=;
        b=fCH4sGRtfIYUXqIliYuI9DddwqrJQCVbjYpbM5zDm7q1rgqfwd/gNxI+f9ZDFHHE3+
         vYOgIgGgvTnytud6YP9opaQ+fD+1c7ZaQgzmphKnide07AYr9YLLa+40vZiJ1Tt23Xfs
         C1DNXJP/Z8TKuIlpbckkRwvfVp77DU2cObNEA2sLqDrOIi3q49TpPGAVDVc/GzyfCWyp
         hesdv+z+8THy1FkCHnaFPmLJwpQ7kKnXwxaeaxauiUvSuO5FV3z+f0g3C9zfjNSilYlK
         3/eGH6kCDvxqYGYYbhlbtd6Q+AKeSTYWiSHy1IAhaAPqKK6wIM04zbqeBpEMCqXqVPy2
         +rKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=6F5bx9R/8v/Q2aIVN6/0QP15YT4T6M4O4/ws6oCDoL0=;
        b=UNgrh6lSQVSd9j1y62+bnOWy386VrA6R5OUh+CK70G4EHBS66NFeJjVapze7MUosqX
         wIkYG/sNYACuLq+JjHiFPFe21+dmzJVCQQbx8Q/hb2jO5oTySqiHDBadJNLJ9ZVD0vT+
         dwo0kfx5CwIpord2+q/Clczf4gJLOELUDsiZlq/1f3QfOGlE6aNok23cyF1gFa3mpy3P
         at/WR0CbCdZGHJmyWcuSHmkdw2ZIbV7xTd1H9yhDIjZmq5I7bxCP9E5lLJiDw+WbBkG7
         ujMiP3H1WDAxwMFZN32YO1XVf0hMlCb2Y+HTWLNAX/D+ThdxsB7N4yK/5tByhs/EvWnC
         lF2g==
X-Gm-Message-State: AKS2vOwglCJQI0Nd3VpI+0DpefDlphym2bfdqoHp46Z8/XVBZvCO44B4
        ITVpa9txkrt1ajAvL2nvTgAEl2as2cIx5+o=
X-Received: by 10.28.46.23 with SMTP id u23mr1460643wmu.102.1496828809043;
 Wed, 07 Jun 2017 02:46:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.105.139 with HTTP; Wed, 7 Jun 2017 02:46:08 -0700 (PDT)
From:   pedro rijo <pedrorijo91@gmail.com>
Date:   Wed, 7 Jun 2017 10:46:08 +0100
Message-ID: <CAPMsMoAYpS8QMrfyed5=XPWJLbV6=kMg5gp-2a75kWMpVD3D1A@mail.gmail.com>
Subject: [BUG] Failed to sign commit
To:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Recently I've updated a bunch of stuff, including git and gpg. I'm using

- mac OS 10.10.5
- git 2.13.1
- gpg (GnuPG) 2.1.21 / libgcrypt 1.7.7

When I do

$ git commit --allow-empty -v -m "lol"
error: gpg failed to sign the data
fatal: failed to write commit object

I tried the verbose flag hoping to have a better insight, but not very
useful. Not sure if it's a gpg problem, a git problem, or something
else.

Any clue on how to debug the problem? Do you need any gpg output to
better understand the problem?

Thanks,
Pedro
