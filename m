Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D0FA1F42D
	for <e@80x24.org>; Thu, 22 Mar 2018 10:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754084AbeCVK6K (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 06:58:10 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:38554 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753353AbeCVK56 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 06:57:58 -0400
Received: by mail-oi0-f46.google.com with SMTP id c3-v6so6938918oib.5
        for <git@vger.kernel.org>; Thu, 22 Mar 2018 03:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XlrKgaEs7WYwvekfXV7yQjRbk9G0iHuWULiPKd/3+D8=;
        b=L2j/eEZnXdEpeQGh3sjBrCTrtqo02v7544cC6Kc+9N20KiIqP9xifQUsE5Udkev5Uj
         Ygc0NkxzO3rvRsYFY5tX5jgmcfYSX1uGo4wTGyWKu/GhBwv4jU9+6e6iJhhMH3xlG56s
         U2S/vwk2cx2tuNzwcYAON6xxLuXrDWDZ/tiJqwoSKjFXyOK78zfUcdRPOKsWD2VVm3G4
         7uxyKEcpS9PDGKXiRBpE5e4Vhe0HAEp0sBT62aMJ1pz/6JuHeTrnHdx9pSiY2jQFCXt8
         r22qkE9QEsQmPA1T7qR5gUvU2NEY3V4rRdIc1HO0mBD7G7O3+Owd5KWsm0eA3MfiMVOf
         XHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XlrKgaEs7WYwvekfXV7yQjRbk9G0iHuWULiPKd/3+D8=;
        b=qTuvBwmBdEG8/9ab2ByrH7LLeOZ51peKsiYA26Jd7UigUJ/3B22cTmeagtXMbSuRm3
         tPwAjVxANu0l8E62KJXPRgl4tA+0KL9EnMdUk/sDqYNgz8CT3UShbc0RxchjXeZOvZ68
         s8t0X7JCwvLfoN2XgmxAJp3bOK65AGCwXi3ixJDqW12S6Piy1MuNP6fPFYDMIQbmJ0IK
         kC/RGTrB3A7+aYeN+qXtSeWH/NXaFpogitBxvu2EV8rVsbVtjF6DR45GgcfKLFH+6naf
         MUQFdan1FBUCEH55/JF+2VGMHcKcgCjOyoYD8o0YUHpAYvy+vXNuTRyCiE+KKT0JQtge
         FOXQ==
X-Gm-Message-State: AElRT7H6rDs0LE5WREguN4GxdrFJAs965umkk03jidkr67JY60s6CJnZ
        0+Iqr3JJYNa6TYsvkgujjBGKb0pmFcBjxf9O3DY=
X-Google-Smtp-Source: AG47ELucDHvFVSmzFQMtzVAEDBm/AiJ8JPhchsAibnwT82j+JzobU3tSkmfqkIIhGDRH3/M/CKh/q7yKdvFu9uFuroI=
X-Received: by 10.84.79.7 with SMTP id e7mr14362777oiy.281.1521716277703; Thu,
 22 Mar 2018 03:57:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.154.146 with HTTP; Thu, 22 Mar 2018 03:57:27 -0700 (PDT)
In-Reply-To: <20180322093212.GB28907@sigill.intra.peff.net>
References: <20180317141033.21545-1-pclouds@gmail.com> <20180318142526.9378-1-pclouds@gmail.com>
 <20180321082441.GB25537@sigill.intra.peff.net> <CACsJy8DkF3TpTGKp5MdS1ApC8Yj6FOL5uAg5U__PjBAQY1vdNw@mail.gmail.com>
 <20180322093212.GB28907@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 22 Mar 2018 11:57:27 +0100
Message-ID: <CACsJy8CieaHxW-EE=3t4tdwAHoEg9+Bw3zpd+ZpROOc2k4Guxg@mail.gmail.com>
Subject: Re: [PATCH v6 00/11] nd/pack-objects-pack-struct updates
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Wong <e@80x24.org>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 22, 2018 at 10:32 AM, Jeff King <peff@peff.net> wrote:
> That would still mean you could get into a broken state for serving
> fetches, but you could at least get out of it by running "git repack".

I was puzzled by this "broken state" statement. But you were right! I
focused on the repack case and forgot about fetch/clone case. I will
probably just drop this patch for now. Then maybe revisit this some
time in fiture when I find out how to deal with this nicely.
-- 
Duy
