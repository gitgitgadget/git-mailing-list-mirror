Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 546741F404
	for <e@80x24.org>; Wed, 29 Aug 2018 20:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbeH3Abl (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 20:31:41 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38689 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbeH3Abl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 20:31:41 -0400
Received: by mail-ed1-f65.google.com with SMTP id h33-v6so4900193edb.5
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 13:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gpyqOE7iaXtQaTE6HLfyNB2checfBNlspzO+kxBcUy8=;
        b=nYtlL/mPnH2jxhGaiwDIc4g1hCx2LHqs27wEuPetpMFZDvkjyb6l5VCIyBeDVo2bB2
         f85vOVKRGH98pbEWU5DUb76cGo2m6E2Ef14WWvTXZuEjHYNr+e8Z8dCVPgzveI0iTqtb
         6F1PmRAarP3aWnR4Tcm9GtUxzOzFkE4V0b9RUt9dBejPIzwV/O30zxzFerRtirqjw+zl
         X5G7KPZaFsXjlN3U1OOx9S8uop0xpcCqdqpobv/x/J3jK93Ws89CqQRnuN79a4L773rG
         mdEabG1c+JTDMcid9RKZKteIab4EGNV0gSWvgals11aKNtzARu6g2bNKWiIkyvbpUrFY
         PDBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gpyqOE7iaXtQaTE6HLfyNB2checfBNlspzO+kxBcUy8=;
        b=rYpE46pIu7NwpTmfZ5tPGprirdMEjm2QH2Db/5ermeuWsKUQopq+RA0YSnO6ib4GXe
         zTF7nViFba/ouUdUtbrn/XH2rapwNE5BmuqU6sTzQ/Ixh3WGOGGmjbVQizdTJAOUzqxa
         /6LVNHOnLDT+xlZhQjoU/vWMOOd3uOSvKsjkdzccgU1QEWyMbZKwSuT7qypNd5CwmJV4
         z7JdTLMGIIcf+5prYWZAHayNeHGUkZEPuHbAn0FwzE1BGrGCGzCCosdSfZ+fKIJBhtyY
         MV4PEoNMPI0Ofe/NowdwziDI31fIVtKtfyExcXhte5hncEJhir3Ag20vv5fuiVwt/c48
         u9xg==
X-Gm-Message-State: APzg51BWhpwVMq75iZ5fwCVWppUD0PpESELkfTtGZHzUE07XMMctyjzN
        osFSJOOfTHrHuTy1Q7jY8Ait7HdQ+kxTdJrHd29H/w51
X-Google-Smtp-Source: ANB0VdZbZ2odp/GjRAAwSvVlDgQ3EBaAJ88/rZcls4KeA1yQiKXXwdYeXfQPqgBMJniRtwK+OyTJWOTZSCuA4DQQUXs=
X-Received: by 2002:a50:9e46:: with SMTP id z64-v6mr5821995ede.204.1535574786897;
 Wed, 29 Aug 2018 13:33:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180827221257.149257-1-sbeller@google.com> <20180827221257.149257-2-sbeller@google.com>
 <xmqqtvnefhgx.fsf@gitster-ct.c.googlers.com> <CAGZ79kYApAdFzC82LZNjYDzL5uWxtXHbvqUyjZ9OF+b=pGNbUA@mail.gmail.com>
 <xmqq1sahcctx.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq1sahcctx.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 29 Aug 2018 13:32:55 -0700
Message-ID: <CAGZ79kaq2oBBfFExCTKoNMhTx7iKRto0zddPknWn5qRjw0fKkw@mail.gmail.com>
Subject: Re: [PATCH 2/2] submodule.c: warn about missing submodule git directories
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 29, 2018 at 10:17 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Stefan Beller <sbeller@google.com> writes:
>
> > Not quite, as this is ...
> >
> > Looking at the test in the previous patch, I would think a reasonable workflow
> > in the test is ...
> >
> >> The MOVE_HEAD_FORCE codepath that follows this hunk is, eh, already
> >> forcing to correct the situation, so there is no need to touch that,
> >> which makes sense, if I understand correctly.
> >
> > No, that is not executed for now as it depends on 'old_head'.
>
> All explanation worth having in the log message to help future
> readers, don't you think?

ok, will do.

Thanks,
Stefan
