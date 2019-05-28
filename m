Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A318B1F609
	for <e@80x24.org>; Tue, 28 May 2019 02:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbfE1CRq (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 May 2019 22:17:46 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:41590 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbfE1CRq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 May 2019 22:17:46 -0400
Received: by mail-ed1-f41.google.com with SMTP id m4so29265975edd.8
        for <git@vger.kernel.org>; Mon, 27 May 2019 19:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=mfIJsSApRZDUwEv0194q2usyLOT3U0KzJeazGPQqBhM=;
        b=Pm9TDnzQjnz73MiYEkX87EIY5Qa0HZ/o+NEmL/ETs8fu9CnrG5ERSLDrZc+YOy9H8T
         bq+Gaz6ckIpdpM78cnUE+dp77f48pgVsp6tQ7qNyYdlr23JIc8BSBboOUZuaVf09aDPQ
         b0iBc2YQE1rBBBwp3/dz6Ml9g5if+/6BbmW1NUfnuoBbq9av4EZoJYNfLJTm+mXXbQeS
         7iefUMtkoRhtY6SSyQDEEcrfXpwthvAuJFMMCdycnBajm19Xl4MjoRWx3+Vl6yRdZUvT
         AE0BV8yVmhMYzUqLKVBVW2LgEcQuVfOj8TCjfdAyy4KRRxcP/3AvNfJpHTvuED++EJ4p
         1r8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=mfIJsSApRZDUwEv0194q2usyLOT3U0KzJeazGPQqBhM=;
        b=sZS3ejxR9z+nMVBU5BUBcz8Q19VfCBjchFVBylqmKZKdKrZyLEW6No5rHisf8RjGMB
         c2W9ZvtKqaOnjGWH78VSFIbIlCH5LJMiFnI6GCZvYVYPnxCzxpHWAh2JXi6CfxkJ2RjC
         EozPCTTb/0vO01Cn28WZXKRzWG92wxPXtJ+5zTTOSqx0JrBe2ommTKrAAY94iXbklyA1
         m393C809IqXiJ5WvxZ/Nz28Q468VHgmYSOIaEjV9Yp6dY5JatfUsCvVVk3S9R0BFTOZa
         vD31zwtCP3AmdyQknhLb5Eyw4/YgsEMV9GpAKte+qOPQqQV7cnQGBUgQ9PaxQovqenUJ
         jQJA==
X-Gm-Message-State: APjAAAWjsgENReYOkNdAUAb0FtryQvsJUbESVdDtxMsiW3Y0LEzIlkmH
        1X3YYFsw7By0MXQuH78ASjc=
X-Google-Smtp-Source: APXvYqw2kFSZh2cDBed9qaB2L4pg0/kFqXg/In+QZ0qVMOl4xfI+LkLN1aQ+/oQeb8GF9O2FQR/XrA==
X-Received: by 2002:a50:b343:: with SMTP id r3mr127124677edd.53.1559009864284;
        Mon, 27 May 2019 19:17:44 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id f8sm3828414edd.15.2019.05.27.19.17.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 May 2019 19:17:43 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Eric Wong <e@80x24.org>, Chris Mayo <aklhfex@gmail.com>,
        git@vger.kernel.org, git-packagers@googlegroups.com,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH] send-email: remove documented requirement for Net::SMTP::SSL
References: <20190526172242.13000-1-aklhfex@gmail.com> <20190527193517.GA22013@dcvr> <87imtvmy7f.fsf@evledraar.gmail.com> <20190527234347.GH8616@genre.crustytoothpaste.net>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190527234347.GH8616@genre.crustytoothpaste.net>
Date:   Tue, 28 May 2019 04:17:42 +0200
Message-ID: <87ftozmiex.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 28 2019, brian m. carlson wrote:

