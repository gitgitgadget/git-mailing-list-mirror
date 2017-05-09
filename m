Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 664A21FF34
	for <e@80x24.org>; Tue,  9 May 2017 04:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754223AbdEIE5H (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 00:57:07 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35495 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752232AbdEIE5H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 00:57:07 -0400
Received: by mail-pg0-f68.google.com with SMTP id i63so13493893pgd.2
        for <git@vger.kernel.org>; Mon, 08 May 2017 21:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=z+0JnLMMTOqpPCu0YCXtt0zGkV/y7YtXAw8llWb2CnY=;
        b=m7qlTQxC7H/3zffVw6RcM/V6oheyAiIKXKdruW3bWa2N4kbJ2JkRKjLI4mgZKCi4PT
         0N1x2vJ7Y4c2GtlIYaMXWkLvmL7B2vt4L9qLV+3Ab4a9M5ri935frySOpcDlUXvIrhjT
         6Canq8VAVIwqMgBn6VIil+Qz33N3DncRcp9/3tq1tmgpk+lK6YhiHUhZLvaIAF7PhIii
         VNvPeOegr9bbTEECnXHhEvp7Z/geCnRzHYTnhRupuNxSOWK8lsgJKLo70TcUax7pXfnA
         UHQ0C+bOU8bdNF5ZNDZggTOvmy8ErM3TnhX51YvdQSkgTALo9FzV0SMR284clH4ejHhU
         ksOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=z+0JnLMMTOqpPCu0YCXtt0zGkV/y7YtXAw8llWb2CnY=;
        b=GXEJJiJAgxp5ALIXvnth8D2LhEW4LjsqLcGL3Qy8B1E8EiRCl6u6jwrEXUNHcQSjhT
         YGdQ53rkMxrp82l5z+ZPmFyKPMckM6nuc8lDSxvUghsGhXx57on20StWQik/Ed9uiYq0
         e400TBuuSL/zIV30NNdjTrTRgHS9jBB2JJ30R4XmBTMliK9Nsd5il20UFYIicQKejdgl
         la4EQVySt+tTfBI15zCyctC/1QG/pR+u2dWOI/p0sEeG7+Lqx5EmiAV7HzLnVLyrBTpL
         Ebq36JLF9/zlNrwI4MgxTCmAqaYgaXjMyfrCd5GcSnIeX0md6YQtusqFSE4rKbBfWGte
         DLyA==
X-Gm-Message-State: AN3rC/6FEk1H7xP4KiPccczElM3dkKSCI9XXYypHOy5d514rBejPWPh3
        Pf2fz89v9HOtdA==
X-Received: by 10.98.11.205 with SMTP id 74mr35073906pfl.214.1494305826489;
        Mon, 08 May 2017 21:57:06 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:9133:cf19:b689:27d6])
        by smtp.gmail.com with ESMTPSA id 138sm3791843pgc.32.2017.05.08.21.57.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 08 May 2017 21:57:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Marco Paolone <marcopaolone@gmail.com>,
        Changwoo Ryu <cwryu@debian.org>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [L10N] Kickoff for Git 2.13.0 l10n round 2
References: <CANYiYbH=-AAs1s+tQ_7NiWbHCoEQWiAoavt=k=MJ1gj9aC=aSw@mail.gmail.com>
Date:   Tue, 09 May 2017 13:57:04 +0900
In-Reply-To: <CANYiYbH=-AAs1s+tQ_7NiWbHCoEQWiAoavt=k=MJ1gj9aC=aSw@mail.gmail.com>
        (Jiang Xin's message of "Fri, 5 May 2017 10:03:35 +0800")
Message-ID: <xmqq37ce4ogv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> Git v2.13.0-rc2 introduced 4 new messages, let's start round 2 for Git
> 2.13.0 l10n.
>
> You can get it from the usual place:
>
>     https://github.com/git-l10n/git-po/
>
> As how to update your XX.po and help to translate Git, please see
> "Updating a XX.po file" and other sections in “po/README" file.

What's the doneness of l10n for the upcoming release?  It would be
preferrable if I can get a "done -- pull from me now" within 16
hours or so, as I'd like to do the release at around May 10th 00:00
UTC.

Thanks everybody, as always, for your translations and general
support of the project.
