Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF9CD1F42E
	for <e@80x24.org>; Wed,  9 May 2018 21:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965563AbeEIVmW (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 17:42:22 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:36618 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965530AbeEIVmR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 17:42:17 -0400
Received: by mail-it0-f67.google.com with SMTP id e20-v6so761908itc.1
        for <git@vger.kernel.org>; Wed, 09 May 2018 14:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LdV7bcxyHEXpUuKb31NSce+V90jNMykF1q6m4HpqoZM=;
        b=qBoF+V9n1ieklgEsa74BjplxymOdsOp+H47FqRCRpgJL2ijs1bKe7jxgpluulAvgSs
         fIr4/wcjnY73Ty+fxznj3zv6uLYHnywXoC/dXzEGPAjJkS3lZo7ImOR/uXqq1Gs/bcKZ
         rHeyfTGUEuHpslBVKDrVnd3dVDqp16gCKaf74Zu99MbFVnaG8ZdBagCiQL3HmWVp8qAD
         C0hpdzUeqZrz3th/h0cirxK4+bOQUBzNmMPIwPWqtaIQ2paQN5EgwfnXzcpGKLZBuqMh
         bsb36G0vKO1785pKgiSNwjIPAHApXrpN16TwDFG/F1m/pS0RRIU4piWPwJ50RBqelVDh
         Yv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LdV7bcxyHEXpUuKb31NSce+V90jNMykF1q6m4HpqoZM=;
        b=KpkAZVz4L2oodcqk8nKr/8mewqaKOINihnaqNgFoGr+x5eFZcoEtgAa9XdDYCRobuq
         ApeJhtBtUcP+B1TDGigho/oiw0EkChOoHDR4UJ+MeN9fM6xUWeSg7eY+2vtUcu1KfaOm
         +MncGb4RmNZ66cloHxLQ4RT3EUYBJCjRmFOWVhsAU/xp/KIFiyd/rMczbKddkKpQO0fi
         ecpmm0hUg5Xhw2R1GQ5hV+lHsUFyOLUqscoW1Ikx2Lcxpg1q/zJjn8hdTDTz8lXFo0yj
         NvUJdagkRHKaTubbQcCZ9o/leMHjoH4UlcrXbszlJmK0ltI1ERQA0rC4tr++WcpnHxHe
         GO6Q==
X-Gm-Message-State: ALKqPwdJj6Ebu/qfBIntgKl3xxxf4rBm1N9spmu+D/9/U9Ele6bn1q1J
        0XxCi+/Vt//xJ5oAFyLuSQAsbr2f
X-Google-Smtp-Source: AB8JxZrua7B8ZKl7ndI1bMslzJ9cRobAa3V+L1D+K9hlkmuwMumUhFJAL4LQHb/Y9VDP58Et1CUPBA==
X-Received: by 2002:a24:4151:: with SMTP id x78-v6mr11978329ita.0.1525902136480;
        Wed, 09 May 2018 14:42:16 -0700 (PDT)
Received: from lmm-notebook.localdomain (cpe-74-139-249-65.kya.res.rr.com. [74.139.249.65])
        by smtp.gmail.com with ESMTPSA id h202-v6sm7364389itb.39.2018.05.09.14.42.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 May 2018 14:42:14 -0700 (PDT)
Received: by lmm-notebook.localdomain (Postfix, from userid 1000)
        id 5AE1A300000000133E3; Wed,  9 May 2018 17:39:09 -0400 (DST)
From:   Luis Marsano <luis.marsano@gmail.com>
To:     git@vger.kernel.org
Cc:     Luis Marsano <luis.marsano@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ted Zlatanov <tzz@lifelogs.com>
Subject: [PATCH 0/2] Configurable GnuPG command for git-credential-netrc
Date:   Wed,  9 May 2018 17:36:32 -0400
Message-Id: <20180509213634.5198-1-luis.marsano@gmail.com>
X-Mailer: git-send-email 2.17.0.584.g3d5ba9c85
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

Should `contrib/` area patches go here, too? Contributed Software
page
https://git.kernel.org/pub/scm/git/git.git/tree/contrib/README
says to forward them to "jc" (I'm guessing that's Junio), but I
think they're getting missed. Though the component author approves
(acknowledgement below), am I missing anything for submission?
Thanks.

> git-credential-netrc was hardcoded to call 'gpg' for decryption.
> This is a problem on distributions like Debian that call modern
> GnuPG something else, like 'gpg2'. This proposed update reuses
> git's gpg.program configuration to customize GnuPG's name. It
> introduces the -g|--gpg option on the git-credential-netrc
> command to allow alternatively setting it in git's
> credential.helper configuration. Since testing a git
> configuration involves a temporary repository as provided by
> git's main testing framework, a patch updating tests to reuse
> the main framework is included, too.

------- Forwarded message
Delivered-To: luis.marsano@gmail.com
Received: by 10.103.152.29 with SMTP id a29csp214132vse; Fri, 20 Apr 2018
 16:18:34 -0700 (PDT)
Return-Path: <ted@lifelogs.com>
In-Reply-To: <1524160133-8877-1-git-send-email-luis.marsano@gmail.com>
References: <1524160133-8877-1-git-send-email-luis.marsano@gmail.com>
From: Ted Zlatanov <tzz@lifelogs.com>
Date: Fri, 20 Apr 2018 19:18:32 -0400
Message-ID: <CAMdP0d=sNtgwDnfZz88_cmAt6VYMGOozOC5q4o32R+yw+UcrAQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Configurable GnuPG command for
 git-credential-netrc
To: Luis Marsano <luis.marsano@gmail.com>
Status: OR

That looks terrific, Luis. It's a good change so I'd just go ahead
and propose those patches. I don't see anything incorrect and
tests are always good.

Ted

On Thu, Apr 19, 2018 at 1:48 PM, Luis Marsano luis.marsano@gmail.com
wrote:

> Hello Ted Zlatanov,

> Thank you for git-credential-netrc. Will you please look over
> these patches and decide if they need more work? They're also
> available as the netrc-option branch at
> https://github.com/lmmarsano/git This is a first contribution
> for me, and I welcome input, suggestions, criticisms,
> corrections. Thanks.

> git-credential-netrc was hardcoded to call 'gpg' for decryption.
> This is a problem on distributions like Debian that call modern
> GnuPG something else, like 'gpg2'. This proposed update reuses
> git's gpg.program configuration to customize GnuPG's name. It
> introduces the -g|--gpg option on the git-credential-netrc
> command to allow alternatively setting it in git's
> credential.helper configuration. Since testing a git
> configuration involves a temporary repository as provided by
> git's main testing framework, a patch updating tests to reuse
> the main framework is included, too.

> Luis Marsano (2):
> git-credential-netrc: adapt to test framework for git
> git-credential-netrc: accept gpg option

> contrib/credential/netrc/Makefile | 4 +-
> contrib/credential/netrc/git-credential-netrc | 69 +++++++++++------
> contrib/credential/netrc/t-git-credential-netrc.sh | 31 ++++++++
> contrib/credential/netrc/test.command-option-gpg | 2 +
> contrib/credential/netrc/test.git-config-gpg | 2 +
> contrib/credential/netrc/test.netrc.gpg | 0
> contrib/credential/netrc/test.pl | 86
> +++++++++++++++-------
> 7 files changed, 142 insertions(+), 52 deletions(-)
> create mode 100755 contrib/credential/netrc/t-git-credential-netrc.sh
> create mode 100755 contrib/credential/netrc/test.command-option-gpg
> create mode 100755 contrib/credential/netrc/test.git-config-gpg
> create mode 100644 contrib/credential/netrc/test.netrc.gpg

> --
> 2.7.4

------- End of Forwarded message

Luis Marsano (2):
  git-credential-netrc: adapt to test framework for git
  git-credential-netrc: accept gpg option

 contrib/credential/netrc/Makefile             |  4 +-
 contrib/credential/netrc/git-credential-netrc | 69 ++++++++++-----
 .../netrc/t-git-credential-netrc.sh           | 31 +++++++
 .../credential/netrc/test.command-option-gpg  |  2 +
 contrib/credential/netrc/test.git-config-gpg  |  2 +
 contrib/credential/netrc/test.netrc.gpg       |  0
 contrib/credential/netrc/test.pl              | 86 +++++++++++++------
 7 files changed, 142 insertions(+), 52 deletions(-)
 create mode 100755 contrib/credential/netrc/t-git-credential-netrc.sh
 create mode 100755 contrib/credential/netrc/test.command-option-gpg
 create mode 100755 contrib/credential/netrc/test.git-config-gpg
 create mode 100644 contrib/credential/netrc/test.netrc.gpg

-- 
2.17.0
