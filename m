From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 3/4 v2] Allow detached form (e.g. "git log --grep foo") in 
	log options.
Date: Wed, 28 Jul 2010 12:56:49 +0000
Message-ID: <AANLkTi=TRzn-QWduEYH7qO-4=a-nGqCGSMkZCGn2iB=W@mail.gmail.com>
References: <vpqr5ioukca.fsf@bauges.imag.fr>
	<1280310062-16793-3-git-send-email-Matthieu.Moy@imag.fr>
	<AANLkTikzL-sgysKD+0CZ100xHWZro=-hDgDgUL2Pb3yw@mail.gmail.com>
	<vpq8w4vhmkj.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jul 28 14:57:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oe6C3-0002Ew-FN
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 14:57:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772Ab0G1M4v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jul 2010 08:56:51 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46342 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158Ab0G1M4u convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jul 2010 08:56:50 -0400
Received: by iwn7 with SMTP id 7so4819955iwn.19
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 05:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Mko1dMS+sWkQAf5w3BItTkyoj//91yQy/zJDdsykB2U=;
        b=mj9QzRjfGzrugr5nliqON8Rwx/3H+sI9yXWm4Zhp/JVX0V8cwheGCWO3XG0+R5j3Ig
         oGP/c39VsDANwPhK2j34x7ofcNR6eRK/LYPT2mQv/yRzadEOsuXNkqyFzNox0guYpL2E
         eys0ggqx5FvR2J2OOSQqExxmd5ZNYM2ie8uoA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SvcbaGZFiphpr+mc/fpl8PhNX/4/dAStVk/8jmolKS/LMNU3mnbD5xBrAUnXzZuXEC
         P+pvhr+o5OsPBCP+fK2LuQZZnDB48NJF/OwcVJmRpIMXZFdw6goa1a4+R39/B/3UOu8R
         ZtAIT7czqSl65MqX1B7Xf1p5GaLLYW5bQ9PsM=
Received: by 10.231.191.6 with SMTP id dk6mr12059472ibb.51.1280321809936; Wed, 
	28 Jul 2010 05:56:49 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Wed, 28 Jul 2010 05:56:49 -0700 (PDT)
In-Reply-To: <vpq8w4vhmkj.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152080>

On Wed, Jul 28, 2010 at 11:29, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Wed, Jul 28, 2010 at 09:41, Matthieu Moy <Matthieu.Moy@imag.fr> w=
rote:
>>
>> Here's a better commit message, the subject was >50 chars> (see
>> Documentation/SubmittingPatches):
>
> I don't see a mention of 50 chars there. Conventions usually limit
> lines to <80 chars (sometimes 72), and my subject line is 64
> chars-wide if you don't count [PATCH], which won't end up in git.git.

Hrm, I thought it was explicitly mentioned there, but it says:

	- the first line of the commit message should be a short
	  description and should skip the full stop

Since your patch subject had a full stop I thought I'd mention it.

DISCUSSION in git-commit(1) and gittutorial(7) mention 50 characters
explicitly though, and a lot of tools that present commits in short
form use that as a soft limit, e.g. gitweb and github.

I'll submit a patch to SubmittingPatches citing the 50 char soft
limit.

>>> +test_expect_success 'log --grep option parsing' '
>>> + =C2=A0 =C2=A0 =C2=A0 echo second >expect &&
>>> + =C2=A0 =C2=A0 =C2=A0 git log -1 --pretty=3D"tformat:%s" --grep se=
c >actual &&
>>> + =C2=A0 =C2=A0 =C2=A0 test_cmp expect actual &&
>>> + =C2=A0 =C2=A0 =C2=A0 test_must_fail git log -1 --pretty=3D"tforma=
t:%s" --grep
>>> +'
>>
>> There's a lot of behavior change in this series, but only two small
>> tests that I can see.
>
> 4, not 2.

I only saw two test_expect_success additions in your v2 series, maybe
I missed one.

>> It would be easy to change the parsing code back without triggering
>> a regression test.
>
> I've introduced a test for each pattern, but deliberately did not do
> exhaustive testing: I'm testing the patterns, not the way they are
> applied. In the same way, I don't think there's a testcase for each
> use of parse-option in the testsuite.

Not for everything it seems, but the coverage is pretty good:

    http://v.nix.is/~avar/cover_db_html/parse-options-c.html
    http://v.nix.is/~avar/cover_db_html/test-parse-options-c.html

Anyway. Regression tests can be added later, and I think this series
is good enough for inclusion as-is. But option parsing has been a
moving target in Git for a while now, and it's quite likely that this
code will get rewritten down the line to use a new library that can
parse all of Git's option syntax.

More tests coverage would be valuable for catching regressions in such
future rewrites. In general that's the main value, not making sure
*your* code works, but that someone else doesn't break it.

Anyway, here's how you can easily get almost complete coverage at
almost no cost for this series, first make a t/lib-log.sh like this:

    #!/bin/sh

    log_expect_success() {
        desc=3D$1
        text=3D$2
        test_expect_success "Phony test with attached options: $1" "$2"
        mocked=3D$(echo "$2" | sed -r 's/([A-Za-z-]+)=3D/\1 /')
        test_expect_success "Phony test with detached options: $1" "$mo=
cked"
    }

Then just change the t4*log*.sh tests that aren't doing setup work
(like git init) to use it:

    diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-for=
mats.sh
    index cb9f2bd..7ccc4bb 100755
    --- a/t/t4205-log-pretty-formats.sh
    +++ b/t/t4205-log-pretty-formats.sh
    @@ -20 +20 @@ test_expect_success 'set up basic repos' '
    -test_expect_success 'alias builtin format' '
    +log_expect_success 'alias builtin format' '

We'll be running tests twice, but it'll catch these at least:

    $ ack -h -i '(--[a-z-]+=3D)' --output '$1' t4*log*.sh | sort | uniq
    --abbrev=3D
    --author=3D
    --color=3D
    --decorate=3D
    --diff-filter=3D
    --format=3D
    --grep=3D
    --pretty=3D

I can submit something like that later if I get around to it, or you
can include it in your series if you want.
