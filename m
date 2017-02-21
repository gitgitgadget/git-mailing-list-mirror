Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16AE4201A9
	for <e@80x24.org>; Tue, 21 Feb 2017 20:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751334AbdBUUkP (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 15:40:15 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:36808 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751177AbdBUUkN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2017 15:40:13 -0500
Received: by mail-ot0-f193.google.com with SMTP id l26so15120588ota.3
        for <git@vger.kernel.org>; Tue, 21 Feb 2017 12:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=SBWk3SoAZP7ASph/TzhLq3325WkfliliHe9h+a2XQE8=;
        b=PV2mdi7JlWBgqzHKpdkos2oE1KhhIqR2UMUZHEBikQKe0mqdHOuis1cT98ndobGNVG
         6ZHCkBwl7Vy2KYR/E+MzOFDde/YV97PIHRDjZ6JeNPqpqJFdDJ2SpWj+sslJVxZABoQ8
         QVZEeGO0ByTaLDPgJapJexrjmV8mUq57j3cpZEfX7f04JNKxBiSSksZedJ8bqm8xk4uI
         lZ9UCh3EVHB9jXdX1bR4X+qovpAj04WnfDrT7Y5FEtJQGT/CtG1+42BYiM0eN/iXguiR
         /1N8cxuDoBkdwubl6ZUzjLiiPcytzLYGzQJlSEbfESQPzxVArxdorKLcAZRhYGqGjF5J
         KFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=SBWk3SoAZP7ASph/TzhLq3325WkfliliHe9h+a2XQE8=;
        b=iQIyHnk0ZCyxJyLpLDaFKCRoGNcnTgq8ytuyc2NHGD+l+jEt92VWRijUfwWMLWz1HH
         ewGPqIj9QWC7rtrAn31tfkEpXzPTPTlc3mSRyHRaCwv0CgtQreGeyDu9l4f0qVJeirVx
         36sR0T+qU1lwrnRxbOD42dPd1+rJ+lQkvAlckyLR4h0OBi2CLksdTdZI3YG12aPK/rXH
         Gx6niJ+lGuRKuWVFRubufLvn8ojCBosq7B9oH+lWPgKzl5vxInLgxzmf2GvQ/UFHCe6S
         MTWrpHAGpcxKEuzZaeFFP5KSkfaJcIyERRwQppxYemq0Cd0W8R0Q55h5tmxJKUX5cWWS
         EACw==
X-Gm-Message-State: AMke39mxswPCY8PPqXtC8Nlt/hPN2+p2XrHZWagBDib19meuUzM/Z9yXc5FuCrwDHXL2iYRUuCF4uuh6ve5gBA==
X-Received: by 10.157.4.36 with SMTP id 33mr14568664otc.221.1487709612611;
 Tue, 21 Feb 2017 12:40:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.182.164.66 with HTTP; Tue, 21 Feb 2017 12:40:11 -0800 (PST)
In-Reply-To: <xmqqpoibfgo3.fsf@gitster.mtv.corp.google.com>
References: <alpine.LFD.2.20.1702110943460.31350@i7.lan> <CA+55aFw2S14a4_4YK0b6PNK4TH_AUo_+2JN+PTyBTufNeB5t6A@mail.gmail.com>
 <xmqq1sv2fq6m.fsf@gitster.mtv.corp.google.com> <CA+55aFy-vvOBu5Y4KDeteUyK-7U7yTa1HoqHo+hME1=8bq7Xhw@mail.gmail.com>
 <xmqq7f4tdcua.fsf@gitster.mtv.corp.google.com> <xmqqr330779h.fsf@gitster.mtv.corp.google.com>
 <20170215002901.gtzegvhyy7d6cvrb@sigill.intra.peff.net> <xmqqefywnk5a.fsf@gitster.mtv.corp.google.com>
 <CA+55aFw3ZRtgsLGW-TFqpq-3uCw55L42p7cF=Q-73qM_VPuYsQ@mail.gmail.com>
 <CA+P7+xqtPwzt3J6O05TP=E_hh-ko97adn+__Zmc0DNSDqEnEHw@mail.gmail.com>
 <20170220004648.c2zz6bm2hylvep6x@sigill.intra.peff.net> <CA+55aFwdUxCvmi28T3yn1K4rqn2bZmJBdTRr7tSbMa-g5izHbw@mail.gmail.com>
 <xmqqpoibfgo3.fsf@gitster.mtv.corp.google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Feb 2017 12:40:11 -0800
X-Google-Sender-Auth: _icOUFfu9LsEYKW6_kz78JfaCAE
Message-ID: <CA+55aFwT2HUBzZO8Gpt9tHoJtdRxv9oe3TDoSH5jcEOixRNBXg@mail.gmail.com>
Subject: Re: [RFC PATCH] show decorations at the end of the line
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Jacob Keller <jacob.keller@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 21, 2017 at 12:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> The updated organization smells a lot better to me ;-)

So I have been using the original patch for a bit over a week now, and
I have to say that I'm not sure it's the right thing to do after all.

Most of the time I much prefer the "decorations at the end" thing,
because it just looks better, and the commit log oneliners line up
nicely.

But then occasionally I end up liking the old interface better, just
because there's long commit lines, and showing the decoration at the
end effectively hides it.

So I vacillate between the two formats, and so I'm not sure this patch
is worth the change in behavior after all.

In fact, I played around with some formats, and the one I lines the
most was actually one that split the line for decorations, but that
one was admittedly pretty funky. It gives output like

  b9df16a4c (HEAD -> master)
            pathspec: don't error out on all-exclusionary pathspec patterns
  91a491f05 pathspec magic: add '^' as alias for '!'
  c8e05fd6d ls-remote: add "--diff" option to show only refs that differ
  20769079d (tag: v2.12.0-rc2, origin/master, origin/HEAD)
            Git 2.12-rc2
  076c05393 Hopefully the final batch of mini-topics before the final
  c5b22b819 Merge branch 'jk/tempfile-ferror-fclose-confusion'
  62fef5c56 Merge branch 'dp/submodule-doc-markup-fix'
  1f73ff080 Merge branch 'jk/reset-to-break-a-commit-doc-updated'
  bf5f11918 Merge branch 'jk/reset-to-break-a-commit-doc'
  e048a257b Merge branch 'js/mingw-isatty'

(which looks better with colorization than it looks in the email).

But I'm not even going to send out that patch, because it was such an
atrocious hack to line things up.

              Linus
