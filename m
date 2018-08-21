Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3147C1F954
	for <e@80x24.org>; Tue, 21 Aug 2018 00:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbeHUDyR (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 23:54:17 -0400
Received: from mail-yb0-f175.google.com ([209.85.213.175]:38694 "EHLO
        mail-yb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbeHUDyR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 23:54:17 -0400
Received: by mail-yb0-f175.google.com with SMTP id c1-v6so3679397ybq.5
        for <git@vger.kernel.org>; Mon, 20 Aug 2018 17:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1DkfnG2I/51vLH6P1o2oSR0abyGLkOi7C6biFDJfWmk=;
        b=uB3hilBv2SOLrZXbATaY7b/ek8AFkuZGXoh2Cl347MQXm5wTYwFOvDhbryuNlXo4BP
         PbE+L4CgirEbJBzZfijnzp6ntkmzbzVN2Wk8zEro0BzSCoGgc107wVquEo0prM8uoR25
         yDQDYxXM7pPsdKlTz9nChIBWan43GDzJhquZUN620Ert19EpnOoWzQZebCjSC4ZtIpcO
         Q4afOwAvdg9qYi4dYG4nBo/P592LI/kqtU9XceIXM80ad1pEjORk5TrUz7LEmykT5a3Y
         BBYNh0T3DI8POiBRcTtfqcJGPLW6ty6epwTyzcquXixWlGwKg9t3RIsDpkH+72FRkSr3
         UfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1DkfnG2I/51vLH6P1o2oSR0abyGLkOi7C6biFDJfWmk=;
        b=BA4+5UztuuetdbaMjjE0C0KX+1U4Mninw7RVX4R/o3+76Rgw2y9xyELERy09VueS1k
         nZHZYyr+ggHREKgh6t+jvXuak7LDcLQRyYSnOYsKoWi580cChTGoatdWMDNeLDiMxIDs
         R/rE+7FgJqv2tJzSneS2YG8JSF3sBOA6XZR94OBPnAbO+l8jF31ivNlY3V8MzOQWFgLQ
         NvPLhy4thOrnaNCIjX4auVpj7B7rkCDyJSOrYIEXsgOJ141ZSjnPfDtY99praQcp5Y2+
         NkJ9qNsAEi1jBTkSaDduQC/6+p27bqGhSixTVmi8DdcroCutjBiZQTb+6HhWNe7BDHjI
         PhSw==
X-Gm-Message-State: AOUpUlEOtuA5cOmO9RffmUvjouAZqUxD/x47beaLKtHqAhv/BZuWOX/f
        C1Yj5PfLRyxokLoQbIWve/iO+naPQfNz5Pb1mgvDRjlSybU=
X-Google-Smtp-Source: AA+uWPxaTNe9uzwG83V5oEqlI6Alc/wTeXaW88Y80rS0Tsww33FTPU5wWiNQ+zDRKBWTKlUayRACK0DQBhWoTYxDIok=
X-Received: by 2002:a25:41c3:: with SMTP id o186-v6mr10177683yba.493.1534811786355;
 Mon, 20 Aug 2018 17:36:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1534374650.git.matvore@google.com> <5d3b4e4acb73009e4cefecd0965fe5dd371efea1.1534374650.git.matvore@google.com>
 <CACsJy8AE+MwBzzUFRGLKVp6vaAg2W_KO-qbUU2LQpd=rMQw2sA@mail.gmail.com>
 <cover.1533854545.git.matvore@google.com> <msg.1534770125.matvore@google.com>
 <CAGZ79kZfNeWnZEnX4Z0hMShxZZEsB2jYJ67JgE7F_d-3ymHi+A@mail.gmail.com> <CAMfpvh+7NoOGAmypGSCAtxH7DxHTvVB8_C3OkWNC14+c3MBO4A@mail.gmail.com>
In-Reply-To: <CAMfpvh+7NoOGAmypGSCAtxH7DxHTvVB8_C3OkWNC14+c3MBO4A@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 20 Aug 2018 17:36:15 -0700
Message-ID: <CAGZ79kaR7WARYFOGw8p=B4v9hPyZJ71529y-V0cnB-_tnLiEXw@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] list-objects-filter: implement filter tree:0
To:     Matthew DeVore <matvore@google.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, git <git@vger.kernel.org>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff King <peff@peff.net>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> At the risk of going on a tangent, I assumed this was because enums
> are really ints, and the "default" is there in case the enum somehow
> got assigned to an int without a corresponding value. Either because
> of a cast from an int that was out-of-range, or new values that were
> obtained from arithmetic or bitwise operations on the declared enum
> values, which created undeclared values.

See
374166cb381 (grep: catch a missing enum in switch statement, 2017-05-25)
or a bit date, but nevertheless an interesting read:
b8527d5fa61 (wt-status: fix possible use of uninitialized variable, 2013-03-21)

...compilers these days are just too smart to reason about them :-)
