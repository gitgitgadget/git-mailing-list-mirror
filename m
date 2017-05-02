Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A7891F829
	for <e@80x24.org>; Tue,  2 May 2017 10:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751117AbdEBK1P (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 06:27:15 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37277 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750954AbdEBK1O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 06:27:14 -0400
Received: by mail-wm0-f46.google.com with SMTP id m123so14067811wma.0
        for <git@vger.kernel.org>; Tue, 02 May 2017 03:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YW3elmA46yWixMl532IskNod+5x0zg36djLuSp8vgo8=;
        b=GBoSlQqqqz76vGjeCT0JE1QUkjGNokVb/bzyQ6k1cznbz9ikn+axKbBDzuekuK1SJK
         nzKgYHH/j5zQCH07kvQOy5I3oCMGoKLgtIm2259tjk/Kr9fA2MWVxUITaiDez5H4PIbN
         FfYeGoj0iTF49QcUkQ4+mJrPGFpkUfQVXLXeNvXsdgJn3b/hKtf0Yc6XgGlaAJGD+vek
         Am6F4RPN5CnzvdlCCj/+kziLlFXWZeaFlkXv5IGE2pAclECdJzZ1my2wzCWT48yiHRhq
         W1IsTGDYsy7XRsx6hSazNeWIT5v+U06ro3sC3Z9DJKVNQN20cAz0xhlzT9JsZzFbcmAD
         S25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YW3elmA46yWixMl532IskNod+5x0zg36djLuSp8vgo8=;
        b=NEkG5qf/OiHAwBeTbW7oIOKry6nqYc45PPMRQOSz49j2DA+DUp/dCqN7S5CUEymMgv
         VujFSAH30dDmt17TmWTDjQ0Vu+9h6apwO89XtwcWbqENyIFIHi4N3CuzbvonHP271Hx0
         eQ9H9PumaCikmxNf9jaO9rGsyYO4gSzTWIqzL1Iod5FHGvCiqaWyi+19q3Jfn3KWHe0Q
         YYrm5KrKcdldRmGfEbTr0uKXrU4WsAGzNYvJBkDHDOJ2QwaUU6hgGFasMlA+kic+NpZ0
         6jY8F+BFcqpudVIkpMKCjMFiS75YqHAk7lrV6RSYKEx9cFUFlheuXs1v0MaHqdtE3iWL
         V5RQ==
X-Gm-Message-State: AN3rC/4ln+MRNQ3eHiQU/Cb8BmyEbW2Q4uD6lNhmq4f0JkvarzRuAS+S
        UbsAxfMYQzGp6w==
X-Received: by 10.28.92.84 with SMTP id q81mr1647783wmb.11.1493720832529;
        Tue, 02 May 2017 03:27:12 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id l201sm664840wmb.3.2017.05.02.03.27.11
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 May 2017 03:27:11 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v1] travis-ci: retry if Git for Windows CI returns HTTP error 502 or 503
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAPc5daUOQVu66RDspzScUjufJvLs7TUS0UtqTZjJ=5sMBuF=TQ@mail.gmail.com>
Date:   Tue, 2 May 2017 12:27:10 +0200
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7A4862C2-6414-481B-974E-7BEF85611395@gmail.com>
References: <20170429184822.10128-1-larsxschneider@gmail.com> <C434AB60-F2BB-44A1-B40D-449EA27E2314@gmail.com> <CAPc5daUOQVu66RDspzScUjufJvLs7TUS0UtqTZjJ=5sMBuF=TQ@mail.gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 02 May 2017, at 11:52, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> On Mon, May 1, 2017 at 8:32 PM, Lars Schneider =
<larsxschneider@gmail.com> wrote:
>>>=20
>>> this should make the Git for Windows build a bit more stable. We saw
>>> a few 502's recently. E.g. =
https://travis-ci.org/git/git/jobs/226669324
>>>=20
>> Please don't move this to next, yet. This seems not to work as =
expected :-(
>> https://travis-ci.org/git/git/jobs/227513693
>=20
> Sure. I am wondering if your other one to run both asciidoc & =
asciidoctor
> tee'ed to log files should be ready to work on 'next', though.

The asciidoc changes are good to go from my point of view:
https://travis-ci.org/git/git/jobs/227822259

- Lars=
