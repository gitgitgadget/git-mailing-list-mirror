Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB77B208D0
	for <e@80x24.org>; Thu, 17 Aug 2017 18:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753459AbdHQSV3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 14:21:29 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:38833 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753327AbdHQSV1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 14:21:27 -0400
Received: by mail-pg0-f44.google.com with SMTP id t80so20391597pgb.5
        for <git@vger.kernel.org>; Thu, 17 Aug 2017 11:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7P0TnElR/2FXoWtW6/9Fe1ZfZ9DPK3SAt0C2LfvaUmQ=;
        b=iwZNBSamSZ6T3BCrTP5GXiYS1ROEwzpJUNdIeq1eyEj+zOLFq+mGRMlG/xoLVFRqZ6
         uV3h+FzAN7uO/ykYF12JeRTJLAD4+oi4Ldmp5jscZI5+pGYzFnv/XqZ9f5qIKrzIZ8Z0
         VKW0cAKNG4KhsgSjyAYPRZh8SA6kp3v7kZXlDrkIS0dakeIWTvGfdZpdz7cL1UPoQver
         L+SrFAFyXA3bgYI4fpQnVnkSBrQHEOdMW2x0YBQfKB5VrhBGx314qsOdEUD7gm1pGzqH
         Cd0cYuDrujhCAlaQeHle4IRc0PKvKWhg7LxRbDVnU4B0TIeF8WI30nH1Rcq4825Tn5WN
         U9Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7P0TnElR/2FXoWtW6/9Fe1ZfZ9DPK3SAt0C2LfvaUmQ=;
        b=gWXm1q4YFp3kRWI/bIXxfp4tSKmT+CkY0IRzBN68J8jdleaJCwAe0Q0VrHTjKdL7zf
         kKr/t0CtwVtcDL6NRCYnEXD0Sl740JRGUJIzrnQvhyAxLtVAzsNFHJBejSAvFuPMnyy6
         NEUTbMBN+vX67PI+/vk+AjW2ZMqWIEedmHeyUcr4UKW4MmsbrbiYoGXzGviLCVBxUIO/
         Z+uA0B7O3KPFpifXQ18DZTJx5edna8X/UBf+3oe2W120MUedkvAvxHtr1Uv5lva4IaTf
         Dj0qcbCQb6YzrVDXnUPCdTLsg96qIzvdxTKZwymzwmB13wntSOhqYrdLzm5kqdt2zRm0
         yUnQ==
X-Gm-Message-State: AHYfb5jgKiH/v7Fz2epHQb7ahlrkq14SSpL49CX1uZj5E9rxFckCa9uc
        PaT78A76EX/n+sYWLzQDxaix/mQzRg==
X-Received: by 10.98.89.140 with SMTP id k12mr6225182pfj.71.1502994086594;
 Thu, 17 Aug 2017 11:21:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.37 with HTTP; Thu, 17 Aug 2017 11:21:26 -0700 (PDT)
In-Reply-To: <20170817025425.6647-2-kaarticsivaraam91196@gmail.com>
References: <xmqqy3qluck4.fsf@gitster.mtv.corp.google.com> <20170817025425.6647-1-kaarticsivaraam91196@gmail.com>
 <20170817025425.6647-2-kaarticsivaraam91196@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 17 Aug 2017 20:21:26 +0200
Message-ID: <CAN0heSquaXk421sR6Ry59C+er8n26nC93=3KG1wD0xNXZkuiGw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] builtin/branch: stop supporting the use of
 --set-upstream option
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17 August 2017 at 04:54, Kaartic Sivaraam
<kaarticsivaraam91196@gmail.com> wrote:
> Helped-by: Martin =C3=85gren <martin.agren@gmail.com>,  Junio C Hamano <g=
itster@pobox.com>
> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>

I didn't expect a "Helped-by", all I did was to give some random
comments. :-) I'm not so sure about the comma-separation, that seems to
be a first in the project.

>     *  The option has not yet been removed from the synopsis of the docum=
entation and I think
>        we can't remove it from the 'Synopsis' porion of the documentation=
 as it doesn't make
>        sense (at least to me) to give a description of an option not list=
ed in the synopsis.

The "git interpret-trailers --parse" thread nearby is adding some
options without mentioning them in the synopsis [1], and those options
can actually be useful, whereas "--set-upstream" only results in a fatal
error. So I don't know.

>        Moreover, we have to state the reason for not supporting it in som=
e place.
>
>  I guess the phrase 'no longer supported' is equally communicative. Let m=
e know if that was not
>  a right decision.

I think it's ok. Of course, I know exactly what you want to say, and
why, so I'm biased. :-)

[1] https://public-inbox.org/git/20170815102334.qc4w7akl44bti44x@sigill.int=
ra.peff.net/
