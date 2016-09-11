Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1D9B1FCA9
	for <e@80x24.org>; Sun, 11 Sep 2016 22:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754334AbcIKWFc (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 18:05:32 -0400
Received: from mail-yb0-f179.google.com ([209.85.213.179]:34294 "EHLO
        mail-yb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750912AbcIKWFb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 18:05:31 -0400
Received: by mail-yb0-f179.google.com with SMTP id x93so44344293ybh.1
        for <git@vger.kernel.org>; Sun, 11 Sep 2016 15:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wcEDF5sO1ykiiZ5uf/8ZBl4z74DXZsX0ZoYjaqVJusw=;
        b=XKsWqFUXZzVfR7JT6Q4veqSJaT2cE0YxhQYC3r8TFKSSbvJ00/FecsDqVbNg+y3epb
         XhNdmAqXU7IoRODquFivmu3AEWnOCzaKAEqUbMu1PXVEmGQOkKKZyuYxrsj5jeeFwOYj
         A3afFZfgPqdggq5p0EhAtyCYbGyE0CwA/Zj8CRj1RtZRgqftj2QDz7cfiWIlTHWItXBp
         ikMCRpkEE6hhR1P6pVCyChoUHIHa8DnfAWFQcXUCO5I6FHJcIIL3XCdDO/Dz7YzmvLdq
         ZtaE9ajwuVAKA6ieaIC1ou8MtzW0ZXaqqZ68ywOTCTWWYoZIFUBmRGvvaVJbkY3qlCYf
         ojEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wcEDF5sO1ykiiZ5uf/8ZBl4z74DXZsX0ZoYjaqVJusw=;
        b=NVTsARTqlOcrlEOo+q6+x5yZBCSzTqTncZc9Am6gk2wwNzPXFy2ouMuzK8rEpoOCfZ
         +SiR02t7GzUUyIskpscqEMgliSsQjcqAJRUqDck2OWtj+PbJ8bkWWqR20df14+Ot33Nj
         2LPPd9HPd7S9dBgnXpX/aTjSS0XMeYrcwMRYACLgbMzdUlZIrGzruzmIE/8yV2Ax0hkY
         QbiUU8iyHFgmRFisoCtLzOGLnaklWQubY+ExBZ8B87FqAXdgzwzrkXv+3GLdsy48JL7E
         wMW4ZF9ggBhHUeKnSWcp5d5pgX/nOHdpo5CMcpsaL1milHRiSt2b9zKFoz7opeieZ7nT
         p1aw==
X-Gm-Message-State: AE9vXwPK58/eTsNh46JItHo6fzQ6ez64dJO6eKF0O6Ku7H4kzkz87rWKQ7zcyFG2Eh0+9DLeaxonPW6fGgLABg==
X-Received: by 10.37.20.8 with SMTP id 8mr15535802ybu.103.1473631530350; Sun,
 11 Sep 2016 15:05:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Sun, 11 Sep 2016 15:05:09 -0700 (PDT)
In-Reply-To: <xmqqvay26r8u.fsf@gitster.mtv.corp.google.com>
References: <87zinmhx68.fsf@juno.home.vuxu.org> <CA+P7+xoN+q_Kst=qXG_HRznxbN7cbyi5uZe15zq1c16EifeK1Q@mail.gmail.com>
 <xmqq8tv1c5nb.fsf@gitster.mtv.corp.google.com> <23de5ffe-eaf8-2d62-2202-f1bf6087d44b@gmail.com>
 <87inu4bxt7.fsf@juno.home.vuxu.org> <b9d63103-011a-9486-2fa1-dcf3a82cbe64@gmail.com>
 <xmqqvay26r8u.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sun, 11 Sep 2016 15:05:09 -0700
Message-ID: <CA+P7+xqdWbERVQenZJTLyirBy2VFrKV2-uBOxB1CwcWs+gy43A@mail.gmail.com>
Subject: Re: git commit -p with file arguments
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Christian Neukirchen <chneukirchen@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 11, 2016 at 2:50 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jakub Nar=C4=99bski <jnareb@gmail.com> writes:
>
>> I wonder, if git-commit is to acquire such feature, what would be the
>> best interface.  "git commit :0:./<path>"?  "git commit -o -p <path>"
>> (that is, "git commit --only --patch <pathspec>")?
>
> Just do "git reset && git commit -p <pathspec>", I would say.
> Anything more elaborate would just confuse the end users.
>

Yes, I'm actually confused by "git commit <files>" *not* usinng what's
in the index already, so I think that isn't intuitive as is.

Thanks,
Jake
