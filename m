Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C50320756
	for <e@80x24.org>; Fri, 20 Jan 2017 20:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753384AbdATU1b (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 15:27:31 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35060 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752780AbdATU0s (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 15:26:48 -0500
Received: by mail-wm0-f66.google.com with SMTP id d140so9396001wmd.2
        for <git@vger.kernel.org>; Fri, 20 Jan 2017 12:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=tW4KGAZUqu1ZENpIz4j0myzhs3hV5J0A/m9KrQVlLBE=;
        b=W5Kz58LrDU4Y3FHfvpCpSvQUagc/eitsdjsMe7zbq0fr+AxntVgvdnbHXY2kNRCwq+
         wIMcX2tBWy487G3lqeLbpoelWOIGT2/7/fF541gMkOlTFykiZOmu02gEAoG1lwxeUuIX
         mDLGANOVD00BlpsvuPwHjg4bHE5xDiYqNOS7Zy/B0GdM1O+61xdE/7lbxLonPqW1OEy3
         HbbzEkvFskjROn8ZfXq2Ha/QA/k2ne5gE8Du6SI62lT5HRs1Y2RYP8Uq2PWzPn+njjQm
         F0cV9jvWcxwyTf5OAN4cMraO23zLcFGFZTAh+ovid+rf/e+K6EMbt2amMxrd703tYtNL
         eSVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=tW4KGAZUqu1ZENpIz4j0myzhs3hV5J0A/m9KrQVlLBE=;
        b=HDb2w3CTKp00QjxHosbibDpKy30eV9dYPEUm1bGvVQmJmxhOwKUBkIvUzYYW7XqH46
         YZ636O1gz2FLmcFK0COcGMMdw+sWH5i/MaknfZqLlhpPRjCVRkvZMhtwvFJxv1DtIyeI
         H1kl1582EOLKmKWFwd8TmeCEN2+Sf2QqXZ6nKkUyCcS52ZlK8W1O/ROTmyUfJkufvSav
         8SQbCVbVLGGVG8jHvRYdvBDJaXj0XtoetRc7+cL0lo0wh89ti1tce5BArrotFYz7I17e
         bus+gWD5L/3Tp8sFTcVptAPJTRAIbk9Vqs5YgYcNOvJPahEvYI5VryzFi7RVigdW8Bu9
         gpfw==
X-Gm-Message-State: AIkVDXKJwgIYrElxSRalr7vorKOAEl67syQhVXgMO+gLX1rOjj2qZGzBm4GiineIA1HnKQ==
X-Received: by 10.223.177.134 with SMTP id q6mr13245955wra.83.1484944006665;
        Fri, 20 Jan 2017 12:26:46 -0800 (PST)
Received: from home.thecybershadow.net ([89.28.117.31])
        by smtp.gmail.com with ESMTPSA id h3sm1314274wrb.31.2017.01.20.12.26.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jan 2017 12:26:46 -0800 (PST)
Subject: Re: [PATCH] show-ref: Allow --head to work with --verify
To:     Junio C Hamano <gitster@pobox.com>
References: <20170120155015.4360-1-git@thecybershadow.net>
 <xmqqa8aly2o4.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org
From:   Vladimir Panteleev <thecybershadow@gmail.com>
Message-ID: <1bf9a446-0b00-f27a-4625-0bc8c25356fe@gmail.com>
Date:   Fri, 20 Jan 2017 20:26:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqa8aly2o4.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 2017-01-20 19:03, Junio C Hamano wrote:
> Having said all that, using --verify on HEAD does not make much
> sense, because if HEAD is missing in .git/, I do not think Git
> considers that directory as a Git repository to begin with.  So from
> that point of view, I am not sure what value this change adds to the
> system, even though the change is almost correct (modulo the "quiet"
> thing).

My use case was the following series of steps:

Q1: How do I resolve a full ref name to a commit SHA1?
A1: Use show-ref <full-ref-name>.

Q2: How to make git show-ref also work when HEAD is specified as the 
reference?
A2: Add --head.

Q3: How do I make git show-ref only look for the exact full ref name 
specified, instead of doing a pattern/substring search, and thus output 
at most one result?
A3: Add --verify.

However, A2 and A3 are incompatible. Thus, there doesn't seem to be a 
way to e.g. make a simple alias which looks up a ref only by its full 
ref name, where said ref might or might not be HEAD. The obvious 
workaround is to check if the ref is HEAD in the rev-parse caller, 
however it seemed more logical to fix it in git instead.

The documentation for show-ref also makes no mention that --head is 
ignored if --verify is specified, and the combination was not covered by 
any tests, therefore this seemed to me as a simple omission in 
--verify's logic.

There is also rev-parse, which also has a --verify switch, however it 
does something else, and I don't see a way to ask rev-parse to only 
consider full refs.

-- 
Best regards,
  Vladimir
