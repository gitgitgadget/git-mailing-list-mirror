Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C52B9208E4
	for <e@80x24.org>; Tue,  5 Sep 2017 17:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752284AbdIERNI (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 13:13:08 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:37544 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752157AbdIERNH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 13:13:07 -0400
Received: by mail-pg0-f44.google.com with SMTP id d8so10504273pgt.4
        for <git@vger.kernel.org>; Tue, 05 Sep 2017 10:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=g0KtNibH6a4ORfI2f1FtNkijXEMZDfIvGEbzpep2Ag8=;
        b=iIq4gRDIWRjxghiYFMlsP9+pQZwX/InSOrY8yFUTTF7n7XzW5S8wSKQWe5doWYdqg6
         kn9J8H9ZaStaRUXIwz97kQMNS3z0lYVhYkXNYIPbAh4IpieFqo/U+GH12zlOD17dNuIt
         vyLIaTDTZbvwscc1ppuqhDKxbIP+zBr67EWJ06NW0dVzhiE0RiVCVYyYJJVA/GmhwnQo
         PSVmzhAk0C85MbGLxpIQc0hYy5+/k7frzpvhkcSCu/nrYIBkM0evuS3msAfP4N5q5let
         WdaVZ/3RnLBNp1fzWWvIHgeZsVAKKJ2jwa6Za20edmS8QGbTOg+I9evjDc840FHiUPhe
         RWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=g0KtNibH6a4ORfI2f1FtNkijXEMZDfIvGEbzpep2Ag8=;
        b=HyJlC5GKhw6v79/DPCMknThli34+cWcQSAPtGjWzN1WsnnIFDj9Ae1X+7p8DX+T0AK
         +ebOhSJKArI0nU+VJ/r4K1IdjrpoECZIwqXY4XGArl6afuVvXmuixbX49PEvbFfk7LEI
         SBFGCRso5j0catwJb/6s/EZsD521VdMbVJS3InaHsASfOmRZq15UaBi7qhLwZKdgSJro
         pQiYNwOYA0+dcq5tpg0UzPzHRugHWeo+zEliB+wgbM+CNFh+CNX743v+j9lWpDYg9XX4
         IDrujoL5h/T23pYALB0slfesW/9+ikP3Tsbdl3Zv8kupSVxiXjcr2AZFtrXiDvUfVCVq
         U7hg==
X-Gm-Message-State: AHPjjUgohEYRQhp93ZcqSddVXOtYHGK7/ZxjpkDcVHQ1RS9Dbk/OemKM
        MfWdsdl/LY+rgSQQ2qZ7CiVmr7gWMQ==
X-Google-Smtp-Source: ADKCNb7yrbqEQzhZIDwjPhkxnRk2PY4k8VjV5l/0d57NwHHPdQLy3nfmaWiAYA9xtQMs+SNEMDaa1N4DlJwjMJLTHG0=
X-Received: by 10.98.157.201 with SMTP id a70mr4403536pfk.122.1504631586646;
 Tue, 05 Sep 2017 10:13:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.142.73 with HTTP; Tue, 5 Sep 2017 10:13:05 -0700 (PDT)
In-Reply-To: <06c552de-80a0-9cd0-d016-07a4ab0afaf0@jeffhostetler.com>
References: <adb37b70139fd1e2bac18bfd22c8b96683ae18eb.1502780344.git.martin.agren@gmail.com>
 <20170830185922.10107-1-git@jeffhostetler.com> <20170830185922.10107-2-git@jeffhostetler.com>
 <alpine.DEB.2.21.1.1709020109520.4132@virtualbox> <20170901235030.GD143138@aiede.mtv.corp.google.com>
 <06c552de-80a0-9cd0-d016-07a4ab0afaf0@jeffhostetler.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 5 Sep 2017 19:13:05 +0200
Message-ID: <CAN0heSoJDL9pWELD6ciLTmWf-a=oyxe4EXXOmCKvsG5MSuzxsA@mail.gmail.com>
Subject: Re: [PATCH] hashmap: add API to disable item counting when threaded
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5 September 2017 at 18:39, Jeff Hostetler <git@jeffhostetler.com> wrote:
>
>
> On 9/1/2017 7:50 PM, Jonathan Nieder wrote:
>>
>> Hi,
>>
>> Johannes Schindelin wrote:
>>>
>>> On Wed, 30 Aug 2017, Jeff Hostetler wrote:
>>
>>
>>>> This is to address concerns raised by ThreadSanitizer on the mailing
>>>> list about threaded unprotected R/W access to map.size with my previous
>>>> "disallow rehash" change (0607e10009ee4e37cb49b4cec8d28a9dda1656a4).
>>
>>
>> Nice!
>>
>> What does the message from TSan look like?  (The full message doesn't
>> need to go in the commit message, but a snippet can help.)  How can I
>> reproduce it?
>
>
> I'll let Martin common on how to run TSan; I'm just going on
> what he reported in the "tsan: t3008..." message from the URL
> I quoted.  I didn't think to copy that text into the commit
> message because it is just stack traces and too long, but I
> could include a snippet.

I ran the test suite with ThreadSanitizer:

$ make SANITIZE=thread test

Any failures were then inspected:

$ cd t
$ ./t3008-ls-files-lazy-init-name-hash.sh --verbose

That can be done with or without ma/ts-cleanups. That series adds a file
.tsan-suppressions, which can be used by defining the environment
variable

TSAN_OPTIONS="suppressions=/some/absolute/path/.tsan-suppressions"

in order to suppress some findings which are indeed races, but which are
"not a problem in practice".

Martin
