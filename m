Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E21A12018F
	for <e@80x24.org>; Wed, 13 Jul 2016 16:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbcGMQxc (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 12:53:32 -0400
Received: from mail-vk0-f42.google.com ([209.85.213.42]:36793 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959AbcGMQxb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 12:53:31 -0400
Received: by mail-vk0-f42.google.com with SMTP id j126so19627143vkg.3
        for <git@vger.kernel.org>; Wed, 13 Jul 2016 09:53:26 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=OxZdYdfSq5iCqJ1GEF5ne04cIrgaUUwSs5vjtGEydDw=;
        b=l10bdHjZLp6TtZMXfuFqRQn5MTqxVvIMCaX8Tlu4GtD7ZLqt2l+X7ge0ztZnOL8xda
         Td6hYjLPcEZjb3upwWoFzf5MTOOKQhoeyEcEeAww8f7s9BnWKQccaRwPMc3TNC01DQiQ
         iNJWIMIVjYMvq4msrAjIQJP5bRGPyO8Q3SIUFoK559h/Bv7khf6w3dQSQuFA1lG2iLAu
         LiOsYRTHx773vXU/mrec+rwnN2vueyi6aHhVDIOMfXxIqp1gk3kNptj1jepKG/C1+Xu4
         25soFEQ/90oSmF3wZcknFrpN54QWRgKHEIu5Hh1m41VOl9nMnmjSOo+gDuM1GhT86QqZ
         mLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=OxZdYdfSq5iCqJ1GEF5ne04cIrgaUUwSs5vjtGEydDw=;
        b=kR6YFLnA8y5PNrkx3vum0jJMptQESdCIlnZ6/Nv7EEAbb75Xd86o5FOK8sKqkbrs50
         nMVFg73Adctrzvo0nOVdbOvWheTfmjyqmx0betULlySnuBznv/ZeumpWVi+sGikxKcHI
         OTdy8ckrWayLSIlLMncUCKWnptfe2zWW8D9NR4pTxcoq8yM/RIXceml9aH3RnI4GmjHM
         4Ze1STGLaoxOl+bSdS6oH/dlegZ+w6ZNOrzwKyubpZMTlkXQS/MTjf/q/qokKyxxnaXx
         rcJlXoE3NEvNUGbrGNeSmNde9y7GbMeqc/Uv/Ke5YD8qOMMSD2FXvw6uTpLAZTEcsqL5
         w97Q==
X-Gm-Message-State: ALyK8tKYxo902L1IU0XtNMW/iWX19DWo7sXuApej+RCiVKmDIabK67DKdCo6NL6mPn43bRIJXO2ZbPgOVk4sLg==
X-Received: by 10.176.1.117 with SMTP id 108mr3797749uak.128.1468428788167;
 Wed, 13 Jul 2016 09:53:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.65.5 with HTTP; Wed, 13 Jul 2016 09:52:48 -0700 (PDT)
From:	=?UTF-8?B?SmVoYW4gUGFnw6hz?= <jehan.marmottard@gmail.com>
Date:	Wed, 13 Jul 2016 18:52:48 +0200
Message-ID: <CAFgjPJ-E0k8KQjdcRki4Qr1tPjwfJVtuFWOKYV-+f6POgb-=wg@mail.gmail.com>
Subject: Bug report: --invert-grep and --author seems to be incompatible.
To:	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hello,

> $ git version
> git version 2.5.5

Tested on a Fedora 23.

You can combine `git log --author=someone --grep=something` to have
all commits by "someone" where "something" can be grepped. If I want
all commits by someone where "something" is not grepped, I would
expect this command to return it:

> git log --author=someone --invert-grep --grep=something

But it does not work. Actually it looks like it just returns
everything (as though I had done a simple `git log`). So there seems
to be a problem here.
Thanks!

Jehan

-- 
ZeMarmot open animation film
http://film.zemarmot.net
Patreon: https://patreon.com/zemarmot
Tipeee: https://www.tipeee.com/zemarmot
