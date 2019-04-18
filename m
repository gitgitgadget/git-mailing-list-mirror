Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 159C420248
	for <e@80x24.org>; Thu, 18 Apr 2019 00:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733192AbfDRAs6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 20:48:58 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:50191 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbfDRAs5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 20:48:57 -0400
Received: by mail-wm1-f48.google.com with SMTP id z11so720122wmi.0
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 17:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=m4kbSuIMr//Ko+yoVkLUoYyqb2a+kgZ3htLZBvR4nRY=;
        b=HsdEiI6Mo0F6CY72G9231LjW9DzjHI/Q1lK3M6/3ghOkmKZG0wv807FQ7iwJeo8OSJ
         z95lJcG8aDpogx8Ol57NV7BB962g2OKkwEay50KJ5DJs/GG1q+OVqIcIVhscVIChaH7L
         TW2yaU478rqU2kblY6ZLFs0faTKMLRT0s307lOXVDzICD2cEzTIstcti5vP9S/z4ajWl
         2jufqRef+zspDNYml8kCosRfJ2lcShvFUb5n9YjKzu2yGVdPGLPx1fBiJ0N7JAlcQcA5
         SHFZsZ/YONIqCAmXBexGcf8uUghi12FN2zo9OtOh4GVPmC7EOVmdpbx9muJWx/f0DMCe
         NLSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=m4kbSuIMr//Ko+yoVkLUoYyqb2a+kgZ3htLZBvR4nRY=;
        b=q4YjQmEodKPJguBHmvDFY69iEio+0GudA10AdAd17fW3SGjyFq482wkcgcE8rrpLmK
         n7g9Mjlzi/8nTiA6jagXwM5yUKL/IMtXuC1FPOCxGSpsIlth8PDnhunmxalIjTFyZNBJ
         j8T5anG6yq4ThFVEKdTjuj8CKjXq/NMpthKJ9QB8QMnJcwaXvL/AJxfzFs9Gw+XUbeKd
         NkjL6/K6tumd1peYAy+cVC0ygSH1vZ2qVT5WWEpSaVynpqRCGc54icRJ9GtPOZ3tCDZE
         CrBmKoeHDxCCBG/PxOHxbOAXpBIDDsFZspCdWLc21FdN6o3sm/rSDWQG2yDQItkA6wjj
         ix7w==
X-Gm-Message-State: APjAAAWFcG5LAFBP9JwkiSn3/kpKJY0iFQVfDpJakWft2D0YM+yqJGas
        C9ON1vgFU+D5Qo8HGosUqz8=
X-Google-Smtp-Source: APXvYqwcUTi6tsFcDxE0Sv6NuqvW/GuDFEYaYzMv4I9BX7Zo0HGhP0GvPV/aZ7GlfuZJbZWJd+5bJA==
X-Received: by 2002:a1c:62d4:: with SMTP id w203mr881829wmb.54.1555548535644;
        Wed, 17 Apr 2019 17:48:55 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id r196sm371180wmf.22.2019.04.17.17.48.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 17:48:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: jc/format-patch-error-check, was Re: What's cooking in git.git (Apr 2019, #03; Tue, 16)
References: <xmqqef62ozny.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1904171449330.46@tvgsbejvaqbjf.bet>
Date:   Thu, 18 Apr 2019 09:48:54 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1904171449330.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 17 Apr 2019 14:50:25 +0200 (CEST)")
Message-ID: <xmqqzhooi1e1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Tue, 16 Apr 2019, Junio C Hamano wrote:
>
>> * jc/format-patch-error-check (2019-02-22) 2 commits
>>   (merged to 'next' on 2019-04-10 at 6ca358b7ef)
>>  + format-patch: notice failure to open cover letter for writing
>>  + builtin/log: downcase the beginning of error messages
>>  (this branch is used by jc/format-patch-noclobber.)
>>
>>  "git format-patch" used overwrite an existing patch/cover-letter
>>  file.  A new "--no-clobber" option stops it.
>
> Is it possible that this description needs to be adjusted, now that the
> --no-clobber option patch is actually set to be discarded?
>
> Ciao,
> Dscho

Sharp eyes.  Thanks.
