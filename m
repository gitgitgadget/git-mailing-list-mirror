Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3441620193
	for <e@80x24.org>; Thu, 27 Oct 2016 23:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034005AbcJ0XTk (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 19:19:40 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36033 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030400AbcJ0XTj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 19:19:39 -0400
Received: by mail-oi0-f65.google.com with SMTP id e12so7165502oib.3
        for <git@vger.kernel.org>; Thu, 27 Oct 2016 16:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=XevOuq8zd1ezaRfZTeDETUfjMOAkbuDQxbAEGCnAqj4=;
        b=gbRNqxkMjhbusTW5KhkwNjOs0AHSJU5H1ZOaiiedAPXPFAvY07IarYNvSbt5/CHZ38
         Nq6gGmieno1eywx7LyteNhbVoEm/D6IWxh7jMIlN+uXOhhMmFEuw2aG4cy2kpKsN2pse
         BfcVHD7y0h95jDl/g4QQMC6RAS2QIeu7kHZdbr1bkb27ALtxCdr8dME+yhEp+zTkXRef
         oHg/+78+3U6YBP1RPvrDoGBGgtzW5IPFM3qWAoRgpzTMPXkFk1G1vOFJOo7+mH1IIioF
         YU/U06ukRdQXxdl9qlgCunXubnkJrcJ/yzUJrLn9Xf0mttfUkAiHRdgw/LTeyZftoeU3
         vs5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=XevOuq8zd1ezaRfZTeDETUfjMOAkbuDQxbAEGCnAqj4=;
        b=YvpuUpFj8Zmn54OthMsqwOI0SkeQo8W+7DvIRKJsS4yXGkdZaE+O4UEbGuMwkucLbB
         4GFYlBNuw73SRZitGq5lcTWgSva2K2Yvrb8yXQ5aq45cTrCdR4TRI4FFxCwAbwfnZ/Yl
         kNucWnw0MyHEeGI5BSY26RfQAxJjtR6DVr1hA6Yqm04rd2RSywNOiZjvX5pgtCnbcFV5
         UAFg64y407WkW+yhrWRh0rNf9YconaZqqpEI2zdHmmGS7TIcUBsRAjbHCpeFD4OUKaq+
         YvqKASM9tDE1VhOE3enwZSxov8g+bmD3otGqB/0wXfy92WtF8ecA/bikeJHm7LQiASe/
         Fc7A==
X-Gm-Message-State: ABUngvd3B5+LAB9mnzD2ZnMG75QZtLjtthPRUIiW+bFf86auIAPuXSOWVMY0cOPDK69Y8FX2KSloRoNiA5Yg+w==
X-Received: by 10.157.34.137 with SMTP id y9mr8832120ota.108.1477610378254;
 Thu, 27 Oct 2016 16:19:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.142.104 with HTTP; Thu, 27 Oct 2016 16:19:37 -0700 (PDT)
In-Reply-To: <CA+55aFxTHF4BRfcrCiV1D26-be+_rPhwAV+Vq8Roz-NMpPBadg@mail.gmail.com>
References: <alpine.DEB.2.20.1610251327050.3264@virtualbox>
 <20161025181621.4201-1-gitster@pobox.com> <20161025181621.4201-3-gitster@pobox.com>
 <20161026042555.neaxvnmggtcku5cc@sigill.intra.peff.net> <xmqqa8drcc5i.fsf@gitster.mtv.corp.google.com>
 <20161026164746.2fu57f4pji5qdtnh@sigill.intra.peff.net> <xmqqpomnatg6.fsf@gitster.mtv.corp.google.com>
 <20161026201721.2pw4slsuyhxhcwxj@sigill.intra.peff.net> <xmqqd1imbymi.fsf@gitster.mtv.corp.google.com>
 <20161027102419.dbzigj7wtr355ofh@sigill.intra.peff.net> <CA+55aFwfhFqV74s_O=GucycY9U19ysiACDqX=mK4Gf=eQ0coxQ@mail.gmail.com>
 <xmqqoa254czs.fsf@gitster.mtv.corp.google.com> <CA+55aFxTHF4BRfcrCiV1D26-be+_rPhwAV+Vq8Roz-NMpPBadg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 27 Oct 2016 16:19:37 -0700
X-Google-Sender-Auth: 4ZEuCc-h9rj82hq9m8MYDog3ivk
Message-ID: <CA+55aFxdy4maom8byH0FoBBMWx+sQB8J7uWvHOxswjiaAhSjVg@mail.gmail.com>
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

On Thu, Oct 27, 2016 at 4:09 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> That said, now that I think about it, I should double-check: maybe
> open() doesn't actually set atime at all, and we *could* do NOATIME
> with SETFL after all.

Checked. Yup. O_NOATIME could easily be done with SETFL:, because as
with O_CLOEXEC, it only affects operations _after_ the open. The open
itself doesn't set the access time.

So I was full of it.

But the basic issue still remains - I'd really prefer to have NOATIME
stay around for all those poor misguided souls that for some reason
don't like "relatime" or run old kernels. But whether it is with
O_NOATIME at open time or with F_SETFL, I don't care.

            Linus
