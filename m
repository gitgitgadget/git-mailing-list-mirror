Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D503720899
	for <e@80x24.org>; Wed,  2 Aug 2017 17:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752982AbdHBR6W (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 13:58:22 -0400
Received: from mail-lf0-f53.google.com ([209.85.215.53]:37018 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752963AbdHBR6V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 13:58:21 -0400
Received: by mail-lf0-f53.google.com with SMTP id m86so23076923lfi.4
        for <git@vger.kernel.org>; Wed, 02 Aug 2017 10:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iNpfmLProuhvDbtB2XoIj+C/ngu0rZBseR+G8Q1j2gQ=;
        b=obAVWmTRwV0MOc11JrZehY8GK7N7tsnuCPaZmi//3RfRdTMKToorehd5Ge4nAyYHeK
         7HnlTPVBDI6KkliKesJbvuM0BTtkcGnWtMW0L648p8sblnW/p8sDU4j247Qh7NUhobLq
         4XkkD9qQ2nMqLNmo2CAPn5nffW6FXBS2/azH5brYvPXnU5swPXsGvt8YX4PUGH+tM0z3
         xOIoTvxDA+aNJ0e0HSPLPgwv1aTV+1VFXwS/0gMOIqHtIIReTIrPS1oYWQ8ENFUfIMVW
         JYc9e9JLoRfQ+Tgm/ZhRrSKihfg6lNYOiUVb6WPCFlpeA0pgqVSbUtCrmdOFUttp5nOG
         /fFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iNpfmLProuhvDbtB2XoIj+C/ngu0rZBseR+G8Q1j2gQ=;
        b=HS9G9lbF0lg7gfUMW/yqHmexOlmcP3BEN2DoRlRfq1ySDRzOIbGcmkdB4ZRUg30iIU
         mkRg9VO1xmC9KBAQp9mQRWwU3k/xegkXZQ71vKpJ1WfCyqg4J++PmlZjO98oJ3EXrRnd
         jIRF5ugq5Px3I8sTA/vTnozRDhMa4HrXB0vCyM826bF73Z3rDxKmMDlXgv1qV3F+VGu/
         8hJ5+nd0ilSiIdX3vCPjSSdOAD0S1DIoOBH3tQHdOE9vFazSHPYrjLuDlSdxYEUdd9A5
         X4A3DcwTvDmrSZcGkt5828yvHRFALghE172NJPhKUSlp24o5rxKkyi9DOubYI4rXgMfr
         O7+A==
X-Gm-Message-State: AIVw112gTN3CaaUCDMqI1dL16eh3THbd0F/hiNKZ3fvUwMeuKF8XANgJ
        klp/MdQu8YfO2lTV8axZMN3hNt2UTKPI
X-Received: by 10.25.204.149 with SMTP id c143mr7011742lfg.195.1501696699298;
 Wed, 02 Aug 2017 10:58:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.1.130 with HTTP; Wed, 2 Aug 2017 10:58:18 -0700 (PDT)
In-Reply-To: <xmqq60e6djcu.fsf@gitster.mtv.corp.google.com>
References: <CAGZ79kYg9jQ3kaKnNEJCH9fde=ar1KPiUr7=X+TguNc0Twqdzg@mail.gmail.com>
 <20170801160539.5587-1-kaarticsivaraam91196@gmail.com> <20170801160539.5587-2-kaarticsivaraam91196@gmail.com>
 <CAGZ79kZgV1=2HcYeXyoCy2Jk6v__trvTh_-rH+kbFX7fgWziyw@mail.gmail.com>
 <1501677122.1957.8.camel@gmail.com> <xmqqini6dkmu.fsf@gitster.mtv.corp.google.com>
 <xmqq60e6djcu.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 2 Aug 2017 10:58:18 -0700
Message-ID: <CAGZ79kYArf6R-vx1-Lm4X_ANLMrXc3VNd2aCQMnqq3J6y-s31Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] doc: add another way to identify if a patch has been merged
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 2, 2017 at 9:28 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> I think the exchange Stefan cited was an example that we want to
>> have more of.  The contributor is indicating that, even though the
>> patch could be a drive-by patch by one-timer from whom we will never
>> hear again, it is not--the contributor is willing to learn the way
>> things are done here, and showing that it is worth _our_ time to
>> explain the things so that the future patches will take less effort
>> to accept on our side.

The example I cited contains two important parts that I considered.

> I tried to follow as best I could, here's my attempt (please advise).

    ok, I can help out as that conversation is very likely
    to deliver some impact.

> I'm a bit overwhelmed by the documentation for submitting a patch!

    That may be either a contributors problem (lacking time or
    motivation to go through a long document) or a problem with
    the community.

Here are my thoughts on the "problem with the community":

    We are using Git ourselves as a mere (content-)version-control-system
    What we really need is a community oriented workflow tool:
    Instead of writing a long-winded document on what you can
    do wrong in each contribution, we should have technical solutions
    that just present the single issue that needs addressing.

    For example when a contributor forgets to sign-off a patch,
    git-send-email could warn about the missing sign-off and
    present the rationale why our community needs sign-offs.

    As this is specific to our community, such that it cannot be
    baked into git-send-email, but rather we'd need a distributed
    configuration that is respected by various git commands.

We had the discussion on shipping a project config which is
respected by git commands lately when discussing the
.gitorder file that I proposed, and IIRC such a thing "doesn't
quite fit into the broad picture of a version control system",
so maybe we need another tooling in our community?

    Another example would be to show a hint/advice when
    commits with no or very short commit message are created.
    (also this is project specific, other communities do not expect
    commit messages as we do. So they would not want to utilize
    such an advice given).

>>
>> Because we do not have a group of dedicated volunteers, it is done
>> by more experienced people around here but that can be done only
>> when they have time.  I view it as a more severe problem than any
>> documentation.  An abbreviated version of the documentation to
>> invite more new people means that we must be prepared to give more
>> high-touch onboarding help to them.
>
> Just to make sure there is no misunderstanding, I am not saying "do
> not update the doc to have an abbreviated version, because we will
> get more clueless newbies".  I am saying that it is not a good idea
> to add an abbreviated version _before_ we are prepared to handle
> more patches from new people that require high-touch help.
>
> If you are volunteering to coordinate and form the onboarding
> helpers group, that would be great.

I would not want to explain the same thing over and over again,
but rather have a technical solution that explains the problem and
solution once it is detected.

Coming up with a technical solution for each little quirk
is not the hard part (e.g. grep for the sign off string, count lines of
the commit message), but rather to put it in place. (How can I make
sure that contributors run these small checker scripts?
Currently I cannot.)

Thanks.
