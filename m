Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0835A1F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 12:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbeKTXVE (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 18:21:04 -0500
Received: from mail-yb1-f170.google.com ([209.85.219.170]:42191 "EHLO
        mail-yb1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728242AbeKTXVE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 18:21:04 -0500
Received: by mail-yb1-f170.google.com with SMTP id o204-v6so668011yba.9
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 04:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kfNEx+O71xtrLvdsgZ/yiRilLkAyWD5qdMZ91FYTpV4=;
        b=YnOyolumCvcPThLhyilseJRmZ/ma65uTJdV6Pih2JuNILR0L/HfSxRMUiDjdZ7d6bY
         5nOlr8Ih+B46Odid4T+1abfkyei/rlP6AUr/+P0GvkFbf7puEQRozO8N9Q7ggwSlrxB5
         hczhqTyhdsu+DsGJKrMYt+HiAMrU6k1fAGQ09f/8lOCDeSxbzUq+h8iK52MbKG8h6yPz
         xepIiK8cC2u2V5oWMSdq/7qFsipy+MdHR7jMwZJeY8+mxhUxIMgGZf3g1XqgIZ4+pb8g
         22JY/yk0cLMO2h2qDtARJpNHvY2YDAi0AWGrg0riZ/3KQxF9mnSBoR7nxPQkNPE8DA74
         ENHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kfNEx+O71xtrLvdsgZ/yiRilLkAyWD5qdMZ91FYTpV4=;
        b=FEnssFBDvGZOITXvYn++e3aSLi1thISIJ/4OqL3UzxUlJxPHGKXPof2sFzO/owpbM0
         wGmAx2HvdasrA4Mo6ktKDlT/j1n1VH+Y8bm2vGm5uzzmO8gSznEP3kdZgV575hs72PUb
         YX7a/kSfNLOU88W9fIFcH+e8DIMFIL+RuAfZUHTwp/1YWy2hpaFAMHa1ykO95LWd+zh7
         o8SbFHW0EjxjIIT3+QsO/fUPx81v2axaKa4cmDJPvjDH0VJgcmOJi5I2lVu8zr5D8XWv
         rhnpw0dtTvpAgXgyfbseaeW8NJsbBlgdQYiRHzbTLD7QpFB6OBDiG4avf6iASp7zYBL1
         LUWg==
X-Gm-Message-State: AA+aEWa4ib8p3w3LF2FOlxDmPYY0ZOPYPmfemlCI3KSzPoCiOsvjvUUH
        I/oHefuwqphI41sCMYEMYjZaFsAcHd6z8E2Dc4QKEC39vXg=
X-Google-Smtp-Source: AFSGD/W3JXzR745Zg31ObQBzu0n78EWhHh9kSfdhF6u/v4ZtAce+Q8iCfmpaj5gIBYZxFfL6Uw7T6XNex8BKP8Ndhv0=
X-Received: by 2002:a25:2ccb:: with SMTP id s194-v6mr1553728ybs.415.1542718323800;
 Tue, 20 Nov 2018 04:52:03 -0800 (PST)
MIME-Version: 1.0
References: <5bf18396.1c69fb81.20780.2b1d@mx.google.com> <20181118154124.GA21680@tor.lan>
 <CAAXzdLXSJU5bC_D1Q_gCWqKG7mcdcAvRkiYzano-VsrRRxazDQ@mail.gmail.com>
 <20181118171525.GA25854@tor.lan> <xmqqsgzydj6n.fsf@gitster-ct.c.googlers.com>
 <005801d47fad$345d5a70$9d180f50$@nexbridge.com> <xmqqbm6leo7g.fsf@gitster-ct.c.googlers.com>
 <bddb9e06-2688-c459-9467-a3f0978866f9@web.de> <CAAXzdLXCEeZdkCXT+-0n=Fn7_=Nz5cm+6xr0w-cd6B1om028uA@mail.gmail.com>
 <9bee0f47-d1fb-c483-2597-d8edb1ed36de@web.de>
In-Reply-To: <9bee0f47-d1fb-c483-2597-d8edb1ed36de@web.de>
From:   Steven Penny <svnpenn@gmail.com>
Date:   Tue, 20 Nov 2018 06:51:57 -0600
Message-ID: <CAAXzdLU3dsCabgYKnD9c7iWZcXx1cfO3tisJ7r0dNjiiTHk1mA@mail.gmail.com>
Subject: Re: Cygwin Git with Windows paths
To:     tboegi@web.de
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 20, 2018 at 4:36 AM Torsten B=C3=B6gershausen wrote:
> Could you please post a "git diff" of your instrumented code,
> so that I/we can follow the debugging, especially what the printouts mean=
?
>
> I think we need to understand what is going on in abspath.c
>

diff --git a/abspath.c b/abspath.c
index 9857985..09548e5 100644
--- a/abspath.c
+++ b/abspath.c
@@ -14,6 +14,7 @@ int is_directory(const char *path)
 /* removes the last path component from 'path' except if 'path' is root */
 static void strip_last_component(struct strbuf *path)
 {
+       printf("strip_last_component, path, [%s]\n", path->buf);
        size_t offset =3D offset_1st_component(path->buf);
        size_t len =3D path->len;

@@ -30,6 +31,8 @@ static void strip_last_component(struct strbuf *path)
 /* get (and remove) the next component in 'remaining' and place it in 'nex=
t' */
 static void get_next_component(struct strbuf *next, struct strbuf *remaini=
ng)
 {
+       printf("get_next_component, next, [%s]\n", next->buf);
+       printf("get_next_component, remaining, [%s]\n", remaining->buf);
        char *start =3D NULL;
        char *end =3D NULL;
