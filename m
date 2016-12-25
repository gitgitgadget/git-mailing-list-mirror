Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 075B3200E0
	for <e@80x24.org>; Sun, 25 Dec 2016 02:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752948AbcLYChI (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Dec 2016 21:37:08 -0500
Received: from mail-io0-f172.google.com ([209.85.223.172]:33732 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752101AbcLYChH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Dec 2016 21:37:07 -0500
Received: by mail-io0-f172.google.com with SMTP id d9so278470021ioe.0
        for <git@vger.kernel.org>; Sat, 24 Dec 2016 18:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9fGOKt8EEiky/JYIJ+fObjRe1T7Y20XBJPI4uvV6ixA=;
        b=W6QftflIfMDBvV8PMOxw8MUnXiSOOkaowA7RVwG48BNCyehvRuRB0VFwgm/xcceaMv
         VpBUUZMmM6VP9Gc2I6IvZw6++kG1BqF0bLERptBoRdRjUs+STgSdVoJDApFGxUNEe1Z5
         gW/veDq4WmEsbsU3JH8b2DV6nef3cnudcPhh9dDXrFEID2JNZYL2lYUOPX/OOcWGMy73
         IquJSnyEKwdZs2uNPZ7eAeGRkcWWUgnjOS9X8QPy7xNHZlpcBU/SaTMG6zqiusZxNCTh
         L2/rz7OgaWleWguCqIEHJS37iwdmUWW1yltyrkreViH1KKj3lfsQ3RauOz7Xd0tKSd7K
         zL5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9fGOKt8EEiky/JYIJ+fObjRe1T7Y20XBJPI4uvV6ixA=;
        b=kmeJe7uphB3AcD37IqulGUeKUYX995Dp9+/9ICcGVWO5Lw/mDTIABR0zzetrGb5x8C
         x3znkNtLuWmFX9f3ZYl8aQCKvTMWmAe1CYacB8gP8U8E+FnY6lWxcYrMHDpO89FNZTtl
         cyUGmx0VZ/ttb+v6K+SMtRD822V9aq+RbhrTTRKk7QV5lhVOgypmibh7W2SIRTITCP08
         O2WLyhd479P36Jg4cRX87zXlK3VFvv0J8NRRxAjr6Ng7kT5jyt75m5q5pRY02QCxqvyv
         Z4zc9JWuoJ3WjT0269wf7egEspYK2PRhnznvNkckOeIg4ujxM11lVGnUg15HLxviIYl5
         QDtg==
X-Gm-Message-State: AIkVDXKZu5d7SzmYX4E8Zk/txEXiT0nNSsLwM57PxH3qpoIloiyyJUqlOq66F/V+y/YB1/O/kdRhS/raXg1kfQ==
X-Received: by 10.107.44.137 with SMTP id s131mr17428779ios.212.1482633426803;
 Sat, 24 Dec 2016 18:37:06 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Sat, 24 Dec 2016 18:36:36 -0800 (PST)
In-Reply-To: <xmqqtw9vg4vh.fsf@gitster.mtv.corp.google.com>
References: <20161220123929.15329-1-pclouds@gmail.com> <20161220165754.hkmnsxiwbcgn6uin@sigill.intra.peff.net>
 <CACsJy8CnS1=_vA5xhbZ94Qyh7ySC5FvaALu1vhQwt_YJya4wHA@mail.gmail.com> <xmqqtw9vg4vh.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 25 Dec 2016 09:36:36 +0700
Message-ID: <CACsJy8ANbXZWOV+zN-S8c8V0aTWZ4DHZ=GVmuuAqmY=oFh8T-Q@mail.gmail.com>
Subject: Re: [PATCH] log: support 256 colors with --graph=256colors
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 23, 2016 at 2:06 AM, Junio C Hamano <gitster@pobox.com> wrote:
> If I were doing this, I'd just prepare a table with 32 color slots
> or so [*1*], start at a random spot (say 017:00005f) of
>
>     https://en.wikipedia.org/wiki/File:Xterm_256color_chart.svg,
>
> and pick spots by jumping southeast like a chess knight
> (i.e. 017->030->043->086->...) until the table is filled, wrapping
> around at the edge of that color chart as necessary.

If you want to play with that, [1] may help, which sorts colors in hsv
space, and you can select a few colors to see how they look, either
manually or by calculation. Yeah we probably get maybe 32 (or 48 if
you stretch it a bit) distinct colors. Not sure if it's any better
with true color terminals, probably not.

[1] https://gist.github.com/pclouds/616b67f0b5a9b20d74373286574cd0ac
-- 
Duy
