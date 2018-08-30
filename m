Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37EC41F404
	for <e@80x24.org>; Thu, 30 Aug 2018 14:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729357AbeH3S2a (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 14:28:30 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36204 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729084AbeH3S2a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 14:28:30 -0400
Received: by mail-wm0-f67.google.com with SMTP id j192-v6so2250027wmj.1
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 07:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=NAo3WgB48puM9MKXcKx2cDQ0rHAQg6JYCw3eNcPUXok=;
        b=PZnBm/1REsy3zeI2zvspGp/2whARlms/Y23d2jsP3W3w5EKOBodJOibP61Tf77B4qK
         cBswPaSGKSlCOygGJRlOGAn3fQQTXNFdA6R2rwi+he544H6VEpbJ5Lc/PFj6VUh7weqi
         WRDMRaOdlGuHXN+p5MmQgwXCFI+9hM7iKfDPFCYS2KcMEnkod3jNlH2xs8t588CQCqWd
         kA6XUhCKkVnRTfnuztvR35aNSiZ4/UQ1fsfjempoJK9AuoEA1bnsSt/D806X2JcYQzeG
         CgOK2I1pzA4VohYi9AYP0h4OyqX9d5JWoEThHrL2zkwgDy5AVDFXxCdISaRz4iq87ysa
         HhTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=NAo3WgB48puM9MKXcKx2cDQ0rHAQg6JYCw3eNcPUXok=;
        b=IgEJ1IY7eW7IaZHZkHisuWGQisr+RXK8fL6O5JKSTQbYiDQl2jUEp2AhXaY49EnoQ4
         dJ4+Akr8wUlWKgyIsLPjthCaxoWvhuZKlzGFP0BnxoYA+Jbfa0vIqANKBc0QWuHcaeuy
         LSUa3zI+3jN3HUef4+0yNCoeBmuim8gPG5cPOupd8BBettRRPmGUDAOOEZXZwwRjUCLz
         oejUsXcWSuVm3eJXJ23OMSyj3Tq7jJ7zuP0zadHg1+ih/sYoGWjN8DQZFZFLF/CbypxM
         vgi6nc4rnqE6yqWxL8C5XlBtiCWUgDEmtUyng8gOZxbgVCbsWDof2JLAiHAdA6XwhJeT
         xDAA==
X-Gm-Message-State: APzg51CHILR7RN75e7gjSg8rKv3ROgETskJBqN+kASmEX/IupJzAqpOM
        m5UwsCfF45j5ECdkEeYGRcE=
X-Google-Smtp-Source: ANB0VdbxYi7MLv+7vei/hbIN1VpPZd0OqM84kdCprGInlmhrnigdrruNBoKtxvGEUPEramYAB+ncMg==
X-Received: by 2002:a7b:c086:: with SMTP id r6-v6mr1925434wmh.119.1535639163865;
        Thu, 30 Aug 2018 07:26:03 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e141-v6sm2575946wmd.32.2018.08.30.07.26.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Aug 2018 07:26:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ulrich Gemkow <ulrich.gemkow@ikr.uni-stuttgart.de>,
        git@vger.kernel.org
Subject: Re: Trivial enhancement: All commands which require an author should accept --author
References: <201808282305.29407.ulrich.gemkow@ikr.uni-stuttgart.de>
        <nycvar.QRO.7.76.6.1808291653190.71@tvgsbejvaqbjf.bet>
        <xmqqpny1at28.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1808301350340.71@tvgsbejvaqbjf.bet>
        <87r2igca0s.fsf@evledraar.gmail.com>
Date:   Thu, 30 Aug 2018 07:26:02 -0700
In-Reply-To: <87r2igca0s.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 30 Aug 2018 14:29:55 +0200")
Message-ID: <xmqq1sag7wxx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> I believe the "official" way, such as it is, is you just put
> #leftoverbits in your E-Mail, then search the list archives,
> e.g. https://public-inbox.org/git/?q=%23leftoverbits

I think that technique has been around long enough to be called a
recognised way, but I do not think it is "the" official way.  It is
one of the efforts to allow us remember what we might want to work
on, and focuses on not wasting too much efforts in curating.
Another effort to allow us remember is http://crbug.com/git that is
run by Jonathan Nieder.

Anybody can participate in curating the latter.  The former is
uncurated and deliberately kept informal, but will stay a usable way
until clueless people catch up with the practice and mark any random
garbage they come up with with the marking word.  I myself try to
refrain from using it when I raise the idea/issue for the first time
to avoid "ah, it turns out that it is not such a great idea after
thinking about it for a while"--rather I try to limit my use to my
responses as a reaction to somebody else's idea/issue.  That way, I
can make sure that messages with the marking word from me has idea
supported by at least two people, one of which is known to me to
have a good taste, so mailing list search "from:me #leftoverbits"
would stay meaningful.


