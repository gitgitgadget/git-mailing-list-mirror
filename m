Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CF011FAFB
	for <e@80x24.org>; Sat,  8 Apr 2017 08:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752124AbdDHI0T (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Apr 2017 04:26:19 -0400
Received: from mail-lf0-f44.google.com ([209.85.215.44]:32975 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751747AbdDHI0F (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Apr 2017 04:26:05 -0400
Received: by mail-lf0-f44.google.com with SMTP id h125so51549743lfe.0
        for <git@vger.kernel.org>; Sat, 08 Apr 2017 01:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WC+SuetC7AVVh8QUBJQlMoU9IiI42QH6a0ZexHia9wY=;
        b=VMPOXwMdSVVtnjUc24/ggtKlAjyCcnZ8v2CRAv0niWF1MA2MUBvSO2l8MqCAS69Tdp
         2rn1gw6Vgkew2dpTZQ0M5xuIrkVkI1cVsRWcAdUOUsQq3bo7LnjmROBRwtZKTda+Z8Ch
         gfvJaIdTwERQBkNhd20+kfq7PFgEOUZVNR/yFDohtF8KKoiGUj/o951F7TAhCknVeUT9
         DxtKcplURyYx3QUaEIG5MO85iToDXEJgAN0jHMJb2jpXas8NsaMWf4o4/xPkeLa96WG+
         ufukY4nAG8vGlFmKG2Z0sOxQX+YS9lwgdu+z+wN1YDRe9R1CFwARt1parhIdbAJ9KX7i
         /KoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WC+SuetC7AVVh8QUBJQlMoU9IiI42QH6a0ZexHia9wY=;
        b=kyo7XRpb1tMJh2jC8v3PO0i/wyRNrSPI1J/gac7REs7Hz7UPASIIneF29uUHP3xmcM
         exgpxI8K2Id7NH32KZxMEnYh+7cROeoe/4cjidkFnhzv9DR0f6MvuqzTOOSwAO7IiFB6
         +GHzOsB0r3uZ0492+El7RIrVBPcEVFNUWHDwH7VuYCtTGOj9mbQn3X2nQo1wdfdXLBCx
         NYuIvEy1Ik5JPzinT4Cy6nQMpkk+k4G0yf/zQRsLld5ZNlWQIgfbXX2X+xW+rM9Drb1q
         pxSuyQunOhdb/hJSJkuj7Nu9X4MG0doUuhTObYOwWijYbX8BIHuqXUjCnf7WimnhX2c/
         Qekg==
X-Gm-Message-State: AN3rC/74DLe9rawukDIrhMQRSrv7uCAuoTHzD/Asrkg3ODFvA+OGVVzsWC8Luz9kmA2/wEZaHQDBBLko+7NShg==
X-Received: by 10.25.24.217 with SMTP id 86mr2749802lfy.12.1491639964228; Sat,
 08 Apr 2017 01:26:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.145.30 with HTTP; Sat, 8 Apr 2017 01:25:43 -0700 (PDT)
In-Reply-To: <1491617750.2149.10.camel@mattmccutchen.net>
References: <1491617750.2149.10.camel@mattmccutchen.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sat, 8 Apr 2017 01:25:43 -0700
Message-ID: <CA+P7+xrVe7jnqpQFvYBb25ofrNqnRspdk-M6jRuwRi5sUqCCZg@mail.gmail.com>
Subject: Re: Tools that do an automatic fetch defeat "git push --force-with-lease"
To:     Matt McCutchen <matt@mattmccutchen.net>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 7, 2017 at 7:15 PM, Matt McCutchen <matt@mattmccutchen.net> wrote:
> When I'm rewriting history, "git push --force-with-lease" is a nice
> safeguard compared to "git push --force", but it still assumes the
> remote-tracking ref gives the old state the user wants to overwrite.
> Tools that do an implicit fetch, assuming it to be a safe operation,
> may break this assumption.  In the worst case, Visual Studio Code does
> an automatic fetch every 3 minutes by default [1], making
> --force-with-lease pretty much reduce to --force.
>

Isn't the point of force-with-lease to actually record a "commit" id,
and not pass it a branch name, but actually the sha1 you intend the
remote server to be at? Sure if you happen to pass it a branch or
remote name it will interpret it for yuou, but you should be able to
do something like

current=$(git rev-parse origin/branch)
<verify current is correct and then do your rewind stuff>
git push --force-with-lease=$current

and this will work regardless of when if if you fetch in between?

Thanks,
Jake
