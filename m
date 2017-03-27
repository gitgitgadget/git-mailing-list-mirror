Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BACD820966
	for <e@80x24.org>; Mon, 27 Mar 2017 07:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752025AbdC0HxR (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Mar 2017 03:53:17 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:34873 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751945AbdC0HxP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2017 03:53:15 -0400
Received: by mail-it0-f65.google.com with SMTP id y18so9817150itc.2
        for <git@vger.kernel.org>; Mon, 27 Mar 2017 00:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=H2au+thjDlHWw7U2OFAXvL8IeWkv+JWcpf7EZ5gxaVY=;
        b=IQXc8vjo5Wj9WBYaC9zUPBtoMSAN3JOUqREwqL+Q+4UVMGnQzqvthkFX53YSwcSEHK
         bV1R3WU2G7sGAR+MMvMVfUdnFgHKMc543EpOwEeTQexYnPSJA6e9sZQA3q1JX1VZNuTq
         yhQRKvkp3wWUA3Av+gLDJ52C5AjjonbunR1a2En4gNGwBvaTatdB5qiCMhISeDJOxSS2
         7jmVTe7jGGemNiAU9fzo/Lb0n9vVf+IvreMsWKi6CjUX2XGpb0Ho9KaUudiKSmGDVYnf
         y1S9JYfKFLz4DRmbww5Xy39lGeOhcRDtLvSvwvoX3p1AHdc/CAfvSK1cjf108aywSQGB
         Z4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=H2au+thjDlHWw7U2OFAXvL8IeWkv+JWcpf7EZ5gxaVY=;
        b=bj869VbQiJiEDQ7r1Wf6/KqfcA4reCECB6Ux6GdqezJ3fyo0pKitcm4G2mclmpM95i
         10aJf7YGnvcNtk4D1moTh/yC46mDvVqWzhal4/l7yON0UOfmYUkMlu8DqfnuBHpKiodX
         KRXErecOUJy2Zgrdz6Wf3dpKpWkZiJaePLd1Y/Bhugt/MsvZujGA3ZDBL2HBAbf0irhf
         E5U8oYOXGLDTpT98hTyiVyQZgkODVEMx1nhO21qFfGLp+FzCVNLWZrlQjAFq4xlbWuLJ
         oxaIShbLyVlO8tMYEZFwHcof5dz7Ro4iZ4cddtivj18mANVsVbBgR+pQwQQBHpQHb7kJ
         jtnQ==
X-Gm-Message-State: AFeK/H1Ype9BeQ91JX2aHfPJRmTAUsOeiv9QP3rNQqjbKv6/o8i2d1KKvYZH01CTlGWiK4nkeQsHTDnZDJEnBw==
X-Received: by 10.36.76.11 with SMTP id a11mr9323482itb.60.1490601189161; Mon,
 27 Mar 2017 00:53:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Mon, 27 Mar 2017 00:52:48 -0700 (PDT)
In-Reply-To: <20170327025346.cwig3ulmyqcgqx7n@sigill.intra.peff.net>
References: <xmqq1stszxn4.fsf@gitster.mtv.corp.google.com> <20170326121654.22035-3-avarab@gmail.com>
 <20170327025346.cwig3ulmyqcgqx7n@sigill.intra.peff.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 27 Mar 2017 09:52:48 +0200
Message-ID: <CACBZZX7WoQKu5ZUjSg2tmL+07q_dGrf83NkfQnW8stoLS2sX_w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] rev-parse: add @{p} as a synonym for @{push}
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Conrad Irwin <conrad.irwin@gmail.com>,
        Sitaram Chamarty <sitaramc@gmail.com>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        "Brian M . Carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 27, 2017 at 4:53 AM, Jeff King <peff@peff.net> wrote:
> On Sun, Mar 26, 2017 at 12:16:53PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> Add @{p} as a shorthand for @{push} for consistency with the @{u}
>> shorthand for @{upstream}.
>>
>> This wasn't added when @{push} was introduced in commit
>> adfe5d0434 ("sha1_name: implement @{push} shorthand", 2015-05-21), but
>> it can be added without any ambiguity and saves the user some typing.
>
> It _can_ be added, but it was intentionally avoided at the time because
> there was discussion of adding other p-words, including:
>
>   - @{pull} as a synonym for @{upstream} (and to better match @{push})
>
>   - @{publish}, which was some similar-ish system that was based on
>     per-branch config, but the patches were never merged.
>
> It's been a few years with neither of those things happening, so in a
> sense it may be safe to add it now. OTOH, if users are not clamoring for
> @{p} and it is just being added "because we can", maybe that is not a
> good reason.

Yeah let's just drop this.

>> -'<branchname>@\{push\}', e.g. 'master@\{push\}', '@\{push\}'::
>> -  The suffix '@\{push}' reports the branch "where we would push to" if
>> +'<branchname>@\{push\}', e.g. 'master@\{push\}', '@\{p\}'::
>> +  The suffix '@\{push}' (short form '@\{push}') reports the branch "whe=
re we would push to" if
>
> Did you mean to say "short form '@\{p}'"?

Yup, my mistake.
