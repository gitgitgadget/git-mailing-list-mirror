Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4ECB20229
	for <e@80x24.org>; Tue,  1 Nov 2016 20:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751866AbcKAUxu (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 16:53:50 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35512 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751157AbcKAUxu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2016 16:53:50 -0400
Received: by mail-pf0-f174.google.com with SMTP id i88so7383810pfk.2
        for <git@vger.kernel.org>; Tue, 01 Nov 2016 13:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=2n70wAWmURkmH4SO2O3CP10PZ/UziOTo4uawhYdorl4=;
        b=aEXmzGj/sintxeZiDDT1NrW9sIr/aBlmXRUT+yaAmOhNiZrJ9xDG56QCn/RVNyXslz
         nwxv/z0tCfHSzg/D59nKs1QN6OY9FqLGI/GDA1pAvhAYTOu14mQuZATAorf+/9U2qIBR
         cEpeRoacxLY3wcOueq2SJxfcbi+g5HfN2oIHTvixGkf1PRr/p+v014lt8t0vabdmmM40
         IzkfpJnutjhPPc2j+gSIXusBPcPphBpHcYETUtE6V5MKdm2JIflB7ToFvjsI6kLeFFOM
         yi92sTefGSTJBNN44/+VTxkUcNFurl4CDQhUMr2v04mEemrEdHdUMPNtEFnuCx2j5TA1
         5ExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=2n70wAWmURkmH4SO2O3CP10PZ/UziOTo4uawhYdorl4=;
        b=YDNH2xe81wVR+mULAQW/f96Zkeig+G6nozSE4PuyeYa56M5AwkItEjGgTLnYnRw1AC
         agyVrRNdBUsv5Po/ZQ7rH9ftPljd6MVokujcCm5101VVuWLFs1a3v1RGzorTrLxgcn6z
         ZR11HrlPvgp5QvXQK9agKdRtlAF8jfEZsn48CE3T0qWNDGCPJDZmv157OLfeEFFqqXXr
         vX7fiZSiTJWlMKzpcEFYQvRmI+/BzgWKgomsy2DZsbkFRIJS6i8aW+3QAyTY3+leY73a
         D2IBw6/g8XdNRHd/gTaB9VsWtf/lnDng0SbDAaLsuWRTHC19MRf0G9G5PQhSsEJx2fF9
         9qPA==
X-Gm-Message-State: ABUngvefn/sthe2vzh/z4Ju9DMyrK6SWfo5zKmM4tPhGsPEPPb6TMPGSzrgJ6+fcRaimnCf/
X-Received: by 10.99.47.7 with SMTP id v7mr52555070pgv.15.1478033629208;
        Tue, 01 Nov 2016 13:53:49 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:294b:6247:1bca:2342])
        by smtp.gmail.com with ESMTPSA id d26sm44196868pfb.37.2016.11.01.13.53.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Nov 2016 13:53:48 -0700 (PDT)
Subject: Re: [PATCH v2 1/5] trailer: be stricter in parsing separators
To:     Junio C Hamano <gitster@pobox.com>
References: <cover.1478028700.git.jonathantanmy@google.com>
 <cover.1477698917.git.jonathantanmy@google.com>
 <cover.1478028700.git.jonathantanmy@google.com>
 <c7db0aafb543845382e1835e3704273d3596e6bb.1478028700.git.jonathantanmy@google.com>
 <xmqqvaw7ndow.fsf@gitster.mtv.corp.google.com>
 <xmqqr36vndgn.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <0b3e70fe-5e1f-7aaa-4c3d-88f30cb15008@google.com>
Date:   Tue, 1 Nov 2016 13:53:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqr36vndgn.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/01/2016 01:37 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Jonathan Tan <jonathantanmy@google.com> writes:
>>
>>> Currently, a line is interpreted to be a trailer line if it contains a
>>> separator. Make parsing stricter by requiring the text on the left of
>>> the separator, if not the empty string, to be of the "<token><optional
>>> whitespace>" form.
>>
>> Hmph.  The optional whitespace is to allow for what kind of line?
>>
>> It is not for "Signed off by:" that is a misspelt "Signed-off-by:";
>> it may not hurt but I do not think of a case that would be useful
>> offhand.

This is to allow trailers of the form "Fix #42" (mentioned in the 
git-interpret-trailers documentation and also in the test).

> Other than this "Hmph" (which is not an objection---just something
> that the reviewer did not understand), the rest looked good to me.
>
> Will re-queue.
>
> Thanks.

Thanks!
