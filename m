Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98AA020954
	for <e@80x24.org>; Thu,  7 Dec 2017 19:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752449AbdLGTyY (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 14:54:24 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:45410 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750828AbdLGTyX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 14:54:23 -0500
Received: by mail-wm0-f48.google.com with SMTP id 9so15047910wme.4
        for <git@vger.kernel.org>; Thu, 07 Dec 2017 11:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Go/g9mDz3FZUbWI1j+AXPXWZVTlp5br4pQy+a/v5tP4=;
        b=JxSqFRtgqKTAAJrebQNSWOLhvFkAMUkgB2QLsQnW0ekjw2iXxFUNzg+2clEnJ/vHgp
         gfk+baDUQ65dm1KngYscvTv/ZfYEC34E4oglrglD4Md42bBYkTArdlhCPHaT183rj/8x
         lTMtsZMXLybIlvQ8noZGCvsmvLw0LtniVnyW7ewofrRT7YMwu+mrlKPAKOi+JPFUBQHJ
         NEMUv+nMDHSiU220GG9Hv6vRQmQFp8yqdCmPTmuqhyjcibakVJMcWs4es35st+kczGMG
         +ABjm+g95zoyEPr/QmZGujTF67Rck8HDfODeu4RX3lIf9uyL2mx9brySnsJJl+ci5GWv
         h9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Go/g9mDz3FZUbWI1j+AXPXWZVTlp5br4pQy+a/v5tP4=;
        b=fQEggbgU2Y+LQ7AS7ZS5UrDN6lK+XsjsORolALDRg2JPDcsgexXANTopMp51rSuR2r
         2IP4og4hWWmVWEpN6O5/LOTooGft10uZRQCLgLBS1GRksCo4dj+cIXOUtj8H5SKe14WQ
         DHbDg8ey8yB9fE2tOPef7H7LxbXr15BbtbAeY9+4tuNDTY2J6XtISpgdE8Z8hlTQB6LJ
         vBCK967elfb4HL76MIlr2vaQ3UVj91LunOmlQkTqvoPLB2bKA7NzH66vGfWiCBhT+Jx1
         xSZRQ5kc6mfnGnDLuCWhctTe4O7VzheBLwhJmPx36Dfvf98zUpsWQUV6SwLlfH7Fb3hT
         A2CQ==
X-Gm-Message-State: AKGB3mLly88uyDvFniXUXfdeaLuMiwDpElcYjkgFoEwNDC6O+183enUi
        qJe/hgq1ddzMKwfNHh/oK2FfJw/KGCWTO4O1HS8=
X-Google-Smtp-Source: AGs4zMapu1Z47pZqVLOX0FgHnrs6GDwVzJenQGmJiSIPjj4WOtuOVTAjGjoMSM7x87HviJNjWlnxCbMAROIHKJhZU5c=
X-Received: by 10.80.176.70 with SMTP id i64mr4923296edd.187.1512676462558;
 Thu, 07 Dec 2017 11:54:22 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.174.252 with HTTP; Thu, 7 Dec 2017 11:54:02 -0800 (PST)
In-Reply-To: <xmqq374me4a7.fsf@gitster.mtv.corp.google.com>
References: <20171207190135.28660-1-jacob.e.keller@intel.com> <xmqq374me4a7.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 7 Dec 2017 11:54:02 -0800
Message-ID: <CA+P7+xom-R3JX1ghZLDciRX=5zsJs=ngCX9iM=Y8m8TN5TX_=g@mail.gmail.com>
Subject: Re: [PATCH] diff: add tests for --relative without optional prefix value
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 7, 2017 at 11:17 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
>
>>  for type in diff numstat stat raw; do
>> -     check_$type file2 --relative=subdir/
>> -     check_$type file2 --relative=subdir
>> -     check_$type dir/file2 --relative=sub
>> +     check_$type . file2 --relative=subdir/
>> +     check_$type . file2 --relative=subdir
>> +     check_$type . dir/file2 --relative=sub
>> +     check_$type subdir file2 --relative
>
> OK, I didn't think it would be sensible to unconditionally pass the
> directory and use "-C ." as a no-op.  It looks good.
>
> I think the new one should go before the dir/file2 test; all three
> earlier tests (including this new one) are about taking a patch
> relative to subdir/ spelled in different ways, and the one about
> dir/file2 alone is different.

Yea, your patch looked fine to me, minus the use of subshells where we
could avoid it.

I'm fine taking your version.

Thanks,
Jake
