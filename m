Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69C832036D
	for <e@80x24.org>; Sun, 19 Nov 2017 03:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750862AbdKSCys (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Nov 2017 21:54:48 -0500
Received: from mail-qt0-f181.google.com ([209.85.216.181]:40542 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750765AbdKSCyr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Nov 2017 21:54:47 -0500
Received: by mail-qt0-f181.google.com with SMTP id u42so11193981qte.7
        for <git@vger.kernel.org>; Sat, 18 Nov 2017 18:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=h6RtmMQb1GHohv0I81QThchavPeX1/zlg0XPGOcrtNw=;
        b=GRWPrZxEpVCZJn2aSMORl4Su/HZlAe8gPxWaJfgY8AXYTexmPZj/ZeKIXzGzSepJ8M
         7QeLCiDg98opzQRAcyJkJln59bHn+WqxtQjqaARtAsN5bC2xiTNb5PuRlo8qNGx+VX0c
         5JTyX4s490Bun5qeqQ4gXpWO+lv5p3FASIFmcF3dooi7Y6gWIsvsntIfCBQJmMMIwBlg
         7+T5sls+joIusVUaDMeeInOH8iGm0amXonzaF36B+JF5l/oKX34EfQ84/BFcmLORg0kr
         Vcx2W/GqQMJs6zIC3kTun3DHZPHgve6yatCHhPMYkxTh3Eo/wcd+/lHqNoyJ59Jm1J/o
         sq0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=h6RtmMQb1GHohv0I81QThchavPeX1/zlg0XPGOcrtNw=;
        b=qNNVLx4dTVMJvy5fPIZvqFq946v9vNq8lnAoRbRDL9fIHFaXoAB3wXUTA/3I6H4u8A
         ABjXFPVeonxEWBY7+NdLst4jk7feki100FBl43UaicL2zrFfabs8jHP3x7iO4gCeKAPA
         NAY7UYr5wXO/rUlrwt+sy31TCorV/CxNGnO7jHVoZU6j+AHw88RphZ9aHEr2Elkbp3sZ
         SWLQuap50S8LXkFBcjlf1dgY+8d7KzYXGEI936Zj1erbZsqoyhuF9xJbhB/ILbhkyej+
         cVmzZAsvpFrdeCPDyS+H3Ohfl/2VM99wRKe8HvDFZpqnvhEtVkOmVcRxb/vISkrmtctY
         g2oQ==
X-Gm-Message-State: AJaThX4JuFr9ZSFrFCeKrUmplrRPVufxKqeC0crQWsUIq/nwjNm9U11y
        fQnAYLD2gX3EeGMyAqnQFPUn0VvuRp+owKGLT7E=
X-Google-Smtp-Source: AGs4zMYqKQ3b8i70HLcOJiJRTkDshtyi+YuvyO9NNwmE/2FA9ljccCCm+rA0UXu/aUt6844c49gQ2JPis0xGxIztsVw=
X-Received: by 10.237.37.47 with SMTP id v44mr16383403qtc.55.1511060086637;
 Sat, 18 Nov 2017 18:54:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.155.209 with HTTP; Sat, 18 Nov 2017 18:54:46 -0800 (PST)
In-Reply-To: <20171116154814.23785-1-alex.bennee@linaro.org>
References: <20171116154814.23785-1-alex.bennee@linaro.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 18 Nov 2017 21:54:46 -0500
X-Google-Sender-Auth: l3XROHhuTxiSghcpn_1FSXnxx1c
Message-ID: <CAPig+cSh0tVVkh0xF9FwCfM4gngAWMSN_FXd2zhzHcy2trYXfw@mail.gmail.com>
Subject: Re: [PATCH] git-send-email: fix get_maintainer.pl regression
To:     =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 16, 2017 at 10:48 AM, Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
> Getting rid of Mail::Address regressed behaviour with common
> get_maintainer scripts such as the Linux kernel. Fix the missed corner
> case and add a test for it.

It is not at all clear, based upon this text, what this is fixing.
When you re-roll, please provide a description of the regression in
sufficient detail for readers to easily understand the problem and the
solution.

More below...

> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
> diff --git a/t/t9000/test.pl b/t/t9000/test.pl
> @@ -35,7 +35,9 @@ my @success_list =3D (q[Jane],
>         q['Jane 'Doe' <jdoe@example.com>],
>         q[Jane@:;\.,()<>Doe <jdoe@example.com>],
>         q[Jane <jdoe@example.com> Doe],
> -       q[<jdoe@example.com> Jane Doe]);
> +       q[<jdoe@example.com> Jane Doe],
> +       q[jdoe@example.com (open list:for thing (foo/bar))],
> +    );

Style nit: The dangling ");" introduced by this change differs from
the other list(s) in this file which have the closing ");" on the same
line as the last item in the list.

> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
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

Use write_script() to create the script:

--- 8< ---
write_script expected-cc-script.sh <<-\EOF &&
echo '...'
...
EOF
--- 8< ---

No need for #!/bin/sh or chmod, both of which are handled by
write_script(). In fact, you could fold this into the following test
(since there doesn't seem a good reason for it to be separate).

> +test_expect_success $PREREQ 'cc trailer with get_maintainer output' '
> +       test_commit cc-trailer &&
> +       clean_fake_sendmail &&
> +       git send-email -1 --to=3Drecipient@example.com \
> +               --cc-cmd=3D"$(pwd)/expected-cc-script.sh" \
> +               --smtp-server=3D"$(pwd)/fake.sendmail" &&
> +       test_cmp expected-cc commandline1
> +'
> OK I'm afraid I don't fully understand the test harness as this breaks a
> bunch of other tests. If anyone can offer some pointers on how to fix
> I'd be grateful.

There are several problems:

* test_commit bombs because there is already a tag named "cc-trailer"
created by an earlier test. Fix this by choosing a different name for
the commit. Even better would be to avoid making the commit in the
first place since it doesn't appear to be relevant to the test, and
the test works fine without it.

* The directory in which the expected-cc-script.sh is created contains
a space; this is intentional to catch bugs in tests and Git itself. In
this case, your test is exposing what might be considered a bug in
git-send-email itself, in which it invokes the --cc-cmd as "/path/with
space/expected-cc-script.sh", which is interpreted as trying to invoke
program "/path/with" with argument "space/expected-cc-script.sh". One
fix (which you could submit as a preparatory patch, making this a
2-patch series) would be this:

--- 8< ---
diff --git a/git-send-email.perl b/git-send-email.perl
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1724,7 +1724,7 @@ sub recipients_cmd {
    my ($prefix, $what, $cmd, $file) =3D @_;

     my @addresses =3D ();
-    open my $fh, "-|", "$cmd \Q$file\E"
+   open my $fh, "-|", "\Q$cmd\E \Q$file\E"
     or die sprintf(__("(%s) Could not execute '%s'"), $prefix, $cmd);
     while (my $address =3D <$fh>) {
          $address =3D~ s/^\s*//g;
--- 8< ---

However, it's possible that might break existing users who rely on
--cc-cmd=3D"myscript --option arg" working. It's not clear which
behavior is correct.

* Subsequent tests fail because you've added a commit which they are
not expecting. If you look at tests earlier in the file, you will see
that they deal with this by removing the added commit (via "git reset
--hard HEAD^") by the time the test finishes. However, as noted above,
this new test doesn't actually need to make this commit in the first
place.

So, with fixes, your test might look like this:

--- 8< ---
test_expect_success $PREREQ 'cc trailer with get_maintainer output' '
    test_commit cc-trailer-get-maintainer &&
    test_when_finished "git reset --hard HEAD^" &&
    clean_fake_sendmail &&
    git send-email -1 --to=3Drecipient@example.com \
        --cc-cmd=3D"$(pwd)/expected-cc-script.sh" \
        --smtp-server=3D"$(pwd)/fake.sendmail" &&
    test_cmp expected-cc commandline1
'
--- 8< ---

Or, if you drop the unnecessary test_commit():

--- 8< ---
test_expect_success $PREREQ 'cc trailer with get_maintainer output' '
    clean_fake_sendmail &&
    git send-email -1 --to=3Drecipient@example.com \
        --cc-cmd=3D"$(pwd)/expected-cc-script.sh" \
        --smtp-server=3D"$(pwd)/fake.sendmail" &&
    test_cmp expected-cc commandline1
'
--- 8< ---
