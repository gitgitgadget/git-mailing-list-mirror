From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v2] hooks: Add ability to specify where the hook directory is
Date: Tue, 26 Apr 2016 18:31:55 +0200
Message-ID: <CACBZZX5X_7guR2b+uQFcxzzC6xCv55z=KiMUO6kEmJdQ-U1Gcw@mail.gmail.com>
References: <CACBZZX7jTHqSq0ADJxO0cP+1MZMWAowLMMj4J0NHkFTYOYsJiw@mail.gmail.com>
 <1461532702-4045-1-git-send-email-avarab@gmail.com> <xmqqlh41junh.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 18:32:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av5uS-0006fh-4E
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 18:32:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752471AbcDZQcR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Apr 2016 12:32:17 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:33304 "EHLO
	mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280AbcDZQcP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2016 12:32:15 -0400
Received: by mail-qk0-f195.google.com with SMTP id q184so1331684qkf.0
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 09:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FnXvwoi6fMCBzXrTbA+JMCHUOu8vMBRmvMPwCtWxY8c=;
        b=ovQaZdpppvI2wYymYUApetZojHpCcy+Rb2FkilorXzAKuIXYVzAXJ+F93tE+dGQLs0
         yl6ak7a0jEbbLex8ssWI8oL7BqU5CT6e+OytmyTBR/kBTggE2Y0C4N06bbiFPfiOsNCU
         gx+HLY/Ho9tEIn93PGGnj0nb6dIIPMo8oGRCrMxiLSwExGLxc0Z8YOHf12HljeS6X35Q
         0PqYlUnHrNIC2NBrbUlC9eWBOQpsenNgUiRsmBkDWgaHT7Sf0bvGTZL/79INAYf5vYwT
         PX0Ka7xlZ6n8TMhlqM0UVblvXFZBEruArdCSb3nlRge5/6GW43riR5ufXKE2/ysj6BTD
         MVWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FnXvwoi6fMCBzXrTbA+JMCHUOu8vMBRmvMPwCtWxY8c=;
        b=WEQ2g0yaYxAMdjRHU3EzkB6bd+0QrWKtk8pI3Q6dXbXubhdoJe1UMqlvmk9zB7hfor
         Q/0rzMPH0v+NjWU8Rma/BW8Bkiq6bBHh9suMw+l7mGSMl7IM5o/rvXYHrcbuzftJhihS
         BlB9JpbKCS5X90D2t7Qokq6OnWfHycWz3oyJS+XhQ3LKrsdB2+7Y4Y56ftfTaJEoC+vg
         gxFDoWzYTlBQpwENVCpm9FckMahaEoarOJDietJzPvTfOgPe1S2mNOX6i1UuDce5ci5l
         MLQuHfZTzEHW/OlS6qFX0IMRtzxc7ZYLOcWDHmzCuyyzTwKG7vmeFjBq567LXpwrHtnY
         +aNw==
X-Gm-Message-State: AOPr4FXk6G0xsHpUKsa1SyES8VewFrAuhKBbYn0qO+7qu5Mj6Ii0uJDXNnx143OsDluhX5VNxe+yCe/7mZa1hw==
X-Received: by 10.55.204.6 with SMTP id r6mr3278964qki.21.1461688334434; Tue,
 26 Apr 2016 09:32:14 -0700 (PDT)
Received: by 10.55.77.133 with HTTP; Tue, 26 Apr 2016 09:31:55 -0700 (PDT)
In-Reply-To: <xmqqlh41junh.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292613>

On Mon, Apr 25, 2016 at 10:33 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> +core.hooksPath::
>> +     By default Git will look for your hooks in the
>> +     '$GIT_DIR/hooks' directory. Set this to different path,
>> +     e.g. '/etc/git/hooks', and Git will try to find your hooks in
>> +     that directory, e.g. '/etc/git/hooks/pre-receive' instead of
>> +     in '$GIT_DIR/hooks/pre-receive'.
>> ++
>> +The path can either be absolute or relative. In the latter case see
>> +the discussion in the "DESCRIPTION" section of linkgit:githooks[5]
>> +about what the relative path will be relative to.
>
> ... which does not seem to appear there, it seems?

I think it does. Read on...

