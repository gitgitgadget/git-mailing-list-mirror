Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E0352018F
	for <e@80x24.org>; Tue, 19 Jul 2016 20:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077AbcGSUop (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 16:44:45 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35613 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023AbcGSUon (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 16:44:43 -0400
Received: by mail-wm0-f42.google.com with SMTP id f65so151624932wmi.0
        for <git@vger.kernel.org>; Tue, 19 Jul 2016 13:44:43 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=sryxuLe3dkg17DBxunLolLYW0t8SfxIahA3oU5de7sw=;
        b=SCo6xiBr3xZVnjxX29FaYJo+73Lprq2Dj4rjY/15Nh+jY4QFZRk6vKqtIYP91ro5aK
         olHjtkQVGvqhcclt0fhDFYIuF5buCmPwhA0uUZZlrylpVr8oZ8zgGtidJccRwiUnfCrD
         tFF2zWgZ6/dm6gWN2Pqx1PayhTTCj7+127pJKqizsY/g0Ss1EKf68ufCaypqCVMowedQ
         oTtb1hRc957vC/yjNeRv8UInHkE+RLdSyhpVmZHcbV0/mUs9tpLxQGWn8puws7Lwtk+g
         M4A+z/kYkyUgAX1icRuVfvMOnKeQxqj1sLjMfJxblodB8xU1PLqUTwXzHNU9VbutS0m9
         2roQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=sryxuLe3dkg17DBxunLolLYW0t8SfxIahA3oU5de7sw=;
        b=bS2eAiBlUISQKKiiYFnvHcIBelnnakH9UQqtkDTuIjcZcDruMpgnUiARK/ipu1+YYr
         W+iHTg0/KXfqT14NFQvbeUhmtcN+Edko2GwmgDn3HPtBdIOfyQoDljMqVaTw+3v5QPQb
         W18thBOC5DPCIMhFgun2fo6voUYO9paTtVDXzgTpI5rtv+YJ/hLv5+kxbv6RciGHp5hh
         5EQaq74mqzmLzaCE8CS7RdrnnINvuPgCNr2yap/lW9MKVSzOTwlZtbg8xuMbACHj7X8F
         arXPVdRjR2YwpJTkwDNt9+6Pg2gG9mb0qaYrPDAWPr0yB5YIIv23RvGvOiJJIfjXqI0e
         umNA==
X-Gm-Message-State: ALyK8tIbPfS74upUsHOXBOz7LRQuAooxpLWTElovjPJzRFjJpIR3+NT/dCBouHaEipwSKg==
X-Received: by 10.28.193.140 with SMTP id r134mr6533710wmf.81.1468961082193;
        Tue, 19 Jul 2016 13:44:42 -0700 (PDT)
Received: from slxbook3.fritz.box (p508BA0C8.dip0.t-ipconnect.de. [80.139.160.200])
        by smtp.gmail.com with ESMTPSA id m201sm25914080wma.11.2016.07.19.13.44.40
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Jul 2016 13:44:41 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: Looking for help to understand external filter driver code
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqlh0xfoho.fsf@gitster.mtv.corp.google.com>
Date:	Tue, 19 Jul 2016 22:44:53 +0200
Cc:	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>
Content-Transfer-Encoding: 7bit
Message-Id: <7B44C694-7CB2-411D-9CC6-7334CCBAD20B@gmail.com>
References: <67D9AC88-550E-4549-9AFD-2401B70B363B@gmail.com> <xmqqbn1th5qn.fsf@gitster.mtv.corp.google.com> <xmqqlh0xfoho.fsf@gitster.mtv.corp.google.com>
To:	Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.1878.6)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


On 19 Jul 2016, at 20:53, Junio C Hamano <gitster@pobox.com> wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
>> The key benefit of this arrangement is the above can be done without
>> having to do poll() to flip between reading and writing that is
>> needed to avoid deadlocking, which kept the code simpler.  A later
>> conversion of the write side into async does not fundamentally
>> change anything from the original arrangement.
> 
> Translation: I was too lazy to worry about doing poll()/select()
> when I did it originally.  As long as you can do so correctly, be my
> guest to reduce one process by having the main process do both
> reading and writing.
> 
> ;-)

Thanks a lot for this explanation. My goal is to add an option to
the clean/smudge filter config that instructs Git to keep the
external filter process running. Whenever Git encounters a file
to be filtered then it would continue to talk to the filter process
over a simple pipe protocol:

Git writes --> 4 byte filename length
Git writes --> filename string
Git writes --> 4 byte content length
Git writes --> content string
Git reads <-- 4 byte filtered content length
Git reads <-- filtered content

I still need to read more about poll()/select() but it looks to me
as if these functions are only required if Git doesn't know what to
expect. With the sketched protocol above that wouldn't be the case.
Therefore, I wonder if I would need to use poll()/select()?

Thanks,
Lars

