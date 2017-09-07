Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC95820286
	for <e@80x24.org>; Thu,  7 Sep 2017 19:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752689AbdIGTaD (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 15:30:03 -0400
Received: from mail-yw0-f176.google.com ([209.85.161.176]:33906 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751424AbdIGTaC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 15:30:02 -0400
Received: by mail-yw0-f176.google.com with SMTP id r85so2010837ywg.1
        for <git@vger.kernel.org>; Thu, 07 Sep 2017 12:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z45yD/D1yiYtwiH5ZcYfyOjQO354/ZyAhd1F9eYQvuA=;
        b=QlbHQyDrDjNdpRuTFqrh1WeFh1pKk1+Ca26WXV8dl01GmtYWLvw1SCRj34n2baYad/
         1IrPiP2LV8MUiFuO0z94Pm8kca75oa7AnF+i/3dBmqPx8yH5t7n2kjhJ6zSN5MKjmX1H
         Y5v5WT0RF4cxgAFr8pVgXuiT2TTGG4IUrJH5XsFI1mgb/SUmWAYl2ayiboaajbfF2orO
         UJkYwKCPaCPrUpqCbEGBzH5+Wdme2m2Jf7OHmGGUnaYzWLs+bnpFN4qJjHIgw/it8mH+
         OafeLQC5tWPhrdPDQwXxCJmcF1DCorD7h+3X3hAzq+o8iIuKrwLt1Y9qPhe5pVaH/423
         XUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z45yD/D1yiYtwiH5ZcYfyOjQO354/ZyAhd1F9eYQvuA=;
        b=Yie8sshCfoAhsrqIPrxwkmcruOjBNl9kXPVBOL85W8uNdwVCSXSipbxyMBbTDOfYHf
         HK6LevnH5ePdRVQMPu3IBbRtgY/LYqrbY5U11cNOPLt9IoU5iTwN5A5etvZhd9Gsza8g
         ri7xykS8n1yLBlFCjZqnwXFfKg/3tazVqy2xsfujPop2W9fqAXnIVEc1sE2MzLDkI6br
         ThXD7W6dcf4+cjax5CYLroIzzeIvnQnEznPGXwC2rc2hc9BgNcC1KYb2L0s7tHQ+Jmys
         g/ZBD/K5oPKdLc7RxAgzQbJ9aWFZ5x/SaEwflY9vP27ASVUsMBg/9EA4oSQSCFc39SUJ
         6AUw==
X-Gm-Message-State: AHPjjUhpbUyVnOcgG3pHzN7EYwFuvdvfHR2FKqLwWo8FqlB6vllfaCYc
        HCqdS7A3XLGM3E6uZ8IZt0CKtDm4PQUX
X-Google-Smtp-Source: ADKCNb79SuvBoMQsntD8tQVBoRYpIIBJYPLwkjYtMAtHPjdTSafLyJ/BrzpfOuhHwQcMpcqMjX4Ja/O4NSGfyIz0e34=
X-Received: by 10.13.251.132 with SMTP id l126mr357859ywf.175.1504812601909;
 Thu, 07 Sep 2017 12:30:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.116.7 with HTTP; Thu, 7 Sep 2017 12:30:01 -0700 (PDT)
In-Reply-To: <CAJrPYn8_n1JD3hL1LSAVz2Khs=dZRVaZ-gpru5AV+ottv5WfAw@mail.gmail.com>
References: <CAJrPYn8_n1JD3hL1LSAVz2Khs=dZRVaZ-gpru5AV+ottv5WfAw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 7 Sep 2017 12:30:01 -0700
Message-ID: <CAGZ79kZAeCERKn6he2LzAj97BXEJ5U+Fy4sorAPNmW_XaCS9Vg@mail.gmail.com>
Subject: Re: "git shortlog -sn --follow -- <path>" counts all commits to
 entire repo
To:     =?UTF-8?B?0JLQsNC70LXQvdGC0LjQvQ==?= <valiko.ua@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 7, 2017 at 11:13 AM, =D0=92=D0=B0=D0=BB=D0=B5=D0=BD=D1=82=D0=B8=
=D0=BD <valiko.ua@gmail.com> wrote:
> Hi,
>
> I'll be short as shortlog :)
>
> "git shortlog -sn -- <path>"
> counts all commits to the specified path, as expected.
>
> "git shortlog -sn --follow -- <path>"
> counts all commits to the entire repo, which looks like a bug.
>
> "--follow" switch is not listed on
> https://git-scm.com/docs/git-shortlog so maybe it's not supported. In
> this case I would expect error message.
>
> Tried the following versions:
> "git version 2.14.1.windows.1" on Windows 7
> "git version 2.7.4" on Ubuntu 16.04

The shortlog takes most (all?) options that git-log
does, e.g. in git.git:

    $ git shortlog -sne --author=3DPeter

    74  Peter Krefting <peter@softwolves.pp.se>
    43  H. Peter Anvin <hpa@zytor.com>
    23  Peter Eriksen <s022018@student.dtu.dk>
     7  Peter Hagervall <hager@cs.umu.se>
     6  Peter Collingbourne <peter@pcc.me.uk>
     4  Peter Baumann <waste.manager@gmx.de>
     3  Peter Oberndorfer <kumbayo84@arcor.de>
     3  Peter Valdemar M=C3=B8rch <peter@morch.com>
     2  Peter Colberg <peter@colberg.org>
     2  Peter Eisentraut <peter@eisentraut.org>
     2  Peter Harris <git@peter.is-a-geek.org>
     2  Peter van der Does <peter@avirtualhome.com>
     1  Peter Hutterer <peter.hutterer@who-t.net>
     1  Peter Law <PeterJCLaw@gmail.com>
     1  Peter Stuge <peter@stuge.se>
     1  Peter Wu <lekensteyn@gmail.com>
     1  Peter van Zetten <peter.van.zetten@cgi.com>

Maybe we'd to state in the man page explicitly that
shortlog is part of the log family hence taking all
log related options.

Thanks,
Stefan
