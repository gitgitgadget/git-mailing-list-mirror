Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45B0420188
	for <e@80x24.org>; Sun,  7 May 2017 23:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752541AbdEGXqW (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 May 2017 19:46:22 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35260 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752150AbdEGXqV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 May 2017 19:46:21 -0400
Received: by mail-pg0-f65.google.com with SMTP id i63so8091874pgd.2
        for <git@vger.kernel.org>; Sun, 07 May 2017 16:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=w+z+oo4ulDfgrfc2cg6rjCQcQvPRiXYISXe8rlOrtiY=;
        b=kNwwHaCpRV1p3dQ2Oy7PMqXMGFvWxxwT1OED9kaayNoxWvKMksEWX6qAEgBMVH511C
         eKyCCECrbhnYoTut9KMl61Bbfhz/4/ZhebdcegqSP0I8dFW3u+1hdYtDI2f1iaKwTSR+
         mOGzdphpM+C5sKylwm9JKzWgWCHjgy6F72D4R9ydlpXuWqXDHBbg9ewUCVetlogvaxYl
         PehL+2WLkhSd/PpqjeHYktXbGE6sr22EmCbJY78Q2yTxpRXplqHqfa5RDXGN6Gm3gbX7
         7YfuF3c+WAV0jXo0QEtY9fP3/E75cmoiGH/K4csQe84ORCuqJDKtp4FneNy79dAMCxdM
         /NsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=w+z+oo4ulDfgrfc2cg6rjCQcQvPRiXYISXe8rlOrtiY=;
        b=X03QOs6h+3npiAdBLuKeQDXLVXOkois9o50HIKNAql0gVmJynQ99v8MKY567pS+JVL
         QZv29/a3Q95K18ZkG9aw9CuYRbU3ZI2FIW/041t8BrrM5o/ztNXLdm2uwRzfNi0jHtFZ
         GXkg89LWbyPOFXmXBEDEo5HYwnGg5voqaAJqomS2NwMpWweGcF9C0nha+dDqVEL8vD3i
         6A7I2VTCTCXiZaeB0QmM3/EtBjUmtCg6eF02iV88HEsWH8kdrnypoU8jiSd4gxAjUsVG
         ixM0q0sOcuJwtJhn7pgJNtNzZHfMkHAkZu0C7SskrW7j2JjkKFd/aprCTt/D9TIFwWxi
         cy0w==
X-Gm-Message-State: AN3rC/4mrJ7KhbgcbfAacj1fE6QW8TM3Ff/oExS0Grx+trhKUmg/HjG8
        XtKnQZsfiwApEcXfJOA=
X-Received: by 10.84.232.141 with SMTP id i13mr45549635plk.143.1494126034308;
        Sat, 06 May 2017 20:00:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:503b:fcc1:2b99:f95])
        by smtp.gmail.com with ESMTPSA id n22sm8606695pfj.27.2017.05.06.20.00.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 06 May 2017 20:00:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     Samuel Lijin <sxlijin@gmail.com>,
        Jonathan Tirado <tiradojonathan32@gmail.com>,
        Jeff King <peff@peff.net>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        meta@public-inbox.org
Subject: Re: vger not relaying some of Junio's messages today?
References: <v26esrmyqyqykypjs75fx2vy.1494092763967@email.android.com>
        <CAJZjrdWYDMFHRrbeFk89p+GebLpWJBUQfnpC6w87aVh8czL5_w@mail.gmail.com>
        <20170506205041.GA26189@starla>
        <CAJZjrdXPgrSAHJPsQiW756XFK1-XyGY0skJTefczaqJpOy6yKQ@mail.gmail.com>
        <20170507010537.GA21703@starla>
Date:   Sat, 06 May 2017 20:00:32 -0700
In-Reply-To: <20170507010537.GA21703@starla> (Eric Wong's message of "Sun, 7
        May 2017 01:05:37 +0000")
Message-ID: <xmqqfugh74mn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> Samuel Lijin <sxlijin@gmail.com> wrote:
>> Sorry, should've been clearer - I did check my spambox in my original
>> message. Some old patches from Brandon were in there, but the ones I
>> mentioned in my original message just seem to have been dropped.
>
> Apparently, vger also throttles mail to gmail aggressively, so
> maybe some show up eventually:
>
> https://marc.info/?i=20170501.105057.824365162373797902.davem@davemloft.net
>

Thanks for a pointer. That does explain the symptom I saw number of
times, seeing list traffic that directly came to me hours before I
see a copy on the public list mirrors like gmane and public-inbox.

As it is a pain to access gmail inbox via imap (I was told that
something called "offline imap" may alleviate the pain, but I
haven't tried it yet), I tend to use NNTP interface to either gmane
or public-inbox almost exclusively, so like everybody else, it often
takes a message hours before I see it due to this throttling.  I do
not see the message I am responding to on public-inbox, and I am
responding to the copy I got direct from you, for example.

