Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 675D7207EC
	for <e@80x24.org>; Sun,  9 Oct 2016 12:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751401AbcJIMi5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Oct 2016 08:38:57 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:38506 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750701AbcJIMi4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2016 08:38:56 -0400
Received: by mail-it0-f50.google.com with SMTP id o19so56557322ito.1
        for <git@vger.kernel.org>; Sun, 09 Oct 2016 05:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9R5NfE3RlpzDRiTubhjugL2qXeDDmK4baoOk4zR0A6c=;
        b=ik+aInV3TYLJ7zyE0syfRCeVqk98XBDfE325gfBxH4hlTKH94vHqS+7oOCGC3eT+30
         yN6yVzX0UN957lFDxZ1cUwP6fnpIVkqVkFIhhBqn3y2E38lyflBSWEXeUh0rm1JlzKAd
         +dYfkrIUmhujQhUXf1zjjDgTAe3VbeOCqqYFSFtV2bXDJlhfajQDL92DwLDSjg9X11dk
         9OytHn7whBapBeDNbIBnCshliyqmBHK5U9Hj98oE3nGdODRmkBHj3W6GphVbnQ7q7yvw
         tm81ywgBhQy/ZZc2D59uNWFun3/M65Xkv7C7l0uT+GiCoybTTRVnJbQqlgpdsn8PpzJb
         Jwcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9R5NfE3RlpzDRiTubhjugL2qXeDDmK4baoOk4zR0A6c=;
        b=lJu2ThfLTA3ozm4CmqPmfQ18xRCnarPGl76xMhlY5cHfey4VRKctlRWDzNNASbWT61
         R4rQtRvc+z/MnkKrbunzTCoY54HctlHhr3YjDsrpVOxmyBlb5yuTxIdi00W+mMeifhot
         TYVfq85JHv0JZ6d42raDDWr6m4OBhyB+Mpmp+FxFyW/+RyqcfomszJxJEv+1UjGMmU7W
         0mNGrqKUUx074i+1I1Ddoo21ZAYyZDD1vkMRDz19UmdXNfRDCBPelLUHvJN8TGR1JUR1
         t7e9CvQW8PMON+jlbt7t4qUoN5arxbvGNkSQxz6McI5ZPKqJLTVmxkw1/oC0vQtWh8LO
         Tw5A==
X-Gm-Message-State: AA6/9RnlGzH7Z3vB6zn+7eNdSej8CZQI4c4QW09F6yJnC1MHropm2X1gz15v0yLa2KTlMPSmgLgj7AKsaMGIWQ==
X-Received: by 10.36.112.135 with SMTP id f129mr5258814itc.3.1476012789589;
 Sun, 09 Oct 2016 04:33:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.230.206 with HTTP; Sun, 9 Oct 2016 04:32:38 -0700 (PDT)
In-Reply-To: <20161009060149.voqjoiltqi6jub7g@sigill.intra.peff.net>
References: <20161006114124.4966-1-pclouds@gmail.com> <xmqq60p5l3om.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1610071319520.35196@virtualbox> <CACsJy8ASc7Fxm5XDHFiX9E+bQ8s1MtmEHfc7bZY4C-_GEQr0og@mail.gmail.com>
 <0347de20-72a7-b384-389f-4b2ad5789973@kdbg.org> <20161007175052.sxyk7y2ytjh36phr@sigill.intra.peff.net>
 <alpine.DEB.2.20.1610081034430.35196@virtualbox> <20161009060149.voqjoiltqi6jub7g@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 9 Oct 2016 18:32:38 +0700
Message-ID: <CACsJy8BpYYJmBm32YsQyuP58uhLE+sn8WdhiHyY6xzcqPVjMVQ@mail.gmail.com>
Subject: Re: [PATCH/RFC] git.c: support "!!" aliases that do not move cwd
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 9, 2016 at 1:01 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Oct 08, 2016 at 10:36:13AM +0200, Johannes Schindelin wrote:
>
>> > > Maybe it's time to aim for
>> > >
>> > >   git config alias.d2u.shell \
>> > >        'f() { git ls-files "$@" | xargs dos2unix; }; f'
>> > >   git config alias.d2u.cdup false
>> > >   git d2u *.c   # yada!
>> >
>> > That would be nice. It would also allow "alias.foo_bar.shell"; right now
>> > "alias.foo_bar" is forbidden because of the config syntax, which does
>> > not allow underscores outside of the "subsection" name.
>>
>> So what about this?
>>
>>       [alias]
>>               d2u = !dos2unix
>>       [alias "d2u"]
>>               shell = 'f() { git ls-files "$@" | xargs dos2unix; }; f'
>>               exec = C:/cygwin64/bin/dos2unix.exe
>>
>> You introduce all kinds of ambiguities here that did not exist before...
>
> If you mean ambiguity between the old "alias.X" and the new "alias.X.*",
> then yes, I think that's an unavoidable part of the transition.  IMHO,
> the new should take precedence over the old, and people will gradually
> move from one to the other.

Do we really need to treat this differently than

[alias]
    d2u = !dos2unix
    d2u = C:/cygwin/bin/dos3unix.exe

?

Another similar case is one d2u (could be either old syntax or new) is
defined in ~/.gitconfig and the other d2u in $GIT_DIR/config. In
either case, the "latest" d2u definition wins.

> If you mean the ambiguity between alias.X.shell and alias.X.exec in your
> example, the problem is that you have keys with overlapping meanings.
> One solution is "don't do that" (so have a key like "cmd", and another
> to select "shell or git-cmd", etc). Another is to define some rule, like
> "last one wins" (so "exec" overrides "shell" in your example).
>
> I'd prefer the "don't do that" path. The config you showed is
> nonsensical, and it doesn't really matter that much how we behave. But
> it is better still if we have a config scheme that makes it hard to
> write nonsensical things in the first place.

Any suggestion? I suppose we can have _one_ key for the command. How
to execute that command (exec, shell, nocd...) are boolean options.
People can still write conflicting things. We have been nice so far,
always dying when the user specify conflicting command line options.
We could do the same here, I guess.
-- 
Duy
