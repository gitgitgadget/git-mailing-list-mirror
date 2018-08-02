Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03B491F597
	for <e@80x24.org>; Thu,  2 Aug 2018 18:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbeHBUtm (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 16:49:42 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52006 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbeHBUtm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 16:49:42 -0400
Received: by mail-wm0-f66.google.com with SMTP id y2-v6so3673824wma.1
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 11:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2Uo0ZYucZ0QehtWFgwmQzqRr3ZSfG30OIGS1EWZWFN8=;
        b=c9mz7jTzbnHQBcR3+fFZ2KJKbgffeJT5zcE7yBCNhSvvleiVb60z/9i81zAeZ4Apo/
         yuoHbBknIT2l/ItchBP/Vq7es5RtOZlBn7eB6ZqUvrxLeXQF+YCWfn6jM7EC6xPDO2v6
         TbhNEG7NS3zb0Q2ummNGdSDv720s/HqZ4PYzU9e+WHf5d8ZXl2HCvR3lgnoPDg5pSMXm
         EAhkg+5cJWspfxbwQKGRIWKA+4L4rW72XB/8io3jvlc+t1DEqFnqGoiqtontt5NsMk/Q
         lCSF0uecq8fypqZ8dZ9GSeXD2ryq39fxHJ5JR1mr6UCgv2hpVug8qe4oxyOc9w2u+Ah2
         7OgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2Uo0ZYucZ0QehtWFgwmQzqRr3ZSfG30OIGS1EWZWFN8=;
        b=EA6LnlbVtKEagl4p2jCR8ZptZttw4iW+0Dh74GdnE0aJmk9GMWNBNb2+fiuBKiD5zW
         kZdZNZdHtV07OESsVO+eB/pmF+cw4CEiFZ5W7OBM/+cpRUc1ucycHR5cLl7YA4q3W4jV
         gcSEN0UDYu4c0VcybiFajwlHf/nLQEpR3RuJq3HWJtUk8YdX5T1ACsTHPLFTr1gob1no
         zdFNAeO6lBXS+jhWQf908SoCjxfxyo45kftPkEgljNVBNEayjpXuYlVbFI5wGETmD0I8
         TTqyEblJriaU5dexDppVgAfEyMEn5vvuOC5zcngNCRmMvOiziYOpVDJ17dZbqG8npjYZ
         nOxw==
X-Gm-Message-State: AOUpUlFQpkX9105xVacZK1tpF+0P4QJQhSX2G2MvD5ByS/EDdoG9iLSR
        DPUkJjBl+eNs5S3o1oeA6HA=
X-Google-Smtp-Source: AAOMgpcy15hrwnRaDvgxKAUQGl/wVPpQCnqjzmqhBxq96gtC7YxIz7rF8R+bS+eZXGCmmg2oWsv1rA==
X-Received: by 2002:a1c:dc1:: with SMTP id 184-v6mr2728067wmn.145.1533236236001;
        Thu, 02 Aug 2018 11:57:16 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 200-v6sm222410wmv.6.2018.08.02.11.57.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 11:57:15 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Antonio Ospite <ao2@ao2.it>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Daniel =?utf-8?Q?Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH v2 06/12] submodule--helper: add a '--stage' option to the 'config' sub command
References: <20180802134634.10300-1-ao2@ao2.it>
        <20180802134634.10300-7-ao2@ao2.it>
Date:   Thu, 02 Aug 2018 11:57:14 -0700
In-Reply-To: <20180802134634.10300-7-ao2@ao2.it> (Antonio Ospite's message of
        "Thu, 2 Aug 2018 15:46:28 +0200")
Message-ID: <xmqqd0v01trp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Antonio Ospite <ao2@ao2.it> writes:

> Add a --stage option to the 'submodule--helper config' command so that
> the .gitmodules file can be staged without referring to it explicitly by
> its file path.

Sorry, but I have no clue what the above is trying to say.

The original 's--h config <name> [<value>]' is quite understandable.  It
is like "git config <name> [<value>]", i.e. either get the current value
for the name, or  set a new value to the name.

What does this 's--h config --stage' that does not take any option
do?  "git add .gitmodules"?  Something else?  In what meaning is the
word "stage" used?  Is it used as a verb "to stage"?

In a series that lets us use the data in the .gitmodules file without
materializing the file in the working tree, I would have expected
that you would want an option to specify which .gitmodules among
(1) the one in the working tree (i.e. the only option we currently
have), (2) the one in the index, and (3) the one in the HEAD, and
when I saw the title, I would have expected that

	git submodule--helper config --stage name

may be a way to read from the .gitmodules in the index to find the
value for name (however, we we follow the option naming convention
in gitcli.txt, it should be called --cached, I would think).

> In practice the config will still be written to .gitmodules, there are
> no plans to change the file path, but having this level of indirection
> makes it possible to perform additional checks before staging the file.

Again, a claim without explanation or justification.

If you are planning to something like

 - prepare trial contents in .gitmodules.new file
 - do whatever "additional checks" on .gitmodules.new
 - add the contents to it to the index as a new .gitmodules blob

Then you do not need such an option.  "submodule--helper" is purely
a helper for scripts, and not for human consumption, so scripts can
just hash-object the blob contents out and update-index --cacheinfo
to register the blob at any location of choice.

But as I said, this step is way under-explained, so my guess above
may not match what you really wanted to do.
