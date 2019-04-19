Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A49520248
	for <e@80x24.org>; Fri, 19 Apr 2019 19:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfDSTHi (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Apr 2019 15:07:38 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38364 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfDSTHh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Apr 2019 15:07:37 -0400
Received: by mail-wm1-f65.google.com with SMTP id w15so7287191wmc.3
        for <git@vger.kernel.org>; Fri, 19 Apr 2019 12:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=pYmoMUz7gMz/+stpJiI6Ltf0+tG8T7xGkHn+u7jvaoU=;
        b=gD1uJnNj6yGZXOKg/In2rrzti9YkA7OlmVss7TFtPoMTGHQ3z4GKsBUGMDJ56tGSou
         mCxAUx1Gqp80yPKZzHawlwGHqqh8sOQR6MUjsO1xmZb/HFszNqpOo3s4/R1aZP+goaes
         JDTUSs0YApyw+nVxOX821KrHdDV2+gKV7+vXYbiDcpnK0FEtXUYgv3+3ZujxFiJgjtge
         w5Yv/wepTP21i3mUN+TD8TlDTWYwZl4Vnkh3Is6Bm1YlkTvF+qFJWQps2q8u95l/hYXP
         vJTIPF8ieVY6hMJZV1mChiA7/P0qqEFte+SvhMNbc0ZB1MxQuhXivuj6l1Nh4UphUzd3
         c9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=pYmoMUz7gMz/+stpJiI6Ltf0+tG8T7xGkHn+u7jvaoU=;
        b=Ibf5b7ZOJdrs9AZFHNLZpUxnbQkadfmNNbjyCHh9E9ZeSyylNsL298abgejbKmDpjn
         CyMd1Ch9BEvqSkcWHel9/0xhcddKK8Vdd3AiUbuMhmWREnFL4+RcXJY0qGp4r0snED5e
         PrVUjgdc+e/bv+7wM3oOy5QjRkKPXFV8KQVwenG3IttefYe8heVQp12qzMu9R1XFPPiw
         vdzmOkikKiFw7X6/m3aibkfEOb14+CptkQjDuF7bPLdIdx/pG213KlRCin9clOVkG2KT
         tbNosVBpIw/sFT1QVhOglyglMxHAEISY3km++/QKfoZBwUhFYfq9iBZX6+8xwuabKP53
         SsDA==
X-Gm-Message-State: APjAAAXF1nPwcLplWv+agIlvxQ2Ia4Fd1l23AI7T+m9HKnNn3/93GqV1
        MLeu4Txf4XlIzekUZpHpfsNuGgF9c3c=
X-Google-Smtp-Source: APXvYqxpFUDULCuvj/q+JlmdG9J69F/iE+eWQ/R8MGJhKuSzmUNXue0n8RJX79gXDisoQfdDtlOGUg==
X-Received: by 2002:a1c:7dd7:: with SMTP id y206mr1168988wmc.81.1555649166177;
        Thu, 18 Apr 2019 21:46:06 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id w12sm6869661wrg.29.2019.04.18.21.46.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 21:46:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
Cc:     BOMPARD CORENTIN p1603631 <corentin.bompard@etu.univ-lyon1.fr>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        BERBEZIER NATHAN p1601409 <nathan.berbezier@etu.univ-lyon1.fr>,
        CHABANNE PABLO p1602176 <pablo.chabanne@etu.univ-lyon1.fr>
Subject: Re: [PATCH] [WIP/RFC] add git pull and git fetch --set-upstream
References: <20190409125205.13754-1-corentin.bompard@etu.univ-lyon1.fr>
        <20190417160138.6114-1-corentin.bompard@etu.univ-lyon1.fr>
        <36559daca9d84f7a91933add734020cd@BPMBX2013-01.univ-lyon1.fr>
        <86h8av7ian.fsf@univ-lyon1.fr>
Date:   Fri, 19 Apr 2019 13:46:04 +0900
In-Reply-To: <86h8av7ian.fsf@univ-lyon1.fr> (Matthieu Moy's message of "Thu,
        18 Apr 2019 11:51:28 +0200")
Message-ID: <xmqqwojqeh6b.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthieu Moy <Matthieu.Moy@univ-lyon1.fr> writes:

> -u::
> --set-upstream::
> 	For every branch that is up to date or successfully pushed, add
> 	upstream (tracking) reference, used by argument-less
> 	linkgit:git-pull[1] and other commands. For more information,
> 	see `branch.<name>.merge` in linkgit:git-config[1].
>
> Probably the reasoning was to make a symmetry between "git push
> --set-upstream", which mentions "pull" in the doc, and the new "git pull
> --set-upstream". However, I do not think there should be such symmetry:

Yeah, if "git push --set-upstream" affects the settings that is used
by "git pull", then the above description is good.  Does this new
"git pull --set-upstream" affect the settings used by "git push"?  I
somehow did not think so.  It records the remote and branch used by
this particular "git pull" invocation in branch.<name>.{remote,merge}
for use by future uses of "git pull", right?

