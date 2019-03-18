Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBAAD20248
	for <e@80x24.org>; Mon, 18 Mar 2019 05:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbfCRFhn (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 01:37:43 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34189 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbfCRFhn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 01:37:43 -0400
Received: by mail-wr1-f67.google.com with SMTP id k1so15048021wre.1
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 22:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=kcSV4N2Wd/kUVtZoumTxXukoOC2Q5cAeeMN+d6qmUXQ=;
        b=qW2JV7wrSHpG0vrN3XFemLip8cMT9ldOy48qrdccjMOWgOk7j6JM6NpZRCgWk0SNE2
         385j5cCl6QScDREIBTOvmfMglejXQ9Kevuz+nnx1sG0uzvCJk+5AE3NT1A236tWg9usX
         fNed4TzRgfAiEfwMuSRediMF+NXdXWOrB82qdX/z2rXjYv5L3YOqxCCo+zIa1kiCt0CJ
         iOFcyIwWrUitZJXQ13vPnQFRRKnxaBvVQESH1jBrtdFZSE4sxClwYk9Iy23/42xWQrgl
         GEsf/tZoHbhkj6orc7RKu0lG8HGo/gNe9X9Pa/TYyf+3q5ogjHjqSL2oi1Zzja7HRPFm
         d/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=kcSV4N2Wd/kUVtZoumTxXukoOC2Q5cAeeMN+d6qmUXQ=;
        b=NZkd4sFlXSnfDtobHdOlE4xniK44r0OR1o1wi6gFL44fcX7eJ/y+fKTWXxrmy+y30x
         OZCxwwr8a5qhpT7VTCdEEOwEjFe/SxxxLlcauGlJNTpisoS57xpMQ8mMbVxK87CaYxJ3
         /yRE9pZltAizUTotWEQGz+GLcJY6l2aUDppuoL/f77ywmpiVP18W2YhXgFRX5maoO2G9
         NdkgrV9Fq1mFox1pvEwRcUKlcSPoYqWI55doM215jmSvoVKNNQ/KoLMGKfYxiq8xgYd5
         7uFLlamlF0oyBHu63J37WcLZumVQ9+OhLNE1U14V5PMybXoikA2UArS1FCx0Aa84VJ3g
         nC+g==
X-Gm-Message-State: APjAAAWHqV8Y4Vdn9imOlV31kbPxeHXSMaZMl2h0shckvg2hjL2XlqWD
        l9UieKBspPfG4uAn/yE8VCM=
X-Google-Smtp-Source: APXvYqztMmn0GDke3ylkoZlr6xnecL+I93pnBfDJPUgjDN01U4yZISlParf802of+RBX4eu/bi7egQ==
X-Received: by 2002:adf:e40b:: with SMTP id g11mr556648wrm.207.1552887461338;
        Sun, 17 Mar 2019 22:37:41 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id g8sm3830432wro.77.2019.03.17.22.37.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Mar 2019 22:37:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fix pack protocol example client/server communication
References: <20190316085707.4151-1-mh@glandium.org>
Date:   Mon, 18 Mar 2019 14:37:40 +0900
In-Reply-To: <20190316085707.4151-1-mh@glandium.org> (Mike Hommey's message of
        "Sat, 16 Mar 2019 17:57:07 +0900")
Message-ID: <xmqqimwg4uaj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mike Hommey <mh@glandium.org> writes:

> The pkt-line formatted lines contained the wrong pkt-len.

Wow.

>
> Signed-off-by: Mike Hommey <mh@glandium.org>
> ---
>  Documentation/technical/pack-protocol.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
> index 7a2375a55d..c73e72de0e 100644
> --- a/Documentation/technical/pack-protocol.txt
> +++ b/Documentation/technical/pack-protocol.txt
> @@ -657,14 +657,14 @@ can be rejected.
>  An example client/server communication might look like this:
>  
>  ----
> -   S: 007c74730d410fcb6603ace96f1dc55ea6196122532d refs/heads/local\0report-status delete-refs ofs-delta\n
> +   S: 006274730d410fcb6603ace96f1dc55ea6196122532d refs/heads/local\0report-status delete-refs ofs-delta\n

This miscounts from the very beginning.  I am not sure where the
mistake came from originally.

>     S: 003e7d1665144a3a975c05f1f43902ddaf084e784dbe refs/heads/debug\n
>     S: 003f74730d410fcb6603ace96f1dc55ea6196122532d refs/heads/master\n
> -   S: 003f74730d410fcb6603ace96f1dc55ea6196122532d refs/heads/team\n
> +   S: 003d74730d410fcb6603ace96f1dc55ea6196122532d refs/heads/team\n

This too miscounts from the very beginning of this content; it is
likely that it was copied and pasted from the line above, which does
have a correct bytecount.

>     S: 0000
>  
> -   C: 003e7d1665144a3a975c05f1f43902ddaf084e784dbe 74730d410fcb6603ace96f1dc55ea6196122532d refs/heads/debug\n
> -   C: 003e74730d410fcb6603ace96f1dc55ea6196122532d 5a3f6be755bbb7deae50065988cbfa1ffa9ab68a refs/heads/master\n

These are likely copy-and-paste from the above ;-)

> +   C: 00677d1665144a3a975c05f1f43902ddaf084e784dbe 74730d410fcb6603ace96f1dc55ea6196122532d refs/heads/debug\n
> +   C: 006874730d410fcb6603ace96f1dc55ea6196122532d 5a3f6be755bbb7deae50065988cbfa1ffa9ab68a refs/heads/master\n

I counted these myself before applying, and they look correct ;-)

Thanks.

>     C: 0000
>     C: [PACKDATA]
