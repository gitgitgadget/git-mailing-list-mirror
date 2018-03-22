Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6501F1F404
	for <e@80x24.org>; Thu, 22 Mar 2018 17:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751669AbeCVRvH (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 13:51:07 -0400
Received: from mail-lf0-f49.google.com ([209.85.215.49]:42283 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751625AbeCVRvG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 13:51:06 -0400
Received: by mail-lf0-f49.google.com with SMTP id a22-v6so14450513lfg.9
        for <git@vger.kernel.org>; Thu, 22 Mar 2018 10:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JJiDyZPaY2fubUqbix5blwqCfNEXVyT+Rr6g7Bu9sj0=;
        b=098uQ5bTMpsTkD0qvBZMDKtErw/Fzrd2PCAWEKSdF0IuzPENDB0eNVGXhLeiRbh/n/
         XLUpibY2B55bOoeYHghulsEU7jTW2FH1O+vizTc873uIOEEnfcN7TIiVYKruJimaVe9H
         j7abI6BVQJJyStfOCBqGu8loxw8/5C7+bVV4ziYDCoz9/Xx7fM4p4hE9HNecwo1MwVWB
         BvOFiyUvugWgqqNeVcuuYnU/eigeRS2brH++AfMfVPszQ00vr9bI3no3g0RKlcdF5QpS
         PZILJ5TGjEjM/Q0FGikU3S8YEBXpwn3hBiVWPpmV4VwyXGq7Awq8MKdTo5/6/3t3msB/
         e5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JJiDyZPaY2fubUqbix5blwqCfNEXVyT+Rr6g7Bu9sj0=;
        b=d7QSgRJzrckRdr7eyTrGTRmfX6WwxKeMrryv6v5w6Q8+/KszaOoZACleohKeW4VmjL
         9NX21gFXOj1hB8QJD3YcDVe8XHMqIczjzartXUFlotx6sOXJ6llOiZr7Sk3m+TEF36ZI
         YtamGHO8iQgZMa/Ed7bLKS5wbaA9JDNygmkGxXy9Wr3uSTf9Aemjf5NpwwTwZ2ebC9GO
         vN8OglCDPG9V+f5O0/au7hrsvHdtHDxAwr/2nXw6+MjWxxw7ifDHOV5qoiFO3z1FBNab
         ifPa+WPu71muezMjsgR0BWrJ3Sxkuk4ORwmpFddHq1Ird6kjrhH+zR+EilXZUqu3ov0P
         EtuQ==
X-Gm-Message-State: AElRT7G3dUjiZAwTm9JRtJnBXrrtb7gLwKdTFPgIGFL+ZapmLahwXy5p
        WYgwuRlKz4DThC+Q3+7w7LaJktFnD9PMm36Zb99Qkg==
X-Google-Smtp-Source: AG47ELvWOw0lCT0N2vcQDjvniNMza1c4AXaLJz86sNxw4iHgn0MbM6ANdChHKFsTHcamLtbK46FnRmU8Qawi2ugzSbo=
X-Received: by 2002:a19:ef08:: with SMTP id n8-v6mr16227368lfh.1.1521741064630;
 Thu, 22 Mar 2018 10:51:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:9a93:0:0:0:0:0 with HTTP; Thu, 22 Mar 2018 10:50:43
 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1803221831120.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <CADzBBBb0KDVJiX2WSNW=vC6b6paWoK=5XrnZNAY+pwpcu-t9JA@mail.gmail.com>
 <nycvar.QRO.7.76.6.1803211242190.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <CAKk8isrOMMm0zyJ1JtH3aDm=tF5hwokZ0Wzn=D1BQ1R-qEPicw@mail.gmail.com> <nycvar.QRO.7.76.6.1803221831120.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Wink Saville <wink@saville.com>
Date:   Thu, 22 Mar 2018 10:50:43 -0700
Message-ID: <CAKk8isqH4uRdf4dXKpxMkNoJqpabztWNPgELqtLbSupR+_C=SA@mail.gmail.com>
Subject: Re: [GSoC] Regarding "Convert scripts to builtins"
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>,
        Paul Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 22, 2018, 10:32 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Wink,


>
> > Please see "[RFC PATCH 0/3] rebase-interactive" and
> > "[RFC PATCH v2 0/1] rebase-interactive: ...". I'm looking for
> > advice on how to proceed.
>
> Sadly, I had almost no time to spend on the Git mailing list today, but I
> will have a look tomorrow, okay?


NP, I totally understand and, of course, I now have a
version 3: "[RFC PATCH v3 0/9] rebase-interactive:"

Cheers,
Winthrop Lyon Saville III (I had to repsond with my full name although I
always use my nick name, Wink, just because Johannes seems so formal :)
