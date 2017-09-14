Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BEE7209B8
	for <e@80x24.org>; Thu, 14 Sep 2017 15:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751323AbdINPpU (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 11:45:20 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:45313 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751255AbdINPpT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 11:45:19 -0400
Received: by mail-it0-f50.google.com with SMTP id v19so537674ite.0
        for <git@vger.kernel.org>; Thu, 14 Sep 2017 08:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rl09XYn5Uu1RJfqjFaanajW3rx4Ob+eg44oAV1/yJZ4=;
        b=m9l59KHJt3mxRTnLKFusakNyi8a8mdcebu5thvNbfDVwR3zHecErSV8ZXAqe1VO28h
         HHXkA1AST4do+WI0XDOV8NCATFVY8ChpywX/GmDvt47CSegqYtSIrRwJUDQ2SQuIxZbw
         G2q06Lrlc5XdVnN1rVFf4Ef4I/b7fh5jNATDoq2lpf8krwksoydjnO8RBqiP2ESVSQMF
         MoKBOsHxaSfoFAnIaNy+JBs31vt0VdsLMjNL24Sk6cKUPXqeNZtAHzmkqQwc8eQI9A1w
         1E7ewok4YjPArkjnpXgVe4emszZr8oqGsAVfrKjNxjPkTyX0wbWlNr6rXK/XJKobxaMO
         N4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rl09XYn5Uu1RJfqjFaanajW3rx4Ob+eg44oAV1/yJZ4=;
        b=uHtdHZfj1i99pgo/55GwZNGL0qDl5gJvZ8p2fAPUVwDeyGJlmraT+/O2O+52hJx7WZ
         UB39CvkZsv7EwBKEzjeUSn/pvpgfHd18hpwB+JmidcKciIk1YEvTUfrJ9rF/Nlh+TLf4
         ZnVFszyDN2mSJHaXUh4shC/Q3FeoHAh029NVjaH2Rd3CZcJ/RR5WJmw5v6mujbouvp9r
         Uu0oR+xO1gz6x6Z9CnZS5PBv4MwG5lFrud+zFZI/bEDP4BA/sOjptgb3G/4pGdIZszKg
         bv2Ljolhz6uI3LQ9/yoE+WjQjYP6+f6zilLyQY1TiJT9rHNqJZsjs0hF67LUMsOH9Tqa
         FeAA==
X-Gm-Message-State: AHPjjUhX0WaCqm2i7BBWk8x+FyfjdD7dVQMQSMKUsTYd0sebWnXsyXn7
        7iFb6Ug+qQ+ONccE2xi6XpSPwQs3LvBYv5vn/Ew=
X-Google-Smtp-Source: AOwi7QCff8rw36JMneSvbCxWm/ZqVljPmyztH0NTODOta7ZP7IuYwSGaxSUJ1wyG3nIlE3mfGTxvmEBrhu4l0Fywfl8=
X-Received: by 10.36.68.207 with SMTP id o198mr724025ita.74.1505403919313;
 Thu, 14 Sep 2017 08:45:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.164.4 with HTTP; Thu, 14 Sep 2017 08:45:18 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1.1709141722500.4132@virtualbox>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
 <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com>
 <20170307001709.GC26789@aiede.mtv.corp.google.com> <xmqqa828733s.fsf@gitster.mtv.corp.google.com>
 <xmqq1snh29re.fsf@gitster.mtv.corp.google.com> <20170911185913.GA5869@google.com>
 <alpine.DEB.2.21.1.1709131340030.4132@virtualbox> <20170913163052.GA27425@aiede.mtv.corp.google.com>
 <xmqq7ex21d2v.fsf@gitster.mtv.corp.google.com> <CAGZ79kakGcMJ7HuH+MPsMrvw40uGchr6H-SQw9-p8pgi3Yk_Bw@mail.gmail.com>
 <20170913221854.GP27425@aiede.mtv.corp.google.com> <xmqqpoauyqlp.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1709141722500.4132@virtualbox>
From:   demerphq <demerphq@gmail.com>
Date:   Thu, 14 Sep 2017 17:45:18 +0200
Message-ID: <CANgJU+UpMu82a09h644GjqKLsYzHq-t7Tv8x=+ybTYP-QqyPtQ@mail.gmail.com>
Subject: Re: RFC v3: Another proposed hash function transition plan
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>, David Lang <david@lang.hm>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14 September 2017 at 17:23, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Junio,
>
> On Thu, 14 Sep 2017, Junio C Hamano wrote:
>
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>>
>> > In other words, a long lifetime for the hash absolutely is a design
>> > goal.  Coping well with an unexpectedly short lifetime for the hash is
>> > also a design goal.
>> >
>> > If the hash function lasts 10 years then I am happy.
>>
>> Absolutely.  When two functions have similar expected remaining life
>> and are equally widely supported, then faster is better than slower.
>> Otherwise our primary goal when picking the function from candidates
>> should be to optimize for its remaining life and wider availability.
>
> SHA-256 has been hammered on a lot more than SHA3-256.

Last year that was even more true of SHA1 than it is true of SHA-256 today.

Anyway,
Yves
-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
