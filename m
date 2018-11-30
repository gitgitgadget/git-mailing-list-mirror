Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C26F211B3
	for <e@80x24.org>; Fri, 30 Nov 2018 05:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbeK3QuU (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Nov 2018 11:50:20 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:54935 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbeK3QuU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Nov 2018 11:50:20 -0500
Received: by mail-it1-f193.google.com with SMTP id i145so6635067ita.4
        for <git@vger.kernel.org>; Thu, 29 Nov 2018 21:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mgUAJAdsETyur35Ox1OByxzVk9MFRwsUA1pI/Azx0YM=;
        b=Pr4yP3/WLIO0BrXn1CrX0rMTcHxOBfrh/K5bxCT3uld7fPfl1H92KCPX0YzlB/PNPq
         mDSJ8BfLYwYH7ZInEc4OfcXyxu1T7c/3f1Pq7EDF5O31PodTNizwRRv9aIGqYTbUK5e8
         NsyiOK/yT3iKlgD31P5WzYZ62cDYMW6CA+bkFXrg7TTNU+dtSP1W03HlmmjvsUO7E49C
         M2McLvFxsPD7iET8gY6Zu4RH4Z/U2y/CMIi2yNJQkJS1j8s/wq4+VHntZWuscfZxSBVQ
         DwbyLxlvFHkykIg/W7+SEXLgBZQQ4TGArRe+0Uazf43whtDAopYcm2SCqJNZFyj/FbYr
         Rt9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mgUAJAdsETyur35Ox1OByxzVk9MFRwsUA1pI/Azx0YM=;
        b=ZdOyoOZVu6hukUIvuD19qe/CzpcObBVlBmSz0LyHdu7wnHh6vvqCW531UsOLc32PS6
         2MZgGUA91PdiWHqtxSmn3HTXGD7u+pcxkjFzZ8ZeOqXfs6GbdxVIf0V06QHtd2fBx8h7
         9Q/9BXfg85dP5csQrrfTGJuTUjPdtgEVS2StLyIDb3bAckLYPY9WXYd1/qyRMth3rKvu
         5G1VdlhQoZNVU5m/1cocf+IEXGVYLs5Q8Qd3C1TCqTUfq7YkkjdBwd15bYSxZ8GSqVEZ
         aefRr7L4HM0YZ0cZY2U4zd/Cyx1z54zaS/8B90mYwFLpJMwewUMigWUYQlDGUyjCK7Hk
         0egA==
X-Gm-Message-State: AA+aEWbaGMAKWQzWEZmpkYi4kV82JCR9tP/pKB4sU7Pk9azaO08eiFLQ
        9gznZJlHrF0Eb8APZR3un9dlcvq4/Wzxrz+/sdY=
X-Google-Smtp-Source: AFSGD/WjUMDG9Goyre+lLsJHL2/fy46epB1j1XoHG4TJ07FfDHzCDCGRVvsIU+WeheF8ACqUBgc8VATKZdJfOhAkpUs=
X-Received: by 2002:a24:e1ce:: with SMTP id n197mr4084664ith.123.1543556532060;
 Thu, 29 Nov 2018 21:42:12 -0800 (PST)
MIME-Version: 1.0
References: <20181127165211.24763-1-pclouds@gmail.com> <20181129215850.7278-1-pclouds@gmail.com>
 <xmqqefb3mhrs.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqefb3mhrs.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 30 Nov 2018 06:41:45 +0100
Message-ID: <CACsJy8BZ7s2TbqiO+hensOF0quz+N3h5+GwKqiNTakGaGJ2yeA@mail.gmail.com>
Subject: Re: [PATCH/RFC v3 00/14] Introduce new commands switch-branch and restore-files
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Stefan Xenos <sxenos@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 30, 2018 at 3:16 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
> > 'git switch-branch'
> >
> > - implicit detaching is rejected. If you need to detach, you need to
> >   give --detach. Or stick to 'git checkout'.
>
> OK.  Is "auto-vivify the named branch based on a remote-tracking"
> also rejected, as it is a confusing behaviour that is a too subtle
> and implicit, just like the detaching head is, and require --guess
> or sticking to 'git checkout'?  I think it should.

This touches the "remote" concept which I think is another confusing
thing for new people (your "master" is not the same as the server's
"master", aka origin/master) and perhaps this dwim thing helps.
Frankly I don't do dwim much so I don't know if it's that often used.

> > - -b/-B is renamed to -c/-C with long option names
>
> I did not expect that these two are the only options that would be
> out of place with the command name split, but presumably you looked
> at all options for both of the two new commands to see if they made
> sense in the new context?

Yeah (at least the description in struct option[] array)
--
Duy
