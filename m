Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E1A1208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 21:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753180AbdHJVGn (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 17:06:43 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:38773 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753139AbdHJVGm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 17:06:42 -0400
Received: by mail-qk0-f172.google.com with SMTP id x191so11124368qka.5
        for <git@vger.kernel.org>; Thu, 10 Aug 2017 14:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=39lNN9U1q3m4mhpe1Lk1hO8qNXsNDtPRnp4M9GVi4To=;
        b=L01hbKtEbH+nU4KmtHFGKyYc21J0/qS1RUHkqlSQy7LTOKAgb8wYxZib48NmHXdq7J
         1WbLyDW5wYfhzjkO2cZmG1L5xjCPmVgxw8wTgQ5jkMKzOQnat9Kdsyfa/moUaZvha1/S
         8xTKJENcqwRZl5tILqhC+s/W1B5tm7+yC89fhI6wzNiehKZhRZx9tJ1CfS5GytgI9SlX
         tDR7+Bey1YxKGdTJ+u4ax/PirMRTWL+j6yMRiyu45HygaEgBLgMfbipNCdhGls8AnEs8
         h9I9XWYxb5ZpOcURzKx0vJ/iQmzV074UMOVPXLqpLKiXRjmBYL+j+/kagBqdV1sRVwNi
         VF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=39lNN9U1q3m4mhpe1Lk1hO8qNXsNDtPRnp4M9GVi4To=;
        b=ZxPDj3t5XfCMXfW3YhtBgUJyWYyK2P0mZg3r0rIbQ9CIIDLFWXqhj/m4sK6M4p8jPj
         uajlo2w2cCXM41apneW8qP/UlanCfxcq+BgSzo441L2ahq6Np6y7isEsvnV7xvnn9owH
         cPFAq5qcEOpqkD/uW3g9ouXfM9IKnhxcSfrl6E02j5jbfmRbL8iLuGAI+PPL3+d0BAOh
         QwENYwUIJYtJZX6xcrB60hFE09i7Mgw/oDO4F3DXrQkKAr9rxLS3oWbQ/qSKFupJGrzm
         7V8/DKf+hivXvlkrEufCWOoLp+1JtYVTfnoouUel9FDPJGzz3C8Lg7dlyr057piaC1OU
         Lvbg==
X-Gm-Message-State: AHYfb5hqL5JVv3HANwRjPTHcKFsGrSxpo33YeZJtwJsR14D+WDj2b38J
        5dF76LOCsel5bkOzvlS5iT+/RswZSQ==
X-Received: by 10.55.160.15 with SMTP id j15mr17598867qke.324.1502399201408;
 Thu, 10 Aug 2017 14:06:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.31.13 with HTTP; Thu, 10 Aug 2017 14:06:40 -0700 (PDT)
In-Reply-To: <CAGZ79kYeNb3sN4b8xZvYAjQOXWKP9oi+dNsJmS8fyz+iUH9p8A@mail.gmail.com>
References: <20170810080246.njjd5zkphytzmlda@sigill.intra.peff.net>
 <20170810080325.tehbbgajm4cgn2ku@sigill.intra.peff.net> <CAGZ79kabhz-FWNyjB6KjF4qpGfSqONBNVBcVd=+J=5XT+emz-A@mail.gmail.com>
 <20170810183713.z75bwk5eeavi6z22@sigill.intra.peff.net> <CAP8UFD2kWW41NDHVKjzdL2O2=QAeEtzKEPdJW3zR-zoeTiJPgw@mail.gmail.com>
 <CAGZ79kYeNb3sN4b8xZvYAjQOXWKP9oi+dNsJmS8fyz+iUH9p8A@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 10 Aug 2017 23:06:40 +0200
Message-ID: <CAP8UFD08oyY9eK-0Ydm2qh2etvc2_QGc0ujNswGUgUumwhy4+w@mail.gmail.com>
Subject: Re: [PATCH 4/5] interpret-trailers: add an option to normalize output
To:     Stefan Beller <sbeller@google.com>
Cc:     Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 10, 2017 at 9:44 PM, Stefan Beller <sbeller@google.com> wrote:
> On Thu, Aug 10, 2017 at 12:39 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> On Thu, Aug 10, 2017 at 8:37 PM, Jeff King <peff@peff.net> wrote:
>>> On Thu, Aug 10, 2017 at 11:35:00AM -0700, Stefan Beller wrote:
>>>
>>>> On Thu, Aug 10, 2017 at 1:03 AM, Jeff King <peff@peff.net> wrote:
>>>> > The point of "--only-trailers" is to give a caller an output
>>>> > that's easy for them to parse. Getting rid of the
>>>> > non-trailer material helps, but we still may see more
>>>> > complicated syntax like whitespace continuation. Let's add
>>>> > an option to normalize the output into one "key: value" line
>>>> > per trailer.
>>>> >
>>>> > As a bonus, this could be used even without --only-trailers
>>>> > to clean up unusual formatting in the incoming data.
>>>>
>>>> This is useful for the parsing part, but for the writing part we'd
>>>> rather want to have the opposite thing, such as
>>>> '--line-break=rfc822'. But this doesn't have to be part of this
>>>> series. With this in mind, I do not quite understand the latter
>>>> use case how you would use normalized trailers without
>>>> --only-trailers?
>>>
>>> If you prefer the normalized form (and the input was line-broken in a
>>> way that you don't like), then this would convert to your preferred
>>> form. I agree that you could potentially want the opposite (folding long
>>> lines). Perhaps something like --wrap=72.
>>
>> Related to this, I wonder if people might want to "normalize" in
>> different ways later. If that happens, we might regret having called
>> this option "--normalize" instead of "--one-per-line" for example.
>
> What is normal?
>
> Maybe --style=[one-line, wrapped:72, rfc, json, xml, ...]
> then?

Yeah, we could go there right now (using perhaps "--pretty" or
"--format" instead of "--style", so that we are more consistent with
other commands), but on the other hand we don't know yet if the other
formats will really be needed.

> If you have --one-per-line, this may be orthogonal to e.g. json
> (as json can be crammed into one line IIUC), but when given the
> selection you cannot combine multiple styles.
>
> Scratch that, we actually want to combine these styles with each
> other.

Yeah, that's another possibility for the future. People might want a
--json option that can be used both with and without --oneline. But as
the future is difficult to predict, let's try to make it easy for us
in both cases.

And I think starting with just "--oneline" would be easier to deal
with later than "--normalize" (or "--style" or "--pretty" or
"--format") especially in the latter case.
