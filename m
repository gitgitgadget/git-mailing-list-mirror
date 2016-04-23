From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] hooks: Add ability to specify where the hook directory is
Date: Sat, 23 Apr 2016 02:44:11 +0200
Message-ID: <CACBZZX7jTHqSq0ADJxO0cP+1MZMWAowLMMj4J0NHkFTYOYsJiw@mail.gmail.com>
References: <1461367997-28745-1-git-send-email-avarab@gmail.com> <1461370382-16524-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sat Apr 23 02:44:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atlgd-0001DR-Lk
	for gcvg-git-2@plane.gmane.org; Sat, 23 Apr 2016 02:44:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777AbcDWAod convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Apr 2016 20:44:33 -0400
Received: from mail-qg0-f66.google.com ([209.85.192.66]:35332 "EHLO
	mail-qg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719AbcDWAoc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2016 20:44:32 -0400
Received: by mail-qg0-f66.google.com with SMTP id b14so8714969qge.2
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 17:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Iz+lKXzyiZPyB2NMaIhzGGuzrDfrZKtAtxMu0s5NGHc=;
        b=UPYctpssFI6c7BXl7QGMM1rplPccadmrIywMEod3wV8CMDQqlT+olMq6vA4IWsTsGh
         GzS2QxkEov0bfWvtuideYgoc6CdWaXpFfKYmp6vksHOaScPn0k4uKChJnjCg42LZv3/0
         yq2EJHz5+urIBpUVubM7LXF7ExjOrU7GzI5tgBqpSLD26NA3Bt38Yde69bjdYyy2InBV
         tqw4q1p1GoL3tZWSS4Ptf8hJyNXnc9WTsDGJdZRF9OCwrSwdEpBCFr25aRFPvdD8+kxC
         OjSOY5InBkhl69x5kBb8dLBsftHy0ltEzUMQE9NdMeLm1nkRuPnXtxOs3b/Ank989Ahu
         jA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Iz+lKXzyiZPyB2NMaIhzGGuzrDfrZKtAtxMu0s5NGHc=;
        b=EpgbB/WfYOuO2gzwok8VBxjosIKUqwRHKdbT9fH3X3eE1S79q5QCpn/5FvHXQ0BCcz
         2IRy6drzF5m5fDxd3u0CAsKltomO/hDD1Jrdk9juZIZ7f8XjLezjbIg6zULAEvhX/r/A
         qPjUGlypA8Xt9dwIjcvkB31tfOym2YLust9XjQT3CgHaeZvvyKR4NV/x+1hmiBvC0ue8
         3UTrNIVR3ObkZAB8jTSyXtKLfKfSgegzQN2Cye1OBLWMGaM8DbPwMX3mIHtYFRo3iCE9
         5CusOY+DPF4FpD4D++oSEUlozCHvGGByAu0xBir29TZEpR6tmhk5CewMtQgB7jh2xpzU
         3oSg==
X-Gm-Message-State: AOPr4FVHkN2vUvyeWxjRQ4wn59CAYUoCukog4AXhaRvki5jCn3W+lagylzN7I5ib038qjW5ujaMbQb4CPGxJBg==
X-Received: by 10.140.98.175 with SMTP id o44mr24293724qge.46.1461372271135;
 Fri, 22 Apr 2016 17:44:31 -0700 (PDT)
Received: by 10.55.77.82 with HTTP; Fri, 22 Apr 2016 17:44:11 -0700 (PDT)
In-Reply-To: <1461370382-16524-1-git-send-email-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292294>

On Sat, Apr 23, 2016 at 2:13 AM, SZEDER G=C3=A1bor <szeder@ira.uka.de> =
wrote:
>
>> Change the hardcoded lookup for .git/hooks/* to optionally lookup in
>> $(git config core.hooksDirectory)/* instead if that config key is se=
t.
>>
>> This is essentially a more intrusive version of the git-init ability=
 to
>> specify hooks on init time via init templates.
>>
>> The difference between that facility and this feature is that this c=
an
>> be set up after the fact via e.g. ~/.gitconfig or /etc/gitconfig to
>> apply for all your personal repositories, or all repositories on the
>> system.
>>
>> I plan on using this on a centralized Git server where users can cre=
ate
>> arbitrary repositories under /gitroot, but I'd like to manage all th=
e
>> hooks that should be run centrally via a unified dispatch mechanism.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.=
com>
>> ---
>>  Documentation/config.txt          | 10 ++++++++++
>>  Documentation/githooks.txt        |  5 ++++-
>>  cache.h                           |  1 +
>>  config.c                          |  3 +++
>>  environment.c                     |  1 +
>>  run-command.c                     |  5 ++++-
>>  t/t1350-config-hooks-directory.sh | 35 ++++++++++++++++++++++++++++=
+++++++
>>  7 files changed, 58 insertions(+), 2 deletions(-)
>>  create mode 100755 t/t1350-config-hooks-directory.sh
>>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index 42d2b50..2faf3c0 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -618,6 +618,16 @@ core.attributesFile::
>>       $XDG_CONFIG_HOME/git/attributes. If $XDG_CONFIG_HOME is either=
 not
>>       set or empty, $HOME/.config/git/attributes is used instead.
>>
>> +core.hooksDirectory::
>> +     By default Git will look for your hooks in the '$GIT_DIR/hooks=
'
>> +     directory. Set this to different absolute directory name,

Thanks for the review. I'll submit a new patch with fixes pending any
more comments from others to reduce list churn.

> Mental note: here you say that it should be an absolute directory.
>
>> +     e.g. '/etc/git/hooks', and Git will try to find your hooks tha=
t
>
> s/hooks that/hooks in that/

Will fix.

>> +     directory, e.g. '/etc/git/hooks/pre-receive' instead of in
>> +     '$GIT_DIR/hooks'.
>> ++
>> +This is useful in cases where you'd like to centrally configure you=
r
>> +Git hooks instead of configuring them on a per-repository basis.
>> +
>>  core.editor::
>>       Commands such as `commit` and `tag` that lets you edit
>>       messages by launching an editor uses the value of this
>
>
>> diff --git a/t/t1350-config-hooks-directory.sh b/t/t1350-config-hook=
s-directory.sh
>> new file mode 100755
>> index 0000000..556c1d3
>> --- /dev/null
>> +++ b/t/t1350-config-hooks-directory.sh
>> @@ -0,0 +1,35 @@
>> +#!/bin/sh
>> +
>> +test_description=3D'Test the core.hooksDirectory configuration vari=
able'
>> +
>> +. ./test-lib.sh
>> +
>> +test_expect_success 'set up a pre-commit hook in core.hooksDirector=
y' '
>> +     mkdir -p .git/custom-hooks .git/hooks &&
>> +     cat >.git/custom-hooks/pre-commit <<EOF &&
>> +#!$SHELL_PATH
>> +printf "%s" "." >>.git/PRE-COMMIT-HOOK-WAS-CALLED
>> +EOF
>> +     cat >.git/hooks/pre-commit <<EOF &&
>> +     chmod +x .git/hooks/pre-commit
>> +#!$SHELL_PATH
>> +printf "%s" "SHOULD NOT BE CALLED" >>.git/PRE-COMMIT-HOOK-WAS-CALLE=
D
>> +EOF
>> +     chmod +x .git/custom-hooks/pre-commit
>> +'
>
> Please use the 'write_script' helper for, well, writing scripts.

Will fix.

>> +
>> +test_expect_success 'Check that various forms of specifying core.ho=
oksDirectory work' '
>> +     test_commit no_custom_hook &&
>> +     git config core.hooksDirectory .git/custom-hooks &&
>> +     test_commit have_custom_hook &&
>> +     git config core.hooksDirectory .git/custom-hooks/ &&
>> +     test_commit have_custom_hook_trailing_slash &&
>
> These two cases ensure that it should work even when the configured
> hook directory is given as a relative path, though the docs say it
> should be an absolute path.

Yeah I didn't mention this in the docs or commit message, but I
figured not promising anything else in the docs made sense.

I.e. a relative path of e.g. .git/custom-hook/* won't work if you're
cd'd into a subdirectory of your repository, so telling users that it
has to be absolute is probably an OK white lie.

>> +     git config core.hooksDirectory "$PWD/.git/custom-hooks" &&
>> +     test_commit have_custom_hook_abs_path &&
>> +     git config core.hooksDirectory "$PWD/.git/custom-hooks/" &&
>> +     test_commit have_custom_hook_abs_path_trailing_slash &&
>> +    printf "%s" "...." >.git/PRE-COMMIT-HOOK-WAS-CALLED.expect &&
>> +    test_cmp .git/PRE-COMMIT-HOOK-WAS-CALLED.expect .git/PRE-COMMIT=
-HOOK-WAS-CALLED
>
> Indentation with spaces.

Will fix.

>> +'
>> +
>> +test_done
>> --
>> 2.1.3
