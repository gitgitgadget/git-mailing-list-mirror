Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 020AC208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 16:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387407AbeHFSub (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 14:50:31 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:37508 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbeHFSua (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 14:50:30 -0400
Received: by mail-it0-f50.google.com with SMTP id h20-v6so19041250itf.2
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 09:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EdaWJMpIdzXnRgSF5doL9u2beRV6sZLduE4M9GvkXGw=;
        b=o4wxroSHCajiPRZFfkKFCqY3j9j7HCFMTwuIpwg7IlU02erSKgBe7CycYU9ZsOkhmJ
         v6dmT/TSNj9ZA+omKJiForoYZ6KG82kTSHdKW0lGsxIjYLMtb+1q/wrh2EeOujWBvl2X
         2gp+yxwKu3BDzh3gj4KX/zczjzzV+LgbWfcoTpA/FEvks2gWZIzFHVAIBJzx2yYPNMdv
         yzR+yzKluX02V8AZfL5ST3k++Heg/wNsQBHtuyht41ch8rMLW2Swrk67uYfnA0DlvkBC
         6nSImqH/2odWiWWMdP4F8UJhJ3WP8aoA6nsc6ZYiAVfaXAgOJOJAI5iCY9FHIKquiTLa
         If1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EdaWJMpIdzXnRgSF5doL9u2beRV6sZLduE4M9GvkXGw=;
        b=sfshWd4uOY1swV6BAlRJIn3BeHyxxb01ZroSpWCqHN5JQnBDZJG2wCNvdP7QC2bTRo
         8rwS92oIrATbBmKTIwTg/5qXRVUD77v8k452XOJtuQc6twi0UhGrdyCYauOe/iP2ptGB
         O0ElxRAwn153z2YVJ4hgmQBVMBCUrInK2CMRBpkQlZS3Zktr7TwqhNwTVY8De4KEG7Jj
         2osxTfOL0IYV0FyGBoRXWocKbBUy1bezrCuN+OQgJ+3nkSkMFstfDJPL++E/O3uE5x7x
         LLqbSZ7jUfMoscH6qwX44/imi+7RoiIFlhWowMBtUEEztqW8Q5Izmwo/ZaBZ4QnuLpin
         5GYA==
X-Gm-Message-State: AOUpUlGzpYcj/qhFf0o68Hj56I63XBlzqqUJd6A9OLkF/QmYzX8+QmOG
        Bknc9S2JTcoLz64kZjv0K1JbfHR+UlU4r44c7z2mHw==
X-Google-Smtp-Source: AAOMgpddBPxxuMjsTqCcBeCgpuW9APIssv8J+51OJ/FR+IYqFXiFhZj36M9fAqV7grpkbaFANtxD+eEX54wH1+jK9dI=
X-Received: by 2002:a02:891b:: with SMTP id o27-v6mr13989794jaj.23.1533573636673;
 Mon, 06 Aug 2018 09:40:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180806143313.104495-1-hanwen@google.com> <20180806143313.104495-2-hanwen@google.com>
 <xmqqsh3rpial.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqsh3rpial.fsf@gitster-ct.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 6 Aug 2018 18:40:25 +0200
Message-ID: <CAFQ2z_MOk0xx_3LrooCgtoERUtMoSM6WESKyzcxAxYm1To1crA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] config: document git config getter return value
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrn@google.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 6, 2018 at 6:32 PM Junio C Hamano <gitster@pobox.com> wrote:
> patch and queue it on its own merit (not that I think the other one
> is not yet good enough---I haven't even looked at it yet ;-).

I discovered that emacs tabify will happily also add tabs in the
middle of the line, which breaks in the case of DUMB_SUFFIX.  I can
reroll a v6 if needed, though.

--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
