Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2526420248
	for <e@80x24.org>; Tue,  5 Mar 2019 13:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbfCEN1k (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 08:27:40 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43984 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfCEN1k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 08:27:40 -0500
Received: by mail-pf1-f194.google.com with SMTP id q17so5695212pfh.10
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 05:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UTcsr7r1kLXo0ib0DB7pvnrLdNpfjZvDWFkc17lGQVg=;
        b=avUDVZwhsZmLqNyrwNntS6byvZ8KtR2A5FpKVmOaRnFm6cauIwtfmAwGU605TfZeS2
         h02emg8qKzKKNAkWfJ3ofm5QhFcETseB24CJobVTGI7Lud5Oh73Pf1J0Qs+NDsZIlESq
         ZAMKwJbtrfGWOLeuUgFHJSs54MgICNOZ4rAtGbVzp3lALJNEsA4SmMC89vVbyei/QtQx
         9t/jPIgumEqGxnJSnNHX9gzsVatKZMzI/rcVlsxVEBMqO5DJMHI390Otxl55ljEyI25P
         Vt7nkGBeSDfUlFpsgAhSUuY2K+GMPSKkwS/s42KKMHWaybEbKGEmKMlL2xXYDyp9rtTY
         +Emg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UTcsr7r1kLXo0ib0DB7pvnrLdNpfjZvDWFkc17lGQVg=;
        b=aOKKvK9248R6ToTmLtzd4POOBogmVBYt5Ufj3vYSAKwwpUO4KZzRjzW9f1VtBecG8P
         cKgK+1VlzdteRraqU2as8fPP1YImeHWHih1I55B2po6SkFEoROD/MgFVzQoJG99KMJy2
         BuqgEXF0uJQ2SxvuDYDWbTHC+wmTeH0CRwqn254U/D4hNRj5uYdv8Owkgp0d+fXdj9B3
         9iiL7FcHZ1r3zi+KvRAL092rWhgSdI2iwpa4jgNJgKzOh/hok5HRooYjsV4tTOZvvnUL
         ZY2GgrI3ZXCtV+MG2sdbRXDyppu3tHYNM0n2tdx4vo56gRtopde9Q4Xs5GDv73r0w8Qr
         NaeA==
X-Gm-Message-State: APjAAAVmsex6yR5Psbm/A3QhDEF3MCm8p6ZVtqh3A9TFncKFtl/NpIq2
        hLuihkDOvLYkpHsIrSWsfno=
X-Google-Smtp-Source: APXvYqzfs+zm5RAjY3ifEr6hPxGH2vLC3W/5W9z4znJkdBrc1SIaXUGUkDTafrZJPSpaGs09HeZnIw==
X-Received: by 2002:a63:f753:: with SMTP id f19mr1363571pgk.437.1551792459306;
        Tue, 05 Mar 2019 05:27:39 -0800 (PST)
Received: from ar135.iitr.ernet.in ([103.37.201.80])
        by smtp.gmail.com with ESMTPSA id k75sm20636808pfj.46.2019.03.05.05.27.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 05:27:38 -0800 (PST)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     sunshine@sunshineco.com
Cc:     Johannes.Schindelin@gmx.de, christian.couder@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, rohit.ashiwal265@gmail.com,
        t.gummerer@gmail.com
Subject: Re: [GSoc][PATCH v3 1/3] test functions: add function `test_file_not_empty`
Date:   Tue,  5 Mar 2019 18:57:01 +0530
Message-Id: <20190305132701.9657-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAPig+cTTJgXERud0=svc5b+ctwQxoQ6cmpiA7WHMa7TUZ37BgQ@mail.gmail.com>
References: <CAPig+cTTJgXERud0=svc5b+ctwQxoQ6cmpiA7WHMa7TUZ37BgQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Eric

On 2019-03-04 19:17:50 -0500 Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Mar 4, 2019 at 7:08 AM Rohit Ashiwal <rohit.ashiwal265@gmail.com> wrote:
> > if ! test -s "$1"
> > then
> > 	echo "'$1' is not a non-empty file."
>
> Although not incorrect, the double-negative is hard to digest. I had
> to read it a few times to convince myself that it matched the intent
> of the new function. I wonder if a message such as
>
>    echo "'$1' is unexpectedly empty"
>
> would be better. (Subjective, and not at all worth a re-roll.)

I think the current message is more accurate as it implies both:
	1. There is no file, and
	2. If there is, it is not empty

"unexpectedly empty" may imply that there is a directory which is not empty
and that is not the intention of the function.

> Also, it might be a good idea to add this new function as a neighbor
> of test_must_be_empty() rather than defining it a couple hundred lines
> earlier in the file. Alternately, perhaps a preparatory patch could
> move test_must_be_empty() closer to the other similar functions
> (test_path_is_missing() and cousins).

I think we should relocate the function `test_must_be_empty` in a separate
patch as this patch deals with a different issue. 

Thanks
Rohit

