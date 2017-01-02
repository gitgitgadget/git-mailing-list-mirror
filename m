Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A34651FEB3
	for <e@80x24.org>; Mon,  2 Jan 2017 08:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754949AbdABI3Y (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 03:29:24 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33960 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751104AbdABI3X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 03:29:23 -0500
Received: by mail-lf0-f68.google.com with SMTP id d16so27284785lfb.1
        for <git@vger.kernel.org>; Mon, 02 Jan 2017 00:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=p9C0hejfWBTjV/dh/8Js6P/g96zVvRXtObImPX/8B40=;
        b=Xh2+X7NCJdbiEEZ6DYM9RzMcfpcOBjuEyUK2nuEg6HxrCr0NbBsAAUvD0q6R+1YQ5S
         WVAzjuXPezOyyE78BLDua9OKVPaUyCrvB7rNBGsSe7DdS8nRLdCVaQ2bdF8v95vdOEuG
         wyfqDQqoyKIIGCLD2ptTp75ChXXhMi10fldfFd5PKKUQ0arwsjuu+opoweXkUjpkAWio
         xDLWW0NvEkvkV89Gmhpog3IrToCiV5TZa24VfM1gZeoxPN2cTGvHwym1bdU1cG7W9sEx
         Shy2XYK4GWPOX2nS5AhOTYiI1Aw3+kbzRWxD03iTmKp2lvpEsW+eqUxh0R0NKzdSAYLp
         AV7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=p9C0hejfWBTjV/dh/8Js6P/g96zVvRXtObImPX/8B40=;
        b=pbvezfIRJCKlP6RddmESMCPRm/1dC4nZBybD/mHqBuGbJgWQ+NUFU+D/Q+oCVMRCig
         68Fe5x6uhfyt7oFFcr6r7zTqqoHoWahd6Ud+7rp8iiDhQkmpXAna3pytT/rPs27tN/bu
         sAHhm64/9uf2YKQDPwvSDplo3m8ETvooTy4+p0+rk8hlNtM12Bl4B8ky3sFHKioGNPtk
         Vf2mdXF07jUdQacUnsKXtVlYb9gWroDLvK3cNyYxTiWw95vjB49aXisQI2FqFiQlGo/P
         crULU9lWRueRUJhluSBfsjRoGvd6vaqwen1q/WgmHGSST4yhuYyVQvZ6Ri0uqrVePdi6
         rfrA==
X-Gm-Message-State: AIkVDXICyOHNCWYyc0y6ifDzY+/zGRJhs3AMmCq5afMUBjXEjWjYUFbagHIw8ucy8pdRZx0/B2nyTaCQmJmjkg==
X-Received: by 10.25.99.73 with SMTP id x70mr20827140lfb.81.1483345761468;
 Mon, 02 Jan 2017 00:29:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.135.198 with HTTP; Mon, 2 Jan 2017 00:29:21 -0800 (PST)
In-Reply-To: <xmqqvau59ocy.fsf@gitster.mtv.corp.google.com>
References: <20161226102222.17150-1-chriscool@tuxfamily.org>
 <20161226102222.17150-7-chriscool@tuxfamily.org> <xmqqvau59ocy.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 2 Jan 2017 09:29:21 +0100
Message-ID: <CAP8UFD1TwVvsvuffyHuzse_9afbNvSEJtyQyWzn6Rc4KwJNwHQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/21] t1700: add tests for core.splitIndex
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 27, 2016 at 8:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> +test_expect_success 'set core.splitIndex config variable to true' '
>> +     git config core.splitIndex true &&
>> +     : >three &&
>> +     git update-index --add three &&
>> +     git ls-files --stage >ls-files.actual &&
>> +     cat >ls-files.expect <<EOF &&
>> +100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0    one
>> +100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0    three
>> +100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0    two
>> +EOF
>> +     test_cmp ls-files.expect ls-files.actual &&
>
> It does not add much value to follow the "existing" outdated style
> like this when you are only adding new tests.  Write these like
>
>         cat >ls-files.expect <<-\EOF &&
>         100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0       one
>         100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0       three
>         100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0       two
>         EOF
>
> which would give incentive to others (or yourself) to update the
> style of the existing mess ;-).

Ok, I will add a patch to update the style of the existing tests at
the beginning of the series and then use the same new style in the
tests I add in later patches.
