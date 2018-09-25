Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D92601F453
	for <e@80x24.org>; Tue, 25 Sep 2018 21:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbeIZEH7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 00:07:59 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42853 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725732AbeIZEH7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 00:07:59 -0400
Received: by mail-oi1-f194.google.com with SMTP id v198-v6so2813885oif.9
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 14:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=A7SnPxO4+LanHKDYyIB+VSFLgfj6rTTmoVcm4phNkSk=;
        b=TpdORDASnDptaDRtiphsJB84VB0eDpX4zoKsexprjqx/HF8SVuJvR+e7MNVWzj5ep3
         OxCr3mb8BxXiRIWOkgUMEHa/RSA0e/scgyjEUXN/VYHHEzla2lTZ2yGIhop3XB1YJ9uF
         7Cx7DstXBpPaRtD8LPtCbgW74Od3ksctxzmXex7MSRax/Vqq+tCZeUYQFgioxyPhTFLu
         /nU8JQHXoqhgSJ/MIJHwkiti5/OnM2NjjsN9dRmynGHADC4k9xKAwVqSon3xAFt9Je22
         x15hLpR23OxNX79c0TzCUET0P9uXDym/XN6FA2oewDl9i06aDRa3Mo6/rmqyMcKdmJ30
         3MzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=A7SnPxO4+LanHKDYyIB+VSFLgfj6rTTmoVcm4phNkSk=;
        b=ICqpKJVpwyr+B8GEvM8c1oMMA2DWfUgn9Ia4ZJmg5NfMqV4/NcYk3dECtS3Fr/RotI
         sd0VkkbDk3+woXKsRpBYCZiXc7WTycj99wuxvm9VrWlwHaOiKysaHzp+KD2G8WyAY8LG
         Xeah/sQHBi5Mv3nPY9npNlf4yZ0V4ji9KRFVfB0Z1ErQRt/KwS1Dm5DXM9tYc8mlV6Rp
         QY5mwEae9CutizaSSdArLuV2x/PncnMU9NNDZftlc+E1arWWR0R3CCESalvk7ZDOdfAJ
         3bayTAOBbFk27HX9s9fW+c4Ly/dRHu/9NA55tMk6b7oACyGjE53E/sNBPVXhZEAqXJOB
         IXeg==
X-Gm-Message-State: ABuFfohiFIYgLPpMKpPZyv5N16CrLMLg5TTWgCePIn03/smbY34gihqP
        1kEAmHK+g2a+SO+iCNSQtAcSujOT3j9wntz1wVRm
X-Google-Smtp-Source: ACcGV62+CTU+H/A2/xaQXQIINsYHfcDNLwk991VglF3uzasJc4EEQU3bn4fqy9/qvsCL0eOwoug+lNRC7K3+y+z7pSo=
X-Received: by 2002:aca:b208:: with SMTP id b8-v6mr97712oif.144.1537912701253;
 Tue, 25 Sep 2018 14:58:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536969438.git.matvore@google.com> <cover.1537493611.git.matvore@google.com>
 <7dd9a1120726dee34aeebdfa4bf45a232c185500.1537493611.git.matvore@google.com> <20180924210314.GE27036@localhost>
In-Reply-To: <20180924210314.GE27036@localhost>
From:   Matthew DeVore <matvore@google.com>
Date:   Tue, 25 Sep 2018 14:58:08 -0700
Message-ID: <CAMfpvhJ-chi7OMRKjjk79r0uqCqW67Vj9J=tT7Kz-XUmw41H5A@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] CodingGuidelines: add shell piping guidelines
To:     szeder.dev@gmail.com
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrn@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 24, 2018 at 2:03 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
> > + - In a piped chain such as "grep blob objects | sort", the exit codes
>
> Let's make an example with git in it, e.g. something like this:
>
>   git cmd | grep important | sort
>
> since just two lines below the new text mentions git crashing.
Done.

> > + - The $(git ...) construct also discards git's exit code, so if the
>
> This contruct is called command substitution, and it does preserve the
> command's exit code, when the expanded text is assigned to a variable:
>
>   $ var=3D$(exit 42) ; echo $?
>   42
>
> Note, however, that even in that case only the exit code of the last
> command substitution is preserved:
>
>   $ var=3D$(exit 1)foo$(exit 2)bar$(exit 3) ; echo $?
>   3
>
OK, I've changed this guideline to allow for setting a variable with
command substitution, but not in other contexts. It's worded
sufficiently openly such that your latter example will be forbidden.

