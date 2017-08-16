Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 754A01F667
	for <e@80x24.org>; Wed, 16 Aug 2017 13:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751844AbdHPNI1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 09:08:27 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:34358 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751522AbdHPNI0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 09:08:26 -0400
Received: by mail-wr0-f170.google.com with SMTP id y96so12023825wrc.1
        for <git@vger.kernel.org>; Wed, 16 Aug 2017 06:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=XPQ5/eoDvEEyNOicnoOwdkHhFpdEQoRmylmWl2+47OI=;
        b=J5c4CBtyQY3ktpEy8YPz8XTowGGl+1f8DuznBuH8bZpT6/PzGGl7Eby2QQUWDKHj2R
         DuM1sI542+djLvsu0LXj3V+DCuX43XUfGfAzs+PB7FSLwghpmlLYNI1XG7TBO9U22byS
         ZhHU8jAH11A6XFTd2oRXZ7KXd5RpT07pzPbC3p0F+Kz+LOmYQv5BF5v/l/T2bUp59aDm
         nTANdYNZk0uzYWysIv9amzabf7XWuMxPe/ftc5pxvYKUpHpcmVD3FHb0DVZlAP+Pawyu
         Bjzo1LzMLPunoR1m6XcnkW3AFBteQTvZTsza+roUYh9Cre3GPDIPkSIUvIpoEUsstoKl
         6oJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=XPQ5/eoDvEEyNOicnoOwdkHhFpdEQoRmylmWl2+47OI=;
        b=gYSJ5X66UAuHDG75UCGvUQ399G9FVBuD0Nm4ZYaQBB9aQU+cWdCsGzYkJGFxNdIeVw
         ezapUvzpL8NOeqqx+R7mF9TzRLzIuEYE1AOjQ9QtZojjt6ptlljdla1xw8dc6W+Elwun
         x+D9HOVBw/zRhqER/7U2PgbJ74ab4R6jnBxITQO9NPB5Nqflcoed8s7DLaVR8rYrwB8O
         awjc+t2JYeJsnt+9EjDjKhOorTlHFmHRWMmpCaSYW9SoMgiOqFYO6ozGwG9gpquRcld8
         IHAwP5Ve9cRXs+HybjOJ2CasrO+aVBracVaZ3T8nc5B3SKefeycL64mTkRJGG4kFmRw0
         27WA==
X-Gm-Message-State: AHYfb5i0MU3imoVEoU4AOwwKanoFFr/z9g/j2kWim2MgVjpuNN4FKbkZ
        /HmSc2YAwO/bOLDGngW2qhBv/qbgRA==
X-Received: by 10.223.138.167 with SMTP id y36mr1282291wry.176.1502888905125;
 Wed, 16 Aug 2017 06:08:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.24.130 with HTTP; Wed, 16 Aug 2017 06:07:54 -0700 (PDT)
In-Reply-To: <xmqqo9rgr8eh.fsf@gitster.mtv.corp.google.com>
References: <cover.1502796628.git.patryk.obara@gmail.com> <ee8edaf08864d5983ff1a5150077d29a4ee17796.1502796628.git.patryk.obara@gmail.com>
 <xmqqo9rgr8eh.fsf@gitster.mtv.corp.google.com>
From:   Patryk Obara <patryk.obara@gmail.com>
Date:   Wed, 16 Aug 2017 15:07:54 +0200
X-Google-Sender-Auth: cvEWiZT8nCZYut3NlJIswdXHWY4
Message-ID: <CAJfL8+RVNYh1ryZ5EkiWxiZRo3Loq-MjujD94zGBMEGykmSWeg@mail.gmail.com>
Subject: Re: [PATCH 5/5] commit: rewrite read_graft_line
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> I am not sure if this is a good approach.  Just like in 2/5 you can
> use the MAX thing instead of 20, instead of having each graft entry
> allocate a separate oid_array.oid[].

Once MAX values were increased memory corruption was caused exactly by
this line:

> - graft =3D xmalloc(st_add(sizeof(*graft), st_mult(GIT_SHA1_RAWSZ, i)));

I could've replaced it by:

    graft =3D xmalloc(st_add(sizeof(*graft), st_mult(sizeof(struct
object_id), i)));

But it seemed to me like short-sighted solution (code might be broken if
object_id will be modified again in future).

> Is this because you expect more than one _kind_ of hashes are used
> at the same time?

Yes - I think more than one kind of hashes will be used at the same time
(meaning in single git binary, not necessarily in a single process), at
the very least to allow read access to repositories in "old" format(s), wit=
h
sha1-based grafts. Using MAX for parsing here would prevent this,
requiring either modifying grafts code again in future or forcing right now
some unwelcome design decisions down the line.

My goal here was to make this code compatible with whatever hash
function transition plan will be chosen.

--=20
| =E2=86=90 Ceci n'est pas une pipe
Patryk Obara
