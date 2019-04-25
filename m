Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB7971F453
	for <e@80x24.org>; Thu, 25 Apr 2019 10:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfDYKIl (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 06:08:41 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44640 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfDYKIl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 06:08:41 -0400
Received: by mail-ed1-f65.google.com with SMTP id i13so18606169edf.11
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 03:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=ytnC4IwFrtPF9vNwri1Lur6fstQDu1HKodxjOWAV83U=;
        b=r7S8FklA8js2BJbPeQLFHkBehx0ajGhIJGQiQ0voL8vxAffwGLjwX08gk64mhG1Fwb
         cvSYX660Gi+17Jpd2DLSQroC4eA/ZokItv6gDSjqtyLDCKMbKUtiOuKDcw2kSCQiXAI7
         3WWetxDFnFQosOFJ9EVvGifcxcMNN/HfTWZlOH+u4HeKJdCkEhwzxZM1L6jVLdi0Omzk
         WhJibOAC94Fhwehe63Q8Z7UzkVZO4hFdSvI5qTA1315c7rJKVeCeyz5h4HVzNIUSW4C9
         opF6gJk10lOYZgf6vfSSiDcR6ZIMCtnn0hb4b2hEQ8pI1bracIX/m8LiX09IqxSiGR/q
         y9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=ytnC4IwFrtPF9vNwri1Lur6fstQDu1HKodxjOWAV83U=;
        b=G9/8NR+8VhetYstp+XOhLhhm/2myLBHdUbOr69uM2CVdUHvAlDi60SHZLkO3WfvWtc
         Xmqtk5Zt7LJB/LLGBpCC8g4OjisHG7E9YDsYWLmaRBSZtkU4H5HNKr2a/MYV97zVQfXQ
         86697L7Vyb6ypuz75d7YVhMX3GPIHRWSNhbpUDkii4mb1XE+Th0N41xNG+VLkcRk5XND
         DcU5jqROiAEifxbVskMCAeYWwBHCoec0HPPWp2In6zS8IKJR/3PxVahmHRrO+Kt/oNmU
         Yl0iSUmTEGeAwJnLXEyZWotDuRqT3IctvJjPYPwfmdvdpaoluxqbgGqVWnd7b+t7njH7
         kDJw==
X-Gm-Message-State: APjAAAUwwaWmsv4iRSpBEpU5JGb3z3F945QKKdC+sG5j47ILS8MhbbPu
        bDH8zkBabU8L3lE0c5+Ziw8=
X-Google-Smtp-Source: APXvYqyqRwyzv+OP+cdOi7nAchYaMQszXXmejT43yAogU2iiur1II3pINUuZDp2banLuNeoG6kZEVA==
X-Received: by 2002:a17:906:b291:: with SMTP id q17mr19291847ejz.56.1556186919451;
        Thu, 25 Apr 2019 03:08:39 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id d56sm280562edb.70.2019.04.25.03.08.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 03:08:38 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Barret Rhoden <brho@google.com>, Olaf Hering <olaf@aepfle.de>
Subject: How to undo previously set configuration? (again)
References: <20190424004948.728326-1-sandals@crustytoothpaste.net> <20190424023438.GE98980@google.com> <20190424230744.GL6316@genre.crustytoothpaste.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190424230744.GL6316@genre.crustytoothpaste.net>
Date:   Thu, 25 Apr 2019 12:08:37 +0200
Message-ID: <87k1fis8gq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 25 2019, brian m. carlson wrote:

> On Tue, Apr 23, 2019 at 07:34:38PM -0700, Jonathan Nieder wrote:
>> Hi,
>>
>> brian m. carlson wrote:
>>
>> > I've talked with some people about this approach, and they've indicated
>> > they would prefer a configuration-based approach.
>>
>> I would, too, mostly because that reduces the problem of securing
>> hooks to securing configuration.  See
>> https://public-inbox.org/git/20171002234517.GV19555@aiede.mtv.corp.google.com/
>> for more on this subject.
>
> I know this is a common issue, but fixing it is a non-goal for this
> series. Anything we do here is going to have to be backwards compatible,
> so we can't make any changes to the security model.

Agreed on the problem, and on the non-goal for solving it as part of
this series.

>> Solving (1) without (2) feels like a bit of a missed opportunity to
>> me.  Ideally, what I would like is
>>
>>    i. A central registry of trustworthy Git hooks that can be upgraded
>>       using the system package manager to address (2).  Perhaps just
>>       git-hook-* commands on the $PATH.
>>
>>   ii. Instead of putting hooks in .git/hooks, put a list of hooks to
>>       run for each event in .git/config.
>
> The problem I had with this when discussing it was that our
> configuration system lacks a good way to control inheritance from outer
> files. I recently was working with a system-wide gitconfig file that
> referred to files I didn't have, and my Git installation was subtly
> broken in a variety of ways.
>
> If I have a system-wide hook to run for company code, but I have a
> checkout for my personal dotfiles on my machine where I don't want to
> run that hook, our configuration lacks a way for me to disable that
> system-wide configuration. However, using our current system, I can
> override core.hooksPath in this case and everything works fine.
>
> I mentioned this for completeness, and because I hope that some of those
> people will get some time to chime in here, but I think without that
> feature, we end up with a worse experience than we have now.

I sent a proposal for this last year "How to undo previously set
configuration?":
https://public-inbox.org/git/874lkq11ug.fsf@evledraar.gmail.com/

Obviously the main bottleneck is someone like me working on patching it,
but in this case it would be very useful if those who are interested in
this could look that proposal over and bikeshed it / point out issues I
may have missed, i.e. "no, this categorically won't work with this
proposed syntax due to XYZ you haven't thought of...".

Because we don't have some general config facility for this it keeps
coming up, and various existing/proposed options have their own little
custom hacks for doing it, e.g. this for Barret Rhoden's proposed "blame
skip commits" feature
https://public-inbox.org/git/878swhfzxb.fsf@evledraar.gmail.com/
(b.t.w. I *meant* /dev/null in that E-Mail, but due to PEBCAK wrote
/dev/zero).
