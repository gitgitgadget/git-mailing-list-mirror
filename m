Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SORTED_RECIPS shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 289651F404
	for <e@80x24.org>; Mon,  3 Sep 2018 17:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731188AbeICVxa (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 17:53:30 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:38486 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728303AbeICVx3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 17:53:29 -0400
Received: by mail-it0-f68.google.com with SMTP id p129-v6so1815608ite.3
        for <git@vger.kernel.org>; Mon, 03 Sep 2018 10:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=u5dNRMsHbDjUNoyn9xY5w5ux9j10JTyyGL+ppQYkToA=;
        b=C/VRzZO6ie6D3CKzEjC0HRl5RfK9njFt57Fj/FdEzhZs0VfTaHODQG8kRtYpMeuKMV
         rLHQ36DlE+pZh6eTXl5lqKoBKTH9HbzGyWgKEz0mDxPNj92bC9XuShp8MZEwn+kgDD5Y
         iYKHQCdI2JKkXqR4y5CRM+m8af+ueuMsF1t+S6kU/LR+15o/+uZ+7mBkTM3m3ZG50GSG
         Z6GK187U2dbwuJK3uSAEAYybq/I/FYc129G9IpyRxRgEgBtxX2Jc7uRLiS41sH2uQsCN
         gaL3m9gZXL2ifc66x8vpqxNltB1EDspAZURdUtLYYGLrDUwOxQjNFmLlCtELYcDOeQ7U
         u2vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u5dNRMsHbDjUNoyn9xY5w5ux9j10JTyyGL+ppQYkToA=;
        b=AyF3gEY03Z48AsKFtkOR24nGdDkqsn9UrqrKbJiBav6bQZStIklBluCLmQr4NkXNQp
         5YVNeSS9Fu7X3mOk+fELx5c1NYJtsNnITkhWYTMOgXPtq3i4J3b4tfMRi8rgllQiPuj5
         vpq2EElQ9OJz7OQSEjQGYUipyxOsDSFLTOOYLYD/SHT9X3vcZUcM3aSewWUkJtTtABak
         Kj569nc7h6o3zrvyAMzGioqiJ6bNB+pnCtDb7yGFkYfNgYeLZhJqpWG7ELv0A72bw/Hk
         tEpY9Om/U6NWJUlVYf6UEnVFOqb/cCe3dRU1dnFbI5LIbKReTEwsSeyh8q1gpWsPoIyi
         5JTA==
X-Gm-Message-State: APzg51CXlbY1dn0wcohhRTogh643T5cw2I6S7g1igF6MOufyI8sJOwbp
        QsbD4ZSpjWI8I77Nr5qlZCn93dl89eXK1vX4ns306w==
X-Google-Smtp-Source: ANB0VdYIn9cwiWkIvTxNXNbqnzH9Rz2CvYCfpCe9b74W8M3nSpM9UMWPgM8oQRdfvoy+d3SksXcQ6DbbRsSK0BOAr+E=
X-Received: by 2002:a24:144:: with SMTP id 65-v6mr5233985itk.62.1535995940856;
 Mon, 03 Sep 2018 10:32:20 -0700 (PDT)
MIME-Version: 1.0
References: <CACsJy8AFo+mb8R-O-JKRPZk__csq6mbVXbnZhSd-nZ08zWfSeg@mail.gmail.com>
 <20180902074250.6802-1-pclouds@gmail.com> <CAP8UFD0MHUN=auZW9Zu+hnx6oAxjNsZUfQGeJ0HfBCh5RPv6jg@mail.gmail.com>
In-Reply-To: <CAP8UFD0MHUN=auZW9Zu+hnx6oAxjNsZUfQGeJ0HfBCh5RPv6jg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 3 Sep 2018 19:31:54 +0200
Message-ID: <CACsJy8BOZy5MBsSwvHNsWeAf4tqtRJc0SJuBtfwM9wR8Yn_xfw@mail.gmail.com>
Subject: Re: [PATCH] bisect.c: make show_list() build again
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, haraldnordgren@gmail.com,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        tiagonbotelho@gmail.com, tiagonbotelho@hotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 2, 2018 at 9:57 AM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Sun, Sep 2, 2018 at 9:42 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy=
 <pclouds@gmail.com> wrote:
>
> > In order to stop this from happening again, the function is now
> > compiled unconditionally but exits early unless DEBUG_BISECT is
> > non-zero.
>
> Thanks for going the extra mile and doing this!
>
> I wonder if we should also try to make the show_list() function part
> of the trace_*() functions to make it even more regular. This can be a
> separate patch or topic though.

Yeah that's probably a good idea (though I'm not familiar with
bisect.c enough to take that step).
--=20
Duy
