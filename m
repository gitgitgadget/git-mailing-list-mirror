Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F1881F43C
	for <e@80x24.org>; Tue, 14 Nov 2017 20:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756492AbdKNUvl (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 15:51:41 -0500
Received: from mail-qt0-f176.google.com ([209.85.216.176]:46259 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751197AbdKNUvj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 15:51:39 -0500
Received: by mail-qt0-f176.google.com with SMTP id 1so29113886qtn.3
        for <git@vger.kernel.org>; Tue, 14 Nov 2017 12:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0dqj/5VR3cdCy8qz+w7fmgP4KhP35v6pQrmEvIYz1Cw=;
        b=gOcJ/NkCB/CZC8cHII18n5RnU5BtOGW7CgapncINqLxlzpzPpgc5ybLeypNoBd++1R
         ZDodt6gaQsUEaRroJd7D2/K+V89FovNsZ1zeg4P88fC25mzb+l9XKLjGJ853ZHSYWNu6
         tE4+sGXgb0rSB1B6W50ChMTINBUU6XHnsG4B0iw+X0PIh/4ArqP9dCP8yaCOoMip2CMH
         VITIahDqQoBfDueDxbEmCnEz+eZRdTfjl3oeZ0ciouZtIws1EoEhrad+BJQDth2qdKLF
         /OptfCFdVpu8VgRrjgXMW/RmzmrQfPaABpzOKk5WUjjmPVN9D/P8oV5wM0eSugo1DccD
         tNYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0dqj/5VR3cdCy8qz+w7fmgP4KhP35v6pQrmEvIYz1Cw=;
        b=mqZKLj9pfrADK0bJX1vDH38aM/q36gO4Re7ZJuo9S9VrQ9c9l2EWTaKctiLDMZVIPS
         I8QD6Zd026qkwMixD/lTs1XlRpXkcmsnWEh/HbLwktHXpbvmdd/wkJM2McghEN+S2Kxd
         WZowy8LXNDaAaQFDSeHI9R9Oxjkt80AHfXT7jJRFDHs8wDjlcJ9Vzwz4W4Jju7/ZKcUL
         s6cOYGVPhJjrcA5t/jEZMbhM8Ku6hvjzOAysGSWqkyinmMYQ+f1w88gWgezjJm9jifDi
         zlYjGcBdeEr5+s3BYk6lMs+7Cm/Mfezlwa4j6kMY1fEAPJr+gUFmG1ihtK4t0YI3TP1U
         +nHA==
X-Gm-Message-State: AJaThX6aXc5ZltMZE/Olu9f7Z+6F+KQeYJ1JaPf7v806YDhY9K0yTl8X
        WTpimp8lBUyMdEv/loyOfkP2aJozN0GlaXuOv0Mg8w==
X-Google-Smtp-Source: AGs4zMYTs80+7Ye2s6aN/dm8tGSp0SZhRKyCuvakq51BLwqskYrmrjRTekBnAPI2GNVXDsbWdjl5OCvkvHHqAMGGn/0=
X-Received: by 10.55.26.168 with SMTP id l40mr20872828qkh.352.1510692699042;
 Tue, 14 Nov 2017 12:51:39 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.96.118 with HTTP; Tue, 14 Nov 2017 12:51:38 -0800 (PST)
In-Reply-To: <CAGZ79kbdC8fYx503=YKBvEE62=T5WYST0QSNuQjPp5QG1cx1aw@mail.gmail.com>
References: <ABPp-BHDrw_dAESic3xK7kC3jMgKeNQuPQF69OpbVYhRkbhJsw@mail.gmail.com>
 <20171114173124.25982-1-newren@gmail.com> <CAGZ79kbdC8fYx503=YKBvEE62=T5WYST0QSNuQjPp5QG1cx1aw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 14 Nov 2017 12:51:38 -0800
Message-ID: <CAGZ79kZApzOsjns+q7mU=ta7OPd1fF7r8dWKY3GKa4sRTSMZ+w@mail.gmail.com>
Subject: Re: [PATCH] merge-recursive: Handle addition of submodule on our side
 of history
To:     Elijah Newren <newren@gmail.com>
Cc:     git <git@vger.kernel.org>, real@ispras.ru
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 14, 2017 at 10:48 AM, Stefan Beller <sbeller@google.com> wrote:

>     test_expect_success 'unrelated file/submodule conflict is ignored' '
>     (
>         cd a_repo &&
>         git checkout with_file^0 &&
>         git cherry-pick with_sub^0

This makes no sense, yet. Sorry about the noise.
I think your patch is fine as is.
