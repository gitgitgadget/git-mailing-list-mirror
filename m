Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26928202AB
	for <e@80x24.org>; Thu,  6 Jul 2017 22:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752707AbdGFWmS (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jul 2017 18:42:18 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33201 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752056AbdGFWmR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jul 2017 18:42:17 -0400
Received: by mail-pf0-f170.google.com with SMTP id e7so7631809pfk.0
        for <git@vger.kernel.org>; Thu, 06 Jul 2017 15:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3i1Py/zAyfJhnCBCYND79cQUq/sFxkULFAMs5NcIO6E=;
        b=r9Z88hMljn/Tn0Ddrx45Kq6DGCnkCpqNoqEwSWW3UYMrTKL6P0f0SginjaL/Lq85RE
         F4HWyZb0VKtlkdW2cPlZahaUy2w4GxPJgWEvBanAMvmENKikspOD3UH26Ed1kTIX/0ph
         fxPpB5v3xNxlHHXAB6m3BU0xftFDsQkF6OMnwcpXFRY2UjHNfbjTCNm7f50qac5qZtcM
         4RKM+khaxqv6Q3MWD1wJazu64IWKczW7Q11NRRxKX76iDx8WTAarcUMp8xrQ8jTDdzLf
         ge4P/2cD7M9PnuBi9Ilm/x55txrTvAJKpansjdKE2c6z5bJsnsjfU3gwmJaz65KJYs6i
         goYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3i1Py/zAyfJhnCBCYND79cQUq/sFxkULFAMs5NcIO6E=;
        b=r9vlGhHH8nrziiVb5pZxciCKsyCMdPHgyRIUv3shnTZdyleq/QWdp4O2rUOme60W9x
         ag5GLMzLmOZ4M3wDFnaZd0adzd1kEee1IT03qQL/N5NDeop+a4FDVfkjbxB/WJDwFc0e
         Jnx+THgD5oAFyF065HQEWS3v0d2XCI+LenuaqV6wJnXVwwTOFt1tyf4S21Z6WlTiPpQA
         cME4pYggDemo/idBYVHbXxHGVNH6yOyCltOL+LfQuhK2FWr35ifoQmBmHMn7XD/1RzQT
         mLiJLd2rJmNAiyc3grXDRwXagRyqlqYIASVXtOOdEI4gfsiOldyxpC2fdpaFf5Zu1drI
         zNaA==
X-Gm-Message-State: AIVw112rlwQo/eXvpOG2vWTXZCrQjDENLzfa/VSbh9QYYshtATtoOKcK
        sKcKWYNLQKdrSsuHCJSGIvWHnZ/MYGcj01g=
X-Received: by 10.84.224.74 with SMTP id a10mr30533799plt.210.1499380936556;
 Thu, 06 Jul 2017 15:42:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.183.170 with HTTP; Thu, 6 Jul 2017 15:42:15 -0700 (PDT)
In-Reply-To: <xmqqk23ldwbv.fsf@gitster.mtv.corp.google.com>
References: <CA+P7+xqS1Fh0aDV=QYbVMdRa=M4e-mBtjvknR=U_RShDoccNjQ@mail.gmail.com>
 <1n47so5.9e6qvf1bbqww4M%haller@ableton.com> <CA+P7+xq6MJa-J5cj2Om20d+g7KBretShpxH=13HWV7vFR9be8g@mail.gmail.com>
 <CACBZZX48RanjHsv1UsnxkbxRtqKRGgMcgmtVqQmR84H5j8awqQ@mail.gmail.com>
 <CA+P7+xowo+qXZ+Vr5vYg8wSpNzF44X9RsV34s_fKhBtVcddBvw@mail.gmail.com>
 <CAPc5daXVYA8MsseJxge6Qo6ASc=CL6ySt2K61LpOtZ=3H3gWuw@mail.gmail.com>
 <xmqq37a9fl8a.fsf_-_@gitster.mtv.corp.google.com> <CAGZ79kbCo3EjRGR_iE=6CJ2ou=4gMv3=t+s1ctGhUbZg8UDixA@mail.gmail.com>
 <xmqqk23ldwbv.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 6 Jul 2017 15:42:15 -0700
Message-ID: <CAGZ79kbkO8w+VFqCChe5O8TdkzK6xMB+0LEzWpJntxovf-3_xA@mail.gmail.com>
Subject: Re: [PATCH] push: disable lazy --force-with-lease by default
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Haller <haller@ableton.com>, Jeff King <peff@peff.net>,
        Matt McCutchen <matt@mattmccutchen.net>,
        Jacob Keller <jacob.keller@gmail.com>,
        Mike Rappazzo <rappazzo@gmail.com>,
        Francesco Mazzoli <f@mazzo.li>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 6, 2017 at 3:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> @@ -91,6 +91,7 @@ test_expect_success 'push to update (allowed)' '
>>>         (
>>>                 cd dst &&
>>>                 test_commit D &&
>>> +               git config push.allowLazyForceWithLease false &&
>>
>> Here I thought
>>
>>     test_config -C dst ...
>>
>> at the beginning might be useful, though ..
>
> I did not think test_config would work inside a subshell.

It does not, it would need to be done outside the ( ),
which is a bit subtle.