> > +   goal is to test that particular command, redirect its output to a
> > +   temporary file rather than wrap it with $( ).
>
> I find this a bit vague, and to me it implies that ignoring the exit
> code of a git command that is not the main focus of the given test is
> acceptable, e.g. (made up pseudo example):
>
>   test_expect_success 'fetch gets what it should' '
>     git fetch $remote &&
>     test "$(git rev-parse just-fetched)" =3D $expected_oid
>   '
>
> In my opinion no tests should ignore the exit code of any git
> command, ever.

This seems like a pretty strong assertion, but something very similar
is written in t/README (in the "don't" section):

 - use '! git cmd' when you want to make sure the git command exits
   with failure in a controlled way by calling "die()".  Instead,
   use 'test_must_fail git cmd'.  This will signal a failure if git
   dies in an unexpected way (e.g. segfault).

So I've changed this to basically say you should never ignore git's exit co=
de.

Here is the new commit with updated message (I will wait for a day or
two before I send a reroll):

    Documentation: add shell guidelines

    Add the following guideline to Documentation/CodingGuidelines:

            &&, ||, and | should appear at the end of lines, not the
            beginning, and the \ line continuation character should be
            omitted

    And the following to t/README (since it is specific to writing tests):

            pipes and $(git ...) should be avoided when they swallow exit
            codes of Git processes

    Signed-off-by: Matthew DeVore <matvore@google.com>

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuideline=
s
index 48aa4edfb..3d2cfea9b 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -118,6 +118,24 @@ For shell scripts specifically (not exhaustive):
                 do this
         fi

+ - If a command sequence joined with && or || or | spans multiple
+   lines, put each command on a separate line and put && and || and |
+   operators at the end of each line, rather than the start. This
+   means you don't need to use \ to join lines, since the above
+   operators imply the sequence isn't finished.
+
+        (incorrect)
+        grep blob verify_pack_result \
+        | awk -f print_1.awk \
+        | sort >actual &&
+        ...
+
+        (correct)
+        grep blob verify_pack_result |
+        awk -f print_1.awk |
+        sort >actual &&
+        ...
+
  - We prefer "test" over "[ ... ]".

  - We do not write the noiseword "function" in front of shell
@@ -163,7 +181,6 @@ For shell scripts specifically (not exhaustive):

    does not have such a problem.

-
 For C programs:

  - We use tabs to indent, and interpret tabs as taking up to
diff --git a/t/README b/t/README
index 9028b47d9..3e28b72c4 100644
--- a/t/README
+++ b/t/README
@@ -461,6 +461,32 @@ Don't:
    platform commands; just use '! cmd'.  We are not in the business
    of verifying that the world given to us sanely works.

+ - Use Git upstream in the non-final position in a piped chain, as in:
+
+     git -C repo ls-files |
+     xargs -n 1 basename |
+     grep foo
+
+   which will discard git's exit code and may mask a crash. In the
+   above example, all exit codes are ignored except grep's.
+
+   Instead, write the output of that command to a temporary
+   file with ">" or assign it to a variable with "x=3D$(git ...)" rather
+   than pipe it.
+
+ - Use command substitution in a way that discards git's exit code.
+   When assigning to a variable, the exit code is not discarded, e.g.:
+
+     x=3D$(git cat-file -p $sha) &&
+     ...
+
+   is OK because a crash in "git cat-file" will cause the "&&" chain
+   to fail, but:
+
+     test_cmp expect $(git cat-file -p $sha)
+
+   is not OK and a crash in git could go undetected.
+
  - use perl without spelling it as "$PERL_PATH". This is to help our
    friends on Windows where the platform Perl often adds CR before
    the end of line, and they bundle Git with a version of Perl that


>
>
> These last two points, however, are specific to test scripts,
> therefore I think they would be better placed in 't/README', where the
> rest of the test-specific guidelines are.
>
> >  For C programs:
> >
> > --
> > 2.19.0.444.g18242da7ef-goog
> >
