Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6115E20401
	for <e@80x24.org>; Tue, 27 Jun 2017 21:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753702AbdF0ViB (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 17:38:01 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34212 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753643AbdF0Vh7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 17:37:59 -0400
Received: by mail-pf0-f196.google.com with SMTP id d5so6278461pfe.1
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 14:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=k52AyPmmoym/MKijsT/HeZUgtXIcXCMaBqUUCgU6ing=;
        b=OpMyO7rDyyttMPgczrXx8G0VAYwZhyCmLkujMVMV2a7Tl3H2b/z6Nym9j/OnpELY9r
         2TTvYVAhATUjYM4KCJr8tz3AMhKvIYtai5UOr+3tqOmlhJPGI9Aw9Ixx9TPeNJd479U2
         XCakFQXh1OW32kz5S57h3y5ksRqpwuLdT+IZapGCGdjyLqlkLqnN5Mo0JTT0shAxZst0
         Xf49Iu5olk+zRjTMCVp6c0RxXxCWybYIod6/hZaDmuzaAgXg7L8bvyWeGpXLrgWtCwEv
         lmMSgin6YYyCDDAatxt3OYjsa8meLckZ8iESLVCxauEHRuK+kfXYVeimRXKJz9ovUU9e
         wqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=k52AyPmmoym/MKijsT/HeZUgtXIcXCMaBqUUCgU6ing=;
        b=Ja54XOMiFsDidT4YgjhDtFVgRLT/YvAogeNjymDduxTzM1q7dwPhDvA286rhcKYxD/
         d+iWzVbqcf3kJNIMFcgSb7b7mkSGRUsUqWtjfm8D/nghqOe1vq85hPxYeT8IqgcPdKCe
         IjEgeWLCTu0zQ6peQ0TLaFZLXmZaYIWt7gLWv7kg8AZWPSieo+xetFcCWYTSd3mk6u25
         KZRzXXzbZ1ZdLXiuEyDjbl8Kt1GB0IjUtsDv12FTTgQaLjgzGrCkkSMFRN/E5Mh13tlR
         9jxlxz52dNOliZwxhjhZr1U3xpSygXU7yPof1Z16GxkKqCp00TdDRNaqVJ88MfPDu6P8
         Xbxg==
X-Gm-Message-State: AKS2vOyCwI1D5KuLpY4wV7g5P60kirxLS+FIup5neJ6IotzqN6Lm5odo
        jcHm8+TN3dsAKA==
X-Received: by 10.84.217.219 with SMTP id d27mr7938103plj.180.1498599478783;
        Tue, 27 Jun 2017 14:37:58 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3095:bb54:d256:9ca9])
        by smtp.gmail.com with ESMTPSA id l85sm354474pfj.130.2017.06.27.14.37.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 27 Jun 2017 14:37:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Michael Kebe <michael.kebe@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 0/3] update sha1dc from PR #36
References: <20170627121718.12078-1-avarab@gmail.com>
        <20170627203348.19827-1-avarab@gmail.com>
Date:   Tue, 27 Jun 2017 14:37:57 -0700
In-Reply-To: <20170627203348.19827-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 27 Jun 2017 20:33:45 +0000")
Message-ID: <xmqqh8z1yuve.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> A v2 addressing comments to the v1, tbdiff below. Just fixes the
> subject line on 1/3 & gets rid of the redundant _BIG_ENDIAN detection
> for Solaris, we can just use __sparc (and indeed we did before this).

Thanks.  Let's have this tested by minority platform folks to help
the upstream digest your pull request ;-)
