Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8062207E4
	for <e@80x24.org>; Wed, 26 Apr 2017 04:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751298AbdDZECO (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 00:02:14 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:34611 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751243AbdDZECM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 00:02:12 -0400
Received: by mail-pg0-f53.google.com with SMTP id v1so26150262pgv.1
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 21:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=qiX3wkW4acKw5pW4AxvcDK+PIkOL3P45q+afhHUFGO0=;
        b=NSlD7+XFCAWvH2zqJaRSmvEXIALkWGFEXgWMG1RLA+f6zgFDpvb6U6c7v+po1vbwlO
         ZkQ87p5Ch1xYLQ46CaxrCBeml6a+ps+Lx8aqP4qBD3LbE/rkPJnndO19PSFXZfQpNcEj
         O6HjiHSGXEmXy7ThcTbiotb9t6pQ+qKNVnu86Co4Z9GJUQGWy3hX/MvPri+8E/1S5M/v
         73UsYbWskQJXjSuuvIin4vsE7JDV5sve0I1oRTXh/sTVxXxxolZcQex379at/eYnakl+
         amTpbYaJmNNHuXoAh7jpGqnyuZSHQz+7UMlbjxZzToU1wCQ/JcKcmd764loYpIyi0yfg
         TLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=qiX3wkW4acKw5pW4AxvcDK+PIkOL3P45q+afhHUFGO0=;
        b=d7uKOptw6VJolk/kyGJN/NdRWv1/3lf/wA00d31u7yamhnpioibgTcXkUfV1DxeT+U
         7G7HeApVZzLeYpgCNSDqauZXv9tAwGceJo8E8IwlYgvPuYXInexgPobdpunzGSgnl4JO
         AoziQzsgFthLQdX7U9V7X/AaRQogpYKDZY7WbISwqAVnFSNHRVXfSqzsNhlMUXFpHbeU
         8DP4dq63kk6fZ9UqDxrEVJUBPHK/3FcLyYmzyUtxEcOowtZ94A0xByazlqC8DJoq3NMg
         lSrl0wM19EeDKsehz49RzNoQngl1Mw7q1OiU+kZoKzew1D2sdRaOcF2XZ8j1E8eEtZpH
         DsFA==
X-Gm-Message-State: AN3rC/6TwIZJBh05b2Wk/eucT2EObpoLO1aLcKQchgfuTSWvdFG51zxK
        XodwhVf2q6QBQA==
X-Received: by 10.84.232.69 with SMTP id f5mr1259194pln.137.1493179331500;
        Tue, 25 Apr 2017 21:02:11 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3179:d004:20b:b383])
        by smtp.gmail.com with ESMTPSA id k196sm38946219pgc.0.2017.04.25.21.02.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 25 Apr 2017 21:02:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGg=?= =?utf-8?B?w6FpIE5n4buNYw==?= Duy 
        <pclouds@gmail.com>
Subject: Re: [PATCH] test: remove unused parameter from the wildmatch test
References: <20170425094453.9823-1-avarab@gmail.com>
        <CACBZZX7x0hSy5PTCo1Cf0Hp09jBhnSF0T=BseH68kwMRmqGJig@mail.gmail.com>
Date:   Tue, 25 Apr 2017 21:02:10 -0700
In-Reply-To: <CACBZZX7x0hSy5PTCo1Cf0Hp09jBhnSF0T=BseH68kwMRmqGJig@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 25 Apr
 2017 11:51:47
        +0200")
Message-ID: <xmqqlgqnstod.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> Right now this is all dead code, but I wonder if instead we should be
> partially reverting commit 70a8fc999d ("stop using fnmatch (either
> native or compat)", 2014-02-15) by Duy to the extent of being able to
> extend t/helper/test-wildmatch.c to test fnmatch() as well.
>
> We wouldn't be using fnmatch(), but I think it's a probably a good
> idea for the tests to support a mode where we have to declare
> explicitly whether something should also match under fnmatch or not,
> so we document the differences.

I am on the fence and can go either way.  What you suggest is
intellectually intriguing even though I am unsure of its practical
value.