>>  DESCRIPTION
>>  -----------
>>
>> -Hooks are programs you can place in the `$GIT_DIR/hooks` directory =
to
>> -trigger action at certain points. Hooks that don't have the executa=
ble
>> -bit set are ignored.
>> +Hooks are programs you can place in a hooks directory to trigger ac=
tion
>> +at certain points. Hooks that don't have the executable bit set are
>> +ignored.
>> +
>> +By default the hooks directory is `$GIT_DIR/hooks`, but that can be
>> +changed via the `core.hooksPath` configuration variable (see
>> +linkgit:git-config[1]).
>
> The section talks about what the cwd of the process that runs the
> hook is, but it is not clear at all from these three lines in
> core.hooksPath description above how the cwd of the process is
> related with the directory the relative path will be relative to.

I think the documentation mostly makes sense, but that the context of
this patch is confusing.

I.e. when I say:

> The path can either be absolute or relative. In the latter case see
> the discussion in the "DESCRIPTION" section of linkgit:githooks[5]
> about what the relative path will be relative to.

In config.txt, I'm not talking about the patch to githooks.txt I'm
adding in this commit, but the first patch in the githooks.txt series,
i.e. this section:

> When a hook is called in a non-bare repository the working directory
> is guaranteed to be the root of the working tree, in a bare repositor=
y
> the working directory will be the path to the repository. I.e. hooks
> don't need to worry about the user's current working directory.

I.e. I'm not talking about the "by default the hooks directory [blah
blah]" part I'm adding here.

> Unless the readers know that the implementation makes sure that the
> process chdir'ed to that final directory before calling find_hook(),
> that is.  And I do not think you want to assume that knowledge on
> the side of the readers.

This should not be explicitly covered in githooks.txt in my previous
series per the above..

>> diff --git a/t/t1350-config-hooks-path.sh b/t/t1350-config-hooks-pat=
h.sh
>> new file mode 100755
>> index 0000000..31461aa
>> --- /dev/null
>> +++ b/t/t1350-config-hooks-path.sh
>> @@ -0,0 +1,33 @@
>> +#!/bin/sh
>> +
>> +test_description=3D'Test the core.hooksPath configuration variable'
>> +
>> +. ./test-lib.sh
>> +
>> +test_expect_success 'set up a pre-commit hook in core.hooksPath' '
>> +     mkdir -p .git/custom-hooks .git/hooks &&
>> +     write_script .git/custom-hooks/pre-commit <<EOF &&
>> +printf "%s" "." >>.git/PRE-COMMIT-HOOK-WAS-CALLED
>> +EOF
>
> Because there is no funny interpolation going on, it would help
> readers to signal that fact by quoting the end-of-here-text marker.
> And it makes the entire test block reads nicer if you indent the
> body of hte here-text by prefixing the end-of-here-text marker with
> a dash, i.e.

Yes this and all the other stuff you and Johannes mentioned in this
thread just made no sense and was just some brainfart of mine. I'm
fixing all these issues up for the next re-send.

>         write_script .git/custom-hooks/pre-commit <<-\EOF &&
>         printf "%s" "." >>.git/PRE-COMMIT-HOOK-WAS-CALLED
>         EOF
>
>> +     cat >.git/hooks/pre-commit <<EOF &&
>> +     write_script .git/hooks/pre-commit &&
>> +printf "%s" "SHOULD NOT BE CALLED" >>.git/PRE-COMMIT-HOOK-WAS-CALLE=
D
>> +EOF
>> +     chmod +x .git/custom-hooks/pre-commit
>
> You didn't want cat and chmod here?
>
>> +'
>> +
>> +test_expect_success 'Check that various forms of specifying core.ho=
oksPath work' '
>> +     test_commit no_custom_hook &&
>> +     git config core.hooksPath .git/custom-hooks &&
>> +     test_commit have_custom_hook &&
>> +     git config core.hooksPath .git/custom-hooks/ &&
>> +     test_commit have_custom_hook_trailing_slash &&
>> +     git config core.hooksPath "$PWD/.git/custom-hooks" &&
>> +     test_commit have_custom_hook_abs_path &&
>> +     git config core.hooksPath "$PWD/.git/custom-hooks/" &&
>> +     test_commit have_custom_hook_abs_path_trailing_slash &&
>> +     printf "%s" "...." >.git/PRE-COMMIT-HOOK-WAS-CALLED.expect &&
>> +     test_cmp .git/PRE-COMMIT-HOOK-WAS-CALLED.expect .git/PRE-COMMI=
T-HOOK-WAS-CALLED
>> +'
>> +
>> +test_done
