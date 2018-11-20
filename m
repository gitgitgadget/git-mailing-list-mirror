Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-13.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 753CA1F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 17:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbeKUD6H (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 22:58:07 -0500
Received: from mail-lj1-f173.google.com ([209.85.208.173]:36647 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbeKUD6H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 22:58:07 -0500
Received: by mail-lj1-f173.google.com with SMTP id g11-v6so2369488ljk.3
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 09:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z7nJGfQ4j41x6/Ba6+kDkgqm4CEGqF6FCbZT1j7oJ4w=;
        b=ZuxedBHRKwmsSVMWRrrFR2rU5gTjTa9VDeXjjlCNAN6/qiai2NsOzchugjcA9/Jz7E
         gkTPX6y7Ik+lNHd4qSVTu0+uz+gSbbBHlIrpnahwgLw/ZPFReQRjyNyQZg8ECoLFV1vy
         +aQhaG5sWhpv2dPjz3eUa2P7fFlGvtMrw55z7ttF4MoCqU3R48PHDSrGu2141YVLcVoL
         fT0sexOJnkiRzUJroPiiLnbHRwOMdbRbnre4m9NGZfEYrDMOsr+QO23wvo05qGjGBirU
         iQdFt97msLFqH7GwUN2HPDpvQQ56oU/gUfhlx8n7076lOIA5cUX3Ce9YuobNxg30EYs1
         oJxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z7nJGfQ4j41x6/Ba6+kDkgqm4CEGqF6FCbZT1j7oJ4w=;
        b=TZCZgv41h2ixDRVtHV/058t0vlVum5I8CY+GUvrTFni+6eytWKKwrdFJoqL0+iZ+in
         vVivoTXnS69fDprqtssCtH8Ps7KmwYV/DiMwaenSnp1hiVttxpvD7/4Czd+wxeQdVYf+
         eDkLzX3jJSnT75nOIa/a7lJlqF1fVD8QflTyOy+hgQbSjwwC037vnf1xkPGoCTaT63F8
         nwAV0LiMybADKqJl2bo7yZwh/AjuJOnOQ4JQG4nu7X3JcttKLfQvY/bJ4Pr1zXr58zcl
         t8fpBYEhi9JDDwn3aokvnEn+PyIc4qRhUqIcCqI7SgjuQXePOUjcgga0z8pujYenDuBV
         Uq/A==
X-Gm-Message-State: AA+aEWbBAqME88Ls4Rmo7ufIXQJialieiTAWvOmNkURAWnGVi4NhG+8l
        ew47Kod+CNcaOuH1jj596IVQXLT+iJSDq3jFMonH5g==
X-Google-Smtp-Source: AJdET5fqtdxwqkQUi5F8JxAOFo2FRA/gQ6fUcT4fb0/rNsWSU4GrMmjrJBqryLnKTF0VVClpsNuWOlkXwTNcdsosv0s=
X-Received: by 2002:a2e:8702:: with SMTP id m2-v6mr1704585lji.132.1542734869436;
 Tue, 20 Nov 2018 09:27:49 -0800 (PST)
MIME-Version: 1.0
References: <20181115005546.212538-1-sxenos@google.com> <xmqqd0r4i29w.fsf@gitster-ct.c.googlers.com>
 <CAPL8Zisv-Q04Y_jQzMN7G9fG9rkWwxh4travnSw6cG0ZUFivkA@mail.gmail.com>
 <xmqqftvxertd.fsf@gitster-ct.c.googlers.com> <CAPL8ZisfhNqN3gh0E_=mwXuBPGRZ9fKgyQ=HWNFx_9m2job-=g@mail.gmail.com>
 <xmqqwop9d7oq.fsf@gitster-ct.c.googlers.com> <CAPL8ZisOH7vAPGSCv-RGZdYf56AjgvxXU6CQ9U7rir76u2ga0w@mail.gmail.com>
 <xmqqmuq4d0h5.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqmuq4d0h5.fsf@gitster-ct.c.googlers.com>
From:   Stefan Xenos <sxenos@google.com>
Date:   Tue, 20 Nov 2018 09:27:37 -0800
Message-ID: <CAPL8ZiuVbrXLKaJe2iBe-nDqCe9h+GiVDUDQmdnfDrCJUPHJvA@mail.gmail.com>
Subject: Re: [PATCH] technical doc: add a design doc for the evolve command
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Junio C Hamano <jch@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Carl Baldwin <carl@ecbaldwin.net>,
        Dave Borowitz <dborowitz@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I was trying to see if this is something we can leave out to limit the initial scope.

Oh, in that case, "yes". :-) If there's a need to cut something,
origin parents would be a viable candidate.

I was thinking that this file could document the final goal so that if
anyone else wanted to contribute to the implementation, we would be
heading in the same direction. It seems reasonable that an early
implementation may omit origin parents. Since the actual
implementation will lag behind the spec, I'll add a status section to
the top of the document where we can describe the delta between plan
and implementation.

Also, I'm now convinced we're talking about the same thing. :-)

> > Are you claiming that this is undesirable, or are you claiming that
> > this could be accomplished without origin parents?
>
> I was trying to see if this is something we can leave out to limit
> the initial scope.
