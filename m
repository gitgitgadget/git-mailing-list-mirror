Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE4BD1FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 17:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753549AbdFMRxi (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 13:53:38 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:34866 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752081AbdFMRxi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 13:53:38 -0400
Received: by mail-wr0-f172.google.com with SMTP id q97so154547589wrb.2
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 10:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=oOD1j85+jW5Wg9xmPilqPOuEGe7O51BVSwtPBr8cRm4=;
        b=iXvVEt2h2niBON8x4Wg9oRTZ3hEkl4gX9Q1+k9Ukt/jnnS2AAd4T9BuPV3Fjf7vvtI
         CHfShVG90Kh0Lo78SBCmszR1mB0l6p9GSU3e95cQmds9yLgvFDGj9LLeiGCY/n2LcRtL
         +bWM4yi5bDttpgKFYkWUDZ7VmXRzqfYKnatvVHWhjb0TJ7vDbsJl64lXUGWnwaO5S0jc
         VWAozaTnsJ4VGcqblC+VDkBo/Hfo9NM4yow5Hzj6p09T3m5UeEW4jVeeCJX+dpVNJDM0
         kdwLuOx7aVbryRj3mXdg0m5M9085x3mbSqEtAC4qxwRiC9EVTciUi5TwWCoPZ3b+CckP
         vCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=oOD1j85+jW5Wg9xmPilqPOuEGe7O51BVSwtPBr8cRm4=;
        b=E5TlMwYRRgiNlQYjgqDAkVhEsYFspHO/DbCC7iHlSJyKWQCKbI/STRSuVf6AaZAgDt
         uoq0OeXsuTqhOC3uyfrQKrkNe1jQNVtsZswiGid92EJocJZO+Ff+wCgfUenX4gjuKGCq
         GNjuoA15YnuhzAThYxvsh11OCnFooZaKolNGYTKiEYbbCoBeZBjRmaxJFwDBJIFVIuNE
         WeDD5QBc/djjE4IwqVOwfJcusYaE4Q0e3KUqyq+QqirdMX8oTcNRMaOWVDsycr5q33lY
         azskM03yKFWrWhi0aL5130G4S3OgV+MJ/q4OM3EmEmiI+H7ZAy2pKOBKISFSf+3edJ1R
         gNNQ==
X-Gm-Message-State: AKS2vOwNwXAcXQRfHvmVYtO8Kjws4X4nKQvgmGZfhU4RD5LJq1CW3+nR
        0UMyebX0OAT4sQ==
X-Received: by 10.80.132.99 with SMTP id 90mr873823edp.50.1497376416713;
        Tue, 13 Jun 2017 10:53:36 -0700 (PDT)
Received: from snth ([92.109.130.42])
        by smtp.gmail.com with ESMTPSA id f22sm7262755edf.59.2017.06.13.10.53.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Jun 2017 10:53:35 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dKq0U-0000ZA-UO; Tue, 13 Jun 2017 19:53:34 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sahil Dua <sahildua2305@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/3] branch: add test for -m renaming multiple config sections
References: <0102015ca23f0488-7423db93-b65f-4214-8221-af6a1bb4c2e5-000000@eu-west-1.amazonses.com> <0102015ca23f0529-c860f75d-e3bb-48b0-b2c0-502f7ab9d667-000000@eu-west-1.amazonses.com> <xmqqwp8f7r01.fsf@gitster.mtv.corp.google.com> <CACBZZX5e1cGKeHZhA1vWebdZek=a+TdYzXc5GuXaDi8SpL1YXw@mail.gmail.com> <xmqq7f0f7pnt.fsf@gitster.mtv.corp.google.com>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <xmqq7f0f7pnt.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 13 Jun 2017 19:53:34 +0200
Message-ID: <87poe73hb5.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 13 2017, Junio C. Hamano jotted:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>> On Tue, Jun 13, 2017 at 7:10 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Indenting using <<- would make it easier to read.  I.e.
>>>
>>>         cat >config.branch <<-\EOF &&
>>>         ;; Comment for ...
>>>         [branch "source"]
>>>                 ;; Comment for ...
>>>         ...
>>>         EOF
>>
>> I should have added a comment for that, I can't find any portable (but
>> suggestions welcome) way to do that and preserve the indentation, so
>> the test_cmp would still succeed if the moving/renaming function
>> munged all leading whitespace in the config with -\EOF as opposed to
>> \EOF.
>
> Ah, I see why it is done that way.  You could indent the lines in
> the configuration file with SPs (<<- strips only HTs, no?)

Sure, we'll do that for v2.

>> It's just a sufficiently large number, I thought -A was portable
>> enough after grepping the test suite, but on closer inspection it
>> turns out those were all git-grep invocations, oops. Yeah all I need
>> here is all lines after a line matching a given string, so that sed
>> command works, will fix it up to use that.
>
> Oops, indeed ;-)  Thanks.
