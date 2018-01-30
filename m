Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B563C1F404
	for <e@80x24.org>; Tue, 30 Jan 2018 20:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751541AbeA3UT7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 15:19:59 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38878 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751296AbeA3UT6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 15:19:58 -0500
Received: by mail-wr0-f194.google.com with SMTP id t94so1061776wrc.5
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 12:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=sZh+L9+KurMO5YD/EftvAvy2QHtK+waV4PRnBCZOf4Y=;
        b=Kyz+vdkrqm6652wrfDf3IoXG+JHn4SKYRlMYbHf86Far4z8jhzZw09/gsC2dSnjzne
         evSWAaNsc7qPwhqly1lz4m4+4SsXB2oKq1J+4gxo9zsK/HQHgnSr+i1d8oLMIcDtG4Fw
         KWgGhdUnl/droLAiiD2r7SkS0WCcW7j6TWEUf9QQoOUSi0WfDoH/j1map7+2mypS8RB+
         YfYTAgORG4NSWMyINGlRxSMX5X1Xa9sER2Gin14xIJCTL5/Zenkt8QWmW0U0DJot/msj
         w0zypM+vj8Mubw1NxwycdCp+TO+JXGWOJ8mdD/SDKBs+WqVu69rTjzih4A2YzpUhDRQk
         0GYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=sZh+L9+KurMO5YD/EftvAvy2QHtK+waV4PRnBCZOf4Y=;
        b=XAVpipKhz6Xvq/q6jyredSIBkK+3KCNKu9AoZ7JegwRoQCZBZrgxU7xO/4blxUxKyj
         o5wo1I+Yrsf269jjnj+FTDmcqNMFsKCZYiS3raOmm44pQFkoc4EM6glddffPr7Le3RNZ
         WM+4J+AUBeXKshUM3jTXQvB8wH8trpJOeRXhl7nk9XlwEIDRMzsj3+jdmd7GaU8Hxrph
         b1pDcGEA2VgPSbqZhywcdK2B2scPdBRoLz7FmjtnHv2sAvru+oDb1xyowIwxkt5LaUVv
         EN+AOb5TldHwcJr0FMP85Qckr2qH3MBkFT6FrwZaHtsHu7B7qacFBN2s79i9aBreL/rF
         N6Qg==
X-Gm-Message-State: AKwxytc2uQzW2jtJ67E1C8mzWnepAQWCJ4noY4k5XikSkNVTWGPahWVn
        DUEpYXHHWh8guQz8p6oR9j/1uQgR
X-Google-Smtp-Source: AH8x227iTjZBCB+HqsWBtQ2hkXApvmqOTpkQI+H9ke7g7Rj5KM6hFOnk9T9kMhLZ3csV5YNAP2W70Q==
X-Received: by 10.223.150.199 with SMTP id u65mr12444389wrb.137.1517343597185;
        Tue, 30 Jan 2018 12:19:57 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id d125sm20443441wmc.47.2018.01.30.12.19.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Jan 2018 12:19:56 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/2] Add "git rebase --show-patch"
References: <20180126095520.919-1-pclouds@gmail.com>
        <nycvar.QRO.7.76.6.1801291609060.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <CACsJy8AH+xg3AB3qaqnFud4B8HHeyaO=8DqHL+p4HTTeSx6uYg@mail.gmail.com>
        <nycvar.QRO.7.76.6.1801301331410.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Tue, 30 Jan 2018 12:19:55 -0800
In-Reply-To: <nycvar.QRO.7.76.6.1801301331410.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Tue, 30 Jan 2018 13:32:55 +0100
        (STD)")
Message-ID: <xmqqshant7ys.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The pseudo ref certainly has an appeal. For people very familiar with
> Git's peculiarities such as FETCH_HEAD. Such as myself.
>
> For users, it is probably substantially worse an experience than having a
> cmdmode like --show-patch in the very command they were just running.

I tend to agree with that assessment.  FETCH_HEAD was a required
mechanism for commands in the toolchain to communicate and wasn't
meant as a mechanism for end-users.  I do not think it is a good 
idea to add to the pile to these special files the users would need
to look at, when we do not need to.  

Even if the internal implementation uses such a file, wrapping it
with a documented command mode would make a better UI.




