Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 544FD1F404
	for <e@80x24.org>; Mon, 17 Sep 2018 22:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbeIREXg (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Sep 2018 00:23:36 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:36732 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728720AbeIREXg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Sep 2018 00:23:36 -0400
Received: by mail-wm1-f48.google.com with SMTP id j192-v6so421574wmj.1
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 15:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=JuIWHN76CtsfMqmpUKuv+3yPWs/CyvyTg8fjxQqXrO8=;
        b=MsvMXWtnO8EaaSeehfgIWTcsGW14BedB+R3gTfjnmWxb84ar7m2chEXcJNae02Osl0
         i+4EVoguOf3VLRe/pr22wdyAXUksPv2NeiwREOMX8Y/6u0+eNTXNqW4iECYimOPyIt+u
         DO3i3vbKrnLD/A3kDnUXm41ru8qp1PY2W2o6ozcigMevDSwapi3bQ+wbf5o+Gjf0dvYl
         6iutAkRbZ9zug5RZI8Sx6BjurJBxQRnEsKnNZyt5z/dStEnluTwUgtDQguWEmljVNqse
         aThWL5qqcmkfrmXMfEVGEN4vhGReocarNH8vCRoVrBx0q1bcrFayjTkxx6ySYF8qaQ1O
         27Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=JuIWHN76CtsfMqmpUKuv+3yPWs/CyvyTg8fjxQqXrO8=;
        b=JHWjpoPPiT62mAnM80t8ZMUffbFgZRuk8IfNs/QhVGlSSWLocIiuXupwHgwSzJAwQb
         g3hwWU3lLjL6Yr8MtWo2RRJ1xA1Jh1SYyPKWk64djY+rpKAeDbvK4imbqk2VlZKA2fqk
         GBZoH5UnALvfZMMkx6/VHCjZScrjV+ED82HLdAEoLXlqMuJnxZrpC3bSbLgkH5dd51gX
         RkddC43FlKuDP/bJ4OlI5aC+1uVwzvpLPLF/cRsN2GQw5vHrEKg1YRX3qDAQOFYxFZqJ
         WnJZ9XoFQtZCRr/+uwmebeg9d6Wle9PVpFBuPvFv0OtkY5epTk6MzTAqGpBdilgUVI03
         Dm1g==
X-Gm-Message-State: APzg51B8hE8fEeVRRzVpAiKcpi2WCJlsMrnGdsk0M49H5UGXCszQtQ8Z
        W4e2QCLgOJZSkRkeD2r6STgPWqWo
X-Google-Smtp-Source: ANB0VdYoTp7MLhmmi8nCACyqKp7H4ZHH9uxTVC9UTOrxlC/Ezg/ttR3YMNqvlklYP92su5l4lckgQQ==
X-Received: by 2002:a1c:c7c3:: with SMTP id x186-v6mr13135021wmf.109.1537224849603;
        Mon, 17 Sep 2018 15:54:09 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h82-v6sm264129wme.11.2018.09.17.15.54.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 15:54:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2018, #03; Fri, 14)
References: <xmqqy3c3agkr.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 17 Sep 2018 15:54:08 -0700
In-Reply-To: <xmqqy3c3agkr.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 14 Sep 2018 14:56:36 -0700")
Message-ID: <xmqq36u768hb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> The tip of 'next' hasn't been rewound yet, but the states of many
> topics that were marked to "Cook in 'next'" read "Will merge to
> 'master'" now.  I'll probably start merging a handful of topics that
> have been in 'next' down to 'master' tonight (they appear at the
> bottom of "log --first-parent master..pu" output).

A bunch of topics have been merged to 'master' and also to 'next'
with today's update.  The tip of 'next' hasn't been rewound.  I am
hoping that we can thin down the difference between 'master' and
'next' by merging a bit more topic from 'next' to 'master' without
adding more topics to 'next' for a week or so, and then rebuild
'next' at the end of that period, and then start to accept more
topics to 'next'.
