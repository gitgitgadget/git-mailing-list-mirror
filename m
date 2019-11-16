Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B5411F4B5
	for <e@80x24.org>; Sat, 16 Nov 2019 08:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfKPIaF (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Nov 2019 03:30:05 -0500
Received: from mout.web.de ([217.72.192.78]:50393 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbfKPIaF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Nov 2019 03:30:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573892996;
        bh=qYjTsqm/jZgnkR5Swi+zPm8c4+lS5Hzr7rnDd+DmsfA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=C9DeRTi5Wg6VjReU8sFgbTYQ5cPh8zMvMIMmxmdWIYyWchcZZGLsahK3cH5lVAnvt
         l8Sn4vC8e1Q0uIMW0+dMOOfUfske4+LcdEXwWQIgNfwRyP2qJRligBQOz7JMOxQ5Gi
         MUa4wed8Z9fmzlLDzU+x4fLCV7HW9bXYOUtFJuZ4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.243.152.34]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LetUp-1i5ag703mJ-00qhT1; Sat, 16
 Nov 2019 09:29:56 +0100
Subject: Re: [Cocci] git-coccinelle: adjustments for array.cocci?
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Coccinelle <cocci@systeme.lip6.fr>, git@vger.kernel.org,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>
References: <50c77cdc-2b2d-16c8-b413-5eb6a2bae749@web.de>
 <5189f847-1af1-f050-6c72-576a977f6f12@web.de>
 <xmqqa790cyp1.fsf@gitster-ct.c.googlers.com>
 <fe9b8c08-6fd4-d378-f3ff-8170381b10e0@web.de>
 <xmqqr22b9ptk.fsf@gitster-ct.c.googlers.com>
 <ba5d609a-16ea-d7e9-66e6-19aab94b2acd@web.de>
 <53346d52-e096-c651-f70a-ce6ca4d82ff9@web.de>
 <6c4ef61f-5fef-ffc8-82d6-ee42006756b4@web.de>
 <aed296a6-bae0-6fcc-515e-ef96fed24ca6@web.de>
 <6fffd13a-738b-e750-9f5a-f0bfb252855b@web.de>
 <94301b9c-a397-ae04-c617-92679f4bb018@web.de>
 <alpine.DEB.2.21.1911152000170.8961@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <22a03cac-160b-51be-b015-54ac600d3e92@web.de>
Date:   Sat, 16 Nov 2019 09:29:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1911152000170.8961@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:csgwpmRM3I/du8yLGJZ6gKQfXvaDQ+9wwnHDEeOyuUvOGUd6NuF
 N/my9nNqlKN4oG8uAGtSklWS0XdMhI/pDK2tYauS9L41sx/XYcfq9/rM/nYcjPZDddytgiF
 zn4ZUkQd9+eb4O4IUkVBmEirgYEWuPcQv1dOOeabtYswGCtUM6grJpsfVUNevTeE45O+GIW
 3At2A+nX3tuh9yz+HjhGw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/lCmsZuzCTA=:6+kaiS6vuC0pJc//+pomj1
 TXfBfXNlMa1Qs2rPIt4xMpZofc44cPUzKSzACEw5ypoL2bLkyQctqfsQ8RhTF4FlHuo6Pbop7
 4vh3P90s6FdShsUZ1jV67WttBHeQcCw6WsAAbB6dGhKLTcrh2YOlSXGLCNqOsQlqTJAH1NyVX
 RDOYYmU1i1C6j7tgDL4aw1DehEJxu3m+HCL2AXRCf7MDr15IEAq4JbGeo1/L08jf2kNvJS84G
 uJ9bqKZ0atD3PAKLEO0J1pZV3fPQxfiz7NBC2LWiA2I5QD64lFw1hjY1YGJjiie+umILkM1zB
 6aTOH1+B3jjsdooz9WTW8BHZtUgoNleSuGB0ZYe/CgYIXUbPq/k4SMqIDqdGTrNwnNmaJ/fDb
 X4aybele5utaztaHKRU7t/Gs9wtx+DeSQspKr2DHcYGWl2y+ETvI2UX6qc4q5zmiGp7SyeiDs
 Vbw4mtrsmL9T9U66BMS0C+1/qSFnDgC9B11/vCyasujuuvGyM16cZYRp2LDiEJCh24xwPmZeB
 rL8ICN/m28UQT7fg4uzYtt6CGqgIHkqKwnLINRqFnQfuGXAQl2k+XxAL8BGLRkR4jzes13ZIA
 x+g+j9BqwY6vHs+unllkwhBJ6RmvU/+3vFZBwOcGhAJsFeIE7ErAsKyT6hDgUQ9ZPeK5OgjaI
 n7+4teXmUIEqshltz1lTSovajdUwkuC5TnAwGwOyhDbAqQA0qR/+Ds+7P3v4f0Zhuh8hvNJ+D
 z7sr+XpzWY1irsEC7CK2eJ5Vf5QdzVjLx/0J83JUA5TxuudNmcsURtPDVrqXhdRTLU8jHNLk8
 grbwQKCGXhd5okWaUTzQE8mddz2skkudpSSnojUXv4RYvVAohYSUTTH4ZBVyeZUyaNANMDgxU
 v02Wq+b/SP3BCLUfL9zH9pChVJ34cPLDwiEPnNqYl1Kj0MzULOG2umJjwDFZDS/xMaADVVljv
 RV0PV35jQD0NF1OpYJ5tyMt3Qi9yL9b8iyw+eqZ5YruoHduzLcGKWdvN4HOdof3IBEn0AwpF9
 HhiwXiMMxdjk806C7ZSyC1A3xM7sxumYCw8kyhgyfCu8NZ3a3VuHoQfW+pK6S/lg1Ft7NN7rm
 AuDfmlrIrR3sk6iMcvJ6L5pDQO4kHcSyPeOfzPWCDgLaUyaSqy0lQRYpScuXfikleZB+m4roL
 eXdygpume8YlaO3JfViVPulk4HmXRmZ4S1DR5jIGRkTXVjCsNPsSuh9YQZtcKZQViJ2DA0Psu
 IFE71QRgDA3cu94j1SGc9JnV7T57nCbRTj7PUf5YtywOd73+Bs+xUFlfYIW0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> It can determine the type of t->entries if it has access to the definiti=
on
> of the type of t.

I would like to point another implementation detail out.

Another known function was also an update candidate.
https://github.com/git/git/blob/9a1180fc304ad9831641e5788e9c8d3dfc10ccdd/p=
retty.c#L90

elfring@Sonne:~/Projekte/git/lokal> spatch contrib/coccinelle/array.cocci =
pretty.c
=E2=80=A6
@@ -106,8 +106,8 @@ static void setup_commit_formats(void)
        commit_formats_len =3D ARRAY_SIZE(builtin_formats);
        builtin_formats_len =3D commit_formats_len;
        ALLOC_GROW(commit_formats, commit_formats_len, commit_formats_allo=
c);
-       memcpy(commit_formats, builtin_formats,
-              sizeof(*builtin_formats)*ARRAY_SIZE(builtin_formats));
+       COPY_ARRAY(commit_formats, builtin_formats,
+                  ARRAY_SIZE(builtin_formats));

        git_config(git_pretty_formats_config, NULL);
 }


This patch generation can work based on the following SmPL code combinatio=
n.

=E2=80=9C=E2=80=A6
expression n, x;
=E2=80=A6
-      , (n) * \( sizeof(T) \| sizeof(*(x)) \)
=E2=80=A6=E2=80=9D

The asterisk should refer to a pointer expression within a sizeof operator=
.
I got informed that the semantic patch language would support such a restr=
iction.

Thus I have tried out to specify the corresponding metavariables in this w=
ay.

=E2=80=9C=E2=80=A6
expression n;
expression* x;
=E2=80=A6=E2=80=9D

But the shown diff hunk is not regenerated by this SmPL script variant.
How should an array like =E2=80=9Cbuiltin_formats=E2=80=9D (which is even =
defined in the same function)
be treated by the Coccinelle software in such use cases?

Regards,
Markus
