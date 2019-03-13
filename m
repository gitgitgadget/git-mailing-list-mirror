Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5093720248
	for <e@80x24.org>; Wed, 13 Mar 2019 02:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfCMCQ6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 22:16:58 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40311 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfCMCQ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 22:16:57 -0400
Received: by mail-wm1-f67.google.com with SMTP id g20so243678wmh.5
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 19:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=wU1fHrKmuQedlNGqOQL46N8cAGh1lhIRuDbKW/37//w=;
        b=qYOX6oIUFvgs5bv0sZKj0FcupAHvxdM4JNiea+J2UY0iXWXQbnhNc7h6Uc70NY2KUU
         u8zz8si9iaAuS9BvMrtZ0wQcArlYlpdj2inkMsveReD+iRza7sHuWN2jEh8PHG5y7HEW
         8lUnPZwQ2xMoc13Z5KVgD84cUjx8HzM8w92PmPeFFqxYULT5GHpcVEeCPl1o4CB3TWdX
         VAUzHWq9Phg0MFZ6ZQ1TrYEfkx+y31XfoPIqbATrGj6q+/ws6SlTk1AS8OAnfkhEzTgw
         q+I4yRmV1mTNYoGyAY0et1wR6nw8PNvptdppHqCF4nluZQBQrqwGDlKshyyWNQMRyfm6
         zbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=wU1fHrKmuQedlNGqOQL46N8cAGh1lhIRuDbKW/37//w=;
        b=af8yozkjtkZi79LMJH1kIr/HYoygPU3FdQ0VqcpKq/VHaraS6fAD5DMgNcOhXf66wT
         zBumBBURLTQXxk5DSg4VMbSIidA4QOS92nuzm0nW2qKdwN2DwwoSTl9uAt3gSrfPT7L/
         RCVUox+8trIOROL5XYtkI9OsIc/8KlrSy/AC4DEkvfzuFWsGcat49FLFfI45+R6uwcSU
         VNyD/uQW/BjhQTqlo1quJ02kBSTMeTzSlkMWLUDg0sZmIx1xKMK6f5PAKMFoG9V4JIVP
         IkT/WnQPSmjL3vLK4zGGD5HXEQM3XO2NKD3Rs16XZBkWgayehSUk+UU1A5PH5FpzejCF
         SDhw==
X-Gm-Message-State: APjAAAWjAK4RlIrEFhI7OJXqTZ1hR5SChl1v6+VOVcrY87EOxqzfVsAp
        dTCwAP8Pa715X+w6DW2kqRE=
X-Google-Smtp-Source: APXvYqyjrF01QgwnWiHv0+RncK0aRlsnczA2m0NzqB/nFPUfQmdW25/9zKbqEskrK6Zwkmp8DSW8Xw==
X-Received: by 2002:a7b:c14a:: with SMTP id z10mr378519wmi.99.1552443415993;
        Tue, 12 Mar 2019 19:16:55 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id o5sm18225348wrv.70.2019.03.12.19.16.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 19:16:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Git List <git@vger.kernel.org>,
        nathan.berbezier@etu.univ-lyon1.fr,
        pablo.chabanne@etu.univ-lyon1.fr
Subject: Re: [PATCH 2/2 v3] doc: format pathnames and URLs as monospace.
References: <20190306130446.2193-1-corentin.bompard@etu.univ-lyon1.fr>
        <20190306130446.2193-2-corentin.bompard@etu.univ-lyon1.fr>
        <86va0o9qsp.fsf@matthieu-moy.fr>
        <CAPig+cQEYDay9kTUpBepw6kN_PgpG4dRXeNf82Kty+E7piXeWg@mail.gmail.com>
        <8a8944a6-9559-74be-afee-e6af262412ab@gmail.com>
Date:   Wed, 13 Mar 2019 11:16:55 +0900
In-Reply-To: <8a8944a6-9559-74be-afee-e6af262412ab@gmail.com> (Andrei Rybak's
        message of "Tue, 12 Mar 2019 18:13:48 +0100")
Message-ID: <xmqq5zsnfrhk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrei Rybak <rybak.a.v@gmail.com> writes:

> On 2019-03-12 16:48, Eric Sunshine wrote:
>> Thanks. A few comments:
>>
>> In patch 1/2:
>>
>> * drop the full stop from the first line of the commit message
>>
>> * s/futur/future/ in the commit message
>>
>> * s/There are false/& positives/ in the commit message
>>
>> * s/both, It/both, it/
>
> Also,
>
> * s/inconsistant/inconsistent/ in the first paragraph of the commit message.

Here is what I have locally, with the above input, relative to what
Matthieu reviewed.

Thanks, all.

1:  ed3eba5cc5 ! 1:  0dbd305fe7 doc/CodingGuidelines: URLs and paths as monospace.
    @@ -1,11 +1,11 @@
     Author: Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr>
     
    -    doc/CodingGuidelines: URLs and paths as monospace.
    +    doc/CodingGuidelines: URLs and paths as monospace
     
         The current documentation uses both quotes (italics) and backquotes
    -    (monospace) to render URLs and pathnames, which is inconsistant.
    +    (monospace) to render URLs and pathnames, which is inconsistent.
         Document a best practice in CodingGuidelines to help reduce
    -    inconsistencies in the futur.
    +    inconsistencies in the future.
     
         We set the best practice to using backquotes, since:
     
    @@ -17,8 +17,8 @@
           $ git grep '`[^`]/*[^`]`' | wc -l
           690
     
    -      There are false on both sides, but after a cursory look at the
    -      output of both, It doesn't seem the false positive rate is really
    +      There are false positives on both sides, but after a cursory look at
    +      the output of both, it doesn't seem the false positive rate is really
           higher in the second case.
     
           At least, this shows that the existing documentation uses
2:  38ffa25f88 = 2:  68ed71b53c doc: format pathnames and URLs as monospace.
