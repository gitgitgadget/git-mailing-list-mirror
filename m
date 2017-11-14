Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 444C5201C8
	for <e@80x24.org>; Tue, 14 Nov 2017 09:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751856AbdKNJcJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 04:32:09 -0500
Received: from locusts.copyleft.no ([188.94.218.116]:53618 "EHLO
        mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753164AbdKNJb6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 04:31:58 -0500
Received: from mail-qk0-f174.google.com ([209.85.220.174])
        by mail.mailgateway.no with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72 (FreeBSD))
        (envelope-from <johan@herland.net>)
        id 1eEXZT-000L02-RN
        for git@vger.kernel.org; Tue, 14 Nov 2017 10:31:55 +0100
Received: by mail-qk0-f174.google.com with SMTP id 136so12369051qkd.4
        for <git@vger.kernel.org>; Tue, 14 Nov 2017 01:31:55 -0800 (PST)
X-Gm-Message-State: AJaThX7YmjmiGvSAnD7VAxCS2nLiy8oVLXl6tArYDFJWaIh/M3WolAWz
        pNUKt9J6anI6sbvDa4+2/MtxA315S/7Zbez9RVI=
X-Google-Smtp-Source: AGs4zMZ6Cf0+yQG/GbVaAEBDNBou2DVCF5n12kWyYFTDA448EXuciz7W4MzQNk6jV6zoah13/+8XPpGKFylkuaNGpU0=
X-Received: by 10.55.183.134 with SMTP id h128mr18573722qkf.258.1510651909727;
 Tue, 14 Nov 2017 01:31:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.140.207 with HTTP; Tue, 14 Nov 2017 01:31:49 -0800 (PST)
In-Reply-To: <20171114051520.GU5144@zaya.teonanacatl.net>
References: <20171113210745.24638-1-tmz@pobox.com> <xmqq60ad7ewx.fsf@gitster.mtv.corp.google.com>
 <20171114030351.GS5144@zaya.teonanacatl.net> <xmqqshdh5ygy.fsf@gitster.mtv.corp.google.com>
 <20171114051520.GU5144@zaya.teonanacatl.net>
From:   Johan Herland <johan@herland.net>
Date:   Tue, 14 Nov 2017 10:31:49 +0100
X-Gmail-Original-Message-ID: <CALKQrgc427=JNkkH+k+EohgKYuJSBPbDNR3uUcmGuf_ZyQ0X4Q@mail.gmail.com>
Message-ID: <CALKQrgc427=JNkkH+k+EohgKYuJSBPbDNR3uUcmGuf_ZyQ0X4Q@mail.gmail.com>
Subject: Re: [PATCH] t/lib-gpg: fix gpgconf stderr redirect to /dev/null
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        Santiago Torres <santiago@nyu.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 14, 2017 at 6:15 AM, Todd Zullinger <tmz@pobox.com> wrote:
> Junio C Hamano wrote:
>>
>> The message goes to the standard output stream since it was introduced in
>> 809f38c8 ("git notes merge: Manual conflict resolution, part 1/2",
>> 2010-11-09) and 6abb3655 ("git notes merge:
>> Manual conflict resolution, part 2/2", 2010-11-09).  I do think it makes
>> more sense to send it to the standard error stream, but just in case if the
>> original author thinks of a reason why it shouldn't, let's summon Johan and
>> ask his input.
>
>
> Sounds like a good plan.  If the message does move to stderr, there are also
> a few tests in 3310 that need adjusted.  They presume an error message from
> `git notes merge`, but they only redirect stdout to the output file.
>
> While I was bored, I prepared a commit with these changes and confirmed the
> test suite passes, in case we get an ACK from Johan.

ACK :-)

Error messages should go to stderr, and redirection in the tests
should be fixed.

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
