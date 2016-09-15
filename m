Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C38A2070F
	for <e@80x24.org>; Thu, 15 Sep 2016 19:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753409AbcIOTgA (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 15:36:00 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38717 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751627AbcIOTf6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 15:35:58 -0400
Received: by mail-wm0-f43.google.com with SMTP id 1so2194135wmz.1
        for <git@vger.kernel.org>; Thu, 15 Sep 2016 12:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=M19wCyl6huV/gReIBSwAx33bQEli2hnheMlhVxNNuDU=;
        b=U1EPZBOJczi5XjImHsXDHZdeRXuOAe7Zl/2hMaqrAzKfEJBrvL2hg8+MnAtiVXb/Dy
         ZHVbtM8SalultVh6ET6n8sOv8BQbOPSaaPMZKw4zGtHv/yTQ+vJeKYevBNLX8uREVdpr
         q7N6SjKATt7KgYBcBiLtUMRU10uyRpXzUGMGe5z8aYYrT0kPuFWaTmDazmyXWZPir6PW
         uqUUe5yqerDWHWDJjY3InOB48MZnE2CeZMjqTl6M+UMFksqobfXB33YIp/3Vi8XO0ui0
         r1j0ORQiC8tcPjIOzxY47ED/yRYjn+Yy/AALIz3i0vlhmmLEJpe7zbKM0Hb2lFJbr2kB
         aMEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=M19wCyl6huV/gReIBSwAx33bQEli2hnheMlhVxNNuDU=;
        b=K3pXZuwB4ojKGd3U5QuGXwMhNDYV0J8zh1qiPQY7xP+LrgoZjiXRJNaeT9bB4sciCQ
         LyHElu2H1h0Z6ZrtiNFZgI9ycAWMRWaxEsHvk9QLoJNmQsrXz7LoJP8v6jyIpehGf4g/
         /TaGJTFqo8qX8jwezPiGDQq+Mp8BtoSxNP6pYRHYjvGYUETSolPRfm9uKwOgUhQfsd9J
         cyh8pnYLrQtsrDGAMYNk3LNyaTHMFalhUpSthMntEMBih4bKuRzTTpXNbUGIK/oWA6gH
         HF+IkTbVti4CzYoPdoYZzK39sMHvtxUuQAwKXA5vvkZt69R1vVNogs2OKtUUBqru/Zg0
         Nx1w==
X-Gm-Message-State: AE9vXwNe0HAc3Qd5cuYDYJAKFLMFi3PrWX1Nst8epiSaAv3V0TMEFt64d9QGgQMl4yDAhQ==
X-Received: by 10.194.39.5 with SMTP id l5mr9360671wjk.33.1473968157180;
        Thu, 15 Sep 2016 12:35:57 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB61FE.dip0.t-ipconnect.de. [93.219.97.254])
        by smtp.gmail.com with ESMTPSA id b188sm3797450wmg.24.2016.09.15.12.35.54
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Sep 2016 12:35:56 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v7 04/10] pkt-line: add packet_flush_gently()
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqq37l3v2rk.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 15 Sep 2016 17:42:58 +0100
Cc:     Git Mailing List <git@vger.kernel.org>, peff@peff.net,
        sbeller@google.com, Johannes.Schindelin@gmx.de, jnareb@gmail.com,
        mlbright@gmail.com, tboegi@web.de, jacob.keller@gmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <385016D3-8298-4273-81E7-876CB25B2789@gmail.com>
References: <20160908182132.50788-1-larsxschneider@gmail.com> <20160908182132.50788-5-larsxschneider@gmail.com> <xmqqinu0y9v1.fsf@gitster.mtv.corp.google.com> <B138B703-08A6-45C4-9D54-80F87C75356B@gmail.com> <xmqq37l3v2rk.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 13 Sep 2016, at 23:44, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Lars Schneider <larsxschneider@gmail.com> writes:
> 
>>> On 13 Sep 2016, at 00:30, Junio C Hamano <gitster@pobox.com> wrote:
>>> 
>>> larsxschneider@gmail.com writes:
>>> 
>>>> From: Lars Schneider <larsxschneider@gmail.com>
>>>> 
>>>> packet_flush() would die in case of a write error even though for some
>>>> callers an error would be acceptable. Add packet_flush_gently() which
>>>> writes a pkt-line flush packet and returns `0` for success and `-1` for
>>>> failure.
>>>> ...
>>>> +int packet_flush_gently(int fd)
>>>> +{
>>>> +	packet_trace("0000", 4, 1);
>>>> +	if (write_in_full(fd, "0000", 4) == 4)
>>>> +		return 0;
>>>> +	error("flush packet write failed");
>>>> +	return -1;
>>> 
>>> It is more idiomatic to do
>>> 
>>> 	return error(...);
>>> 
>>> but more importantly, does the caller even want an error message
>>> unconditionally printed here?
>>> 
>>> I suspect that it is a strong sign that the caller wants to be in
>>> control of when and what error message is produced; otherwise it
>>> wouldn't be calling the _gently() variant, no?
>> 
>> Agreed!
> 
> I am also OK with the current form, too.  Those who need to enhance
> it to packet_flush_gently(int fd, int quiet) can come later.

"caller wants to be in control [...] otherwise it wouldn't be calling 
the _gently() variant" convinced me. I would like to change it like
this:

	trace_printf_key(&trace_packet, "flush packet write failed");
	return -1;

Objections?

Thanks,
Lars
