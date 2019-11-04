Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6A611F454
	for <e@80x24.org>; Mon,  4 Nov 2019 14:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbfKDOqX (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 09:46:23 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:34625 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727891AbfKDOqX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 09:46:23 -0500
Received: by mail-oi1-f178.google.com with SMTP id l202so14302560oig.1
        for <git@vger.kernel.org>; Mon, 04 Nov 2019 06:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jMFAwFc/BMUtQfLb2IBEsKc1U9I0XXuvhFfu3ND97GA=;
        b=EvpNOcMFs+GN+ipfOhsFk0AP47idqww/kcU7Yr13u03P3bH1KtesjVqBw6WWn5gVsg
         xdYmqV9Rc6EvW63egh3WXlCz9KHkYMton71hEGZIYX8m90QD23QhyIIsyfv+k+XTBeym
         NyWF2Z1sZaCYXOrZMhz2axD/WM15aseapMR0ufksXlPiFIK8WoxyaII6wwhxTVDTceiL
         EiV+BHudxLmZGrg/PSE0G1RKiQn5bMCz6c4r/XjCi3zqD7YDhqY6oT2BXTN4B6LozpDL
         JAET4xzxGsNoKZupOO6cdjUJODdNK5axiJS0YPsKLoIX5kgCO6rFfSxfXEIrIq6F00Oo
         jLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jMFAwFc/BMUtQfLb2IBEsKc1U9I0XXuvhFfu3ND97GA=;
        b=GdN0IWlfYiFWesiOBbygNXtuHwmtV2/k90gUaWP73g0zEaP3YS9RSCJJmtUEkdzaQh
         Vf1XCyRLYKgo9sUYIGFHrDiZrlw/nMPK+rqvZhNl0RNuufcpwdP5rQWeFbLHZYXYCaEm
         O5op4+j/jM+zDCXP4o6CnGskRrtFxZ3OH4vv7Qu/Qfl0RDnFhTnOCiKUjBo4ku0xxYIu
         HMOCGYdgazGGorY9/SiHsDgQcbM3MjI/jcEcW2QsxXsb80mGKJEGPMAU+Cw2gwXOTjEM
         vwSb2FmJjJFQxmnumKLV1f3ShgpnQg1Y8KXZSTun35FVzWD8sKo5By1pzT5qDoFcOotI
         5stw==
X-Gm-Message-State: APjAAAWXj2rXr8JMSSe8Bdz9w9vIhcdnmHWLNnfPfaHtrWA1phU4t6Dc
        nOLibfleA7f4vtfpDapiBwVQFptphpbhllP/958=
X-Google-Smtp-Source: APXvYqy9z9DUbmHTi22zhtrQqOdgR9DAOIFLqs9xdIOveF+C5rzJ2PFZXdylyTRQgdaOQMzR9EaSdgbb/Qm+jv/47tI=
X-Received: by 2002:aca:d6c4:: with SMTP id n187mr1506997oig.6.1572878782159;
 Mon, 04 Nov 2019 06:46:22 -0800 (PST)
MIME-Version: 1.0
References: <xmqq7e4gyzgt.fsf@gitster-ct.c.googlers.com> <20191104054924.GA47418@syl.local>
 <xmqqo8xsxiyv.fsf@gitster-ct.c.googlers.com> <20191104062334.GA49488@syl.local>
 <a0c175e3-1743-c5a1-8327-5736b7af71f5@iee.email>
In-Reply-To: <a0c175e3-1743-c5a1-8327-5736b7af71f5@iee.email>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 4 Nov 2019 06:46:12 -0800
Message-ID: <CABPp-BHJ3eAARDAdbKZcGwMPSL7f7XD=7as0igvoPM8f8ODhUA@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.24.0
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 4, 2019 at 4:18 AM Philip Oakley <philipoakley@iee.email> wrote:
> On 04/11/2019 06:23, Taylor Blau wrote:
> > On Mon, Nov 04, 2019 at 03:18:32PM +0900, Junio C Hamano wrote:
> >> Taylor Blau <me@ttaylorr.com> writes:
> >>
> >>> Thanks for a great release. As always, your release notes were
> >>> very helpful in putting together GitHub's release highlights [1].
> > Ah, thanks. It must have been dropped in one of the rounds of review. I
> > added it back.
> >
> > Please do let me know if you find any other such typos :-).
>
> in the tidbits section there are two places where a double-dash 'option'
> is shown with only a single dash:
>
> -super-dangerous-option
> -end-of-options

There's a similar issue earlier in the notes where --analyze has had
one of it's dashes dropped so it appears as only -analyze.
