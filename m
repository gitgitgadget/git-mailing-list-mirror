Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98C951F404
	for <e@80x24.org>; Tue, 27 Feb 2018 22:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751707AbeB0WF2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 17:05:28 -0500
Received: from mail-wr0-f169.google.com ([209.85.128.169]:46659 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751550AbeB0WF1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 17:05:27 -0500
Received: by mail-wr0-f169.google.com with SMTP id m12so329895wrm.13
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 14:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9qP/5URTzbJTiBytsnWxHErQ+B0AVtohiORU11cfKQA=;
        b=n/FJfEYR7oHsh21YcvZWjzZoAEf0l/iVfUaOG8jcajEuBonAdrCZj3K9m8JIHnI5Jg
         1K60YQ+RVY8iRYiZG62FssIeSI3q59ggFv2R3oSwqpkprhh/4EuYfZa03ofzS3ftv0SQ
         d8kUuWMN3KySkXgdmhSAWbD06AmLF+GAHupvduGCFyiQHrFtFwdefUCcQmsO6yhp+qvt
         HQQRlfVDoo8P1tMtkzX5ep2hij8nGFCjut6IzW5HbphKIQ1i5t9+ruU6hMpKYSsatujv
         dB+hOnUd0hZQOHvx/eVcB4LKRZOJ77fwqTBtcccHb3LXWPoCaevbR4Rm74zm/9B5QlXo
         1cDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=9qP/5URTzbJTiBytsnWxHErQ+B0AVtohiORU11cfKQA=;
        b=K5tixQDn+UVz7HYTDnW2j/VzfsYIyS+HDOQV011Wvb56Sv+IqDQr0EKxy8IDGGMRFo
         erUNqSrVEqJSyr+NSajDB6CQjtcCNTQt4R8u+RMUPLsPcEuKR+asajziTRPEmRbRE8k8
         AWdfNHl7r4/qUY5cS+9+0a2c13DTLYK3V9Y4vHuFe5ix6679GcGWRj419NVFkFIebb63
         dVrNfPQ4MyNL3IeDKVSX4nl5rpVfztwrBQ7iBwQtEiYgX/9qjSNMRddF170u+Iw00kvk
         HWVJLi6CWR6gqbTXbjVGgV1jIZQkXvUojpDEnyAVWHx3fyN9ZBtNTu7N4UM6VHzEVH9B
         tKLw==
X-Gm-Message-State: APf1xPD06aFt5ySrvOOFIdnmKaPiugx4Pr6LnEXKCiQx5S3jQd5F7u2z
        ZMWkRMLGIEly7Ui4SsSn2qM=
X-Google-Smtp-Source: AH8x2253ygJ2ZmT5deF/TJDHe55ey/ezZ5DZHcs9eFcRmuiAaycvaOT/Q2CvXcwr5xQVfnjBF6B2NQ==
X-Received: by 10.223.160.125 with SMTP id l58mr13289666wrl.264.1519769125905;
        Tue, 27 Feb 2018 14:05:25 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id p78sm622995wmg.47.2018.02.27.14.05.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 14:05:25 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Jeff King <peff@peff.net>, GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] t5556: replace test_i18ngrep with a simple grep
References: <d0e6c6cf-7166-bef6-f179-c4e6acf7b0ac@ramsayjones.plus.com>
        <xmqq3726t11d.fsf@gitster-ct.c.googlers.com>
        <69c7dc21-fb52-5982-f7d8-04518d06db6c@ramsayjones.plus.com>
        <xmqqvaf1qqcx.fsf@gitster-ct.c.googlers.com>
        <20180213100437.15685-1-szeder.dev@gmail.com>
        <xmqqr2porf4z.fsf@gitster-ct.c.googlers.com>
        <20180213172603.GA10062@sigill.intra.peff.net>
        <xmqqeflorc9m.fsf@gitster-ct.c.googlers.com>
        <xmqq371mqjce.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 27 Feb 2018 14:05:24 -0800
In-Reply-To: <xmqq371mqjce.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 27 Feb 2018 12:16:17 -0800")
Message-ID: <xmqq4lm2ozq3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> OK, somehow I had the version from Ramsay on a topic branch that was
> not merged to 'pu'.  Here is the replacement for 2/2 I'd be queuing.
>
> We'd need SZEDER to sign it off (optionally correcting mistakes in
> the log message) if we are going with this solution.
>
> Thanks.

I guess I missed Ramsay's v2 which already did this

<550fb3f4-8d25-c5c4-0ecd-3a4e61ea13f4@ramsayjones.plus.com>

so I'll use that version.  We still want sign-off from Szeder,
though.

