Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66D5E201B0
	for <e@80x24.org>; Sun, 26 Feb 2017 02:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751890AbdBZCKf (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 21:10:35 -0500
Received: from mail-vk0-f45.google.com ([209.85.213.45]:35515 "EHLO
        mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751764AbdBZCKe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 21:10:34 -0500
Received: by mail-vk0-f45.google.com with SMTP id x75so28622777vke.2
        for <git@vger.kernel.org>; Sat, 25 Feb 2017 18:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GEAMcCtXe+3SlJovz1eb5GF6RTCuV0PAhwFnp6ISf3Y=;
        b=K1myNd+sOALzGxGs6yWlHIqckOc9Mc6+QsNqbMUcxXm5KVYPYjHT2lazV02CDFDxTb
         +9XXH9a0Zi8/z/rhZInuZBh2Pdqr8FIYZ2dh738XFS4XDpcg32N4mRDz2eWbdzpNkYpF
         sA2lOjIBPJePnKjnjVzhpWz30Ozx/K8lmSf0G9QBvsfLYBppQodyRH5r2H4LmpaKWrZt
         6v+Pewzv36EvHwToaK9y1OQnch29EKXBTTC1ejYt0iW3r9atScCIHhMno8im25iMjhfg
         CKrcsX+Njm/NElHxEZqUf0jDyjwpP/f3oAsRvAL8a/8ADskF6HBoF82ev6szkbJY7pcV
         e8ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GEAMcCtXe+3SlJovz1eb5GF6RTCuV0PAhwFnp6ISf3Y=;
        b=sn6Mtwg2RapFShuUPrR9cG8qsOgvKvs2e6oCAiOmYIcKxWoCo0vAM9HvnE5RP6idsl
         l9oVIY8BBg8xDlV7evtti0TRtCL8DVFN9ssafZGZm4dXJ8YgsFkqtjO5Z8yZdsPDXsYg
         eUrstf9VFnWjDgZwghMb2Qfdvj+PQqv1Kz7H33eX9zPi8X6RJBHs2Kcfvyq4makNDGOj
         AYTjnY0Zx8N2B9PBiNx1ZqhIoMCe5g3QdWSEBc9X4j2+qYIxssGKIi8U6iKrPdxacAYn
         mZKt930tpAjOc+SfQiSc3kaJRn0265YMJFnnfsdOFxMbGbn1DebcaaJ+qBit6KRZH8zZ
         0hQg==
X-Gm-Message-State: AMke39moCuVmHzKVuK63HEue+R+0lf9SDysDKJjY2WXpcRTbvpdIeaxX3bHRoFIwAdAQtwqSTR7CbbdmZ2v6jw==
X-Received: by 10.31.1.86 with SMTP id 83mr4284814vkb.0.1488075032900; Sat, 25
 Feb 2017 18:10:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.159.34.73 with HTTP; Sat, 25 Feb 2017 18:09:52 -0800 (PST)
In-Reply-To: <BAB1EE0E-B258-4108-AE24-110172086DE4@gmail.com>
References: <CAJZjrdXP3n5fOLx4rEEkbJT7JBMPUqk4Qdutm6KpvMVUMwCSPQ@mail.gmail.com>
 <BAB1EE0E-B258-4108-AE24-110172086DE4@gmail.com>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Sat, 25 Feb 2017 20:09:52 -0600
Message-ID: <CAJZjrdXg=jTXO+Dox9gTby-_JX+Lw_deihbUmbHe8V92dWJ0tg@mail.gmail.com>
Subject: Re: [PATCH] travis-ci: run scan-build every time
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 25, 2017 at 3:48 PM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>
>> On 24 Feb 2017, at 18:29, Samuel Lijin <sxlijin@gmail.com> wrote:
>>
>> It's worth noting that there seems to be a weird issue with scan-build
>> where it *will* generate a report for something locally, but won't do it
>> on Travis. See [2] for an example where I have a C program with a
>> very obvious memory leak but scan-build on Travis doesn't generate
>> a report (despite complaining about it in stdout), even though it does
>> on my local machine.
>>
>> [1] https://travis-ci.org/sxlijin/git/builds/204853233
>> [2] https://travis-ci.org/sxlijin/travis-testing/jobs/205025319#L331-L342
>
> Scan-build stores the report in some temp folder. I assume you can't access
> this folder on TravisCI. Try the scan-build option "-o scan-build-results"
> to store the report in the local directory.

That occurred to me, but I don't quite think that's the issue. I just
noticed that on the repo I use to test build matrices, jobs 1-8 don't
generate a report, but 9-14 and 19-20 do [1]. I don't think it's an
issue with write permissions (scan-build complains much more vocally
if that happens), but it doesn't seem to matter if the output dir is
in the tmpfs [2] or a local directory [3].

[1] https://travis-ci.org/sxlijin/travis-testing/builds/205054253
[2] https://travis-ci.org/sxlijin/git/jobs/205028920#L1000
[2] https://travis-ci.org/sxlijin/git/jobs/205411705#L998

>> @@ -78,9 +79,8 @@ before_install:
>>       brew update --quiet
>>       # Uncomment this if you want to run perf tests:
>>       # brew install gnu-time
>> -      brew install git-lfs gettext
>> -      brew link --force gettext
>> -      brew install caskroom/cask/perforce
>> +      brew install git-lfs gettext caskroom/cask/perforce llvm
>> +      brew link --force gettext llvm
>
> This wouldn't be necessary if we only scan on Linux.

Agreed. I'm not sure if macOS static analysis would bring any specific
benefits; I don't really have much experience with static analysis
tools one way or another, so I'm happy to defer on this decision.


>> -script: make --quiet test
>> +script: scan-build make --quiet test
>
> Why do you want to scan the tests?

Brain fart on my end.

> Cheers,
> Lars
