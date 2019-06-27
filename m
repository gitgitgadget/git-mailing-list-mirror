Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D6DD1F461
	for <e@80x24.org>; Thu, 27 Jun 2019 02:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfF0CxM (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jun 2019 22:53:12 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:36609 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfF0CxM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jun 2019 22:53:12 -0400
Received: by mail-io1-f50.google.com with SMTP id h6so1438164ioh.3
        for <git@vger.kernel.org>; Wed, 26 Jun 2019 19:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=insynOhJXqO33GK1jKDvkzBisY8XCd1gw46PJ6ygT3Q=;
        b=r0cKab9xZ9li6vsaEbytW3BUYCCz7bEKNFFMYD1oEohIk15pBrfbM+MVmZwJnYXgI5
         tDpeDttw77icu/3wiwoTvX/EcHjWC1bvu+1VmKdSUg9oF/Gk/gr87WlQDA4BCautAeYN
         EVKtine7hhRMq+ICxSg30BhV6TmxzT4Mk6rk0iIg8g2pIkpeamoefh03lu6MBgCVJRpO
         x6VPtTX+nNOWnUkUl2zudmAINtgU03FhNU3cx7hwUQwwy+WPO6mVxs4bwGTpUEoBfmD7
         Hvyw2OOS9iQzC/AYqHBsaDCNE4hYM5FYafvc68K8CBVFh8E/235h+AIrrcvSdd1DW00B
         XT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=insynOhJXqO33GK1jKDvkzBisY8XCd1gw46PJ6ygT3Q=;
        b=gA0g2jG2YiIs+A/tRNahpY3/PW+mhdRyxjqU9tiJ2sVOoMXwJZeUivDUCaHCVuiOa5
         DAaG7bYxwoIqqd6oYbDOmmLdpiEDKh8+xyB4jLhtf2AgdnZfrmnBchbyyzJZIJnlzKdU
         b6MgHw0pyy6U/ZW4FxELhz3eoahH1S22Sze90OYBzyO4K+D6Bqs5SI3WnjCwqez2rdnu
         iTFd1uAvV4s3A6A4c/8SLRfVHOaGOvn5vFVs3F5bJwOtA9pFTD5Tx9WmPfz76WMrmH0f
         5EkDDmMWY8aOEdrPUeUhEfjk3q3z4nW7ypGl6P/IfqVgtp5i/jreKPeeRWHYpsYfP8ch
         WZkA==
X-Gm-Message-State: APjAAAWZH/8F3143HaJXoPzB5/jZ5gbrSdKLvwG6Sk5+9vvQuqy1XwTE
        UfkZVfDSto6i8u9Js+UWOJ9wtlsBnl9jXB75WkQ=
X-Google-Smtp-Source: APXvYqyIjibblW7/0VVrd1vNEo550rRJJiltc6R+vr/MWuMMpXFDYg8LBm1HLn6UBjMhsneT6ByqpLOynlyNlcvvBf4=
X-Received: by 2002:a6b:f711:: with SMTP id k17mr1702760iog.273.1561603991542;
 Wed, 26 Jun 2019 19:53:11 -0700 (PDT)
MIME-Version: 1.0
References: <8C0042D8869AEA4AA334B49AFBBCEF820243C01B6A@TUT-EX01-PV.KSTG.corp>
 <20190626084139.30246-1-pclouds@gmail.com> <xmqqk1d8ch9g.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqk1d8ch9g.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 27 Jun 2019 09:52:45 +0700
Message-ID: <CACsJy8AB+YVNi07G-nFkEhexyo2TG=qeNLT=JLksDVnDvs0gxg@mail.gmail.com>
Subject: Re: [PATCH/RFC] get_oid: new extended SHA-1 syntax to control
 resolution process
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Kyle Meyer <kyle@kyleam.com>,
        "Boettger, Heiko" <Heiko.Boettger@karlstorz.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 27, 2019 at 1:51 AM Junio C Hamano <gitster@pobox.com> wrote:
> > - <ref>@{literal} only accepts full ref. No turning "master" into
> >   "refs/heads/master".
>
> This is already doable by saying "refs/heads/master", isn't it?  Any
> ambiguous ones like a branch or a tag whose name is 'refs/heads/master'
> (i.e. refs/heads/refs/heads/master and refs/tags/refs/heads/master
> respectively) won't interfere once you use the explicit prefix refs/
> like so.  I'd rather not to see this one added.

If refs/heads/master does _not_ exist, then ref/heads/master can
resolve to refs/heads/refs/heads/master, which I think is unexpected.
"ref not found" error or something should be returned instead.
-- 
Duy
