Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E51CC1FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 19:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932955AbdBPToj (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 14:44:39 -0500
Received: from mail-qt0-f181.google.com ([209.85.216.181]:34640 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932742AbdBPToj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 14:44:39 -0500
Received: by mail-qt0-f181.google.com with SMTP id w20so23640912qtb.1
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 11:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Pa5w30EsXYp00jScBl4poesUCyyRgkVpgU8nBkKS4hs=;
        b=hRtCSBs+v5yZRcMST13vv2vFEtcr11FF6FGRzvdyxMTVKAS3fnGegVmrp45wIWvemX
         ocgdAnLhlIeD/v/Ts0bb2WmYFSFflpfIzKbymIGlRyS7fzLu8Q5+GDgaHEFLMEvmqE72
         zUHfPHYfSd3acDsKcBTkXeriGdAu37MhLb6YhNSrdeJh0K2siW9AJoYytZUi4Mf9Q6Ls
         DQqKQOQs7WMMruWgiGDjblmQmEUmI61RgCzEjumRO6frGFgEMiwKRL5UWfYo0HmQpfMu
         2uWyLb1Y80hnObhuza5xZ/+7NXFa+F/LhQCBp0aVRmj87sST+qXy/u3ZLOQMqYWhEjiG
         gueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Pa5w30EsXYp00jScBl4poesUCyyRgkVpgU8nBkKS4hs=;
        b=sDjMbmWhJ4C3L7pi82QEXy91RoO2KfHeerWCVECb4/2Pnuv2xyolTdvwXk/ChtOatV
         wIX7CPXRuB/R6lG3vZflUE3f1psDoon+5sDZ43b6zUAlV15EiA6Aa47ZcoOWBwCMpuu+
         lzD4N0jvorO+UgPOMyHnDP7KnzvRFA6pIcA5RbWjW8OXAqffHi25chhPHJRpOWMHYEnc
         vRT8Ts1gnNNZC8ZtTmsVgXSHQ0kHuf6Au17cPR8d6bzMIA264hyyTK4kjZ7aU9TUx7pU
         waKvlVS2rmbz4tGM8P2l8SnZ7JUcgXq+cV4B1+kHREdnG3XIk1G/DuIlSgXxiWNtQbhC
         r9zw==
X-Gm-Message-State: AMke39nrJhq0+oVejVdmaxPBGofccl+6ymQxTXtaWgeye1Tbnzm37NjBRBTuGhte+KSCzjpYXhEq1+YooiJmAA==
X-Received: by 10.237.41.229 with SMTP id o92mr3624361qtd.223.1487274277884;
 Thu, 16 Feb 2017 11:44:37 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.106.138 with HTTP; Thu, 16 Feb 2017 11:43:57 -0800 (PST)
In-Reply-To: <xmqqinoax96u.fsf@gitster.mtv.corp.google.com>
References: <1487258054-32292-1-git-send-email-kannan.siddharth12@gmail.com>
 <vpqa89mnl4z.fsf@anie.imag.fr> <xmqqinoax96u.fsf@gitster.mtv.corp.google.com>
From:   Siddharth Kannan <kannan.siddharth12@gmail.com>
Date:   Fri, 17 Feb 2017 01:13:57 +0530
Message-ID: <CAN-3Qhok0WVZHBc-tFgTCNebGKRH87jPGe-rbRwTrsh1qLTfDQ@mail.gmail.com>
Subject: Re: [PATCH 0/4 v4] WIP: allow "-" as a shorthand for "previous branch"
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Git List <git@vger.kernel.org>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Jeff King <peff@peff.net>, pclouds@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.ath.cx>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Junio and Matthieu,

On 17 February 2017 at 00:19, Junio C Hamano <gitster@pobox.com> wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Siddharth Kannan <kannan.siddharth12@gmail.com> writes:
>>
>>> This is as per our discussion[1]. The patches and commit messages are based on
>>> Junio's patches that were posted as a reply to
>>> <20170212184132.12375-1-gitster@pobox.com>.
>>>
>>> As per Matthieu's comments, I have updated the tests, but there is still one
>>> thing that is not working: log -@{yesterday} or log -@{2.days.ago}
>>
>> Note that I did not request that these things work, just that they seem
>> to be relevant tests: IMHO it's OK to reject them, but for example we
>> don't want them to segfault. And having a test is a good hint that you
>> thought about what could happen and to document it.
>
> The branch we were on before would be a ref, and the ref may know
> where it was yesterday?  If @{-1}@{1.day} works it would be natural
> to expect -@{1.day} to, too, but there probably is some disambiguity
> or other reasons that they cannot or should not work that way I am
> missing, in which case it is fine ("too much work for too obscure
> feature that is not expected to be used often" is also an acceptable
> reason) to punt or deliberately not support it, as long as it is
> explained in the log and/or doc (future developers need to know if
> we are simply punting, or if we found a case where it would hurt end
> user experience if we supported the feature), and as long as it does
> not do a wrong thing (dying with "we do not support it" is OK,
> segfaulting or doing random other things is not).
>

Right now, these commands die with an "fatal: unrecognized argument:
-@{yesterday}" or a "fatal: unrecognized argument: -@{2.days.ago}".
So, it is definitely not doing anything "random" :)

I will wait for consensus on whether these should or should not be
supported.

-- 

Best Regards,

- Siddharth.
