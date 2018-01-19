Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42D591F404
	for <e@80x24.org>; Fri, 19 Jan 2018 23:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754766AbeASXjf (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 18:39:35 -0500
Received: from mail-oi0-f66.google.com ([209.85.218.66]:44738 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752184AbeASXje (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 18:39:34 -0500
Received: by mail-oi0-f66.google.com with SMTP id s11so199118oih.11
        for <git@vger.kernel.org>; Fri, 19 Jan 2018 15:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GUM1t33kOjxSNyBe3xqJ6k27v6ToSkufxtk1bra7UKY=;
        b=rBYYHR1kd738aYRqwFa6a44erjjp8LIy7R3dbWnJd0r+Bp0ANF9moAnlqEquUHsf6r
         1PhU1R1hL+ns77Mz+U4hdz71eRUFk34SFw0kpei/+5z0+L5/4rqHZT3d3nu6PRgW+ZmC
         oGF0eARSo8LB56Gv+3/oiaqBZqZbRYaxGqiwdvttaDujKEBCz1UD4Ddv6CRBQQalEjMa
         k8lXCma/9bMwIOtsXiFTrtZKgbNaKoEH75IrhTd6pcJlEinIpuvkYVkRcKxxZu5aQYLa
         iKSan7wVmL/5eUwrzEDMpX6BxH3zF/s5+mGBH21Nbxcspb4sKVs5w+ydSNh5HGks7Jbs
         +zXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GUM1t33kOjxSNyBe3xqJ6k27v6ToSkufxtk1bra7UKY=;
        b=d+KWy6ZT86TwQlJUpHDGlF059+Huuaxc53XphhtJKT3Kn3kOE901KK4Rcts3c4ZBqn
         w7MNf5QxTJq0F1lBWFnLEiIIDV4eBOitUdlgs+ZCMY36lS4fMPFRHdWAjHpjkNS2IH0o
         x3f9oTViPly2UVhdgUPCEh3HDBmFXcS7NrCZ84tRzwo3jsyM7v/zteJnsjJQTFav3w2m
         aU4fzcMxs8oO9WoIk0t+RxiKD7aOZyI7y++4fnVCS/Do0uuestLrYze8lK6AFCpPX+LY
         LOaUYzcL09b5R05KJo3pqg044ZwZQwBwnIhxCF9WWbZ9+e8UsiAh4huZl8wyrwOG0nIV
         5wsg==
X-Gm-Message-State: AKwxytc5KblzYsRZ8ickYsToOu3DMqTZSmnkGb6JF+eRILZ7UsEv8+Mv
        wNMaJVknKpIcDf7aTgYg+ZzTyWT3d4Hk0isOBEk=
X-Google-Smtp-Source: AH8x227aC+WYC6eTWzayLkCyxbWUTjqVLe46snubkM/kn1yT0S1ajGjxmnQxjsl3wfEozyvBfni7tQBNJy8hkEO0DSA=
X-Received: by 10.202.195.71 with SMTP id t68mr117560oif.216.1516405173746;
 Fri, 19 Jan 2018 15:39:33 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.160.203 with HTTP; Fri, 19 Jan 2018 15:39:03 -0800 (PST)
In-Reply-To: <20180119214655.GB12074@sigill.intra.peff.net>
References: <1516067185-1087-1-git-send-email-gs051095@gmail.com> <20180119214655.GB12074@sigill.intra.peff.net>
From:   Gargi Sharma <gs051095@gmail.com>
Date:   Fri, 19 Jan 2018 23:39:03 +0000
Message-ID: <CAOCi2DE_t_ppRZjiZm6CKJByL0nErTci1D7EL5U3KeCRNMyc+Q@mail.gmail.com>
Subject: Re: [PATCH] mru: Replace mru.[ch] with list.h implementation
To:     Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 19, 2018 at 9:46 PM, Jeff King <peff@peff.net> wrote:
>
> On Mon, Jan 15, 2018 at 08:46:25PM -0500, Gargi Sharma wrote:
>
> > Replace the custom calls to mru.[ch] with calls to list.h. This patch is the
> > final step in removing the mru API completely and inlining the logic.
> >
> > Another discussion, here
> > (https://public-inbox.org/git/CAOCi2DGYQr4jFf5ObY2buyhNJeaAPQKF8tbojn2W0b18Eo+Wgw@mail.gmail.com/)
> > was on what has to be done with the next pointer of packed git type
> > inside the
> > packed_git structure. It can be removed _given_ that no one needs to
> > access the list in order and can be sent as another patch.
>
> Thanks for picking this up again. I agree that this is probably a good
> stopping point for now, as I think just combining this with the 'next'
> pointer may carry more side effects.
Agreed, hence just thought that if the discussion is started again, we
can point them
to the email thread.
>
> Aside from the braces thing that Christian mentioned (and the missing
> signoff), this all looks good to me.
Thanks, made the changes and sent a v3,

Best,
Gargi
>
> -Peff
