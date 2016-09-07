Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C20751F859
	for <e@80x24.org>; Wed,  7 Sep 2016 21:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932380AbcIGVVf (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 17:21:35 -0400
Received: from mail-yb0-f181.google.com ([209.85.213.181]:32932 "EHLO
        mail-yb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932260AbcIGVVd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 17:21:33 -0400
Received: by mail-yb0-f181.google.com with SMTP id d205so10459438ybh.0
        for <git@vger.kernel.org>; Wed, 07 Sep 2016 14:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nleGSwFKNvXLluMpU4QMDOO2+K4m6AaJkRw0b/XIM8U=;
        b=XzVHTHSgBhlBVFWhQwTFzcGzDLPprCt1S3Y/dYqQgAEJ0M28MkH6nlzXSkeCBRGkI2
         bR+8FuLjZyowkNdr3FEpbkRwM4Htffmls67y2ic9Ub457f3P5eXIZoTexXXGg1nWoo97
         IRIV094nFUcNKpd7srN+xq3sp9URRQvr+5Y77GxxAlKI3etY+Esk52RYk9KarQs0C3zt
         NfPzbclB1jHERblRUjgV3vyWdbz45eQX4y40oe6hK4V88PnWcuSSfRyH375YfOHTvu0D
         KrLnz+8SyaQucBQX2tnj3tfvlITIxYQERMWXwwAzOl6LkaltTrf2QsKljMHntn2dsP7n
         SUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nleGSwFKNvXLluMpU4QMDOO2+K4m6AaJkRw0b/XIM8U=;
        b=dg297kU5exZDR1iq/vm+u5F/jdgLg2tcB085Oki5ly3DiMVvVPkfObwzwTuLD5wYGN
         NLNfUOVdJ1s+fpIvNBBAJccdftALvWEvoeECbZWNc4qqG6GNOA9dEclK/ladDXppOWUa
         wqQiY4lMlMn9AHXkdQl7OEOEOzC9cIRggSSPH0gwFX6T0fXYcuC5EJfQgs+HIEGefhws
         Uy7B8wk/zKWypUOApXChNoLdHfOFTRp45WboaJCq9R2Zky19X8rk5qDcQUEy26+3yUM3
         2iEQFpSHTwLCSRthbXQN4LQe54YWbYR1LeSwOW8rxhtGrWUVnnjAfaf4J/fnYCDCEpp9
         3uHA==
X-Gm-Message-State: AE9vXwNLYvPFHXGZY1eUKUUHucmVCP718O6Um294bCkW9rCazxV0OKNBRa/9YWjnv7pm5RmBfLvQQYVjtF37dA==
X-Received: by 10.37.25.7 with SMTP id 7mr6355813ybz.20.1473283292852; Wed, 07
 Sep 2016 14:21:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Wed, 7 Sep 2016 14:21:12 -0700 (PDT)
In-Reply-To: <CAGZ79kbSG-9xdmG3LWEsVoJnhEr5pcL8D-95E99a+=JaXGOXCA@mail.gmail.com>
References: <20160904234237.10548-1-stefanbeller@gmail.com>
 <CA+P7+xr=Lp36wDw2BRuhQ9Genv4q6iu9beGQe5hzOn5PJYDPfw@mail.gmail.com>
 <CAGZ79ka7VV6Pqw-rcVFv0xU4J4D9dHWPg-oocPPWJdY5JVhT+A@mail.gmail.com>
 <xmqq7fanoas6.fsf@gitster.mtv.corp.google.com> <CAGZ79kbSG-9xdmG3LWEsVoJnhEr5pcL8D-95E99a+=JaXGOXCA@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 7 Sep 2016 14:21:12 -0700
Message-ID: <CA+P7+xp8KeeKY3jkWeSNzUvV1_cXOGpES4Ymj3BRTmM06jhY0Q@mail.gmail.com>
Subject: Re: [PATCHv3] diff.c: emit moved lines with a different color
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 7, 2016 at 11:02 AM, Stefan Beller <sbeller@google.com> wrote:
> On Wed, Sep 7, 2016 at 10:54 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> as we do not want to see dashes ('moved-old'), I think I'l go with
>>> "movedfrom" and "movedto".
>>
>> OK.  They would be color.diff.movedFrom and color.diff.movedTo in
>> the doc, and "movedfrom" and "movedto" in the code (as the caller
>> already downcased them for you to strcmp()).
>>
>>> When going through the second pass and actually emitting colored lines
>>> we only find matches in the hash map if the current line AND the previous line
>>> match as we lookup by hash code, i.e. if we have a moved line, but the
>>> previous line
>>> changed we do not find it in the hashmap and we don't color it, such
>>> that the reviewer
>>> can spot a permutation.
>>
>> Hmph.  Does this have impact on a line that was at the beginning or
>> the end of a file that got moved to the beginning or the end of a
>> file (four permutations, of 9 if you throw in "middle"), because
>> some cases it does not have a "previous" line?
>
> I spotted that problem as well. We need to adapt the algorithm a bit more:
>
>   If the previous line is of the same kind (i.e. starting with + or -),
>     then we have to take it into account,
>   otherwise (i.e. previous line is different, such as header, hunk header,
>   or different sign)
>     then ignore previous line, as the previous line is already
>     having a different color.
>
> That works for the very first line of a file as well.

That should work to resolve some issues, and ensure the first line of
a hunk works correctly.

Thanks,
Jake
