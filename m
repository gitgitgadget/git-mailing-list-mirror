Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 093A91F859
	for <e@80x24.org>; Thu, 25 Aug 2016 19:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751667AbcHYTfw (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 15:35:52 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32886 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751494AbcHYTfu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 15:35:50 -0400
Received: by mail-wm0-f66.google.com with SMTP id o80so8662368wme.0
        for <git@vger.kernel.org>; Thu, 25 Aug 2016 12:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=references:mime-version:in-reply-to:content-transfer-encoding
         :message-id:cc:from:subject:date:to;
        bh=w9pa9iPcPVi5rNgHk+EQGkV7Ngbt5fcPUAqMZPyb4vE=;
        b=zaFLnCneQ570zf49+FOVKABUy9VV1PQG9s/csFaFqp/WR5w44IDZulHDR4OI/ZF8b2
         r6p0EEb4rLhbXPo8KWOAK5ctW2TJdUA9RBAQoreyfEzKP7ZwLVFf3nY/XvKN/u2AhDuX
         WU80fF1JOXpm47yqaWnGd6iYchuq+tXoV7aYkMSKlNNBwnB77nNrUcUchSVamgcF0CbH
         5/FM3rGMZdDgRT8HqfdgaGJo80Ic0sffiJchwD+6mtvCFcmlR02fSLIKUtRzVME9BOXF
         l7LiNEz0iPBnrFl8QMixxGv0sZ9vtOVa40GJGuri+6QHG+f0Va0+8aO4GIBZoeIKYcuO
         qbtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:references:mime-version:in-reply-to
         :content-transfer-encoding:message-id:cc:from:subject:date:to;
        bh=w9pa9iPcPVi5rNgHk+EQGkV7Ngbt5fcPUAqMZPyb4vE=;
        b=mvU+Utt/62TCAJy3FngPU1BFqBMOalwyVJM9KyyrKgUE/wMPRIMpqWKxBH3nnxuUv2
         ZDc840sL0mcFirySwOfKDK8SC6/nb56vM9g465BHPm/ng2SgZsqV/0xTH5vG+R3Qnx9Y
         Hd2PAT6k3xl5qVWhSybpOl4AQ7A1N4bP07ALGrpZHmxcaUFQUHYVWTtPC7IvSYEKZ+RF
         Jdb1qo6ZCykY+sMDgP8AVvL3hZfThxJjh78DzQCR6uio5W3cA3jt9tcpTVRa4h3Hy6wx
         3v04MaOs8asbC5CcjuxMgmQP9njsFwWi/i0RY29K5ksGRtdVsaqo2JGXYkPUUWza0TMz
         5LFA==
X-Gm-Message-State: AEkooutQZ3mSP8OxUmWRGojn2nVR8ZntIbfWKheebhv9l7Yva4CGqEJEtDMbVB1iznVs7A==
X-Received: by 10.194.87.67 with SMTP id v3mr9015883wjz.103.1472153711895;
        Thu, 25 Aug 2016 12:35:11 -0700 (PDT)
Received: from [10.20.236.170] (tmo-114-227.customers.d1-online.com. [80.187.114.227])
        by smtp.gmail.com with ESMTPSA id v189sm40209516wmv.12.2016.08.25.12.35.11
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Aug 2016 12:35:11 -0700 (PDT)
References: <20160825110752.31581-1-larsxschneider@gmail.com> <20160825110752.31581-8-larsxschneider@gmail.com> <CAGZ79kaJn-yf28+Ls2JyqSs6Jt-Oj2JW-sAXQn-Oe5xaxSyjMQ@mail.gmail.com>
Mime-Version: 1.0 (1.0)
In-Reply-To: <CAGZ79kaJn-yf28+Ls2JyqSs6Jt-Oj2JW-sAXQn-Oe5xaxSyjMQ@mail.gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <6EC60D1B-3A92-4381-A87E-50417CF04A49@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Martin-Louis Bright <mlbright@gmail.com>
X-Mailer: iPhone Mail (13G35)
From:   Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v6 07/13] pack-protocol: fix maximum pkt-line size
Date:   Thu, 25 Aug 2016 21:35:08 +0200
To:     Stefan Beller <sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 25 Aug 2016, at 20:59, Stefan Beller <sbeller@google.com> wrote:
> 
>> On Thu, Aug 25, 2016 at 4:07 AM,  <larsxschneider@gmail.com> wrote:
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> According to LARGE_PACKET_MAX in pkt-line.h the maximal length of a
>> pkt-line packet is 65520 bytes. The pkt-line header takes 4 bytes and
>> therefore the pkt-line data component must not exceed 65516 bytes.
>> 
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
> 
> I was recently encouraged off list to really try hard to go with
> shorter series's.
> (Duh! Everyone knows that shorter series go in faster ;)
> 
> And as this is a strict bug fix of Documentation that makes sense
> outside this series,
> I'd like to encourage you to send this as a separate patch in case you
> need further
> rerolls.

Agreed!

Thanks,
Lars
