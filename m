Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBC6B211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 04:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbeLEEpU (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 23:45:20 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:46599 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbeLEEpU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 23:45:20 -0500
Received: by mail-vs1-f68.google.com with SMTP id n10so2476975vso.13
        for <git@vger.kernel.org>; Tue, 04 Dec 2018 20:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qH22gvjSKeMFMMYQPFiPGUJjDb8yafl2fB/0P98kudw=;
        b=sMhvlHqrvzef7xu/Lp9yofCDEaMdsPucvzauyg+068P54lOAGunVOHNHrXkMBq4BP2
         Es1cIu2UhjzeDLK/oL49N/3iXUdOm/ME+ginfbQah2mMQlIzT+GByEnLxz/AzXw9DWBX
         So2/a5JVPnfCJmngADIVJa64CfYu2tBTw7Zvidyqz/DXJ0oC3v7KVKBs/u4vzOaCae06
         y3kwGwbdnMh2xmEkpS+fMTgBm1KuTTO7U8hiCCgc87rIvWVjAGA/B2Uf0qWc26qlnPkE
         BuGMJHQF5tT14kLFpMMvw+lZt2gnfGn1MXtpJC5E3UJ46WJboNu4753QJObj5VdOD4CA
         g3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qH22gvjSKeMFMMYQPFiPGUJjDb8yafl2fB/0P98kudw=;
        b=tgeojzRxoAAxiuViUs7jUf+sX1Or3WwkUYV/sUo8ye1+lqfh9ZA2tgeM5NhcFdBumw
         mxAjoIeQkLP2XkOP8Zvq5vBnnE+Mg1X36bkVs100pp8NyLfPI3bwsTDfjWx9We6yKmF0
         88qoW6HZotWq4D1GkuXbXN0Ah77MVR4EVKA+BWgOsql3n9XAwr4pyumLMp4eioZP6/42
         JtmsA/3hYJCbanIxdAcr0W/t6vjQUl/TVcuQWBoTrBsvrOCWDAFsl3jgRRHe/cxin/Sw
         ZLUR5lrr4zDh3vKFMgRpY7YhSGt5Nzt0qG85BtYytCVNFCsLeqzHx1XEZcmbPKOofRl3
         1/cw==
X-Gm-Message-State: AA+aEWZFkbLyxHaYRYi4lp/PAZPK23XXZPXUp/PFhjwGZpbLFV5XF/En
        h7S9bsRlGEKr9rQLUojxxZjoaRrq/XkooFUdyKeW5A==
X-Google-Smtp-Source: AFSGD/U+NvEeQ0PGcaBXI7WZQm1YPrnhtYtRAwDXp9LHDAT82EAfLDS0gpmiKELwd0Sjlc1HhKQTT3fQ33pogcMcoiI=
X-Received: by 2002:a67:3c5c:: with SMTP id j89mr10009873vsa.117.1543985118726;
 Tue, 04 Dec 2018 20:45:18 -0800 (PST)
MIME-Version: 1.0
References: <20181127165211.24763-1-pclouds@gmail.com> <20181129215850.7278-1-pclouds@gmail.com>
 <20181129215850.7278-8-pclouds@gmail.com> <CABPp-BHQ68pkvO8yXYuy=0D6ne8u=5CUMDqiN0jtRrxCL55n2g@mail.gmail.com>
 <CACsJy8BTs+WKzTTEF2XVTT-LVJk_exYCz_hN+hXU1Dw+oquBpA@mail.gmail.com>
 <CABPp-BGRcaiiD-aks1kaLr7ATLQ_oGSyooQBDD+2acgerA+Phg@mail.gmail.com>
 <CACsJy8D9Rgsf-E6yweQxpopFaOVZ1bgihEbg200yS1gup+Gt7Q@mail.gmail.com> <xmqqpnugemks.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqpnugemks.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 4 Dec 2018 20:45:07 -0800
Message-ID: <CABPp-BGZF8s=ReiC=jTKKQbt1LLO72K7a_2pYbQHrw0ZeA9J5w@mail.gmail.com>
Subject: Re: [PATCH v3 07/14] checkout: split into switch-branch and restore-files
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>, sxenos@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 4, 2018 at 6:26 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Duy Nguyen <pclouds@gmail.com> writes:
>
> > On Tue, Dec 4, 2018 at 6:43 PM Elijah Newren <newren@gmail.com> wrote:
> >> > > > +--ours::
> >> > > > +--theirs::
> >> ...
> >> go away.  Maybe it can still be fixed (I haven't dug too deeply into
> >> it), but if so, the only fix needed here would be to remove this long
> >> explanation about why the tool gets things totally backward.
> >
> > Aha. I' not really deep in this merge business to know if stages 2 and
> > 3 can be swapped. This is right up your alley. I'll just leave it to
> > you.
>
> Please don't show stage#2 and stage#3 swapped to the end user,
> unless that is protected behind an option (not per-repo config).
> It is pretty much ingrained that stage#2 is what came from the
> commit that will become the first parent of the commit being
> prepared, and changing it without an explicit command line option
> will break tools.

What depends on stage#2 coming from the commit that will become the
first parent?  I wasn't thinking in terms of modifying
checkout/restore-files/diff/etc in a way that would make them show
things different than what was recorded in the index, I was rather
musing on whether it was feasible to have rebase tell the merge
machinery to treat HEAD as stage #3 and the other commit as stage #2
so that it was swapping what was actually recorded in the index.

I know the merge machinery implicitly assumes HEAD == stage #2 in
multiple places, and it'd obviously need a fair amount of fixing to
handle this.  I wasn't immediately aware of other things that would
break.  If you know of some, I'm happy to hear.  Otherwise, I might go
and learn the hard way (after I get around to the merge rewrite) why
my idea is crazy.  :-)

> > I'm actually still not sure how to move it here (I guess 'here' is
> > restore-files since we won't move HEAD). All the --mixed, --merge and
> > --hard are confusing. But maybe we could just make 'git restore-files
> > --from HEAD -f :/" behave just like "git reset --hard HEAD" (but with
> > some safety net) But we can leave it for discussion in the next round.
>
> Perhaps you two should pay a bit closer attention to what Thomas
> Gummerer is working on.  I've touched above in my earlier comments,
> too, e.g.  <xmqqefb3mhrs.fsf@gitster-ct.c.googlers.com>

Indeed, I'm excited about his changes now; I'll keep an eye out.
