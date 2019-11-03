Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7CC31F454
	for <e@80x24.org>; Sun,  3 Nov 2019 19:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbfKCTkl (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Nov 2019 14:40:41 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39719 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727913AbfKCTkl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Nov 2019 14:40:41 -0500
Received: by mail-lf1-f68.google.com with SMTP id 195so10624701lfj.6
        for <git@vger.kernel.org>; Sun, 03 Nov 2019 11:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=0GvBV7qedXxyCwPSB5EX2VGAt662eMHBj7Yzs6WFUSg=;
        b=FIeSR8wb+34vA+r0ungRZkszOv/4D1taIuKEg+fJHpogGlvqtZ3yZxhoQMABg6yq0v
         CAIpG1p2oNjfftkjjamMmLA2Z7GGHtC93Bncs2YIx7uH/Ig04QV7b7nbFnrlzcFTeqbW
         a8hL6Q/GeU3lCbOwGwVCR5vmKQ1ojSK6uegm6j7ZAtj7j+SCu8mReOQQRjXcWv1rgo/5
         +ITsH7WxRjxVH4FlHJt+d1uxyqjYjdfc7O/g9yKRNqub5IWrXb8h5F1qKdghFUBLEZAL
         oCdWTgCOmKGIl54tdJ6mNerksTbChKhftzd9YIs8pARMmT9SqULx/Y6TpTMnnkoY7go1
         tN+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=0GvBV7qedXxyCwPSB5EX2VGAt662eMHBj7Yzs6WFUSg=;
        b=EoLv79uxqv3v+Cg9mYTX4LxS7h08OkaAGleHdmC0jkd8wKzC78vm2/9FFTpYR8nNQS
         aOkJ8iEw0A2/qfw5GOh7K+1vtrivZs0dHXBAbZLj2j29rG0Qq2FV5HSWAWgDa8+Z46jd
         VCEFKa03j5rJ2VGkiKApUA1PszqhZAU5gA5deTszAxmNKsZJoBOLgUjA4m+kE76e9kU+
         Ea3p+Yfp5sReLhGio570nWiHvKNHBEzk+RevNM7D0VdZ+6dIdO4TjAakkTwEXICD7REE
         wmRTclNnRzEQpv1aoTIzuF+XAjckfHPx66159QCNOzYZVLcyRWpmqwKghGqAS4dQkhQE
         oOSQ==
X-Gm-Message-State: APjAAAWpL68ZIN3M0Rt6U/+1uVbSOngGPj9xJpXH4FSOOjZ4BKBSIzNA
        Lqey6or+UN1oeeIq0p0pWVg+F3fATWY=
X-Google-Smtp-Source: APXvYqxnaL85A2V01olc2Pz7+o4hS9Qq3Jc6/xSbTzXdmZ/KZlZz0D0E0knInE3XmBsk0k3ANVI45Q==
X-Received: by 2002:a19:8c1c:: with SMTP id o28mr14265110lfd.105.1572810038267;
        Sun, 03 Nov 2019 11:40:38 -0800 (PST)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id u13sm5206923ljl.71.2019.11.03.11.40.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Nov 2019 11:40:37 -0800 (PST)
From:   Jakub Narebski <jnareb@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 3/4] doc: dissuade users from trying to ignore tracked files
References: <20191102192615.10013-1-sandals@crustytoothpaste.net>
        <20191102192615.10013-4-sandals@crustytoothpaste.net>
        <86h83lhugj.fsf@gmail.com>
        <20191103185908.GA32531@camp.crustytoothpaste.net>
Date:   Sun, 03 Nov 2019 20:40:36 +0100
In-Reply-To: <20191103185908.GA32531@camp.crustytoothpaste.net> (brian
        m. carlson's message of "Sun, 3 Nov 2019 18:59:08 +0000")
Message-ID: <861ruoiw97.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:
> On 2019-11-03 at 15:04:44, Jakub Narebski wrote:

>> Why the change between formatting '``assume unchanged''' (with double
>> quotes and space separated) and 'skip-worktree' (without quotes, and
>> kebab-cased)?  In the commit message you write about assume-unchanged
>> and skip-worktree.
>>=20
>> I guess that follows the inconsistency in git-update-index(1) headers,
>> namely we have
>>=20
>>   USING ``ASSUME UNCHANGED'' BIT
>>   ------------------------------
>>=20
>> but
>>=20
>>   SKIP-WORKTREE BIT
>>   -----------------
>>=20
>> This inconsistency is much more visible when both names are on the same
>> line, however.
>
> Yeah, I can change them to make them consistent.  I did preserve the
> existing formatting for both, as you mentioned.

Thanks in advance.  This inconsistence just looks strange in one line.

>> I'm not sure if it is a place for it, but the proposed text treats
>> assume-unchanged and skip-worktree as similarly unsuited for intended
>> purpose.  However, their failure modes are different: (ab)using the
>> assume-unchanged for "ignore changed to tracked files" may lead to data
>> loss (as changes are overwritten), while with skip-worktree the trouble
>> is that some operations that should succeed (like unstashing) are
>> unnecessarily blocked - but no data loss.
>
> I agree the failure modes can be different, but from my experience there
> are people who have seen checkout failures with both bits set
> independently.  I'm not exactly sure what those cases are, but folks do
> see them on Stack Overflow quite frequently.
>
> Even if there is a difference in failure modes, I'd rather encourage
> people to just not use this mechanism rather than explain why or in
> which cases it won't do what you want.

What I wanted to say here is that if you really, really need to abuse
those mechanism for "ignore tracked files changes", it is better to use
skip-worktree bit -- at least you wouldn't loose your data (your
precious changes).

Nb. I have experimented with both assume-unchanged and skip-worktree,
so I know their annoyances, but I have not had a need to use them.

>> I would really like to see a simple example of such template, so that
>> even people who are unfamiliar with Ruby's ERB can think of equivalent
>> solution for their language or toolchain of choice.
>
> I hesitated to mention ERB, but I wasn't sure that folks would know what
> we meant by a "templating mechanism".  The reason I had chosen to
> mention it is that someone could search for "Ruby ERB" and find out what
> it looked like and then look for an option in their own language.

I would like to see not an example of template, but example how such
template can be used in place of "ignore tracked files change".

> My concern with adding such a template is that an example will likely
> grow this section quite a bit, and it's meant as a short aside to help
> people avoid making a common mistake and guide them to a proper solution
> rather than a comprehensive howto.  I'm planning on adding a FAQ
> document in the future that covers a lot of these issues in more detail
> and helps folks figure out solutions to common problems, and I'd prefer
> to explain this more in depth there.

Your proposed change:

  +If the file you want to change is some sort of configuration file (say,
  +for a build tool, IDE, or editor), a common solution is to use a
  +templating mechanism, such as Ruby's ERB, to generate the ignored
  +configuration file from a template stored in the repository and a source
  +of data using a script or build step.

I don't see how such templating mechanism could be used.  You have some
kind of configuration file with placeholders comitted, and you have a
version of this file with local changes -- how templating mechanism
could solve this?  I would like to see few lines of an example and its
use.


Alterantives:
~~~~~~~~~~~~~

In our build system, we have versioned Makefile, and not versioned
config.mak (with local configuration), which is included by Makefile.

In many cases using environment variables to provide local changes is
recommended, something like e.g.

  AWS::S3::Base.establish_connection!(
    :access_key_id     =3D> ENV['S3_KEY'],
    :secret_access_key =3D> ENV['S3_SECRET']
  )


Best,
--=20
Jakub Nar=C4=99bski
