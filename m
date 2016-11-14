Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E9361F858
	for <e@80x24.org>; Mon, 14 Nov 2016 19:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936214AbcKNTXi (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Nov 2016 14:23:38 -0500
Received: from mail-yw0-f179.google.com ([209.85.161.179]:36789 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934223AbcKNTXg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2016 14:23:36 -0500
Received: by mail-yw0-f179.google.com with SMTP id a10so74224515ywa.3
        for <git@vger.kernel.org>; Mon, 14 Nov 2016 11:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=i4NMVuArfMs3njsc5jBfkdCg6ryXMTCAgTUJhFn6+8s=;
        b=DeyrjRK2Y3ny5PaQKCDCCTGn41JKsyG45PzVJ1Gp02ebYnxasHccfPf2TAClKJu8Xb
         Tjvp4m03SHdZWNq76kly1UJ4k5029nC2iOAmcrvu4T92AEhq095dh8p+AAajQikVI0UJ
         KO53CRZaj04m0fN6WTW3itvGx/n7z6p8LObkDPYuGPMGNluB5SkKHdRK6SW9IHYQmTEU
         7oRRMspPQiA6LVXP/OtODNhypd8kXLufRBfL106mrZahaeMTV66lO4DKOT7MJ0DzOjli
         VuN+euXYQJ8AU1K5EDsptOwoaduO/gw3QFztVDLYs5hvqnBnAxk2rK+texC3AXDS4+Pr
         ndoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=i4NMVuArfMs3njsc5jBfkdCg6ryXMTCAgTUJhFn6+8s=;
        b=gUOhj000cRXw3ZQTKMs/IoQprTu4QByjtzLZSG25dovBXnfbYFR3dFnvOfe4xPQ55N
         Czn69jJFQCzy6ekj4yo5jGNC/4TyB3fVdq8kq+2v4cxQZAcA/Wra4tb8SLwYWZlDLojO
         +AES4e8ZN70EvVbUYleKIaYr+eZCBvT+B4Xnb3SkDtBd7NbGInPSxiMebSeqlU0mGKNn
         jUcGlet/p9AgOyoNC5oGZ0SMLCzGWKyxQC59GisIjwG75k6lzGINlwpHi5YfW7bOjQe+
         ZjT0bxmMHuX9c5TlQ/OkCohhd9KOYmPgFoR0WcoMA42e6Ke+vHPwGasC7m+fflpKg1kr
         ZJPA==
X-Gm-Message-State: ABUngverf5b9fETV+QCDExi8s8FJoXHKQRFVyxa41ictwBIkz7BAqnotv9iqRZBnU7Me/LqSzh9a1gQxJRRPOA==
X-Received: by 10.129.82.214 with SMTP id g205mr15448657ywb.73.1479151415258;
 Mon, 14 Nov 2016 11:23:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.13.207.69 with HTTP; Mon, 14 Nov 2016 11:23:04 -0800 (PST)
In-Reply-To: <CA+P7+xr20UyKMKUZBpP-SjtEhbow2df+iT6nF67mOAZ8BAaxEg@mail.gmail.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com> <20161108201211.25213-17-Karthik.188@gmail.com>
 <CA+P7+xr20UyKMKUZBpP-SjtEhbow2df+iT6nF67mOAZ8BAaxEg@mail.gmail.com>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Tue, 15 Nov 2016 00:53:04 +0530
Message-ID: <CAOLa=ZQSQe=jfTpdyscZCZgi5p6cVLN23oi2eE-hqFTXgt2LEQ@mail.gmail.com>
Subject: Re: [PATCH v7 16/17] branch: use ref-filter printing APIs
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello

On Wed, Nov 9, 2016 at 5:44 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Tue, Nov 8, 2016 at 12:12 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> From: Karthik Nayak <karthik.188@gmail.com>
>>
>> Port branch.c to use ref-filter APIs for printing. This clears out
>> most of the code used in branch.c for printing and replaces them with
>> calls made to the ref-filter library.
>
> Nice. This looks correct based on checking against the current
> branch.c implementation by hand. There was one minor change I
> suggested but I'm not really sure it buys is that much.
>

Thanks for this review. More down.

>> +               if (filter->verbose > 1)
>> +                       strbuf_addf(&local, "%%(if)%%(upstream)%%(then)[%s%%(upstream:short)%s%%(if)%%(upstream:track)"
>> +                                   "%%(then): %%(upstream:track,nobracket)%%(end)] %%(end)%%(contents:subject)",
>> +                                   branch_get_color(BRANCH_COLOR_UPSTREAM), branch_get_color(BRANCH_COLOR_RESET));
>
> When we have extra verbose, we check whether we have an upstream, and
> if so, we print the short name of that upstream inside brackets. If we
> have tracking information, we print that without brackets, and then we
> end this section. Finally we print the subject.
>
> We could almost re-use the code for the subject bits, but I'm not sure
> it's worth it. Maybe drop the %contents:subject part and add it
> afterwards since we always want it? It would remove some duplication
> but overall not sure it's actually worth it.
>

If you see that's the last part we add to the 'local' strbuf in the
verbose case.
If we want to remove the duplication we'll end up adding one more
strbuf_addf(...).
So I guess its better this way.

-- 
Regards,
Karthik Nayak
