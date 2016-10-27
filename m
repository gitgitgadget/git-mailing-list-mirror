Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39F0020193
	for <e@80x24.org>; Thu, 27 Oct 2016 23:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034012AbcJ0XoQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 19:44:16 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36159 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030644AbcJ0XoQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 19:44:16 -0400
Received: by mail-oi0-f66.google.com with SMTP id e12so7243659oib.3
        for <git@vger.kernel.org>; Thu, 27 Oct 2016 16:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=sAiGQcmMUA4+1AnpuCfu790jLzmRn0MqPVDSfcFQXHs=;
        b=kU5zhtwLRifrJFJgzheMr5cHGYUNCIalA9tTOvrLfVKGBWXROcQaKDvmjNI90+58xf
         IKHv1HPvXUbVNy5booaznaxEBRiazI0g8qdSU8Bv7KXVFq1qy/2mFQPrMpaCDMz1DV0P
         GMKslRnXbw8hF7fxfjgzlV0s+tu8LmUcPHyS7e5Oju4lktR6DtzvJWOJPdszyOtiQH6N
         BTOlFvqpavKPN6CcEnTSGFHMcC3rBwcQw5akcKvMasBlTjbigMFQP0MyTfiYyeE5pJ6Z
         Dd53SMeuYAbBkK+qVzZLMG0ttjtbsr8QOppTDAFdWHPSDUpsCYYWwxgrIjNVHE7iwyqg
         lH7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=sAiGQcmMUA4+1AnpuCfu790jLzmRn0MqPVDSfcFQXHs=;
        b=hV6H2kL2gjh7a1dckfUcLsLEVd8RjnjmH304IA4KDB4CqYp26LYkj8sJ9E11jkQu9t
         W0QZobGYMUQFc46C7fFUvvFK2Sjz5xFTL/Sosuo2s09AccJlN6d1dS3RUjbm+n/lGF1S
         J5SjwKEpEt53M919Ug7LyQUiLHwHCn3uqdBiyAqQQbr+RUU+p5jc7DH4V+bxDoVXNCAS
         rfOmn/NUZhyawSrU95vG3/t5/MhFjvbz4oixoYd5eJW+r9Lg/TpEaDr/LJUhr5zkobCp
         tUoJPvzwNnsAZsieRUuvcihU5TamQq3e20eFnjH/z824+4Ls6lnsMvV+Q/85IePGDzZP
         sNCQ==
X-Gm-Message-State: ABUngvdmI5OPX55/GURd6F3C/rFR3L5+znT+itvViky9el09UawFL+QpZd1Wve/3dLP7MmNHsjP5mwjvooyBHg==
X-Received: by 10.157.39.2 with SMTP id r2mr8619446ota.103.1477611855424; Thu,
 27 Oct 2016 16:44:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.142.104 with HTTP; Thu, 27 Oct 2016 16:44:14 -0700 (PDT)
In-Reply-To: <xmqqfunh4b63.fsf@gitster.mtv.corp.google.com>
References: <alpine.DEB.2.20.1610251327050.3264@virtualbox>
 <20161025181621.4201-1-gitster@pobox.com> <20161025181621.4201-3-gitster@pobox.com>
 <20161026042555.neaxvnmggtcku5cc@sigill.intra.peff.net> <xmqqa8drcc5i.fsf@gitster.mtv.corp.google.com>
 <20161026164746.2fu57f4pji5qdtnh@sigill.intra.peff.net> <xmqqpomnatg6.fsf@gitster.mtv.corp.google.com>
 <20161026201721.2pw4slsuyhxhcwxj@sigill.intra.peff.net> <xmqqd1imbymi.fsf@gitster.mtv.corp.google.com>
 <20161027102419.dbzigj7wtr355ofh@sigill.intra.peff.net> <CA+55aFwfhFqV74s_O=GucycY9U19ysiACDqX=mK4Gf=eQ0coxQ@mail.gmail.com>
 <xmqqoa254czs.fsf@gitster.mtv.corp.google.com> <CA+55aFxTHF4BRfcrCiV1D26-be+_rPhwAV+Vq8Roz-NMpPBadg@mail.gmail.com>
 <CA+55aFxdy4maom8byH0FoBBMWx+sQB8J7uWvHOxswjiaAhSjVg@mail.gmail.com> <xmqqfunh4b63.fsf@gitster.mtv.corp.google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 27 Oct 2016 16:44:14 -0700
X-Google-Sender-Auth: OfKHbuZAC7F1BViK-3u8xwpVqDc
Message-ID: <CA+55aFw83E+zOd+z5h-CA-3NhrLjVr-anL6pubrSWttYx3zu8g@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] sha1_file: open window into packfiles with O_CLOEXEC
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 27, 2016 at 4:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Would the best endgame shape for this function be to open with
> O_NOATIME (and retry without), and then add CLOEXEC with fcntl(2)
> but ignoring an error from it, I guess?  That would be the closest
> to what we historically had, I would think.

I think that's the best model.

Note that the O_NOATIME code is very much designed to try O_NOATIME
only _once_. Because even when the kernel supports O_NOATIME, if you
have a shared object tree where you may not be the owner of all the
files, a O_NOATIME open can fail with NOPERM ("You are not allowed to
hide your accesses to this file").

This is why it uses that

    static unsigned int sha1_file_open_flag = O_NOATIME;

and if the O_NOATIME open ever fails (and the no-O_NOATIME open
succeeds), it clears that flag. Exactly so that it will *not* end up
in some kind of "let's open and fail and re-open" loop. It's designed
to fail once.

Or at least that's how it used to be originally. This code has
obviously changed since that early design. Now it seems to clear it
for any non-ENOENT error. Which looks fine too.

          Linus
