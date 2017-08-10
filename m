Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE3D5208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 19:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753169AbdHJTos (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 15:44:48 -0400
Received: from mail-lf0-f43.google.com ([209.85.215.43]:33374 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752983AbdHJToq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 15:44:46 -0400
Received: by mail-lf0-f43.google.com with SMTP id d17so8013596lfe.0
        for <git@vger.kernel.org>; Thu, 10 Aug 2017 12:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MPyv00AzJG/PfELEyKhDXdED7Cm/UXwcwePOF6mvr04=;
        b=iuocfe0oM7Exonw5aTrm8CUG6eC5Ggw3fpzD8HoAVL5QZzbweJCTwXcNXKVBcaOc5J
         nUluM6dV6jdzGLuKENcOlGABZObIw5MtvfpJNq68ITwK1Tjz0ghtOcrVLIyf8R/HeerJ
         gqRxgqIoiBL71szOUpNNcs7rfb7T36oRDWmbsUtkES6VF04D2KL8dhNrvbk5mde8soO8
         kUxNl/BlUBc1Sh5PW7NHkUBGl8H286wuIorpgRMIeJFJ+gIoG80BZrKIrVJ1wFjWJOv+
         pSwN8RLrSYUVtALqH8fufG7HAB+57W57Xc1GND3aFUST5q+uZQdVYHeRj5jq5ui4xBzF
         9f8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MPyv00AzJG/PfELEyKhDXdED7Cm/UXwcwePOF6mvr04=;
        b=qlUlpxGXGQcGh0aAWR7Ja2GwO7QyGavLrkVLQOTb+go2/4GnNpTs3agehiCYDh6QQP
         pqjRYBtQRiP+GQqb+upP5LS86otpKV5dBR2AJJgdRMOzLj+8v3ZN+qbbMv33YgR/6DRs
         i952PtuK9ECtc4REMY05ZX2dAEpydtqQSX9w6iFRufaJfy4QC/97qRZC5M9+pMX7arn9
         qOkUB4pTyyO1U7vOMfygA6PSbv0/SqPnvOkgdDT1yw8VeGwPfVz4c2JpqEM2TkDsL9L9
         Necegrlnh05Rm3rw4au8EBiz/AgHRisfIzetMoyFvspXJx16FgJ1hPo7IBmi7Ml0V4lx
         MO8Q==
X-Gm-Message-State: AHYfb5iTv7SpjxpCBTADAHoas7Wx/19HttjPKBQZtgRgS1ASnzB9yNdn
        3+EU4lEb9vj2PiiJpt+gX5OKMZ119/UG
X-Received: by 10.25.228.206 with SMTP id x75mr3940503lfi.94.1502394284760;
 Thu, 10 Aug 2017 12:44:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.1.130 with HTTP; Thu, 10 Aug 2017 12:44:44 -0700 (PDT)
In-Reply-To: <CAP8UFD2kWW41NDHVKjzdL2O2=QAeEtzKEPdJW3zR-zoeTiJPgw@mail.gmail.com>
References: <20170810080246.njjd5zkphytzmlda@sigill.intra.peff.net>
 <20170810080325.tehbbgajm4cgn2ku@sigill.intra.peff.net> <CAGZ79kabhz-FWNyjB6KjF4qpGfSqONBNVBcVd=+J=5XT+emz-A@mail.gmail.com>
 <20170810183713.z75bwk5eeavi6z22@sigill.intra.peff.net> <CAP8UFD2kWW41NDHVKjzdL2O2=QAeEtzKEPdJW3zR-zoeTiJPgw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 10 Aug 2017 12:44:44 -0700
Message-ID: <CAGZ79kYeNb3sN4b8xZvYAjQOXWKP9oi+dNsJmS8fyz+iUH9p8A@mail.gmail.com>
Subject: Re: [PATCH 4/5] interpret-trailers: add an option to normalize output
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 10, 2017 at 12:39 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Thu, Aug 10, 2017 at 8:37 PM, Jeff King <peff@peff.net> wrote:
>> On Thu, Aug 10, 2017 at 11:35:00AM -0700, Stefan Beller wrote:
>>
>>> On Thu, Aug 10, 2017 at 1:03 AM, Jeff King <peff@peff.net> wrote:
>>> > The point of "--only-trailers" is to give a caller an output
>>> > that's easy for them to parse. Getting rid of the
>>> > non-trailer material helps, but we still may see more
>>> > complicated syntax like whitespace continuation. Let's add
>>> > an option to normalize the output into one "key: value" line
>>> > per trailer.
>>> >
>>> > As a bonus, this could be used even without --only-trailers
>>> > to clean up unusual formatting in the incoming data.
>>>
>>> This is useful for the parsing part, but for the writing part we'd
>>> rather want to have the opposite thing, such as
>>> '--line-break=rfc822'. But this doesn't have to be part of this
>>> series. With this in mind, I do not quite understand the latter
>>> use case how you would use normalized trailers without
>>> --only-trailers?
>>
>> If you prefer the normalized form (and the input was line-broken in a
>> way that you don't like), then this would convert to your preferred
>> form. I agree that you could potentially want the opposite (folding long
>> lines). Perhaps something like --wrap=72.
>
> Related to this, I wonder if people might want to "normalize" in
> different ways later. If that happens, we might regret having called
> this option "--normalize" instead of "--one-per-line" for example.

What is normal?

Maybe --style=[one-line, wrapped:72, rfc, json, xml, ...]
then?

If you have --one-per-line, this may be orthogonal to e.g. json
(as json can be crammed into one line IIUC), but when given the
selection you cannot combine multiple styles.

Scratch that, we actually want to combine these styles with each
other.
