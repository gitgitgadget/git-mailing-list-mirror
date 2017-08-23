Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4425920285
	for <e@80x24.org>; Wed, 23 Aug 2017 22:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751061AbdHWWL2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 18:11:28 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:35866 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750715AbdHWWL2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 18:11:28 -0400
Received: by mail-yw0-f193.google.com with SMTP id e132so515341ywb.3
        for <git@vger.kernel.org>; Wed, 23 Aug 2017 15:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Nc60Ed7v/ogrtAKWWoIFmGOY2+zrQ1hmjpnNj7DY+Rw=;
        b=cmX4W1FaaVBK+clcjn9piwAHNdaobolBgb3ZR9rlkwrgmQkHdeN4fsOKsksprOzzr1
         FHQlKJJFe44Hfi7dPOnOARF68sfGBZ3zeUDGCYIfIvxk5DuzB7zawR2U3iYlwKgXfVUW
         xQGl1O23wXgXjts3/n3Su9IinHHdM9otwAHo2R7fh0O92VIjuqxoOHo2/OOq6T683ac9
         6F6k0Ih6m/uyY10zxL7hBX1ZImbxZke+vsZgi4foJJy/MeLNAqBdOG3UxpdyGlF+N2KJ
         ad6bQs6tpDlXYnMDt1KGjCS8WIibbN8QaBbo+h1ENYf60eq6JzeixfCS4sABIVPQZXCM
         gpYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Nc60Ed7v/ogrtAKWWoIFmGOY2+zrQ1hmjpnNj7DY+Rw=;
        b=YBT2EdBWX5eWB5tISuOhm+yWt0htZ973iyG5/xwWFIE3D/O/3HKQK0FiU+3XSe2FsE
         d/zH5e4F2XnTEeQlWUrjoD7+STPDibnB8eyQwBMBFAauQ28LyT7yyWD4+xc9svMdHN1T
         INZzk6fs9Laik2/s+WCDTGntXp//drFVmp2OzIzNSPuyFWqMSy8bzmVYj8K6A8xWNJEJ
         R1ET51YwmTyrpsgEMY2cbx2b6mrYVuBOY1/pMGbIORnkjvJ/jQcgf8X9wvwNbTX5/xmr
         N+Au+MYB7P9PnIiO0CM1N/bYjcWKhmvuHGLHqBE5Ew7ocxNcF8TTMxCu+nTBgN5jLO3e
         Yo7A==
X-Gm-Message-State: AHYfb5iJlpamZ4vydw5BXhJJCHRLgioEsWvvAWIkn3fk3w94RYciYpCN
        nQpIzmYljHjHvm1SiBhubNLVt+Dsnw==
X-Received: by 10.13.233.198 with SMTP id s189mr3318855ywe.32.1503526287117;
 Wed, 23 Aug 2017 15:11:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.153.133 with HTTP; Wed, 23 Aug 2017 15:11:26 -0700 (PDT)
In-Reply-To: <CA+sFfMdMgrGBhECegBe09c38nRM+Zt5JK4gJaZ96DO-9zC-8qA@mail.gmail.com>
References: <cover.1502780343.git.martin.agren@gmail.com> <cover.1503323390.git.martin.agren@gmail.com>
 <dccd3e75fcd1b2de93263e8373a3b4cd5da0dd32.1503323391.git.martin.agren@gmail.com>
 <CA+sFfMdXv+nqpXmwfLTHtkRLuGkAEAwWXZCvOryVZ=aLb_UmbA@mail.gmail.com>
 <xmqqh8wyxag1.fsf@gitster.mtv.corp.google.com> <CA+sFfMe56itAMDXOJybf0yHj+BqU1Ai1aU7inoTG3FJtdtZxyw@mail.gmail.com>
 <CA+sFfMdMgrGBhECegBe09c38nRM+Zt5JK4gJaZ96DO-9zC-8qA@mail.gmail.com>
From:   Brandon Casey <drafnel@gmail.com>
Date:   Wed, 23 Aug 2017 15:11:26 -0700
Message-ID: <CA+sFfMf7nerBhm5jZ+sDJdGbTbLz_JXyqkSPGOA8o9mOE-7Khg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] strbuf_setlen: don't write to strbuf_slopbuf
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 23, 2017 at 2:54 PM, Brandon Casey <drafnel@gmail.com> wrote:
> On Wed, Aug 23, 2017 at 2:20 PM, Brandon Casey <drafnel@gmail.com> wrote:
>> On Wed, Aug 23, 2017 at 2:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Brandon Casey <drafnel@gmail.com> writes:
>>>
>>>> So is there any reason why didn't do something like the following in
>>>> the first place?
>>>
>>> My guess is that we didn't bother; if we cared, we would have used a
>>> single instance of const char in a read-only segment, instead of
>>> such a macro.
>>
>> I think you mean something like this:
>>
>>    const char * const strbuf_slopbuf = "";

Hmm, apparently it is sufficient to mark our current strbuf_slopbuf
array as const and initialize it with a static string to trigger its
placement into the read-only section by gcc (and clang).

   const char strbuf_slopbuf[1] = "";

-Brandon
