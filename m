Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B166E20401
	for <e@80x24.org>; Tue, 27 Jun 2017 18:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752924AbdF0ST4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 14:19:56 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36693 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752311AbdF0STz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 14:19:55 -0400
Received: by mail-wm0-f43.google.com with SMTP id 62so32313785wmw.1
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 11:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=ItD92FCZ6J2KB8w3jdTMumys3QKrGqhfT++KLtoUB5w=;
        b=QR28RyrDIGJCFg2zojPs5g+N5oozKjGU2naNGBUY39ss2/zkvwasELP+Aua8ZvnC9W
         7QECv6zplRmtTYeT9Tx9G3ctLG8G6BlBZVywEzheI/F829C/NlMOnyLuJLONlbb8bggs
         uQ4rf/yw+3yJPxZUiBtmJARICEqvqEAJUngQmKjjj0bIfsdAqYe0LUDlj5wtR5sjf09h
         Tn6KDKIQt+8WT/DMkz7e9/zNm8WLRWd8mc8ynVoaIhri91XeHudeKUL6cas8/efu0D2s
         eAwcM48aoL8Pkg0tRwWXbxzJWTrP23AcAWVZER3Z6FtIGDCim2EvKhLhVjK1WG8gj+vp
         dBUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=ItD92FCZ6J2KB8w3jdTMumys3QKrGqhfT++KLtoUB5w=;
        b=jK0YD23PwWCqH0k4WVe8xVD/WmasxvJzINSLwVKNJvppOumGks5uH//DhyuL96coBu
         CvntI8k+BELl/MHiWTLkp1K97+GeUbhyD7v00AZWUlPBKr0UhWezwqHLl5hNGSUX5u4h
         N2TTj3M8Bpzr+mll56zJhvtavKUDZNFM1OmsaMxKiSIjE8L8yOZmPtZw6L4BeYJdtoJT
         dbtMN+WrUQGhat6fF7IpK7krfMd9hIkhtHD0aNBs16129N5haPCt5PgyevgFbJnLnnun
         onbhijTWaNtNyz6tDq+XtdGX3prHEm8wEwFFuQWvGrdCZHzrcq5sr8UOwOCiLFxapdP/
         E3wA==
X-Gm-Message-State: AKS2vOwoTtsDnZVuI9knqheUtAHxjC1ugZ+G69H1KW0RsfniagcjYjNH
        sgaCduh1p10Jog==
X-Received: by 10.80.142.27 with SMTP id 27mr4840022edw.104.1498587594043;
        Tue, 27 Jun 2017 11:19:54 -0700 (PDT)
Received: from snth (g74110.upc-g.chello.nl. [80.57.74.110])
        by smtp.gmail.com with ESMTPSA id g24sm1413780edh.20.2017.06.27.11.19.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Jun 2017 11:19:52 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dPv5c-00063N-2i; Tue, 27 Jun 2017 20:19:52 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Michael Kebe <michael.kebe@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>,
        Marc Stevens <marc@marc-stevens.nl>
Subject: Re: [PATCH 1/3] sha1dc: update from my PR #36
References: <20170627121718.12078-1-avarab@gmail.com> <CAKKM46tHq13XiW5C8sux3=PZ1VHSu_npG8ExfWwcPD7rkZkyRQ@mail.gmail.com> <20170627121718.12078-2-avarab@gmail.com> <xmqqmv8t317c.fsf@gitster.mtv.corp.google.com> <87zictjoff.fsf@gmail.com> <xmqqo9t91eqy.fsf@gitster.mtv.corp.google.com>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <xmqqo9t91eqy.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 27 Jun 2017 20:19:52 +0200
Message-ID: <87vanhjnsn.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 27 2017, Junio C. Hamano jotted:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>> On Tue, Jun 27 2017, Junio C. Hamano jotted:
>>
>>> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>>>
>>>> Update sha1dc from my PR #36[1] which'll hopefully be integrated by
>>>> upstream soon.
>>>
>>> Please be careful about the title of the patch.  "log --oneline"
>>> does not even let you tell your readers who calls this as "my"
>>> change, and readers would be clueless what PR #36 is.  Something
>>> like
>>>
>>>     sha1dc: correct endian detection for Solaris
>>>
>>> may give us more relevant information in the oneline output.
>>
>> Will fix. Can you integrate it as-is into pu anyway? I'm going to need
>> to re-submit it regardless once we get some testing on it & upstream
>> merges the PR, but having it in Travis et al in the meantime would be
>> great.
>
> I somehow thought that your throwing a pull request at git.git would
> automatically trigger a Travis test, without you having to wait for
> me to do anything?  Am I misinformed?

It's a PR against sha1collisiondetection, not git.git, but yeah, good
point, so that runs the same tests?

Still, the set of people testing pu > number of things running the
Travis tests, so it would be good to have it in pu, so we can just make
2.13.3 and hopefully not a .4 for the same issue :)
