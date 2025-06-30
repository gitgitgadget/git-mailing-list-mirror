Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81B6202976
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 23:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751325019; cv=none; b=NL6DMVQ4WulCeRZUxz9TyUSuxI4+oNGForKKaWmJY4MErccPAn58ilNGMwdfEIY5BvDtdpqqv16bUwrnZu3Oqngarq3r/n0fWYFbqjjc80RQFBXj9nGVPzByRVBXn7Y6JnL/u+RT21rwvga8EX/6PWTE6ykru5JkWqjC64Uq7u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751325019; c=relaxed/simple;
	bh=vL94RX9XFsHr8fkDbuLWX3xMOM+C8Yn9vFzXo48gEtM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LVm7rXofEf22icnFqZepDRW4GT699yL9fGDx8sAHQxQg0Srjh2HJOJn4jiHp5raZURxHYforoekE+wl5PZP69RLvLp+xlDdO/4mJjcv5iii+MRdmwnAN+9vOf8u3x62G+MFMazr86EsrD3ZnIXZfQQ8veZAVZpBCqTSamynieGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SyPuIQ9F; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SyPuIQ9F"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-234f17910d8so47574755ad.3
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 16:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751325017; x=1751929817; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wJFPmKGFEN9FbrQNimSxF+l9kwUcyS5R+ELHmZAh6gM=;
        b=SyPuIQ9FKNdWZ8uzD96mGfL+5sxdbQUzJvVXyHYWX3/O9z1PWK16t2XOn0oZegzhEd
         YieP9zx9BJomXeJ7sl2i0zSHXbPNjeCQzVjQ3SEo7Tgc+3UOvAKhRi0KRC/EuOeXs+sA
         wTjyR0QRCiH9IN8uhZYWaFXd/vtJ9QMEzkGG+QDCqwWc94Lvae3Es3BDcBuk+AXIWYg1
         3TuKHSf5P6KxZ40sPm0RvfDGbLbKZy4QAA46KzMHpXujvMYFCy8JzGtuc6emFInalCDF
         7RsDX9ZgUuJtGNaTHpz/2q0xQiRFdlKAaZAmM5lqXNKrrefsy9fSlPPmQ8ahr9zhcWV8
         PSJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751325017; x=1751929817;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wJFPmKGFEN9FbrQNimSxF+l9kwUcyS5R+ELHmZAh6gM=;
        b=g8ESmVh4GGw4WqJJBMFU8qRHyPMyXNl7Hl1SeJAE2Os33ylYeWyDfmeprIaY4HAgGC
         QTJFqyoc0uPvVxmCEEdIUYgsqRpFinNMhvsdVTAGiKiUspGyi0fAK/72hiNMBmvEA+Sp
         zXPkR3QNVXd183oLcQE7kYI5K2vZ8vFets7NAuL/ejEWaHELzq6P46qCFe+749vhK67H
         E9nSHJ5xVFq2JHY7ZCRIV0WZ6cBdpIK2YQPvYYe/0IJmaEGVSYUhXFe0IwkCAdxmMMkf
         E4wxH2ZYsFLfo1GxENZXuI9JhTje3lUJi1KrDx4PmU1Z+7X3Flnw0QzS/WQjKUaHG958
         fGHw==
X-Gm-Message-State: AOJu0Ywu0wi5mu0kl4lGirNBoxhF7x+phMkwzEOI0qNTPrR8tJ0I5tLo
	qN5E1ADgZ2QL/hh2rw8Fp5ULlERPFqj3Lg0iOqJ3uu0Gp1AhWibg2bWd
X-Gm-Gg: ASbGncvmsx0GzGtya/ldYu6AS/IwwqR8blSr75eOf7yD4j7nkOUz2a8WmrJqIBgFjXg
	n+SY5PGZhOODzV1d5Um7gtl/T2dbhe2ClX6/PY9OI0qwA3+9HEphveyUxz6IabsOhYHuONzcwZk
	vl89u7CCv0gH4UG7FiB300xeqysq+sqvUr9lpLHPUv4ojIQ20zyFuY6XQ9m4dmdoiBxt6OFNT+X
	w1caJIROR+GXhIJCbPiEBMI8RKi/aTJ599PPdwHcxhIFZR0glTslVkN9MgmzAxV24R14uJFgBq/
	5dTG+srEvKUBCzCCOxbK0fNSLsWrq4PTDX9LDLoYn+llw7vuhJT+UpwDQJJAAeIeJLS3/tLXtwg
	GSQHMFcqny/p6pLXEpbIPjCW8zsM=
