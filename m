Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EAB41F935
	for <e@80x24.org>; Fri, 23 Sep 2016 08:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757802AbcIWI0L (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Sep 2016 04:26:11 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34395 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751245AbcIWI0H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2016 04:26:07 -0400
Received: by mail-wm0-f68.google.com with SMTP id l132so1514385wmf.1
        for <git@vger.kernel.org>; Fri, 23 Sep 2016 01:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=mQWY+fEM9Q6wGo4sVdy9sONWimBKd8ueBh0lkTF/x6k=;
        b=dQwVBkHtQm+St3nYjBbz4dloTg+N6U2UsGLOyrR79jnQHRXyqMqroo/KU1a1Iq8v5L
         gyuSOCzX3RmL41RvWvUFktchYecnYpKQADoZ/prxIbcb+4zqWPMv8R2NY6XmEtWnA93R
         rPcUQ8LYLM1SPA0HKqWPiSyy4gEC4FtvAcONBZo418skFdYcUoMnc7f+D5CKMsJRuzwK
         yWlGS6iy1y5vKCbbsNNU9fl5ZbkiZs81fom5SYHn5fP+l0uUb6hOu7CE31AMpGoUlw4h
         2fiKkVNeebuTjC/w+7MjxZsdzogdSB+5aKeFmLDUbt69jYhHpq9Ld49pYKqhj2phi9yN
         3Xhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=mQWY+fEM9Q6wGo4sVdy9sONWimBKd8ueBh0lkTF/x6k=;
        b=bP5+G8g0tWUT7Ld1hs8m7utjquOTtFdiqkg0WFBnwo5pyHXaGft5FpxmKUg5vwek5q
         wZ6ZF/K6ZVgU1/6xmfwOLRwBHvQrr7jZCX6MiEe0d7fnGiXfIGZtDEHcTEkWsduTsgVr
         gkTpURZrwf/8Iu4GCBpFAMk8yXOvnmNU8SvzIlCTmAJryUQtR9bOPPrOysmuqzbqwVul
         ysdrMcaDUPY617c2wjmRHGFIc9/YA2MpCIe0Yt636bBNp02TpK8ty53FN/BfCVCvQni8
         jbXiL+a9f/LnDSxqnGxUrhIn4CajS5nBGD/GM0AfzsPuKhgIniqrY9zZkqSCb3nqVj9y
         D5IQ==
X-Gm-Message-State: AE9vXwPPeuddnhwcgdeGq4Z9fx7ObsMCqLgWPE5Fq6Vqlv/895vZZd+UFMEI5NoI0cKTwQ==
X-Received: by 10.194.19.164 with SMTP id g4mr5729468wje.110.1474619166355;
        Fri, 23 Sep 2016 01:26:06 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id w129sm1902254wmd.9.2016.09.23.01.26.04
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Sep 2016 01:26:05 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] run-command: async_exit no longer needs to be public
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <78f2bdd0-f6ad-db5c-f9f2-f90528bc4f77@ramsayjones.plus.com>
Date:   Fri, 23 Sep 2016 10:26:02 +0200
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        GIT Mailing-list <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <58164A5E-AC93-48A9-9139-B69CFB854CA8@gmail.com>
References: <78f2bdd0-f6ad-db5c-f9f2-f90528bc4f77@ramsayjones.plus.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 22 Sep 2016, at 18:56, Ramsay Jones <ramsay@ramsayjones.plus.com> =
wrote:
>=20
>=20
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>=20
> Hi Lars,
>=20
> If you need to re-roll your 'ls/filter-process' branch, could you =
please
> squash this into the relevant commit c42a4cbc ("run-command: move =
check_pipe()
> from write_or_die to run_command", 20-09-2016).
>=20
> [Note that commit 9658846c ("write_or_die: handle EPIPE in async =
threads",
> 24-02-2016) introduced async_exit() specifically for use in the =
implementation
> of check_pipe(). Now that you have moved check_pipe() into =
run-command.c,
> it no longer needs to be public.]

Hi Ramsay,

thanks for noticing this. I actually hope that I don't need another =
re-roll :-)
If I don't re-roll. Should I make a patch with this cleanup or do you
take care of it?

Thanks,
Lars

