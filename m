Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEC00201A7
	for <e@80x24.org>; Tue, 16 May 2017 03:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750784AbdEPD1k (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 23:27:40 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:35342 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750711AbdEPD1j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 23:27:39 -0400
Received: by mail-pf0-f175.google.com with SMTP id n23so67965753pfb.2
        for <git@vger.kernel.org>; Mon, 15 May 2017 20:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=vziECPp1UQv6EK7a8Gze0CCQBGErMAt0eh+UPQIRBvs=;
        b=WnJnWPuteCvL7DQGercc+yEMq4E3AoPJuAHEagzWxIUofSzwfvmZQV0BxcEBQEpHUH
         DfRGtNufaNhNN41AGWNEjSKD8XcIrnYlud6gW/+HK2zOvPD9N45rjzt5sgbMYXRA5+kJ
         nqu1Nbo+qM7EUsSounWm2LW64FGBfnKeZpbt2GywMXFeE2iU1jQ7EYT/68I9fsUNsCuH
         xubGJ3K8r6pvT7tL/dOI/J2oEygQoI2nNV1LZ8Gh7E5GDO8Jc/gZaVLp0OBYFYX7bh3r
         ObVk0bbT+bZarIrI1Ud2uiLiRaFdfZwEWv0Jg6vZDTz2UdliuRiIAN4JOP04FnojcWsw
         jn7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=vziECPp1UQv6EK7a8Gze0CCQBGErMAt0eh+UPQIRBvs=;
        b=Dr491wiDNI55P5yFOLS978jDPuwE3TkRq060YRJ7D+kSgC/ZPT2r9+jX1HKlBnyqs3
         Lw0rd7AerdDJGPwM92nzNSLtFTdHIApjBYD6nILg9v/6EUJnPLRpjsr3u9EeqwFtLoTR
         dH3XGcYr9/V3gPJdG3nMnPnmTBJsO0IkWMkOR5+wFB7rEVPVotCCOmTV98j1u5vjPZH1
         3e8cwQZ9y8+RpY1qMO5eMMb3N612C55R903dhh+K+aky8F2HhVNGV09P4CdwNnPMbEyP
         dH8HXi6QzjwLU0gpeb7t3eAFRompHtgUt95qOdQxUWwUjQ4PqeJN2B/5Ne4iM3yWQOST
         wCCg==
X-Gm-Message-State: AODbwcCOPuuCvO9DVxUOIX5NzF8Tn8HmsnhuPAsfvSjQv7EhM0lxAhwM
        hZaFa8p/LSgi0g==
X-Received: by 10.84.232.76 with SMTP id f12mr12884955pln.101.1494905258512;
        Mon, 15 May 2017 20:27:38 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:8dc7:ff72:325b:10d7])
        by smtp.gmail.com with ESMTPSA id s68sm23007158pgc.5.2017.05.15.20.27.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 15 May 2017 20:27:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: How to force a pull to succeed?
References: <CAH8yC8k8sTGDA=C8vLCE090Y1B4TK86bOnZMNjj13C-JXVEBHQ@mail.gmail.com>
Date:   Tue, 16 May 2017 12:27:37 +0900
In-Reply-To: <CAH8yC8k8sTGDA=C8vLCE090Y1B4TK86bOnZMNjj13C-JXVEBHQ@mail.gmail.com>
        (Jeffrey Walton's message of "Mon, 15 May 2017 22:17:33 -0400")
Message-ID: <xmqq8tlx4h1y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeffrey Walton <noloader@gmail.com> writes:

> I scp'd a file to another machine for testing. The change tested OK,
> so I checked it in on the original machine.
> ...
> How do I force the pull to succeed?

Git doesn't know (or care) if you "scp"ed a file from a known to be
good place, or if you modified it in the editor.  When it notices
that there are differences you may rather not to lose in these files
(because they are different from HEAD), it refrains from touching
them.

So the way to go forward is for you to make sure that you do not
have such local changes in the repository that your "pull" is trying
to touch.  An easiest way would be to do

	git checkout HEAD -- <paths>..

before doing a "git pull" to clear the damage you caused manually
with your "scp".  
