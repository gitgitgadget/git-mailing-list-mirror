Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13BDB1F42D
	for <e@80x24.org>; Mon, 14 May 2018 10:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751991AbeENKU2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 06:20:28 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:40470 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751422AbeENKU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 06:20:27 -0400
Received: by mail-io0-f174.google.com with SMTP id g14-v6so14537553ioc.7
        for <git@vger.kernel.org>; Mon, 14 May 2018 03:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:subject:in-reply-to:references:mime-version
         :content-transfer-encoding:date:from:message-id;
        bh=2W6Ne7Kmu0pQS9tFKwa+VPnNJReniLo8MEiokkRkX1s=;
        b=P9U+k9rxYe7MIfziv1xnKTYNEVUOT867qhl0729b/KuLKcKeQvNDkIuc3rOHup74KC
         qFqAGxPUO4MPB+5zyCQHuY255nHGGaT6dDW8TsUEQGPXmKZLpdkmHpQ+pAqr1QgY7n94
         puzY7xQ7rZxxvR/Ax+BsCi1x1hyQ14JT6NLm3CuCy/RjQ0Zc4gLSqrZdqXZ8Umve3GVL
         2nbGQPMH+/n5nalAJoN/Um4SGhdIsc/s7clFAphVCV6WJJUGgtH2jm+XyjIGn0D+6sIH
         SwhZhrsT2MpzrZHwKYEfTRoHrXO3aoREIZPgep4iMjT+UQiHtgSxAUlJgBqP0N9SK9ay
         WyBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:from:message-id;
        bh=2W6Ne7Kmu0pQS9tFKwa+VPnNJReniLo8MEiokkRkX1s=;
        b=W4vXDbZt1fCBiMnHvzPXXGHH6RnOqTEWys9+untNUe5tk572ylMdfpPMTaSil9pixl
         N20/JMNAWhxPjKgKojG8QC8QsD7+gGMj+DIEnFmUYDK1vd69jJHZXqIlyV/dCqLppOIU
         rG2t6Nh7QxNLJZ0xTOQwqzFLWcP4m4hwcHfFxUw7tvjF/KNUzo9/yg8bKBf2EdOL0cYC
         2g2nOtFEB4XMyTVq5muZL5yTYwgLZyugHWu5v3JT0RtdZZ9qW+IX+IS5KLf0NqGcRBWE
         JHGwfdVPNPJlGGR4MKk+0IZRvOTQhhdNuClDB1lSQInHDnQQhkhwwk5LUD1sFJsQIzgJ
         E0UQ==
X-Gm-Message-State: ALKqPwfsJ3lh+/WrgHF74UdsuSSnZPAJ7BhwxjW7r7TU7NC25D6kbrnU
        IXRr4H4wbUDLgRJXqKVih/oUThx8
X-Google-Smtp-Source: AB8JxZpwTBZmdqBFxEoZTtwk6Ako+Y4GP2UCoYC3dIjye5e+CHVrWxquLTjEL/5jLrz12X3g3lD/Uw==
X-Received: by 2002:a6b:21cb:: with SMTP id h194-v6mr9289403ioh.181.1526293227154;
        Mon, 14 May 2018 03:20:27 -0700 (PDT)
Received: from lmm-notebook.localdomain (cpe-74-139-249-65.kya.res.rr.com. [74.139.249.65])
        by smtp.gmail.com with ESMTPSA id x137-v6sm3702332ite.5.2018.05.14.03.20.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 May 2018 03:20:26 -0700 (PDT)
Received: by lmm-notebook.localdomain (Postfix, from userid 1000)
        id 93A7AB0000000000EA2; Mon, 14 May 2018 06:20:24 -0400 (DST)
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>, "Ted Zlatanov" <tzz@lifelogs.com>
Subject: Re: [PATCH 2/2] git-credential-netrc: accept gpg option
In-reply-to: Your message of Thu, 10 May 2018 18:57:24 +0900
        <xmqq36yzkf3v.fsf@gitster-ct.c.googlers.com>
References: <20180509213634.5198-1-luis.marsano@gmail.com>
        <20180509213634.5198-3-luis.marsano@gmail.com>
         <xmqq36yzkf3v.fsf@gitster-ct.c.googlers.com>
X-Mailer: MH-E 8.6; GNU Mailutils 3.4; GNU Emacs 25.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 14 May 2018 06:20:24 -0400
From:   "Luis Marsano" <luis.marsano@gmail.com>
Message-ID: <20180514062024.5819@lmm-notebook.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:

> Luis Marsano <luis.marsano@gmail.com> writes:
>=20
> > git-credential-netrc was hardcoded to decrypt with 'gpg' regardless of =
the gpg.program option
> > this now uses the gpg command option if set, else, the gpg.program opti=
on set in the git repository or global configuration, else defaults to 'gpg'
> > for git-credential-netrc
>=20
> These lines are way overlong.  Wrap at around 72-78 cols, perhaps.
> Complete each sentence with a full-stop.

Thanks, corrected this in the updated patch https://public-inbox.org/git/20=
180512091728.4931-3-luis.marsano@gmail.com/.

> > - use Git.pm for repository and global option queries
> > - add -g|--gpg command option & document it in command usage
> > - test repository & command options
> > - support unicode
>=20
> There are other changes that are not explained/justified here, I
> think.
>=20
>  - Instead of ALLCAPS as a placeholder for a command line argument in
>    the help text, use <placeholder>, because doing so is better due
>    to such and such reasons.
>=20
> I think it is good to consistently do so, but it is unclear why
> ALLCAPS is bad and <placeholder> is better.  That needs to be
> explained.

Not necessarily bad, but the reason was to conform with Documentation/Codin=
gGuidelines.
The updated commit message now explains this.

>  - Replace three-dots in the help text with U+2026 to punish those
>    who are still using unicode-inapable terminal in this century.
>=20
> I do not think this part of the patch is a good idea at all, but
> perhaps I misunderstood the reason behind this change you had in
> mind (as you did not explain it in the proposed log message).

The original intent for this was semantics & accessibility: screenreaders m=
ore reliably interpret =E2=80=A6 than ... as ellipsis, and I imagine other =
assistive technology would, too.
However, after research, I've learned there are better supported ways to go=
 about it, so I'm retracting that change.

The updated patch https://public-inbox.org/git/20180512091728.4931-3-luis.m=
arsano@gmail.com/ should reflect all corrections.
Thank you for the feedback, and please let me know of further issues.
