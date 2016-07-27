Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FD29203E2
	for <e@80x24.org>; Wed, 27 Jul 2016 09:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754203AbcG0JNb (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 05:13:31 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37183 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753432AbcG0JN3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 05:13:29 -0400
Received: by mail-wm0-f50.google.com with SMTP id i5so52246829wmg.0
        for <git@vger.kernel.org>; Wed, 27 Jul 2016 02:13:28 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=NyQPONIkz9R1mqAODePWCwA3FWLMHhE50EImz9p8rHk=;
        b=CVd9SuuwxC5zna/BQqbiFfqn0t++yJ/uA+CbXivpWTfWYlOB003EUXRtYebO1o6xXU
         X0DWtmZeMbGU1OQG1IR4ab1u/yWUOy8Se2NcWsPaWMfSiNbPwuGuvJmClpYor5ZT7484
         bGzAKDIj85LY45KQU6KmqDX0JJBeX0oX8i7WQmiTR1z6d7QW6ddFvR6la4HGj1HM5egT
         ExhpbqFkHazRAr/iaRQOr4DDeH7bwBsmrXA9WGBdpzDB927QHHeOTwTj5WPUAEymgOkv
         fV4LV6aw3mhpN2f5yxdUeLekWeVGJUufhmuEzYKI3XKAfUvgXADUfUcWZRGMtN3ImV41
         DsvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=NyQPONIkz9R1mqAODePWCwA3FWLMHhE50EImz9p8rHk=;
        b=LhQWbEYUDkAoCEGL4dd0Sh3RQM3ONT6b1Ukt+5a+npy1JapnJCME61UHbv+Il+PMRM
         o87UG9fZywwGCyeMsmsn+LjlRHn21zRWS0ZC/vjAGuodAMUPK00OVQumm+a/g4apJw5I
         o0+GElEm+skXipKSrJarl6fi8n2lV5JhgR3EjCjw2yXzNdTOXPNa3HqD08zaaFeAjled
         XaeiIH030rBV1c/s1fgC95ylBltN8sTP6TVCG3OYmrPypyr4AKynfBHhHOcW1JS06QWc
         /tc/+QrZFPGnWGOCY7ZAFInD5C2XYD3dil1yJaVuCNi2kEWHAl7mNVIS+pgcrSVwxWrV
         Lm1g==
X-Gm-Message-State: AEkooutTeoVPSqq9UZ8DleOlKttfsWzpRA5uJfgmuXyvbhQFI6/lzMYxIyxi5fzbChW0UQ==
X-Received: by 10.194.75.198 with SMTP id e6mr26541549wjw.31.1469610808040;
        Wed, 27 Jul 2016 02:13:28 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id r127sm37241452wmf.23.2016.07.27.02.13.26
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Jul 2016 02:13:27 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2 3/5] pkt-line: extract and use `set_packet_header` function
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqinvsx77w.fsf@gitster.mtv.corp.google.com>
Date:	Wed, 27 Jul 2016 11:13:26 +0200
Cc:	Git Mailing List <git@vger.kernel.org>,
	=?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	tboegi@web.de, mlbright@gmail.com,
	remi.galan-alfonso@ensimag.grenoble-inp.fr, pclouds@gmail.com,
	e@80x24.org, ramsay@ramsayjones.plus.com, peff@peff.net
Content-Transfer-Encoding: 7bit
Message-Id: <A6E129CE-26F9-456A-B9C7-A502245DD19E@gmail.com>
References: <20160722154900.19477-1-larsxschneider@gmail.com> <20160727000605.49982-1-larsxschneider@gmail.com> <20160727000605.49982-4-larsxschneider@gmail.com> <xmqqinvsx77w.fsf@gitster.mtv.corp.google.com>
To:	Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 27 Jul 2016, at 02:20, Junio C Hamano <gitster@pobox.com> wrote:
> 
> larsxschneider@gmail.com writes:
> 
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> `set_packet_header` converts an integer to a 4 byte hex string. Make
>> this function publicly available so that other parts of Git can easily
>> generate a pkt-line.
> 
> I think that having to do this is a strong sign that the design of
> this series is going in a wrong direction.

Thanks for the feedback. Do you think using "pkt-line" is a move into
the wrong direction in general or do you think only my usage of 
"pkt-line" is not ideal?


> If you need a helper function that writes a pkt-line format that
> behaves differently from what is already available (for example,
> packet_write()), it would be much better to design that new function
> so that it would be generally useful and add that to pkt-line.[ch],
> instead of creating random helper functions that use write(2)
> directly, bypassing pkt-line API, to write stuff.
> 
> In other words, do not _mimick_ pkt-line; enhance pkt-line as
> necessary and use it.

OK, I understand your argument. If we agree on the "pkt-line" usage
then I will address this issue.

Thanks,
Lars
