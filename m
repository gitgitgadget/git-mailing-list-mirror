Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2D08208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 17:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752611AbdIERKW (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 13:10:22 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33672 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752167AbdIERKV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 13:10:21 -0400
Received: by mail-pf0-f194.google.com with SMTP id m1so1940487pfk.0
        for <git@vger.kernel.org>; Tue, 05 Sep 2017 10:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OgUb2bJQvlocvBQaJ8w1WWpHNDb42LWAcFdwvynVEyQ=;
        b=RFHwiHSwEXpk8iUoUrhV0jpxaKqbApoe4BYcDZ6jA7TMz6NnCySxrQBbVL7uutTj8I
         QcsWKRycJiSz/WbJ6+TnACUDshf3ReP+YYh8xZEzOX/TIxzXLlvaNkuSRVo6QW7Se17D
         0hljID21g6oP0NaIJRTG08TfJYXNuuZBbBNzeEisdqkZA7O3CVLyd/CWipbohMVJm17E
         Oxw5EKs2ozLRRfrtQzgpaoXcpjzro+LtfSd7VIogBm0AxFyTwguLLtBQBa72s8WA4mrs
         YfI8QmdBGLFDn47UWrxCccPY1VCg+1UoG8450/9WtJKPiDy29XRd43U/Lvbi+P3YO7qN
         S8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OgUb2bJQvlocvBQaJ8w1WWpHNDb42LWAcFdwvynVEyQ=;
        b=AAyGpahzSOkB7ccVI2tnQ7/LS4lFfGfy1twYFZleNg58w5//PCctBrAdjx5vfyHJqZ
         XQiJ+fCanuATNmbXfiCAJSJfz56JjxPLoRk4eAnDu53v6MteehuLaGGNc/5W9F++Ewb3
         M/yABFDZohnwXByQxTlib440vPzscx8ciwabRAYByzO0bHGYKvpzX3RsP4VzNwuaPBB5
         o7g4PKVLzqJulOKsJn6dZS4CEzR08ocCC19U1Mg1z77gk7CylKiBamcf3VAYomz6+9a7
         7ZtKb/uBSOtVTArS7GkbrXSkursOZKRd3+kqJdZ3DD2pRj6lti3blpNZ7fsMWMIzw9ej
         OvWw==
X-Gm-Message-State: AHPjjUjduEgX9PKPtcSH70agQAuWLTgDl41h6gnfzw+0cqNWSDo/PR9B
        Jb13+ReZ4Vapeo/tXkPGugJ52zu0nlrI
X-Google-Smtp-Source: ADKCNb42NcWggHe9ysT2OOtpXLN0KKb4axSrjxEQSjWKUQdJp5sagyMcppPMpvyQtKF8dlpGxRGHm17Ha9sFPFjWmKk=
X-Received: by 10.99.98.70 with SMTP id w67mr4684241pgb.362.1504631420942;
 Tue, 05 Sep 2017 10:10:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.142.73 with HTTP; Tue, 5 Sep 2017 10:10:20 -0700 (PDT)
In-Reply-To: <fe9a4b1a-14e0-04af-15aa-d687118f34b5@web.de>
References: <20170830175005.20756-1-l.s.r@web.de> <20170830175005.20756-18-l.s.r@web.de>
 <CAN0heSopzQdkO373_eTHM8=z9fAWJFhyo6a5tVPWW-j8p0V2xA@mail.gmail.com> <fe9a4b1a-14e0-04af-15aa-d687118f34b5@web.de>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 5 Sep 2017 19:10:20 +0200
Message-ID: <CAN0heSpZJdtbJZf3_QbDnj2wFzJtQv3BmOJcgeKSRTwWWxtuEw@mail.gmail.com>
Subject: Re: [PATCH 17/34] mailinfo: release strbuf on error return in handle_boundary()
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 31 August 2017 at 19:21, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> Am 30.08.2017 um 20:23 schrieb Martin =C3=85gren:
>> On 30 August 2017 at 19:49, Rene Scharfe <l.s.r@web.de> wrote:
>>> Signed-off-by: Rene Scharfe <l.s.r@web.de>
>>> ---
>>>   mailinfo.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/mailinfo.c b/mailinfo.c
>>> index b1f5159546..f2387a3267 100644
>>> --- a/mailinfo.c
>>> +++ b/mailinfo.c
>>> @@ -911,48 +911,49 @@ static int find_boundary(struct mailinfo *mi, str=
uct strbuf *line)
>>>   static int handle_boundary(struct mailinfo *mi, struct strbuf *line)
>>>   {
>>>          struct strbuf newline =3D STRBUF_INIT;
>>>
>>>          strbuf_addch(&newline, '\n');
>>>   again:
>>>          if (line->len >=3D (*(mi->content_top))->len + 2 &&
>>>              !memcmp(line->buf + (*(mi->content_top))->len, "--", 2)) {
>>>                  /* we hit an end boundary */
>>>                  /* pop the current boundary off the stack */
>>>                  strbuf_release(*(mi->content_top));
>>>                  FREE_AND_NULL(*(mi->content_top));
>>>
>>>                  /* technically won't happen as is_multipart_boundary()
>>>                     will fail first.  But just in case..
>>>                   */
>>>                  if (--mi->content_top < mi->content) {
>>>                          error("Detected mismatched boundaries, can't r=
ecover");
>>>                          mi->input_error =3D -1;
>>>                          mi->content_top =3D mi->content;
>>> +                       strbuf_release(&newline);
>>>                          return 0;
>>>                  }
>>
>> Since this code path can't be taken (or so it says): How did you find
>> this and the others? Static analysis? Grepping around?
>
> Code inspection: I looked for functions with STRBUF_INIT that return
> without calling strbuf_release() with "git grep -W STRBUF_INIT" and
> searching for return in less(1).

Thanks for sharing.

I read through this series and thought it looked good. One thing I like
is that it doesn't just blindly apply some standard solution in all
patches, but always tries to do what it feels is "right" for each
particular function.

Martin
