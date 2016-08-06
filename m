Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F8F31F859
	for <e@80x24.org>; Sat,  6 Aug 2016 20:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751949AbcHFUbz (ORCPT <rfc822;e@80x24.org>);
	Sat, 6 Aug 2016 16:31:55 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:33918 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356AbcHFUbw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Aug 2016 16:31:52 -0400
Received: by mail-qk0-f173.google.com with SMTP id p186so166239873qkd.1
        for <git@vger.kernel.org>; Sat, 06 Aug 2016 13:31:47 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=74DQhiv+JE+j9un7U82Qbg9gI6BdI+n8DDGS4wr0p/Q=;
        b=AxsKqBi0jSz9wa4MRrNVQubG9Dx2jxMTYe59k0wEzuxgA9hMi9PSi3G+KJ3WywKZiD
         wrbuKRyvgMISXy9f/P4jcvtI0derMbtToIyUwMm4AD9b1yTErmXR5oli8CeXv+8z8Ni/
         BpK0SYQ91w4osg3DmzAtBzVdB9Ma3mmhfWprzOqtGkwQB/+Bpr9at7y2IBhHFpw31tCI
         lAY01WCX4Tu4yZAISUuwbk7gsnhFQpJyZL+3C9H6d5h+w0ePi2TGe8i7nDsROaRo9YHb
         TZPz2cj9gQQGirJ0E7b0TTX/YkOnlm4Mlhl/9aMJx7oNAzQbY9eQhPx0zJX/Hzt8Z7Tc
         jntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=74DQhiv+JE+j9un7U82Qbg9gI6BdI+n8DDGS4wr0p/Q=;
        b=iWgJ4RMMp1I5514H4DLLJgx49FR6SETWNgqAEIgg2cGf/ael4xC9VzxSNmrAsjRpbv
         PP2udBDxMKatEhZS/ygIWftD8fdkgt2uLYuN7Q6tgu6Ol45ZAQnbapMFV7rBKYJ+rQj/
         Z0lxh+ofeGers9J4kHRHVfrIS64f7gYVFBfRfk5R4yqTpN7BJw2okZtcKe1yFC3AVBO8
         PHRvfx/mlVtQy/4piJcFChV9TXoApCUfwL1rPnr9Tda/M5K7x3xP0iC67YqDT+cZWUoE
         CFgV/aLSvYkIRKqRKbaEnyFSxv25PMFqmHrw/l/ddZpOF+B/RnnnmlOx5fKQFgalC2Ly
         WOfg==
X-Gm-Message-State: AEkoouurclz1oeb8JZUbVS7Yb2oltqNJ3kWrOboX7kF6K4YA7hKOzY+ixSN1g4lNIyZjMw==
X-Received: by 10.55.165.202 with SMTP id o193mr18990889qke.285.1470484527613;
        Sat, 06 Aug 2016 04:55:27 -0700 (PDT)
Received: from orebqcbn32.ads.autodesk.com ([132.188.72.182])
        by smtp.gmail.com with ESMTPSA id d38sm12153182qte.17.2016.08.06.04.55.25
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 06 Aug 2016 04:55:27 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v4 11/12] convert: add filter.<driver>.process option
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20160805222710.chefh5kiktyzketh@sigill.intra.peff.net>
Date:	Sat, 6 Aug 2016 13:55:23 +0200
Cc:	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	=?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	mlbright@gmail.com, e@80x24.org
Content-Transfer-Encoding: 8BIT
Message-Id: <87D4BF17-67BB-4AFA-9B27-40DBB44C0456@gmail.com>
References: <20160729233801.82844-1-larsxschneider@gmail.com> <20160803164225.46355-1-larsxschneider@gmail.com> <20160803164225.46355-12-larsxschneider@gmail.com> <2e13c31c-5ee2-890d-1268-98fb67aba1ea@web.de> <xmqqfuqivpjv.fsf@gitster.mtv.corp.google.com> <20160805222710.chefh5kiktyzketh@sigill.intra.peff.net>
To:	Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 06 Aug 2016, at 00:27, Jeff King <peff@peff.net> wrote:
> 
> On Fri, Aug 05, 2016 at 03:06:28PM -0700, Junio C Hamano wrote:
> 
>> Torsten Bögershausen <tboegi@web.de> writes:
>> 
>>> On 2016-08-03 18.42, larsxschneider@gmail.com wrote:
>>>> The filter is expected to respond with the result content in zero
>>>> or more pkt-line packets and a flush packet at the end. Finally, a
>>>> "result=success" packet is expected if everything went well.
>>>> ------------------------
>>>> packet:          git< SMUDGED_CONTENT
>>>> packet:          git< 0000
>>>> packet:          git< result=success\n
>>>> ------------------------
>>> I would really send the diagnostics/return codes before the content.
>> 
>> I smell the assumption "by the time the filter starts output, it
>> must have finished everything and knows both size and the status".
>> 
>> I'd prefer to have a protocol that allows us to do streaming I/O on
>> both ends when possible, even if the initial version of the filters
>> (and the code that sits on the Git side) hold everything in-core
>> before starting to talk.
> 
> I think you really want to handle both cases:
> 
>  - the server says "no, I can't fulfill your request" (e.g., HTTP 404)

You can do this with the current protocol:

packet:          git< 0000
packet:          git< result=reject\n

Admittedly the flush packet could be consider overhead but I think
that is neglectable.


>  - the server can abort an in-progress response to indicate that it
>    could not be fulfilled completely (in HTTP chunked encoding, this
>    requires hanging up before sending the final EOF chunk)

Also already supported with the following sequence:

packet:          git< HALF_WRITTEN_ERRONEOUS_CONTENT
packet:          git< 0000
packet:          git< result=error\n


> If we expect the second case to be rare, then hanging up before sending
> the flush packet is probably OK. But we could also have a trailing error
> code after the data to say "ignore that, we saw an error, but I can
> still handle more requests".
> 
> It is true that you don't need the up-front status code in that case
> (you can send an empty body and say "ignore that, we saw an error") but
> that feels a little weird.

I understand your argument. However, I think "0000" indicates 
"I have nothing for you" and therefore I think it would be OK in the
reject case.


> And I expect it makes the lives of the client
> easier to get a code up front, before it starts taking steps to handle
> what it _thinks_ is probably a valid response.

I am not sure I can follow you here. Which actor are you referring to when
you write "client" -- Git, right? If the response is rejected right away
then Git just needs to read a single flush. If the response experiences
an error only later, then the filter wouldn't know about the error when
it starts sending. Therefore I don't see how an error code up front could
make it easier for Git.

- Lars


