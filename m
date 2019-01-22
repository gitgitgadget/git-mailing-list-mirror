Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A65A1F453
	for <e@80x24.org>; Tue, 22 Jan 2019 15:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbfAVPeE (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 10:34:04 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:55828 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728670AbfAVPeE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 10:34:04 -0500
Received: by mail-wm1-f49.google.com with SMTP id y139so14474738wmc.5
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 07:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fbUJNxZ7ZDwFiQGLnLTsFnNg0h6uDBstdu+ys8LDdQM=;
        b=h1/lrTFLOXBrDHkQ/DMKF3lO6aDvJoL1aqUMm9YTwlyDhEHRtWEjI2AfTosvAo1iOK
         4lx5G7HEUNF0kd7sQrTi5aV2+1c4eJ66DQ1Q6i3YJGy9fP8jihDzjvoqooopzbWkcEbj
         FVetZ6GwLAieNMWnVC2lhYKVXpmAr+hoIzDQmzCe3Yhs3zFJGA0+CeOuw4asofnQahWB
         nSthT6PT1TE9Uk3F0EOcHSnU9RtLL+t930/jzhEsM/IvFQUQtkDwG9GY0DOV84XJpGB8
         MPUlEXUZsoq0UH05bJaCDtovNnwjet4YpNuKJoYgIqL4LEy8XmpKCN5x7l3vX1qr5HFW
         TDFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fbUJNxZ7ZDwFiQGLnLTsFnNg0h6uDBstdu+ys8LDdQM=;
        b=Pv+PmDCBGSaDFZU05OGaQMsSwJuYFCoh8L7gePjq9BylvtKDlVlGTK+Fs2RevG30OM
         PQmnpYFAuTRYViI9q9TxMIm0ap5Cy82XvqU58sHMkG9HOAhEikPLOcb7q5MxQepCZdM5
         aECX1C/j+sLoFB5N63aiT4qsjhJSG1Bz6DoIcO5hzPVuxFdB8JVNqBB6Gykw57wNsEkW
         3A9R4b5RLAbBr8C6tD2cvXNHbre06WK8MrGNceDCw/B+QtyzqBoYSXJZqMNTOdpbxll4
         PdP9rvzc0KRDMhDd7BUL5JMKVIuthWMaiZ8VkEh8TG1ccdBdZZ7jrqoDYzBuT9ooUbFy
         pWoQ==
X-Gm-Message-State: AJcUukeaNtRGHUIqcVc7Wydv3W0kD+o99DyWG7f5wrXW7NXRWNx7ZsUC
        i6e8b03fNAids9yxC/EAq+85d6qo0OIzkyuc+IE=
X-Google-Smtp-Source: ALg8bN43eJh6I+uOtRmDpZ7hGVdnyL3GXl1FsCu6Ao0aW2nuXwlsfxWindi4fJEIe22mrbHv7F1PucbayyAvLfYb9P8=
X-Received: by 2002:a1c:bd86:: with SMTP id n128mr4258113wmf.22.1548171241986;
 Tue, 22 Jan 2019 07:34:01 -0800 (PST)
MIME-Version: 1.0
References: <CAGAu0HVeQFA_O8_hsZbzRi9X35fF3DAeUaSd993JF=NTwaZP1Q@mail.gmail.com>
 <20190122072946.GB28975@sigill.intra.peff.net>
In-Reply-To: <20190122072946.GB28975@sigill.intra.peff.net>
From:   Alex Netkachov <alex.netkachov@gmail.com>
Date:   Tue, 22 Jan 2019 15:33:25 +0000
Message-ID: <CAGAu0HW=N2nQr7zq_EVpegJDc6_womFDCLU5SCoCQw6cmzw8xg@mail.gmail.com>
Subject: Re: Potential bug in pack-objects.c
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 22 Jan 2019 at 07:29, Jeff King <peff@peff.net> wrote:
>
> On Mon, Jan 21, 2019 at 10:10:16PM +0000, Alex Netkachov wrote:
>
> > On the location builtin/pack-objects.c:1996 the code tries to set
> > read_lock (pthread_mutex_lock(&read_mutex)) and fails. I suspect that
> > read_mutex is not initialised yet. It is initialised in
> > init_threaded_search, which is called later in prepare_pack (through
> > ll_find_deltas).
>
> This sounds like the same bug being discussed in:
>
>   http://public-inbox.org/git/20190118022736.36832-1-phogg@novamoon.net/

It is exactly the same thing. Thank you. Hope it will be applied soon
and released.

Kind regards,
Alex
