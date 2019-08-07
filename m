Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCE1A1F731
	for <e@80x24.org>; Wed,  7 Aug 2019 13:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387981AbfHGNJH (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Aug 2019 09:09:07 -0400
Received: from mout.web.de ([212.227.15.4]:49231 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbfHGNJG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Aug 2019 09:09:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1565183342;
        bh=5syvMQWVIsQaCmRocbkSA2sBjepuQEoaCbOQfmTI8Wg=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=qV3N1Kg6EBvv5Bke1+S446Ne3hx85Ec5A8gQbUfTa/g4WOaHbk7TwyOjSp71YfWff
         n+3lUGL0GVqM2o3owXBodI5O18YGWfEkd95aixz4XBz/HfQhb1EUjNj2qJsvFa4iQY
         g0/938rncujLmRIoHjL5HbZyOtcbEviP3whE6uFA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.24.71]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MCZfe-1i3dPQ2dAg-009SEE; Wed, 07
 Aug 2019 15:09:02 +0200
Subject: [PATCH 2/2] nedmalloc: avoid compiler warning about unused value
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
        avarab@gmail.com, michal.kiedrowicz@gmail.com
References: <20190806085014.47776-1-carenas@gmail.com>
 <20190806163658.66932-1-carenas@gmail.com>
 <20190806163658.66932-3-carenas@gmail.com>
 <ab8a378c-0a60-9554-b2dd-ecb3d05229cb@web.de>
 <CAPUEspip98Mq8FrKTOkEikZhaLPprZXf=E2x3d0b7=c7e5+Gyw@mail.gmail.com>
 <c7f08e19-88a7-ca7f-90b9-54465e621d49@web.de>
Message-ID: <5933e4d2-8141-efd9-9ed4-76946a84974b@web.de>
Date:   Wed, 7 Aug 2019 15:09:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c7f08e19-88a7-ca7f-90b9-54465e621d49@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ik0G8RVWw3b/wCo6ZO6vUu19GqdFj7/KeLZUzuD2WLvWAxDXdXB
 FJtLqzffXK/oWxEWAPOujDhwGc6ekZWdloKDaz3x5V2hRxW8AujR0g0Zh236LZE2fpqS0Hd
 Shc/J91ime1ODMXXqMcRYgOdTNtzdxAEYYTL9DiX93RIPqp1blsLQBdqojoP2Tl8UbtXobv
 alhbjKxrMQAYo6qTJ+mQw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S8JJSBgwprc=:FClAZEh3wPMNAs1aS+z9xi
 Y8khAXoZlxWxt45Hk7JJkecJEoTwNa2Bd+Mp+tDt7POa8rBNAYmnJtAwMP/ofl3NzO/80Ige8
 tFQoWFn+0a/knMy8s5Gay9rUaJKjseQcK1lCfndIG4QmZgEIf3ILpmKmhwHGLju4+Iym3zZRq
 zKiaSci99Fg10k898ofFqBKAZ6UbnRYgE9UBV/iQxzAPenMMPEmd5xi9pg5HnQF+06HSccGIK
 bxfQs+aJI10+FZCe9kUxlsbtN5y6841luQER0erqtvjB2yEi7VSn0bkVouRD9z6M4a2WFE0TD
 Py6dwEWrA3l6KqQxoL7QO8HVv4SDTmOT4CIF0V4xnF0FXU1kD6KM38AeNz/70+h8VrVY8zspJ
 V5nR9mrPurVcvEKOjIxzLvipuhLOoX50vD9uxJCKntDO0MJgun3s27d+QLbILGMyxZH2v8fsg
 S+C1rJUzVsZ8V2LRLHu0EOziJS2tsiQTBMVLn+Z6k8mZF9rHHbPlRmDk8uDyvaJo0M+JDOzG/
 x54XAhcU0OIenvQQcAIUtSoVntrBGaPlWQh3XwnhzPeG5vq2tMLKDqX+K4ZwaYe7BN5R2rbkR
 9SG5uGi8HuZ2qe8vOIIgnFF6zbgVoZwelGGhpscU+SYSx3+jKbhDj/Cuo+ESRRE8XtEp/+BbA
 MiIc76qbGK/UhirwAk07R0DEHNTSQGZCsIGXe7Im2WX35Sc7coVRUOHQPt89Iuumu7wmxZHk+
 RY9tNeEC2nl78qZ6UK0PG5NR7grdqxHzRylkjsP/QNRRZS9KBLgcnC7MWqmdwh01AZ07WJ8s9
 7FCFFpGDYm5yKh8pzGtkeq99YoQW2bZpdjuQo85zNoORStn3UbSfu/izvtWCS1w5z3so9+xgR
 t087l5kbzJyzo6BjVgHOYNVo+g7T/fUoFM5HW92UTFeW6NqVmVMdAbXd1mcVEeORUo+SDTYdH
 48O8ZCNO+3Ru9WqPHdbV8Rz6qgZ3n9o3goFvOAUWXIG9vXXlp3MnpwQi/2PUH8ojOPDL/2BHA
 ShL3qHQd/DbhzStV3wX5USyDBgxER72oManlMvBtY+2jETaDXkURaCMrIwLBhSFYKyTxve7aU
 924DgqDG757l0gjTeJAnVIeZv4M2of9AxTvvsjKEp5JKhzjCCk6pq34gFTtZBgwPYBsELfWCp
 gZG80=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Cast the evaluated value of the macro INITIAL_LOCK to void to instruct
the compiler that we're not interested in said value nor the following
warning:

In file included from compat/nedmalloc/nedmalloc.c:63:
compat/nedmalloc/malloc.c.h: In function =E2=80=98init_user_mstate=E2=80=
=99:
compat/nedmalloc/malloc.c.h:1706:62: error: right-hand operand of comma ex=
pression has no effect [-Werror=3Dunused-value]
 1706 | #define INITIAL_LOCK(sl)      (memset(sl, 0, sizeof(MLOCK_T)), 0)
      |                               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
compat/nedmalloc/malloc.c.h:5020:3: note: in expansion of macro =E2=80=98I=
NITIAL_LOCK=E2=80=99
 5020 |   INITIAL_LOCK(&m->mutex);
      |   ^~~~~~~~~~~~

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 compat/nedmalloc/malloc.c.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/compat/nedmalloc/malloc.c.h b/compat/nedmalloc/malloc.c.h
index 88c131ca93..9134349590 100644
=2D-- a/compat/nedmalloc/malloc.c.h
+++ b/compat/nedmalloc/malloc.c.h
@@ -3066,7 +3066,7 @@ static int init_mparams(void) {
 #if !ONLY_MSPACES
     /* Set up lock for main malloc area */
     gm->mflags =3D mparams.default_mflags;
-    INITIAL_LOCK(&gm->mutex);
+    (void)INITIAL_LOCK(&gm->mutex);
 #endif

 #if (FOOTERS && !INSECURE)
@@ -5017,7 +5017,7 @@ static mstate init_user_mstate(char* tbase, size_t t=
size) {
   mchunkptr msp =3D align_as_chunk(tbase);
   mstate m =3D (mstate)(chunk2mem(msp));
   memset(m, 0, msize);
-  INITIAL_LOCK(&m->mutex);
+  (void)INITIAL_LOCK(&m->mutex);
   msp->head =3D (msize|PINUSE_BIT|CINUSE_BIT);
   m->seg.base =3D m->least_addr =3D tbase;
   m->seg.size =3D m->footprint =3D m->max_footprint =3D tsize;
=2D-
2.22.0
