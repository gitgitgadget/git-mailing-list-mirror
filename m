Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFA452021E
	for <e@80x24.org>; Thu, 17 Nov 2016 09:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752632AbcKQJUA (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Nov 2016 04:20:00 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32936 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750790AbcKQJT5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2016 04:19:57 -0500
Received: by mail-wm0-f65.google.com with SMTP id u144so19206891wmu.0
        for <git@vger.kernel.org>; Thu, 17 Nov 2016 01:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=noEiRBJ3S7H40vSmc+OgLybm43oE4BNj7B0Ok7T3fvc=;
        b=dtXIMzpydVCPub4fUKikN1Grq+qfOxPPoQHOHBbKktnBoC7sGJkWBFPY+FqMlOok+R
         veCEZ5lZdLCW69enW+6vmhgFxjmTUxiXXWJn9nEfv6PzPHGm1e33aAqTDXmpnIBER9+P
         2lbzEdFLbtDGQga2cCWAOf+nIeL+fFp9+DD2G2NQ/Q+TKtdTnWAcPtRjYhKbyvAk9fwo
         McTzNdjVgz2Q4SXlLBssXxSD855Kn5ATg4Tm2Z1l/lEp7t4+dAd23CvJioE+EcP8DR7c
         aFp1Olin1VpFsQBnPLB42i97NbdaT/JbVY7G5CY8vjsNN+lrg+6Zd1CtNO/Em+Ov90U0
         3jAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=noEiRBJ3S7H40vSmc+OgLybm43oE4BNj7B0Ok7T3fvc=;
        b=lhgnG3gSNcyXMhVo1ekxmDqCOvs+JloUCyl13gbqYzvjyKQG6haKZZQVKqKpD83oMF
         qSNOmyaFkyEyhriZrSLhg3gUrCB8gTSX3iZJgZtfEFfG5ikoB+h6neOAJuFY0+mM5WJf
         14JTVOedxsObx0JVcahifoksJ/QUIZ7qi9yIsxcjZHRe76o/F7OLqkiOhqO6eu/VdVeD
         h/Pc+9S0jURtMJgB2kOgSAsggchfUcT14tTfmtlNyOxtk0zg+VJqiqT1RK6n5Fm9r5k+
         EoORi37W2avxiWjCmhrARmK/jRujVsI5ST1+Aqq1SvCX9xQLkv4Hdxu2bn/EtVWDKUkN
         NlPw==
X-Gm-Message-State: AKaTC02EkdBeoZu6YJSAWN5Yj3yON9VOBbx9aiGX/291uOaE/dnFiI52BkccgPp5oE/xTQ==
X-Received: by 10.28.144.70 with SMTP id s67mr2716856wmd.138.1479374396171;
        Thu, 17 Nov 2016 01:19:56 -0800 (PST)
Received: from [10.146.248.61] ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id w18sm2669156wme.9.2016.11.17.01.19.55
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Nov 2016 01:19:55 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: RFC: Enable delayed responses to Git clean/smudge filter requests
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqq37irouni.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 17 Nov 2016 10:19:54 +0100
Cc:     =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Eric Wong <e@80x24.org>, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <EBC181CD-611D-4FD6-9B84-F0AE9A970745@gmail.com>
References: <D10F7C47-14E8-465B-8B7A-A09A1B28A39F@gmail.com> <20161115010356.GA29602@starla> <5BC69AC1-5499-4F73-816A-D8786106D796@gmail.com> <xmqqvavotych.fsf@gitster.mtv.corp.google.com> <17709AFF-3C2D-4EC0-97DC-BD750F514D0B@gmail.com> <5eb682e8-13cb-67f2-a8a9-ec1fa1d139c6@gmail.com> <xmqq37irouni.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 17 Nov 2016, at 00:46, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Jakub Nar=C4=99bski <jnareb@gmail.com> writes:
>=20
>>> I intend to implement this feature only for the new long running =
filter
>>> process protocol. OK with you?
>>=20
>> If I remember and understand it correctly, current version of long
>> running process protocol processes files sequentially, one by one:
>> git sends file to filter wholly, and receives response wholly.
>>=20
>> In the single-file filter case, git calls filter process as async
>> task, in a separate thread, so that one thread feeds the filter,
>> and main thread (I think?) reads from it, to avoid deadlocks.
>>=20
>> Couldn't something like this be done for long running filter process,
>> via protocol extension?
>=20
> My reading of the message you are responding to is that Lars means
> doing so by "implement this feature".  Instead of returning the
> filtered bytes, a new protocol lets his filter to say "No result yet
> for you to process, ask me later".

Correct!

