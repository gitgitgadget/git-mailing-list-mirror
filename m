Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7738720209
	for <e@80x24.org>; Thu, 25 May 2017 05:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968162AbdEYFzR (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 01:55:17 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35529 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966247AbdEYFzP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 01:55:15 -0400
Received: by mail-pf0-f178.google.com with SMTP id n23so157096156pfb.2
        for <git@vger.kernel.org>; Wed, 24 May 2017 22:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=dSWpIX5Pt/dalA02jursEBm5Rd7XUBEWLrLXquG1kVU=;
        b=oL4J/s7wxvhAp4EPU8ul80JkPzdG+8nnHdPCE1t1I/zwf7tgmPW39/kh8TFENmvcMJ
         bbEYggRLeqMo2SuZZ5lESxEEbOoQfBlehTyV9qqotDJYLQ3rMveLX2diOBCu4+THWyNA
         tqmwTiJ0N6apztatHihpBykPomJZD91fTGWtIwnPwMq4vXe0ENO6W0Ktcun8o9x8lngX
         GPVA54Ptc85orw4YbqSgCE4GExNKnhkeCcqoZzQbJILPu11KfplrvtFG97wylTmQtfPr
         uh2ejKrWVz3WrOTA8RzgH86LT2yU5skbEjTIW69ogkNTtYEt8ufq7K8vyk1+eZ9Ji42X
         wqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=dSWpIX5Pt/dalA02jursEBm5Rd7XUBEWLrLXquG1kVU=;
        b=EUluC5/l5fkrRyIBmEG7ZhZ7I0jdTXB69IBiL6fse0oFkdNoQE8UzIzp+6jJglkDzH
         q7UJfurcUFzp3+4swxfpEI+L5Gb5/WsbO1To+dzazQ3d0uBX+Iv8LTVMgWbGDmAcJxS6
         2U6C0S35ohUqO28fCkueJNT4d/hkW7Ys4pYtNJtVu6ISo1SEnxgq/HqB6k7+88W1DBjA
         aAUamJ4Xg+UGy0A+J5fNjXK3chLXLzfRSzFiEFCROFUkt64HOCeFtgrNdqiEzbMmzfbP
         kB+zW76NruPQD+0FzOnzsyQDAdkXVqooVfyiTCJIqBOyAZpWDsYBRt0oP+RRDXCb4T4o
         J+pQ==
X-Gm-Message-State: AODbwcCGK1dG0w5yCje7ZAxw+SOvzfP36R/ina0dTUUw5rzROLOOwOOd
        dnRuJ03m/Jz/wA==
X-Received: by 10.84.217.141 with SMTP id p13mr47388722pli.59.1495691715298;
        Wed, 24 May 2017 22:55:15 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:bc81:1d63:7e7e:dfa1])
        by smtp.gmail.com with ESMTPSA id a3sm10634552pfc.26.2017.05.24.22.55.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 May 2017 22:55:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Smith <whydoubt@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 00/29] Add blame to libgit
References: <20170524051537.29978-1-whydoubt@gmail.com>
Date:   Thu, 25 May 2017 14:55:14 +0900
In-Reply-To: <20170524051537.29978-1-whydoubt@gmail.com> (Jeff Smith's message
        of "Wed, 24 May 2017 00:15:08 -0500")
Message-ID: <xmqqbmqheb0d.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Smith <whydoubt@gmail.com> writes:

> Rather than duplicate large portions of builtin/blame.c in cgit, it
> would be better to shift its core functionality into libgit.a.  The
> functionality left in builtin/blame.c mostly relates to terminal
> presentation.

This was a lot more pleasant to review compared to the last round.
I made a few small comments here and there, but I do not think there
was anything major that needs to be corrected by another round.

Thanks.
