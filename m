Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E3481F453
	for <e@80x24.org>; Tue, 16 Oct 2018 15:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbeJPW5Q (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 18:57:16 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:43711 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbeJPW5P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 18:57:15 -0400
Received: by mail-io1-f54.google.com with SMTP id y10-v6so16710490ioa.10
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 08:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3nxHtshp2oB2li1c/X4bnQdVMduE440G+44j6OegHPs=;
        b=RfSDRYs8IFEYnD/7v87r+C6R8oPCAhCqYNfmkgImaMa9wLePo+QWDLzKvNVqfmrprd
         BwWyy0lI4hkBDiveUo86whaPS3Gs8U1QcWw7PokiPatO3o3XikLHKfUin8/ME3Xbt3Lv
         iqotvVQkM7bd7B5ubPRV1eZLuDP/vPLGV978O6DCqIRisxOzDyXdnwWfHPudzCZlOiTE
         Hmkxvum4cHV6kMk40r7lr8v38hnANZKDY6VZcW24WYt4qUk7O2rmFz18swkuFy5JP1hQ
         p8EBWy5+/qTlu8VWCjSnr7eNsjy3Xl17cScfBGWof60a+PyiiURJzHVXUz5U+NV8UVPq
         ACSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3nxHtshp2oB2li1c/X4bnQdVMduE440G+44j6OegHPs=;
        b=grExHaH4xCttwCT8zZ1e8jUaIes/BPMldM2nkxDkx1rOKOiT3icPBD4AH/VtQr2pOo
         ARsBIY2LmOBEUsunDLvC2AzIYu9RVQ++nQB86H1w2nkTWWuUnpoyHrxBdd94yEj8xlcN
         Ndtsu5dihaDjVyTMbkA0+abJ/ntZXx3AWTKLcm63QSWOJxQH0nMLiuK82X6ue3Ia11Uu
         NIytvL6c43y9TT9+D4c6nseQKE7iEHiCcVNN6aKQFWOQtSPGemZYLkarhW9zy44In1xu
         t7skHVIPW6jUn4aE7oWlUptUdjs7FQop3+CtG3QsLx8zMVOS2YUlBARfast4ku+RHnE6
         8mRQ==
X-Gm-Message-State: ABuFfohP0oXNGskxX0G2jpgC6VmvcyFUozYAoWv7L0MUlzxPGinhP0/Q
        W5bFkQBATwVZ0r2sQiMMtziT/2rJEMS+pgwG4lY=
X-Google-Smtp-Source: ACcGV603sgiilCKVlojBekMHHHVI+oCT/AeLx82zJctkg+P2WNRSAFxyTFolTjasyqSE1YWh6IdGkd2XxxFrNiW9uqo=
X-Received: by 2002:a6b:8b97:: with SMTP id n145-v6mr12651321iod.282.1539702383142;
 Tue, 16 Oct 2018 08:06:23 -0700 (PDT)
MIME-Version: 1.0
References: <7d6858c8-aa84-aa05-6c69-22dbbff7dfaa@hibox.tv>
 <7v4oepaup7.fsf@alter.siamese.dyndns.org> <vpqd3t9656k.fsf@bauges.imag.fr>
 <20181016064049.GB25933@sigill.intra.peff.net> <871s8qdzph.fsf@evledraar.gmail.com>
In-Reply-To: <871s8qdzph.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 16 Oct 2018 17:05:55 +0200
Message-ID: <CACsJy8BzjrvCMzhLKmktywfpa-8_OSvmQ8A_uRv2jfMa8_MbLA@mail.gmail.com>
Subject: Re: Ignored files being silently overwritten when switching branches
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, per.lundberg@hibox.tv,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, git@matthieu-moy.fr,
        Clemens Buchacher <drizzd@gmx.net>,
        "Holger Hellmuth (IKS)" <hellmuth@ira.uka.de>,
        Kevin Ballard <kevin@sb.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 16, 2018 at 11:12 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Tue, Oct 16 2018, Jeff King wrote:
>
> > On Mon, Oct 15, 2018 at 01:01:50PM +0000, Per Lundberg wrote:
> >
> >> Sorry if this question has been asked before; I skimmed through the li=
st
> >> archives and the FAQ but couldn't immediately find it - please point m=
e
> >> in the right direction if it has indeed been discussed before.
> >
> > It is a frequently asked question, but it doesn't seem to be in any FAQ
> > that I could find. The behavior you're seeing is intended. See this
> > message (and the rest of the thread) for discussion:
> >
> >   https://public-inbox.org/git/7viq39avay.fsf@alter.siamese.dyndns.org/
> >
> >> So my question is: is this by design or should this be considered a bu=
g
> >> in git? Of course, it depends largely on what .gitignore is being used
> >> for - if we are talking about files which can easily be regenerated
> >> (build artifacts, node_modules folders etc.) I can totally understand
> >> the current behavior, but when dealing with more sensitive & important
> >> content it's a bit inconvenient.
> >
> > Basically: yes. It would be nice to have that "do not track this, but d=
o
> > not trash it either" state for a file, but Git does not currently
> > support that.
>
> There's some patches in that thread that could be picked up by someone
> interested. I think the approach mentioned by Matthieu Moy here makes
> the most sense:
> https://public-inbox.org/git/vpqd3t9656k.fsf@bauges.imag.fr/
>
> I don't think the rationale mentioned by Junio in
> https://public-inbox.org/git/7v4oepaup7.fsf@alter.siamese.dyndns.org/ is
> very convincing.

Just fyi I also have some wip changes that add the forth "precious"
class in addition to tracked, untracked and ignored [1]. If someone
has time it could be another option to pick up.

[1] https://gitlab.com/pclouds/git/commit/0e7f7afa1879b055369ebd3f1224311c4=
3c8a32b
--=20
Duy
