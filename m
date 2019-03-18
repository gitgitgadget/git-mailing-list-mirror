Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DC3A20248
	for <e@80x24.org>; Mon, 18 Mar 2019 01:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfCRBkD (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 21:40:03 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53951 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfCRBkD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 21:40:03 -0400
Received: by mail-wm1-f67.google.com with SMTP id e74so11349730wmg.3
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 18:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=eF6/hGYtcGEBTbLJD+XlOGgmdAAPcr5L746Nnoz+9Vk=;
        b=C+bWDkXvzllp4SJ0Mhpe+yUui6cwPfgAPWLcw3iHCuqyn6EdN95flUjU7xOUfq+akW
         CvXO8AwqEpE6VZo+5rnRJOosRNJNFGt889bMcHc7Bt3YhmPovEtZcxUSM4LUaexS8qHR
         +qA7qw7Pxs9NILxBLUFink9WLzgFpO5qviREljqHF6bfxCDKVuepWirNZhyBoI5+kdM+
         tMHXCg2ryrt+ORNMW0uWcNl7dH0mXLcuzF4xSDP8uQVV2f9khq8k7tn6DueaoLhdJdw8
         AZF3yk/M7ci+tQ23B5+PL7b9KOHjzetOY8B1HXYOPi4UWyEQboRRjbhumq1GleW9sdSJ
         t1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=eF6/hGYtcGEBTbLJD+XlOGgmdAAPcr5L746Nnoz+9Vk=;
        b=B1iC1i/DU6L8I1CTJz2p05LQyurS7rQuUo9/Di/A1XWXdiNsD7BaIfefvNTz9pG4X8
         ht2ZJhTs12OVOtxVvvQZHpqAb+2wZIWbp77JoSVM07JDBUNPFcxonSnFs/0Y8neoYNCx
         YY9V1X+Wv5RCZUspIDlENSEVcxVcCg5KxgFBp8VFBZyn222ohYhzCm7wQpsP0Mzmz3Yi
         FlPQhEEf7IPUXRjy8NE2eYDnOBLmB16S8PfyYUjv7M32hKakWW8WJJVL4K/i8jD2BxNc
         8feSOYjVADehdPeTu2zrLHt1UxFbOC0dEPuHho2AO+j6LoPfVuEk2CiQx+4djO7bPbAm
         lSdQ==
X-Gm-Message-State: APjAAAUHArTFwdlChFPcacN4MqhMwxZm3Mwt50TvlBE0IZE93qHLcjX4
        wkoa0P6VxtPVD5PENhxbMk4=
X-Google-Smtp-Source: APXvYqwLzl+tPAdrCOTmmKJB+e9E+1WvDoTVCwDzyw4dNTEHMuxXgyaaUxOvsWktmRblSUtZP1pk1w==
X-Received: by 2002:a1c:2782:: with SMTP id n124mr9815056wmn.102.1552873201535;
        Sun, 17 Mar 2019 18:40:01 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id e16sm1485406wrs.0.2019.03.17.18.40.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Mar 2019 18:40:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, git@jeffhostetler.com
Subject: Re: [PATCH 2/2] trace2: randomize/timestamp trace2 targets
References: <cover.1552519463.git.steadmon@google.com>
        <17ec237ba7498251a3ff64eec259d6f61c8f5ccc.1552519463.git.steadmon@google.com>
        <87h8c6baif.fsf@evledraar.gmail.com>
        <20190315204327.GE47591@google.com>
        <20190315204919.GF47591@google.com>
Date:   Mon, 18 Mar 2019 10:40:00 +0900
In-Reply-To: <20190315204919.GF47591@google.com> (Josh Steadmon's message of
        "Fri, 15 Mar 2019 13:49:19 -0700")
Message-ID: <xmqq1s357yfj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> On 2019.03.15 13:43, Josh Steadmon wrote:
>> On 2019.03.14 00:49, Ævar Arnfjörð Bjarmason wrote:
>> > 
>> > On Thu, Mar 14 2019, Josh Steadmon wrote:
>> > 
>> > > When the value of a trace2 environment variable contains instances of
>> > > the string "%ISO8601%", expand them into the current UTC timestamp in
>> > > ISO 8601 format.
>> > 
>> > Any reason not to just support feeding the path to strbuf_addftime(), to
>> > e.g. support a daily/hourly log?
>> 
>> No reason not to. Seems reasonable to me.
>
> Although as Junio says elsewhere in this thread, it's possible that we
> may want to support fields other than timestamps.

Yup.

On the other hand.

After seeing that the possibilities got discussed on the list, and
that nobody seems to be very much demanding customizability (I am
taking Ævar's mention of strftime as a mere "if we were doing an
optional timestamp, why not do so in an even more customizable way?"
nice-to-have, not as a "we must allow hourly or daily log, adjusting
for each host's needs" must-have), I actually am fine if we declare
that we've chosen the hard-coded "if it is a directory, use the last
portion of sid to create with O_EXCL (and if we fail, append a '.%d'
counter to retry)" or something simple.  Which I think takes us
closer to your earlier and unpublished draft, but this time we can
say that we omitted customizability after making sure that there is
not much interest---so I think it was worth it.

People who really want customizability can and are welcome to argue
otherwise and then I may change my assessment of the level of
interest in customizability, but the above is my current feeling.

Thanks.
