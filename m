Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9106C203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 17:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753229AbcGYR2O (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 13:28:14 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:33527 "EHLO
	mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753261AbcGYR2N convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jul 2016 13:28:13 -0400
Received: by mail-it0-f65.google.com with SMTP id d65so8008555ith.0
        for <git@vger.kernel.org>; Mon, 25 Jul 2016 10:28:11 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PwMuDZPmExe1qEpUZ2f92XJ3Y3T/LTqt+sE6OMXqKac=;
        b=Vt+x8LM/FVf0YVwbxMeiiCDylibJZuXVEA6PS8OmAmVBhMs/pV/tzWCAArJRo4iaU/
         qGf8foA2LUEel5hTqxrEyHvvQBVGcwXSUAV4KtLn52P7+c0u6PmSnTTXrwa2UmcnoVFE
         UsiUOs5/IleAtlQKr4fbdKhCcKuPiu3/KPtPeG0Trpridbas3Ol7oPFVUIXK6ZXxz3UJ
         ybwpUdGjkMzQfC50m5lguDSzwjYuBbbzVQV8YVuQiEMZPH07a6vc9hWZtrajtvBWgcn3
         vTvuS9uKLCaSseJCiWYl9SsXc6jKF//+GHwR+ko3+RVLJtYuY68auHCuIMt40E91/gXZ
         DhSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PwMuDZPmExe1qEpUZ2f92XJ3Y3T/LTqt+sE6OMXqKac=;
        b=N4fmJml+zpjMVvIn9bovkw9nvBQUegXboDpLUb9DVyZIWD8V4M532qhUWZarnCzskv
         00/xyT0cRAV20p6OufmXwLNp6Ags7Sa4+VeA3pUmdwZSxgPJv7mZqDoBHCJP2nfNnIip
         1FC2YXGGTsq6kT0XpPAFMz3BKVJ0ZDEpUnjt8ZrS7AGZB6AGGWUo//z5GmSLJzPRWBYt
         dDV6fC242TqQGvKJwF8K2KD4fzwyRuGgAeiWAUYCBm4gTomrS6Bf7aixaZSnQqmBMxd7
         tKsMnI8qoy3QVO5fbzA30I0oR04u+P/ROv/1kfHorYpM4BAyk1DB34QndqysHpfDshWU
         Rh4Q==
X-Gm-Message-State: AEkoousQ1H82FCBaDvn4miCQvziD9P2GUx6JYYFIxWkIcAUnN83gavqMoJ05VSyMB2lag6nB00N9EqfFNMZf/A==
X-Received: by 10.36.208.71 with SMTP id m68mr22063301itg.63.1469467691348;
 Mon, 25 Jul 2016 10:28:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Mon, 25 Jul 2016 10:27:41 -0700 (PDT)
In-Reply-To: <CAPc5daWNAWjtfR7CYN3RTeT7VyvgiNX5HED0=f3F=GT8h4yKPA@mail.gmail.com>
References: <20160725162125.15734-1-pclouds@gmail.com> <CAPc5daWNAWjtfR7CYN3RTeT7VyvgiNX5HED0=f3F=GT8h4yKPA@mail.gmail.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Mon, 25 Jul 2016 19:27:41 +0200
Message-ID: <CACsJy8Df2cBAf0bWe1FLTb9cOqTX3vgNgC=ko82rG2in81R-FQ@mail.gmail.com>
Subject: Re: [PATCH] config.mak.uname: correct perl path on FreeBSD
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Git Mailing List <git@vger.kernel.org>, Eric Wong <e@80x24.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jul 25, 2016 at 6:56 PM, Junio C Hamano <gitster@pobox.com> wrote:
> On Mon, Jul 25, 2016 at 9:21 AM, Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
>> It looks the the symlink /usr/bin/perl (to /usr/local/bin/perl) has
>> been removed at least on FreeBSD 10.3. See [1] for more information.
>>
>> [1] https://svnweb.freebsd.org/ports/head/UPDATING?r1=386270&r2=386269&pathrev=386270&diff_format=c
>>
>> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
>> ---
>>  Tested with fbsd 10.3, kvm image. But I suppose it's the same as real
>>  fbsd.
>
> Thanks; and we know that older (but not too old that we no longer care about)
> FreeBSD all have /usr/local/bin/perl?

I'm no fbsd expert but from the first sentence in [1] "Perl has been
removed from base more than ten years ago..." I would assume it meant
"... removed from base, _to_ ports system" which means /usr/local for
all package installation (for ten years for perl). So I think we are
good.
-- 
Duy
