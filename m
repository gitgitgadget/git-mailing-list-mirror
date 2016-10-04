Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 007CB207EC
	for <e@80x24.org>; Tue,  4 Oct 2016 05:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752248AbcJDFzO (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 01:55:14 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:34094 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751063AbcJDFzN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 01:55:13 -0400
Received: by mail-yb0-f194.google.com with SMTP id 191so1142518ybv.1
        for <git@vger.kernel.org>; Mon, 03 Oct 2016 22:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KRVUvZfR+I2iMxbpHNWxDtkpA+bm9sltxHjVnwJKLs8=;
        b=0kuDFWzyITs0zfFw+sKXuptIND4UCLKaYJmQVLWNRCErCtH32qBTh85hEQ6ZmsUHqo
         6bKD4PaEaYhmljhAFi0y9/IqZEu8rggNorbByTBNUIyOOicXZzw0Sp+ybJgYrp1zdzMz
         OsGXGdQDRKYniNKnfBfcb07L9QqhrKldcdatdOnV5YpvEWBLy0Dt1oNLUDU5K3cIHIoC
         L0RObf0yjJaqSXwvjym+zxsP7R/vCVGRnbxvKwjyZv8ZgaqeMXZ/LNQRpQK9pl5n5OtA
         bWAari82MfsH5LE+1oURRE0NBERPRd1wDXbUWhamYenuQAPCkMQu/6DG1IiJpVbPlsOR
         0Meg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KRVUvZfR+I2iMxbpHNWxDtkpA+bm9sltxHjVnwJKLs8=;
        b=dQAgqiU90C1B1+2WVyNRqem/+NaRr7/13ZAJLr+CN9mJ4qvcna0ssx7gzWdlqOOEOu
         dlsMFziBWrWeDXMv5P6FQCp5svPS1JartmtQ0DDX0KoJtHCIdPK1ieXWeXibVwu9KqGf
         gfznmaNpNYpTGrfLrVBi0yZjba71saAoASpWnrxbocUXdojsc3vsvZJYQIf81TKb89nJ
         Tt1+HheBoWn0eGnVGUytP09oJR7j1J6TMeohNlgngLQ+ZcievBBpjLcnLh+o1OKdKA0w
         lIU5MSlEEUXtwcbpyrKax/bXYWFIwxyloBUkVRbyR47Y2pTgX3s3rgEizD4CFdEhXsEF
         7C8A==
X-Gm-Message-State: AA6/9RmnXQf96MkxyM9HEn78bKd5pUD+WxOHMUQy18vkQgjNrjT8FKOgvP6sLa6up0Lx7+n0yVUy7PgmQxfRtQ==
X-Received: by 10.37.118.137 with SMTP id r131mr1311782ybc.57.1475560512628;
 Mon, 03 Oct 2016 22:55:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Mon, 3 Oct 2016 22:54:52 -0700 (PDT)
In-Reply-To: <20161003203408.qnakqgcninzty3sr@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net> <20161003203408.qnakqgcninzty3sr@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 3 Oct 2016 22:54:52 -0700
Message-ID: <CA+P7+xr5bhsSLwXAD0G3PFwFdojWjHAhMMfn6kcpyVFVMUJN=A@mail.gmail.com>
Subject: Re: [PATCH 05/18] t5613: do not chdir in main process
To:     Jeff King <peff@peff.net>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 3, 2016 at 1:34 PM, Jeff King <peff@peff.net> wrote:
> Our usual style when working with subdirectories is to chdir
> inside a subshell or to use "git -C", which means we do not
> have to constantly return to the main test directory. Let's
> convert this old test, which does not follow that style.
>

More obvious cleanup for this test file. Seems like a lot of
intermediate steps to get this test file into a clean state.

Thanks,
Jake
