Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E63751F404
	for <e@80x24.org>; Tue, 13 Mar 2018 23:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932257AbeCMXOF (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 19:14:05 -0400
Received: from mail-ua0-f169.google.com ([209.85.217.169]:41518 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752729AbeCMXOF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 19:14:05 -0400
Received: by mail-ua0-f169.google.com with SMTP id u99so895512uau.8
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 16:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tzvMXDIbVz9tXm+cpvr4W9zZ1UhLOO7kZV9u95enfQI=;
        b=XuRKdj7oUXxSW7cXCQf8x/OEF2KGTjIOfZwupPaFXZjCWbuiwsn3fQgZ1tcLHk7OqH
         9MlMMsOXsymFDYU/PR0wP5D4PzmKgm2S2GqpNTH9tbtAJCuPDgYhwB9+zx7aoaVaxUUU
         EksScIRYuYkpSltNduFHC7KBmyfL0WBEL9lP2mu6iei+PXOccix1r7kuoTMIbvrAJFb7
         km8j24Yn/pDhWd1AhSkOaz5kC+jwSZUXEe7AFDJcykcw/qLCW9mCU47PrqIjiiMIgrNv
         Fgx74x0j6wYQ4KTBWzzYXujwrPlqgJTALUA6X2ofQ5xgW4lwLJ0Jt7Ev6J2Uf4ZCN/qA
         1moA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tzvMXDIbVz9tXm+cpvr4W9zZ1UhLOO7kZV9u95enfQI=;
        b=hM1aKWDssAyA8GXopq0zGeKXtzQtJDxZEZ30qXFBRp8Sy5STCPfGQuQq0k3nc6XQ3B
         a2rf61pX99etzidzQ4Rag5BBIpwx3wJ+/dsq2eRnukZ+XKFBb8BEe9IizLm2ziuKE7ry
         htJAXIMg3W0yoHBEFOSrteaTzu3WKBdgF8ig0+zzS5Xtq8KA6pKUIu0VzeqnxWwcujYX
         QwwYPOsSRHLCVj/zxfqLkrh2e59TE5ZGqks9N9m2mi6zakKmHr0ZJu+yp8mykB4/C7jU
         kCVfIjKoLaJEAg1TA+I3A3V2UbOG4LTQ+y5Rir9nQH79zxJ87mylwWUHLpF8WWwT1mwK
         ZcaA==
X-Gm-Message-State: AElRT7FglltTenfhogbBnnYHAdvz4zwu+gtx0epwTL9t81GFj5JknafD
        1pVmftJxa5SFSl3Kzd4KY+4V/GHbrc+L1SbPsk8=
X-Google-Smtp-Source: AG47ELvqe7/tBDqh/QSjo4gNx66vxS9eqQwlynTP2iyr/2okEtMfWnuSobsgTeYH6Q2MWQMytIDcT65Ev/pAwnb0EZE=
X-Received: by 10.159.63.11 with SMTP id h11mr2009409uaj.94.1520982844141;
 Tue, 13 Mar 2018 16:14:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.3.241 with HTTP; Tue, 13 Mar 2018 16:14:03 -0700 (PDT)
In-Reply-To: <20180313225639.GC147135@aiede.svl.corp.google.com>
References: <CABPp-BEXcvgxcn4-OrDhjUpuOsGCJwE_XT+0eYOK4Ad_O5maOg@mail.gmail.com>
 <20180312184734.GA58506@aiede.svl.corp.google.com> <CABPp-BEdh+UOCpFn5Y1_RydR==dDHWTeNtBub+pPjH_06Ub28w@mail.gmail.com>
 <CAPc5daVu8vv9RdGON8JiXEO3ycDVqQ38ySzZc-cpo+AQcAKXjA@mail.gmail.com>
 <CABPp-BF-LnGPx6vKzCNaFNi_fkxK-CpenatOVa2fvJRZHd0hZw@mail.gmail.com>
 <xmqqbmfr1uj3.fsf@gitster-ct.c.googlers.com> <CABPp-BGXdBJSi5EUyeom0PcgRXvwNy4EBA71MP3FZK9xsw-jdA@mail.gmail.com>
 <20180313225639.GC147135@aiede.svl.corp.google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 13 Mar 2018 16:14:03 -0700
Message-ID: <CABPp-BE=D_TgjLZkhRh6-7k3UpnDDMfZB6vE=FMdwFT+mmp_tw@mail.gmail.com>
Subject: Re: Opinions on changing add/add conflict resolution?
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 13, 2018 at 3:56 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Elijah Newren wrote:
>
>> However, my question here about what to write to the working tree for
>> a rename/rename(2to1) conflict in one particular corner case still
>> remains.  Should a two-way merge be performed even if it may result in
>> nested sets of conflict markers, or is that a sufficiently bad outcome
>> for the user that it's the one case we do want to write colliding
>> files out to different temporary paths?
>
> Nested conflict markers only happen in the conflictstyle=diff3 case, I
> would think.

Currently, yes.  To be clear, though, this change would make it
possible even when there is no recursive merge being done and when
conflictstyle=merge.

> merge-recursive writes them already.  I've often wished that it would
> use a union merge strategy when building the common ancestor to avoid
> the nested conflicts that rerere doesn't understand.  But anyway,
> that's an orthogonal issue: in the rename/rename context, it should be
> fine to write nested conflict markers since that's consistent with
> what merge-recursive already does.

Cool, sounds like we're now all on the same page.

Someone in the future might hate us if they use conflictstyle=diff3,
and have a recursive merge, and have a rename/rename(2to1) conflict in
the virtual merge base with nested conflicts, and that resulting file
is also involved in a separate rename/rename(2to1) conflict in the
outer merge that has its own nested conflicts; we'd have up to four
levels of nested conflicts.  But for now, I'm going to write that off
as a crazy thought (or dismiss it as nigh impossible to reason about
regardless of what we did to help them) and just proceed ahead.  :-)
