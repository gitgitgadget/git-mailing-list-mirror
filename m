Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77DE120195
	for <e@80x24.org>; Wed, 13 Jul 2016 06:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbcGMGC6 (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 02:02:58 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:35201 "EHLO
	mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009AbcGMGCx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jul 2016 02:02:53 -0400
Received: by mail-it0-f67.google.com with SMTP id f6so2355898ith.2
        for <git@vger.kernel.org>; Tue, 12 Jul 2016 23:02:36 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3tveVTbLbahAAz76C5c/NDy47DbLayLmEgBKfJCmT+c=;
        b=hTWB8g1ftawdTrML4rh+dc/ZRVlMP33gqrfELkMNxlQYpfKgIi3Gx322QKAzhN3Wn/
         ed2aQJDOBuKmlc55INkvj7/YkIQXE2O09IJ8MuC2MPT9ofG7ElDdwNaTuNh/QV82nST9
         YBDQsPb0ahrDlvoB4/an0atuhtaN8EWxvhHlLL7wbBVYSFd97aobclBSRKfln4vXj8uO
         UPQEdRPcne9H6rJG4YDlaboQR3PTEXiAle2CTaYJ9iKg4+0xZ6jlLI3iW5/OinmWlL6m
         jsHlIt/xAQfg+FOwvU/WdI1UcP8+DFVcOUyEdCLgm69eric8SYC6vxr3BSCZKIgEaf9n
         OpkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3tveVTbLbahAAz76C5c/NDy47DbLayLmEgBKfJCmT+c=;
        b=JC7h6eUoyq1m+rsxOgXS/pw/xH2iGo3WL4pVXUSI5xdq8uXqedk6/5Z7sUxLoTFE9r
         tMP/X2TS9xLD5YRA3XOzlFoCVBKCoKxZ7KblEBXXgwfswZ1JR6rQYJeR5X0AMxace0Ef
         3YnMq1022pG1mS1ti2fabMzttAldWEvfW41knK8qkRIHCDnQ+BoyUPLoVMwE16umMZu9
         u8wi1iKWYx8Yu0hWMHpYNjUAMi5Z3YeqSokbfPFE8Tq6K3uj18pckAeMCdXoAojLE2Xk
         i9ssfEpbh767GLaXpxA5BkcfGZyIUtEoMDMsALJ/Vw8uY7Qiz6MrrMXpeSrNNtDSZofx
         joUg==
X-Gm-Message-State: ALyK8tITfGNsSYUZ6kTXBOREIvvu7lM9q5gIiJMulXqYwr11lsuJIpyO2wz6ttED1HRAYIBDRUoyRaIxpGe4Jw==
X-Received: by 10.36.43.5 with SMTP id h5mr21180724ita.57.1468389736948; Tue,
 12 Jul 2016 23:02:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Tue, 12 Jul 2016 23:01:47 -0700 (PDT)
In-Reply-To: <xmqq60sa4mnv.fsf@gitster.mtv.corp.google.com>
References: <1466807902.28869.8.camel@gmail.com> <20160705170558.10906-1-pclouds@gmail.com>
 <xmqq60sa4mnv.fsf@gitster.mtv.corp.google.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Wed, 13 Jul 2016 08:01:47 +0200
Message-ID: <CACsJy8CXg_x_4GRe88yUBYFm-_1=REAox=wK5yzu4W7Mf2qwgQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] Number truncation with 4+ GB files on 32-bit systems
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Christoph Michelbach <michelbach94@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 12, 2016 at 10:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:
>
>> Since I now could reproduce the problem that Christoph showed, I
>> decided to send the good patches out. To sum up, we use "unsigned
>> long" in some places related to file size. On 32-bit systems, it's
>> limited to 32 bits even though the system can handle files larger than
>> that (off_t is 64-bit). This fixes it.
>>
>> clang -Wshorten-64-to-32 is very helpful to spot these problems. I
>> have a couple more patches to clean all these warnings, but some need
>> more code study to see what is the right way to do.
>>
>> Most of the rest seems harmless, except for the local variable "size"
>> in builtin/pack-objects.c:write_one(). I might send 6/5 for that one.
>
> With 1-7/5 it appears t1050 is broken?

Oops, sorry I focused on testing big repos and forgot the test suite.
But hehe.. it's a good thing. That test was added by 735efde, where
fsck could keep on going after failing to inflate some blobs (instead
of hitting malloc failure and abort). Now it's even better, fsck
passes. I'll fix that up and resend with your squashes in.
-- 
Duy