X-Google-Smtp-Source: AGHT+IH+oGGcTat+l09pkfxnuWe3bYTmwM4vMwfl8lz8/u1UjUwbdvT+x3uJgjat+HiB2B1UpQq+wA==
X-Received: by 2002:a17:903:2445:b0:234:8f5d:e3c0 with SMTP id d9443c01a7336-23ac45c1cb3mr193221495ad.6.1751325017066;
        Mon, 30 Jun 2025 16:10:17 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23acb3b7b0asm94071305ad.173.2025.06.30.16.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 16:10:16 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  Patrick Steinhardt <ps@pks.im>,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH 0/5] doc: config: update for the ps/config-subcommands
 series
In-Reply-To: <cover.1751310455.git.code@khaugsbakk.name>
	(kristofferhaugsbakk@fastmail.com's message of "Mon, 30 Jun 2025
	21:10:22 +0200")
References: <cover.1751310455.git.code@khaugsbakk.name>
Date: Mon, 30 Jun 2025 16:10:15 -0700
Message-ID: <xmqqwm8sltbc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> Update git-config(1) according to the ps/config-subcommands series
> (fe3ccc7aab (Merge branch 'ps/config-subcommands', 2024-05-15)):
>
> 1. Document `--show-names`
> 2. Document `--value`
> 3. Mention `--value` throughout instead of the deprecated
>    `value-pattern`
> 4. Mention `--url` in the synopsis
>
> Kristoffer Haugsbakk (5):
>   doc: config: document --[no-]show-names
>   doc: config: use --value=<pattern> consistently
>   doc: config: document --[no-]value
>   doc: config: use --value instead of value-pattern
>   doc: config: mention --url in the synopsis
>
>  Documentation/git-config.adoc | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
>
>
> base-commit: cf6f63ea6bf35173e02e18bdc6a4ba41288acff9

Have you run tests with this series, especially t0450?

$ sh t0450-*.sh -i -v
...
expecting success of 0450.142 'config -h output and SYNOPSIS agree':
                t2s="$(adoc_to_synopsis "$builtin")" &&
                if test "$builtin" = "merge-tree"
                then
                        test_when_finished "rm -f t2s.new" &&
                        sed -e 's/ (deprecated)$//g' <"$t2s" >t2s.new
                        t2s=t2s.new
                fi &&
                h2s="$(help_to_synopsis "$builtin")" &&

                # The *.adoc and -h use different spacing for the
                # alignment of continued usage output, normalize it.
                align_after_nl "$builtin" <"$t2s" >adoc &&
                align_after_nl "$builtin" <"$h2s" >help &&
                test_cmp adoc help

--- adoc        2025-06-30 23:09:02.715600047 +0000
+++ help        2025-06-30 23:09:02.723600026 +0000
@@ -1,7 +1,7 @@
 git config list [<file-option>] [<display-option>] [--includes]
-git config get [<file-option>] [<display-option>] [--includes] [--all] [--regexp] [--value=<pattern>] [--fixed-value] [--default=<default>] [--url=<url>] <name>
-git config set [<file-option>] [--type=<type>] [--all] [--value=<pattern>] [--fixed-value] <name> <value>
-git config unset [<file-option>] [--all] [--value=<pattern>] [--fixed-value] <name>
+git config get [<file-option>] [<display-option>] [--includes] [--all] [--regexp] [--value=<value>] [--fixed-value] [--default=<default>] <name>
+git config set [<file-option>] [--type=<type>] [--all] [--value=<value>] [--fixed-value] <name> <value>
+git config unset [<file-option>] [--all] [--value=<value>] [--fixed-value] <name>
 git config rename-section [<file-option>] <old-name> <new-name>
 git config remove-section [<file-option>] <name>
 git config edit [<file-option>]
not ok 142 - config -h output and SYNOPSIS agree
#
#                       t2s="$(adoc_to_synopsis "$builtin")" &&
#                       if test "$builtin" = "merge-tree"
#                       then
#                               test_when_finished "rm -f t2s.new" &&
#                               sed -e 's/ (deprecated)$//g' <"$t2s" >t2s.new
#                               t2s=t2s.new
#                       fi &&
#                       h2s="$(help_to_synopsis "$builtin")" &&
#
#                       # The *.adoc and -h use different spacing for the
#                       # alignment of continued usage output, normalize it.
#                       align_after_nl "$builtin" <"$t2s" >adoc &&
#                       align_after_nl "$builtin" <"$h2s" >help &&
#                       test_cmp adoc help
#
1..142
