Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57E371F859
	for <e@80x24.org>; Sun, 28 Aug 2016 23:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756148AbcH1XSg (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Aug 2016 19:18:36 -0400
Received: from mail-lf0-f49.google.com ([209.85.215.49]:34627 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756133AbcH1XSf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Aug 2016 19:18:35 -0400
Received: by mail-lf0-f49.google.com with SMTP id l89so89617101lfi.1
        for <git@vger.kernel.org>; Sun, 28 Aug 2016 16:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=caBwAdxIHcAtwxB3tnjGocaX/nJVIZ/pcg2Nbuj3wNQ=;
        b=N1cRF3rkuVTCZh0cpUpproN5ZT0k8vaaxcOvzlOTI7Apusufs9YdIyb9Klp73KHtWU
         BCHWuB9mXVKpNBMeTBgJ0X8DnlTzjtKNP7ZJFpp4zo8zKkv9EOCVqr9KEwphkkmyuP3D
         otHX3YiaZdmhf38Rrv0c2oQjdBfqwwZUjcTbxhGVOXdKd1tQKYtrORqQqmu2Bq6Nn9vv
         AX9inoASpYAym8XOUd6ooeBqJHVqdiIGpLgjgeQiJt1ECrwXG5gZkzwDwMBzGT4bz7E6
         2AxLCkwO5fuxOKB4Ve8/naSRJjTxsyR/Ai1GlrUduIjV9C25DrzJWCiKWWbIm/915LV0
         E2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=caBwAdxIHcAtwxB3tnjGocaX/nJVIZ/pcg2Nbuj3wNQ=;
        b=TKSlJ6ypWKYhidjxfO4a8oAEGlr82rtKePgN2ObgTv53zHQXjSM5yQSpB6VbIpS71B
         5kzZEySXbYIj2R/GHGe/eWwGCUDH13jS/LPStu9cqyMxCF8YQ4mEGqcSUpzdFCk6zSzM
         BPFd4zfO1tY1NtI8eRNXN01oB7XiGtaLxhv0bvIMvbdHF8ehI7jIV2YLgrpBXvuwSXSI
         h3/4Ksl9vWxbyIJhEpOVGPfaeYS+PSkJ2UMz7K1EbDYpEY9IzwF46NgpOpoTjCozkrKu
         Cf493NqP1cZNU1fgQJVthX+50H/jDpwXnolP0Lzh5i8Jd64Erv7M1Vk3Z8MdbGbYIZCm
         WBKQ==
X-Gm-Message-State: AE9vXwMgzpbnhyniP6T/iQBpcuwDaCKI1F0KA57+1E+DmHXRjT+TPa9mKaG3JwUulflGHrqq8FnnImC4h0d8KA==
X-Received: by 10.25.76.139 with SMTP id z133mr4443915lfa.90.1472426313937;
 Sun, 28 Aug 2016 16:18:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.114.78.226 with HTTP; Sun, 28 Aug 2016 16:18:03 -0700 (PDT)
In-Reply-To: <51205109-5293-3058-f029-0703c33e8cb9@gmail.com>
References: <CAFMAO9y3LsrAb_jp8XVq2mexaA4bBqmWFwJu55r4S6Dxd2-zxw@mail.gmail.com>
 <51205109-5293-3058-f029-0703c33e8cb9@gmail.com>
From:   "W. David Jarvis" <william.d.jarvis@gmail.com>
Date:   Sun, 28 Aug 2016 16:18:03 -0700
X-Google-Sender-Auth: GU9SBEQwzoZgOSFw8rBLvYRrx5k
Message-ID: <CAFMAO9x5hi=drGSZTrJAxntjN+BATLCa_mSsqYZs+o6BO=x2wA@mail.gmail.com>
Subject: Re: Reducing CPU load on git server
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My assumption is that pack bitmaps are enabled since the primary
server is a GitHub Enterprise instance, but I'll have to confirm.

On Sun, Aug 28, 2016 at 2:20 PM, Jakub Nar=C4=99bski <jnareb@gmail.com> wro=
te:
> W dniu 28.08.2016 o 21:42, W. David Jarvis pisze:
>
>> The ultimate goal for us is just figuring out how we can best reduce
>> the CPU load on the primary instance so that we don't find ourselves
>> in a situation where we're not able to run basic git operations
>> anymore.
>
> I assume that you have turned on pack bitmaps?  See for example
> "Counting Objects" blog post on GitHub Engineering blog
> http://githubengineering.com/counting-objects/
>
> There are a few other articles there worth reading in your
> situation.
> --
> Jakub Nar=C4=99bski



--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
venanti.us
203.918.2328
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
