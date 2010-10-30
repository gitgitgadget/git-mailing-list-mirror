From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Buglet in i18n?
Date: Sat, 30 Oct 2010 09:14:26 +0000
Message-ID: <AANLkTikOgMGqw5fc95c2VGwXxKu9rmsA+=z5_jykD92=@mail.gmail.com>
References: <4CC13AC1.7080402@viscovery.net>
	<AANLkTimqzmPLCj=JeSGWFcY829gxct9ANGt+CCjB2jy=@mail.gmail.com>
	<20101022083450.GA8289@burratino>
	<AANLkTi=Q91mQ9ucLZw1E+1MuA+niXJFvmx1xw8JVYuuH@mail.gmail.com>
	<20101023182940.GD21040@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 30 11:15:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PC7X3-0007uh-GT
	for gcvg-git-2@lo.gmane.org; Sat, 30 Oct 2010 11:15:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751967Ab0J3JOa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Oct 2010 05:14:30 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58381 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103Ab0J3JO2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Oct 2010 05:14:28 -0400
Received: by fxm16 with SMTP id 16so3772487fxm.19
        for <git@vger.kernel.org>; Sat, 30 Oct 2010 02:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=bvk7EcuG7d6fTDU6batevhKgJyE4sqV5NbhqIsk1f5U=;
        b=OAi9yqVF713+12ONLLnRU2L6QzrGQpSxsP3MSSrTdTzOz4/XVlj5VERKCMTLfPmfTI
         t7BKNKHUbbehlSQe7ANLeAvwv11gGyDzLSPDCdnAeL/kATuJgBqEUZs2ss+pXB0VKNdV
         WR+hfgb9nNHAZ1vUrCg8b6qiS96lGuLIiIuYI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=PRvStzjlOwP50T7lKM+11zwEAubpcxQtq0UaXAV41T5fbI8kP8UzUwJaStIakJvh4E
         5F4h0nyv5bB5jA/UdwpemmTYiYVd1FkQhzAwgQMFt960mSNoRdiNstTX02DbdkiiLtqY
         yoqgdWwFZ+fuwkXBYwyaskaHiGscKlUsjYob0=
Received: by 10.223.115.203 with SMTP id j11mr426843faq.35.1288430067042; Sat,
 30 Oct 2010 02:14:27 -0700 (PDT)
Received: by 10.223.123.203 with HTTP; Sat, 30 Oct 2010 02:14:26 -0700 (PDT)
In-Reply-To: <20101023182940.GD21040@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160396>

On Sat, Oct 23, 2010 at 18:29, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Fri, Oct 22, 2010 at 08:34, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
>
>>> Now eval_gettext is supposed to just interpolate $variable
>>> substitutions, right? =C2=A0In particular, the quotation marks
>>> ought to be preserved.
> [...]
>> That prints:
>>
>> =C2=A0 =C2=A0 foo "bar baz"
>>
>> (with double quotes)
>>
>> But what we want is:
>>
>> =C2=A0 =C2=A0 foo bar baz
> [...]
>> Have I got that right
>
> No, I don't think so. =C2=A0Checking /usr/bin/gettext.sh, I see that =
it
> uses envsubst:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# Note: This use of envsubst is much safer=
 than using the shell built-in 'eval'
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# would be.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# 1) The security problem with Chinese tra=
nslations that happen to use a
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# =C2=A0 =C2=A0character such as \xe0\x60 =
is avoided.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# 2) The security problem with malevolent =
translators who put in command lists
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# =C2=A0 =C2=A0like "$(...)" or "`...`" is=
 avoided.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# 3) The translations can only refer to sh=
ell variables that are already
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# =C2=A0 =C2=A0mentioned in MSGID or MSGID=
-PLURAL.
>
> And:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0; echo '"foo"' | envsubst
> =C2=A0 =C2=A0 =C2=A0 =C2=A0"foo"
>
> envsubst(1) has more details.
>
> The idea: translators do not have to worry about quoting at all.
> $var is presumably rare enough in messages as to not matter.
>
> One problem with my mockup: it makes it hard to talk about $5.00
> solutions, unlike envsubst:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0; echo '$3.00' | envsubst
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$3.00

Sorry for the late reply. Yes, envsubst is the way to go. What I'm
going to do when I get around to it is to pull (the GPLv2 version of)
envsubst out of gettext.git and modify it to be a minimal
git-sh-i18n--helper command.

Then just do:

    diff --git a/git-sh-i18n.sh b/git-sh-i18n.sh
    index f8dd43a..c65f9ec 100644
    --- a/git-sh-i18n.sh
    +++ b/git-sh-i18n.sh
    @@ -55,8 +55,7 @@ then
                    }

                    eval_gettext () {
    -                       gettext_eval=3D"printf '%s' \"$1\""
    -                       printf "%s" "`eval \"$gettext_eval\"`"
    +                       printf "%s" "$1" | git-sh-i18n--helper envs=
ubst
                    }
            fi
     else

Along with this test:

    commit 42f2eabad4434875f3dd123844461ccfc4ad220b
    Author: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
    Date:   Sat Oct 30 08:59:51 2010 +0000

        t/t0201-gettext-fallbacks.sh: test for broken eval_gettext

        Add a test for the broken eval_gettext() variable interpolation
        behavior.

        Reported-by: Johannes Sixt <j.sixt@viscovery.net>
        Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@g=
mail.com>

    diff --git a/t/t0201-gettext-fallbacks.sh b/t/t0201-gettext-fallbac=
ks.sh
    index 7a85d9b..682c602 100755
    --- a/t/t0201-gettext-fallbacks.sh
    +++ b/t/t0201-gettext-fallbacks.sh
    @@ -46,4 +46,27 @@ test_expect_success NO_GETTEXT_POISON
'eval_gettext: our eval_gettext() fallback
         test_cmp expect actual
     '

    +test_expect_success NO_GETTEXT_POISON 'eval_gettext: our
eval_gettext() fallback can interpolate whitespace variables' '
    +    git_am_cmdline=3D"git am" &&
    +    export git_am_cmdline &&
    +    printf "test git am" >expect &&
    +    eval_gettext "test \$git_am_cmdline" >actual &&
    +    test_cmp expect actual
    +'
    +
    +test_expect_success NO_GETTEXT_POISON 'eval_gettext: git am $cmdli=
ne bug' '
    +    cmdline=3D"git am -3" &&
    +    export cmdline &&
    +    cat >expect <<EOF &&
    +When you have resolved this problem run "git am -3 --resolved".
    +If you would prefer to skip this patch, instead run "git am -3 --s=
kip".
    +To restore the original branch and stop patching run "git am -3 --=
abort".
    +EOF
    +    eval_gettext "When you have resolved this problem run
\"\$cmdline --resolved\".
    +If you would prefer to skip this patch, instead run \"\$cmdline --=
skip\".
    +To restore the original branch and stop patching run \"\$cmdline
--abort\"." >actual &&
    +    echo >>actual &&
    +    test_cmp expect actual
    +'
    +
     test_done

The latter of which starts passing with envsubst.
