Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F42E1F404
	for <e@80x24.org>; Fri,  6 Apr 2018 22:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752264AbeDFWsU (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 18:48:20 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39582 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751623AbeDFWsT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 18:48:19 -0400
Received: by mail-wm0-f67.google.com with SMTP id f125so5774008wme.4
        for <git@vger.kernel.org>; Fri, 06 Apr 2018 15:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TGGGyewW2JVS270QAR5vlqPDiQHS8zMGtbDxFZg2GGg=;
        b=J9UvkUw9O7LP5AVfl45qWGrz3KqU02Edx/P1W1bsH+4Qx+YR0RAIVDYSsLUh2uMz4M
         57ADSGq5hp5Z1bpUu/SiiRKn2GZE9ngW/UFlvM9l5mFzvhUBd4/4+doNP+n6aA1F/qe+
         2BuW+utvmroFmEJtudD3iM9ZRTFYTPqR8H0P98TRgr5DdAIM2LIlkn+27kKM7IWBCh7R
         kjoG8wyjIdHcWzOXQI1P+20YMPAXCnZq0S7dOgeXdDhMoFj1JCQsSsy8UPQPLtogiso7
         rHxVF60gGBjaOxJqUgDSP8rkUOGThckL7qBIf39laWWxfK+JRsCHXUXlw3PoihANlSWa
         Nj4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TGGGyewW2JVS270QAR5vlqPDiQHS8zMGtbDxFZg2GGg=;
        b=VJY5yU6kE5lnBzBhVYh6rsqYdwQ6hT+f6yXji96woGciI75CHe5kMgxhIYOoWrG7HD
         DZML1mMIzEPVvEofUfCDZOH1+un/pFRtYqcD3s3Mq5hjNXi+xE/jISK5r+iVMW9Iz3ea
         IKGIi6TcWyMHcZgTv3b5a36Oczn73bYYhYj/C5kbKIt5kOtILh3vagDsGDHYg+eBchBF
         w9BpIKdN1uZT7o/vaoi9yMFnPVKPjH8LR/z5Z26cuTomAfZsQygdTuJij1zdX4YTP+Vl
         mP6QjHXQU8VYWNGhT+3Xi0zib7RmbcY42Zfeip2/oJQFwKk87DdhiG1vz8MeGXle5w1N
         7aXQ==
X-Gm-Message-State: ALQs6tAMgX5hBV9aMj13huqufZRnM+n6fOk5GGYdXBJ0RKVbhA0nFM6+
        7MxJYVUn5ZXyy6WBu2003AQ=
X-Google-Smtp-Source: AIpwx4948wEWkeEjSa4UHFGI2ClPutG3c3yVY1siv+4e+UYBUmUHynqg3/VMHsdXSoAic7faGLpslg==
X-Received: by 10.28.72.135 with SMTP id v129mr2698512wma.107.1523054898051;
        Fri, 06 Apr 2018 15:48:18 -0700 (PDT)
Received: from [192.168.0.137] ([79.116.108.13])
        by smtp.gmail.com with ESMTPSA id h190sm15323192wmd.22.2018.04.06.15.48.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Apr 2018 15:48:17 -0700 (PDT)
Subject: Re: [PATCH v5 1/5] stash: improve option parsing test coverage
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Joel Teichroeb <joel@teichroeb.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>, gitster@pobox.com
References: <20180405022810.15796-1-joel@teichroeb.net>
 <20180405022810.15796-2-joel@teichroeb.net>
 <nycvar.QRO.7.76.6.1804061439100.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Message-ID: <a64d281b-a18c-7c6c-1524-92aef869209f@gmail.com>
Date:   Sat, 7 Apr 2018 01:48:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1804061439100.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 06.04.2018 16:06, Johannes Schindelin wrote:
>> +	git stash clear &&
>> +	test_when_finished "git reset --hard HEAD" &&
>> +	echo foo >file2 &&
>> +	git stash &&
>> +	echo bar >file2 &&
>> +	git stash &&
>> +	test-chmtime =123456789 file2 &&
>> +	for type in apply pop "branch stash-branch"
>> +	do
>> +		test_must_fail git stash $type stash@{0} stash@{1} 2>err &&
>> +		test_i18ngrep "Too many" err &&
>> +		test 123456789 = $(test-chmtime -v +0 file2 | sed 's/[^0-9].*$//') || return 1
> 
> Not your problem, but if there is future work on this (read: if I get to
> mentor a GSoC student, and if I get them to work on it: this idiom
> `test-chmtime -v +0 ... | sed ...` is too common, there really *should* be
> a `test-chmtime --get ...`).

Hi,

I submitted a patch for this [1].

[1]
https://public-inbox.org/git/20180406221947.28402-1-ungureanupaulsebastian@gmail.com/

Best regards,
Paul Ungureanu
