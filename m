Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,PI_EMPTY_SUBJ,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25F3F1F404
	for <e@80x24.org>; Tue, 27 Feb 2018 01:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751514AbeB0BSl (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 20:18:41 -0500
Received: from mail-qt0-f178.google.com ([209.85.216.178]:45215 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751445AbeB0BSk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 20:18:40 -0500
Received: by mail-qt0-f178.google.com with SMTP id v90so21235321qte.12
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 17:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Fxb7+TV4UW/5tqdcPgpa62fxARJebFG5dulcyLi9wbw=;
        b=OL3qFLoxDxN7CF22mNN+fFP3rAhBWBaoyDVZM0cOslk89qmY/htFJKDeMG3e/INYBZ
         Z9slaSzBIl5QQbodvvoTEGo0SMse6CJpyQP9crkv3KO4GLy1MYLYR1w7SkzUuysBQoJf
         GjxOGKbk1mowqCQCONLI15INZIApZFbZxmv/KNymfgrVQ0ZUiMmg2Nr06ESB5XmBf/It
         c+OGLDFZ3ksVsUhxe2+UG62yxf5X4gVTknNbDaj772bzp2S7jSSeEdj/GYJOijT9hKDn
         JNqA/TKI7Z5TRVDAKRwUEEQ8v53JDstvqsnlrcI1svZofpNbpw5nThZ1sofUVM6bBn0B
         AX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Fxb7+TV4UW/5tqdcPgpa62fxARJebFG5dulcyLi9wbw=;
        b=DNcoeXjmd9Q7+fnfSDzf7aKLUuXMMfMSYGctroj2fwfdOagCC3lu4EAlLevvKNzl05
         +lEtbxCPI1+5OU0Q+DHF82UakW1OQt4BZJkxjzp2mWl68UZkQca6NVhj0OGeVu85cZSG
         mMSkq2JoC2CMbdLTbNxeMTq2KNTizPe0lemVvWFdllauCPuIPnRAoB4kv6Hxu1jftjum
         lPyfLe6xYab1X9tZrmRt//4axIWhEO67QQAXkQ3Rsf7UmM54MsZ+OJuZn52D9scI1hh3
         UtlRH76SCpdgnxWpImdyyo774f8HJHTSm+HosmiH4UGlzjYcOsJl6YHXRIt7ElgPsC+6
         Nvgw==
X-Gm-Message-State: APf1xPAwJsdvQNnJr+mzuDtz2Ao/O+vHoNnSMHNl3nsxw05T98vUz8JM
        P89LizwsTlOTi6g99bTAaMkdJVnDtSkUnSM++ZQ0EQ==
X-Google-Smtp-Source: AG47ELvqJ0CpOknDyj9Yn6yy6mPu/2FAplS0M8j6T/qWRo0pa+e13tNnSYnWckEpZK6z8uQ26NVXrvFuOw1LA17hVUw=
X-Received: by 10.200.67.7 with SMTP id z7mr4197781qtm.18.1519694320096; Mon,
 26 Feb 2018 17:18:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.55.192.147 with HTTP; Mon, 26 Feb 2018 17:18:39 -0800 (PST)
From:   Alan Gage <sergeantdestroyersc@gmail.com>
Date:   Mon, 26 Feb 2018 20:18:39 -0500
Message-ID: <CAJTBYTnA56peLi4Cb0ZEx1PtOmh8eRF45tQgE=prwF_o7FDMcA@mail.gmail.com>
Subject: 
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, I recently noticed a bug involving GitBash and Python. I was
running a function that would post the system time once every second
using a while loop but the text was only sent after the while loop
ended due to a timer I had set. Essesntially, instead of it being
entered every second into the terminal, it was entered all at once,
when the loop ended. I tried this with the Command Line, among other
things, and it worked as intended, with the text being entered every
second. This is on Windows 10 Pro with the Fall Creators Update and
the most recent version of GitBash.
