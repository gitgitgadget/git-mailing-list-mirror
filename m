Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E04B215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 15:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754597AbeD3PKj (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 11:10:39 -0400
Received: from mail-ot0-f175.google.com ([74.125.82.175]:46375 "EHLO
        mail-ot0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754550AbeD3PKg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 11:10:36 -0400
Received: by mail-ot0-f175.google.com with SMTP id t1-v6so9805337ott.13
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 08:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ha6MaLIRvtTyXCCuWrPsVBllp8S1gDLGXIvz7g0XlXk=;
        b=Q0dBnMWGk+NISxvXtSuRjtToLbwyfH7G6UOvlL69AvbmB3ux2gpdIMsH6ghiiU7y/1
         DAvPbZOrcu14hwwUeHzU21cjK7HrlzveP55Lz/HTdQT9FNqxcVrLuVup9YkkDxlFKQZZ
         8pVl2wAq7Spfi+eGakAT6IZRDaA4gfyTqVmTECWZOIwBnSBz5V0iVYOh42aCtQN/50H8
         8wMg1jFDo2/6jId/HMH1AxH2tznFAZ7ornkIc1ywocpO9nDKwCRoCUZDKIif9e3ewxYx
         k6H7IfIbhrQLM4yyov3YrglAvSW92nqd6usAZOy3vGZHsvetR780uzsW+6x+n4XRMLdV
         sgBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ha6MaLIRvtTyXCCuWrPsVBllp8S1gDLGXIvz7g0XlXk=;
        b=Xb1Nk+AVqOISVCmy5Cg6pPp57YIty1mjvfxtleJsl3T3gVQLO8kW13i9FPd1e0SXNu
         CSCNt3J9N/wMRSMEiuKWqZJxTqgAcwCeaPpddIq3nb6BO+ChzIb5Cqu3FJSsEKuIM+BN
         nc6lhIryeV2TAlFIB1Vv+poM0u1qgsQO5xj+6t4yhjeBIiAHrEGIwhocYrsppzeNjqYw
         Xkg45qpvuxZ+ovKd3RlhZ76U1QC5IP9c8igkC6ZEUVn7e50+R6ZLor4ClX8ufcFFENO5
         3KRwpjgLdZGGIWgbYmUWM5Xq68AdbqRfw6spVNTCsAbrg0ujdW5671/F5OuSBEG8Z2dn
         o4XQ==
X-Gm-Message-State: ALQs6tAxP49y6nSFu+QqC+aETindB85fjQzXQxEak5wfPuRXp96G0a6R
        JH6EFCztG8jUcbae5S2uMbKtH8Ms3iBYs0VINbY=
X-Google-Smtp-Source: AB8JxZq0MC452Dlm8xu8Db+7ILxv36WItw3+6TDbydAqZmoEnahtk3vBkj3xHas8JtFUuDCh5iQwHUY2qLxarfE2ng0=
X-Received: by 2002:a9d:3477:: with SMTP id v110-v6mr8906725otb.65.1525101035558;
 Mon, 30 Apr 2018 08:10:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Mon, 30 Apr 2018 08:10:05 -0700 (PDT)
In-Reply-To: <xmqqpo2hzhwg.fsf@gitster-ct.c.googlers.com>
References: <20180413170129.15310-1-mgorny@gentoo.org> <robbat2-20180423T200557-844830385Z@orbis-terrarum.net>
 <xmqqtvs18p9o.fsf@gitster-ct.c.googlers.com> <robbat2-20180425T060717-325652820Z@orbis-terrarum.net>
 <xmqqin8f4qoq.fsf@gitster-ct.c.googlers.com> <ad4d0d66-58f4-5cab-d314-a30a50e8ad32@xiplink.com>
 <CACsJy8ATwEPiCDpOr7e=wJxhZAr1R4OpSdOvb6EgpnyYonQYWg@mail.gmail.com>
 <robbat2-20180426T165501-471483273Z@orbis-terrarum.net> <20180426184411.GA6844@duynguyen.home>
 <xmqqpo2hzhwg.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 30 Apr 2018 17:10:05 +0200
Message-ID: <CACsJy8AcB5+n-3xdipT8Dve5V68vVRf9sAEOGPTSCe9xKjYHyw@mail.gmail.com>
Subject: Re: [RFC PATCH] checkout: Force matching mtime between files
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Robin H. Johnson" <robbat2@gentoo.org>,
        Marc Branchaud <marcnarc@xiplink.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
        Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 30, 2018 at 1:56 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> Target revision should be available in the index. But this gives me an
>> idea to another thing that bugs me: sending the list to the hook means
>> I have to deal with separator (\n or NUL?) or escaping. This mentions
>> of index makes me take a different direction. I could produce a small
>> index that contains just what is modified, then you can retrieve
>> whatever info you want with `git ls-files` or even `git show` after
>> pointing $GIT_INDEX_FILE to it.
>
> That's somewhere in between a tail wagging the dog and a hammer
> looking like a solution even when you have a screw.  By passing a
> temporary index, you may be able to claim that you are feeding the
> necessary information without corruption and in a readable and
> native format of Git, and make it up to the reader to grab the paths
> out of it, but
>
>  (1) the contents, and probably the cached stat information, in that
>      temporary index is duplicated and wasted; you know from the
>      time you design this thing that all you want to convey is a
>      list of paths.

Yep, I was not happy about this. Which I why I moved to update the
hook calling convention to pass pathspec to the hook instead.

>  (2) it is totally unclear who is responsible for cleaning the
>      temporary file up.

The one that creates it deletes it, which is git.

>  (3) the recipient must walk and carefully grab the path, certainly
>      has to "deal with separator (\n or NUL?) or escaping" anyway,
>      especially if the reason you use a temporary index is because
>      "they can use ls-files on it".  They need to read from ls-files
>      anyway, so that is no better than feeding ls-files compatible
>      input from the standard input of the hook script.

Err "ls-files compatible input" or "ls-files compatible _output_"? If
by input you mean the pathspec we give to ls-files, I agree. If it's
standard ls-files --stage output , letting the hook call ls-files lets
it select the output format it wants (including the potential json
output in the future), which is more flexible.

>
> no?



-- 
Duy
