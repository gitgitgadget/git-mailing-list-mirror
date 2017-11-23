Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2528202F2
	for <e@80x24.org>; Thu, 23 Nov 2017 16:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753115AbdKWQbm (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Nov 2017 11:31:42 -0500
Received: from mail-yb0-f173.google.com ([209.85.213.173]:43219 "EHLO
        mail-yb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753090AbdKWQbl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Nov 2017 11:31:41 -0500
Received: by mail-yb0-f173.google.com with SMTP id q84so4222022ybc.10
        for <git@vger.kernel.org>; Thu, 23 Nov 2017 08:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kD6EP2ZYwTC4BLfd25xn2h3UC6hJHHTdNkGypJfpuNM=;
        b=LTqGf3gkWnOQ/atjZOPTwgAqU6kYtUtPgUUMQ4HzLBPvkPmvPENwEX/LJ7rcGrnbrh
         fIU0sIeYAUdQtQpccQ3fUj+pja1UVFuP5UdiSbL9z8LSPftHX/IREbZa8XscHn2zA8V1
         MTDQDUeBjqc833xoLwPruNxK0mrRGCaor835YF2zb12AsGmhO0B3GhMkPcrLy8VQTJYa
         x+iNaTKjJTfRmVdyqlmgN2Ajqelfh3pvoay7DcpUpHq7eqPWWb7/4ucCppLtIeXxRicx
         ZGdfndqMMeSMCghm2mMAH0zzD0ANX/BB9FA5opq4xm2CNN36JebAnW8fk5g9MWtMQ/JG
         xhZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kD6EP2ZYwTC4BLfd25xn2h3UC6hJHHTdNkGypJfpuNM=;
        b=KVehFHsJBH/UhkFdZDUeni9Q7iWCnUMIs0LybIdThHEZ2v4Qb5z5eLTYs3LtWjSehg
         xM9VsGAQFaB5WLII5EAc+NnEpe7cD9i6oJxPPXZn/+rkAFDs5/k4dGJkxzR7zrqMtbQ3
         f1XLaqNhw4bkp0US6jkDPzdW5nZS9BfbfNV+DvwHOsGnEQ2YQJe7jFmVvd2gQX+7c1tM
         j49XyFcdvlbuEd8P6fV1lenJgmwta3P0l3lw2Py2kwS61lUvEoS4bTLUE72Qi6n/A+D/
         sDGcWOwWMWcJw2gjrsGZNba7CYApw9Y2O+n3My8/HRDzCYAtddNpHeSSEg4c4kJFwQcT
         uqoQ==
X-Gm-Message-State: AJaThX44KKnBbxUjlgThq4IXK+cle/SUZf0lXhkAjjCAqiuaqbsGfPDE
        iEohp39jb3EeUPnFsGoUq8cHGV4NdAGlLFIet0A=
X-Google-Smtp-Source: AGs4zMZnUXgKg1FpDgKlfC0eHdzhOOeWCNclibSTA2aivDdrPWJOUvKeWN5N6h59Nbpq7dRULuiU5nZAMBWKHltUIzo=
X-Received: by 10.37.177.16 with SMTP id g16mr15261476ybj.191.1511454700552;
 Thu, 23 Nov 2017 08:31:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.13.203.85 with HTTP; Thu, 23 Nov 2017 08:31:40 -0800 (PST)
In-Reply-To: <20171116161506.GA20809@tor.lan>
References: <CAJ_+vJ6FXXda4fe7=1YxtDGR2d8CqP4KXN+YR6+mdQ+5jQQXug@mail.gmail.com>
 <8b3225ce-a4aa-56ee-5296-6cc7528556d1@web.de> <CAJ_+vJ5J250CtzVg4QwEusddviDSYuJhubsbTJyv5Nc2conAfA@mail.gmail.com>
 <CAJ_+vJ7Yfcpz5252M4XJnDmEDCANp+eJ7RLJJF8TCcTxexZEUA@mail.gmail.com>
 <f9dc6482-587d-50a9-d649-aed63be18fad@web.de> <CAJ_+vJ6SxLOmZfG79Sa-vskBR-XG=C97--PB-vpijjUKym=jYw@mail.gmail.com>
 <20171115171258.GA12963@tor.lan> <CAJ_+vJ7am7dU9B0qTYVtxpkHoZdV45ciZN5ifbv9W8xRO2o=EQ@mail.gmail.com>
 <20171116161506.GA20809@tor.lan>
From:   Ashish Negi <ashishnegi33@gmail.com>
Date:   Thu, 23 Nov 2017 22:01:40 +0530
Message-ID: <CAJ_+vJ74mocjicpQ2BGUT+TrqrWqidp0bUJUGSz-B40-bC-c6w@mail.gmail.com>
Subject: Re: Changing encoding of a file : What should happen to CRLF in file ?
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for confirming.
Is it possible to track this via a bug number ?
It will help me to try out the fix when its available.


On Thu, Nov 16, 2017 at 9:45 PM, Torsten B=C3=B6gershausen <tboegi@web.de> =
wrote:
> On Thu, Nov 16, 2017 at 12:35:33AM +0530, Ashish Negi wrote:
>> On windows :
>> > git --version
>> git version 2.14.2.windows.2
>>
>> On linux :
>> > git --version
>> git version 2.7.4
>>
>> I would like to understand the solution :
>> If i understood it correctly : it removes file_name.txt from index, so
>> git forgets about it.
>> we then add the file again after changing encoding. This time, git
>> takes it as utf-8 file and converts crlf to lf when storing it
>> internally.
>> Right ?
>
> Yes, exactly.
> (In a coming release of Git there will be a "git add --renormalize <paths=
pec>" )
>
>>
>> Thank you for the support.
>>
>
> Thanks for a clean bug report.
> Actually it is a bug, I put it on my to do list
>
>
