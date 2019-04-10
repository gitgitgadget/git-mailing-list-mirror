Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2955320248
	for <e@80x24.org>; Wed, 10 Apr 2019 19:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfDJTEl (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Apr 2019 15:04:41 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41697 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbfDJTEl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Apr 2019 15:04:41 -0400
Received: by mail-ed1-f68.google.com with SMTP id u2so3004176eds.8
        for <git@vger.kernel.org>; Wed, 10 Apr 2019 12:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=cwkUdHGBAb/o5dNhYL7y+HTtY2rviO/az6lw59f7MzE=;
        b=gp/Mx/YWsnHix9X5tpRrFY4uOmQ+ClC6zh6TZgH70b18XQpHIW1rmAE2NYoRLswIrr
         EaSquzTh6BjRBinhwjoTyqBfnvEvhrANBdEYPMNU3gruhKQSXrS6kdQRWkZD3WZ/Bp7I
         U7KrBadE//8vU816eAUVQMFikjtrTbXKqWPjSIa5ydWpGqJotKih1Nx4SM2Zz8JDqTUE
         ls2jaXRSl98PqFI9yNU8A5aDB0vAaNIGDRH1KKhNOgIfKPgLmqo1w44pCNuVD1Z+hiLh
         8E59qW4Jsoz3z9jqThjpphx3S1iZDEVXlV6tfBDb9UCURx4eH9quQgJbTPR8NjkT8eM0
         7Pxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=cwkUdHGBAb/o5dNhYL7y+HTtY2rviO/az6lw59f7MzE=;
        b=JoqIlwqeoESG3eFj6RxBP6/YV+RwC1DFbMM8GdjS7eQKKXrxZ1UnXDsAmIJ8hk4486
         NakgOJmeyvFSdDfiHNcvCa3ZXZlu7nl6eJIEvodtjvyPQWlPfSYejavx973OIB/036Mc
         xUAjF79VGo3QD1JJkjSVMt2bRilwchbqaHeBM+9dSO13wYvph8mpHzZi7Mrnt+CLSLm6
         iENd5sLESH3P8zpStEBtOwlYG0Vi6gj4zAfna0B1fgiP3KXwdQVhmfAI/2Uh6f0sGEQ5
         VlakmQD08QE+qgZXyYB2zFisd58A3yA2aE1zzTsNUjcYKZSlEUThHd/X2C6+KeRyRkBv
         Zp6A==
X-Gm-Message-State: APjAAAUXWfErp0F5VFlv5pFAW9yQIFOgtfCziwESJ7D8IyBKZwLpLr7o
        CchELzkIh9KcWlBLl0BuzTc=
X-Google-Smtp-Source: APXvYqwD1myC1DT6hkvpQJ6yf+7ER+SpsC23oFJL2Asx73SP9tta724tSXwUAQcHon+iLZs5+vKDfQ==
X-Received: by 2002:a17:906:f0f:: with SMTP id z15mr9324717eji.125.1554923079633;
        Wed, 10 Apr 2019 12:04:39 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id y12sm4239216ejo.85.2019.04.10.12.04.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 12:04:38 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Barret Rhoden <brho@google.com>
Cc:     git@vger.kernel.org, David Kastrup <dak@gnu.org>,
        Jeff King <peff@peff.net>, Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>,
        Michael Platings <michael@platin.gs>
Subject: Re: [PATCH v6 1/6] Move init_skiplist() outside of fsck
References: <20190410162409.117264-1-brho@google.com> <20190410162409.117264-2-brho@google.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190410162409.117264-2-brho@google.com>
Date:   Wed, 10 Apr 2019 21:04:37 +0200
Message-ID: <877ec1fzqy.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 10 2019, Barret Rhoden wrote:

> init_skiplist() took a file consisting of SHA-1s and comments and added
> the objects to an oidset.  This functionality is useful for other
> commands.

This change would be much easier to review if you led with a commit
where you s/Invalid SHA-1/invalid object name/ (lower-case while we're
at it), s/skip list/object name/ etc, and did that rename of the "hash"
to "name" variable if you're so inclined.

Then you'd end up with a small refactoring change that changes the tests
(or even just make the tests grep for e.g. "Could not open.*:
does-not-exist" instead), and the moving of the function would be
entirely caught by the rename detection.
