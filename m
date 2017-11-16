Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 695B7202A0
	for <e@80x24.org>; Thu, 16 Nov 2017 16:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936172AbdKPQq7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Nov 2017 11:46:59 -0500
Received: from mail-wr0-f177.google.com ([209.85.128.177]:52939 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759814AbdKPQql (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Nov 2017 11:46:41 -0500
Received: by mail-wr0-f177.google.com with SMTP id o14so4478892wrf.9
        for <git@vger.kernel.org>; Thu, 16 Nov 2017 08:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=TM9sX1qhSJP9ZjFNXMQWCOveyFU4JPmnX6/Oik2yNAg=;
        b=dQHoBk+g4KRr0hi3fQjnEnKS+ksDnhMu4iGENrTzF+YOAhcCCzseG0KcMRB+j1ZYZO
         EbOEWbppOm5lOLJza/rvx7207dILZkXnh4W4twzO3uzsQm6TAVlrNpnD7+BQleu8GddQ
         1OQnKAGhT88JuIhCeaJDaxKjqqjREaWd4DtUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=TM9sX1qhSJP9ZjFNXMQWCOveyFU4JPmnX6/Oik2yNAg=;
        b=dgpkEj98gvNTkBWRcSfEx26cw6jmeBsDzmXR6I7BHlz5iYPyjQNNlOCkDC4ZVJ1Jdk
         EmiipmVQzrAervXl/SP2ZKddhEmyDHv90VK/vrtk4yIHjYrumYJ/Uvu1lmyWM1FsqcRC
         CUIWEkCMtmdPICWWf59Fbb0N+7QLzrJr9Kb+hzGenDI9MYkmd5iLLDla5VOWaByOCYhn
         7dlSQLR7+Mo49F/JN7ILJ2vSZuI+W9ZKX25qJkwkHkD5giYHQJX+OwYkdkqClJfO0uas
         g2r4gqDtbCJvBIhIO+vfhcRTS2lKxfZnO6OoJqaYKsfb3xVR1de/O9nTkwof4/oGfTB5
         buZw==
X-Gm-Message-State: AJaThX6bt3OT9QV0rgojx0lFmBXsk4ISNJ1WfqaxY43wRVcrLEbgocXC
        uF8OM3oZJbW881uZ5cezuvYr6g==
X-Google-Smtp-Source: AGs4zMYu2ro+Ou5P+m9CkXjAe1smxbZsbyIxWuRkGxqL+dTGh0EM3kAILpbS4etJoU5U6VMlr3Z2oQ==
X-Received: by 10.223.167.76 with SMTP id e12mr1919596wrd.259.1510850800445;
        Thu, 16 Nov 2017 08:46:40 -0800 (PST)
Received: from zen.linaro.local ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id 2sm835346wrg.49.2017.11.16.08.46.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Nov 2017 08:46:39 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaro.local (Postfix) with ESMTPS id 1976A3E009F;
        Thu, 16 Nov 2017 16:46:39 +0000 (GMT)
References: <20171116154814.23785-1-alex.bennee@linaro.org>
User-agent: mu4e 1.0-alpha2; emacs 26.0.90
From:   Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     git@vger.kernel.org
Cc:     Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] git-send-email: fix get_maintainer.pl regression
In-reply-to: <20171116154814.23785-1-alex.bennee@linaro.org>
Date:   Thu, 16 Nov 2017 16:46:39 +0000
Message-ID: <874lpu189c.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Getting rid of Mail::Address regressed behaviour with common
> get_maintainer scripts such as the Linux kernel. Fix the missed corner
> case and add a test for it.
>
<snip>
> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index 4d261c2a9..0bcd7ab96 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -172,6 +172,27 @@ test_expect_success $PREREQ 'cc trailer with various=
 syntax' '
>  	test_cmp expected-cc commandline1
>  '
>
> +test_expect_success $PREREQ 'setup get_mainter script for cc trailer' "
> +cat >expected-cc-script.sh <<-EOF && chmod +x expected-cc-script.sh
> +#!/bin/sh
> +echo 'One Person <one@example.com> (supporter:THIS (FOO/bar))'
> +echo 'Two Person <two@example.com> (maintainer:THIS THING)'
> +echo 'Third List <three@example.com> (moderated list:THIS THING (FOO/bar=
))'
> +echo '<four@example.com> (moderated list:FOR THING)'
> +echo 'five@example.com (open list:FOR THING (FOO/bar))'
> +echo 'six@example.com (open list)'
> +EOF
> +"
> +
> +test_expect_success $PREREQ 'cc trailer with get_maintainer output' '
> +	test_commit cc-trailer &&
> +	clean_fake_sendmail &&
> +	git send-email -1 --to=3Drecipient@example.com \
> +		--cc-cmd=3D"$(pwd)/expected-cc-script.sh" \
> +		--smtp-server=3D"$(pwd)/fake.sendmail" &&
> +	test_cmp expected-cc commandline1
> +'
> +

OK I'm afraid I don't fully understand the test harness as this breaks a
bunch of other tests. If anyone can offer some pointers on how to fix
I'd be grateful.

In the meantime I know the core change works because I tested with:

#+name: send-patches-dry-run
#+begin_src sh :results output
# temp workaround
export PERL5LIB=3D/home/alex/src/git.git/perl/
git send-email --confirm=3Dnever --dry-run --quiet ${mailto} ${series}.patc=
hes/*
#+end_src

When I sent my last set of kernel patches to the list (the workflow that
was broken before by the cc9075067776ebd34cc08f31bf78bb05f12fd879 change
landing via my git stable PPA).

--
Alex Benn=C3=A9e