> On 2019-05-27 at 20:36:36, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> I've done enough git-send-email patching in anger for a year at least
>> with what's sitting in "next" so I'm not working on this, but just my
>> 0.02:
>>
>> I wonder if we shouldn't just be much more aggressive about version
>> requirements for something like git-send-email.
>>
>> Do we really have git users who want a new git *and* have an old perl
>> *and* aren't just getting it from an OS package where the module is
>> dual-life, so the distributor can just package up the newer version if
>> we were to require it?
>
> In my experience, shipping newer versions of packages shipped with the
> OS is a no-no. That's a great way to break unrelated software on the
> system, and if you're the distributor, to get users angry at you about
> breaking stuff on their systems.

Just because a package X needs dependency Y at version Z doesn't mean
you need to package it up in such a way that everything that needs any
version of Y must use it at version Z, you put the two versions in
different places on the FS.

So in this case the packager would grumble a bit and package up a
Net::SMTP installed at another path. I do that myself to get some more
modern versions of dependencies on CentOS 6 without breaking the base
system.

Does that mean we should do it in this case? No, and given the feedback
in this thread about this in particular I think we should just keep the
old code.

But I think is important to clarify in general, i.e. just because you're
on CentOS 6 and don't want to update the main perl-Net-SMTP you can
still package up a for-git-perl-Net-SMTP or whatever.

We had a similar discussion about whether to depend on a more recent
libcurl in the past:

https://public-inbox.org/git/CACBZZX78oKU5HuBEqb9qLy7--wcwhC_mW6x7Q+tB4suxo=
hSCsQ@mail.gmail.com/

> We do indeed have users who want a newer Git on those systems and are
> using the system Perl. The Git shipped with CentOS 7 (not to mention
> CentOS 6) is positively ancient and doesn't support useful features like
> worktrees, so it makes sense to upgrade it. But if you're not a Perl
> shop, nobody cares about the version of Perl on the system and fussing
> with it doesn't make sense.

What I was suggesting was whether it was worth it to ask distributors to
drop in a few *.pm files, and perhaps a *.so or two compiled against
openssl, they wouldn't need to change the base /usr/bin/perl.

In the case of the *.pm stuff we could drop fallbacks into
perl/Git/LoadCPAN if we wanted things to work out of the box.

>> I.e. couldn't we just remove the fallback code added in 0ead000c3a
>> ("send-email: Net::SMTP::SSL is obsolete, use only when necessary",
>> 2017-03-24) and do away with this version detection (which b.t.w. should
>> just do a $obj->can("starttls") check instead).
>>
>> For shipping a newer Net::SMTP we aren't talking about upgrading
>> /usr/bin/perl, just that module, and anyone who's packaging git
>> (e.g. Debian) who cares about minimal dependencies is likely splitting
>> out git-send-email.perl anyway.
>>
>> We could then just add some flag similar to NO_PERL_CPAN_FALLBACKS so
>> we'd error out by default unless these modules were there when git was
>> built, packagers could then still set some "no I can't be bothered with
>> send-email at all" or "no I can't be bothered with its SSL support", in
>> the latter case git-send-email would work except for the SSL parts.
>
> We had a problem with Homebrew sometime back where they stopped shipping
> git-send-email because it required Perl modules and there was a big
> uproar and a request for us to allow dynamic Perl support. I would like
> to discourage distributors from simply refusing to ship core pieces of
> Git because it tends to cause problems for users and for us down the
> line.

I'm sympathetic to packagers that do that, particularly when "add -i"
and friends in s/Perl/C/ land, at which point we'd be asking some
distributors who otherwise wouldn't have perl at all to install it just
for us.

It seems packagers mainly had issues with the Perl-SSL stuff. We already
support SSL for https via libcurl usually, perhaps we'd be better off
having some wrapper using that
(https://curl.haxx.se/libcurl/c/smtp-tls.html), or having
git-send-email.perl support something simpler like say stunnel.

> I understand and am fine with splitting components out into multiple
> packages or omitting parts interfacing with other systems (e.g.
> git-svn).

I tend to think of SVN as a system more closely related to Git than Git
is related to E-Mail :)

It's also something that's by definition part of an "egress" workflow,
so it tends to be much easier to work around it being missing than say
"add -i" or something you truly need locally not being there.
