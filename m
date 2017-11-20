Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED9422036D
	for <e@80x24.org>; Mon, 20 Nov 2017 10:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751131AbdKTKoU (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 05:44:20 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:43654 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750969AbdKTKoS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 05:44:18 -0500
Received: by mail-wm0-f48.google.com with SMTP id x63so17769611wmf.2
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 02:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=RTZPK/1/AHdPPU1+JyxhIx/5fkmOa7ix9/ICmrEraqk=;
        b=DkozJLvyCx0QyXo4zOyIpcCmlTF16Z4ukHA1vV3LEPiaVcVCC8fTYKxPIHAXoOBvd+
         SMLQZ3Ia0j+zmz4shupuu+2jB62Iu0Ry9jWhu4iV4zDGlRaTCeS4AXBESE7xV0bdp+pU
         bkdjSOa6ebOQdFlYcVi/t+5+bOhM8Sy9WNJg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=RTZPK/1/AHdPPU1+JyxhIx/5fkmOa7ix9/ICmrEraqk=;
        b=QfIz334ICOojjdBeNNbFTG+hrFrKUnCjul99tXHyqjN/cZ/Qn7Xz5l41UJ1ymsddhI
         4LZ8NZhQEU1JIAKxfq0LvDM76DZ77ttncCLraHjhp7VHE5kT2Z/31dh5R5hYKJA/CxS2
         SNoxI4IR7ZaqNZoe8NVCEsXWE+lda/m/kq/jewZP3bPTv6TM3Lfba9Bv03qpSAstFA4t
         58DCikafc5UZirh09M0c8QG/FbJ5jv0XWE06tizyXObEFd32DKNU/2cKS/x6Fzmewuhg
         eEl3GMhdb3kZGNEUe3xuUGv8n/d61etMZP+LK/0jdsZR6hK4i1dR2GBBNRTr00cDgesD
         7bbw==
X-Gm-Message-State: AJaThX7pq0LNeFUJ+rqjnaQwzdbn8teETgYtCyAUJuk3q7Z5d9+EEvI3
        NBa1K/8ugfW9xv5k+Ck3z12jFj2IPGc=
X-Google-Smtp-Source: AGs4zMYbHxv9AZ/M62Je9UIonx9nJnrUOjeYYKNtSsKxHeISgWgtrFvoQSOhqz41eQE42/ifQ4eBWw==
X-Received: by 10.28.184.143 with SMTP id i137mr10517073wmf.143.1511174656731;
        Mon, 20 Nov 2017 02:44:16 -0800 (PST)
Received: from zen.linaro.local ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id 10sm12435398wml.27.2017.11.20.02.44.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Nov 2017 02:44:15 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaro.local (Postfix) with ESMTPS id 742903E00CD;
        Mon, 20 Nov 2017 10:44:15 +0000 (GMT)
References: <20171116154814.23785-1-alex.bennee@linaro.org> <CAPig+cSh0tVVkh0xF9FwCfM4gngAWMSN_FXd2zhzHcy2trYXfw@mail.gmail.com>
User-agent: mu4e 1.0-alpha2; emacs 26.0.90
From:   Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] git-send-email: fix get_maintainer.pl regression
In-reply-to: <CAPig+cSh0tVVkh0xF9FwCfM4gngAWMSN_FXd2zhzHcy2trYXfw@mail.gmail.com>
Date:   Mon, 20 Nov 2017 10:44:15 +0000
Message-ID: <87a7zhxm9s.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Eric Sunshine <sunshine@sunshineco.com> writes:

> On Thu, Nov 16, 2017 at 10:48 AM, Alex Benn=C3=A9e <alex.bennee@linaro.or=
g> wrote:
>> Getting rid of Mail::Address regressed behaviour with common
>> get_maintainer scripts such as the Linux kernel. Fix the missed corner
>> case and add a test for it.
>
> It is not at all clear, based upon this text, what this is fixing.
> When you re-roll, please provide a description of the regression in
> sufficient detail for readers to easily understand the problem and the
> solution.

How about:

Since the removal of Mail::Address from git-send-email certain addresses
common in MAINTAINERS now fail to get correctly parsed by
Git::parse_mailboxes. Specifically the patterns with embedded
parenthesis fail, for example for MAINTAINERS:

  KERNEL VIRTUAL MACHINE FOR ARM (KVM/arm)
  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
  L:	kvmarm@lists.cs.columbia.edu

Is returned by get_maintainers.pl as:

  linux-arm-kernel@lists.infradead.org (moderated list:KERNEL VIRTUAL MACHI=
NE FOR ARM (KVM/arm))
  kvmarm@lists.cs.columbia.edu (open list:KERNEL VIRTUAL MACHINE FOR ARM (K=
VM/arm))

But the parse_mailboxes code mangles the address, appending the trailing
parenthesis to the email address to the address part causing it to fail val=
idation:

   error: unable to extract a valid address from: linux-arm-kernel@lists.in=
fradead.org) (moderated list:KERNEL VIRTUAL MACHINE FOR ARM (KVM/arm)
   error: unable to extract a valid address from: kvmarm@lists.cs.columbia.=
edu) (open list:KERNEL VIRTUAL MACHINE FOR ARM (KVM/arm)

As this is a common pattern which was handled by Mail::Address I've
fixed the regression by explicitly capturing a trailing bracket and
appending it to the comment token.

>
> More below...
>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>> diff --git a/t/t9000/test.pl b/t/t9000/test.pl
>> @@ -35,7 +35,9 @@ my @success_list =3D (q[Jane],
>>         q['Jane 'Doe' <jdoe@example.com>],
>>         q[Jane@:;\.,()<>Doe <jdoe@example.com>],
>>         q[Jane <jdoe@example.com> Doe],
>> -       q[<jdoe@example.com> Jane Doe]);
>> +       q[<jdoe@example.com> Jane Doe],
>> +       q[jdoe@example.com (open list:for thing (foo/bar))],
>> +    );
>
> Style nit: The dangling ");" introduced by this change differs from
> the other list(s) in this file which have the closing ");" on the same
> line as the last item in the list.
>
>> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
>> +test_expect_success $PREREQ 'setup get_mainter script for cc trailer' "
>> +cat >expected-cc-script.sh <<-EOF && chmod +x expected-cc-script.sh
>> +#!/bin/sh
>> +echo 'One Person <one@example.com> (supporter:THIS (FOO/bar))'
>> +echo 'Two Person <two@example.com> (maintainer:THIS THING)'
>> +echo 'Third List <three@example.com> (moderated list:THIS THING (FOO/ba=
r))'
>> +echo '<four@example.com> (moderated list:FOR THING)'
>> +echo 'five@example.com (open list:FOR THING (FOO/bar))'
>> +echo 'six@example.com (open list)'
>> +EOF
>> +"
>
> Use write_script() to create the script:

Thanks for the pointers, I'll fix it up.

I missed the existence of write_script.sh while I scanned through
t/README, perhaps a stanza in in "Test harness library":

 - write_script <name> <<-\EOF && <rest of test>
   echo '...'
   ...
   EOF

   The write_script helper takes care of ensuring the created helper
   script has the right shebang and is executable.

?

>
> --- 8< ---
> write_script expected-cc-script.sh <<-\EOF &&
> echo '...'
> ...
> EOF
> --- 8< ---
>
> No need for #!/bin/sh or chmod, both of which are handled by
> write_script(). In fact, you could fold this into the following test
> (since there doesn't seem a good reason for it to be separate).
>
>> +test_expect_success $PREREQ 'cc trailer with get_maintainer output' '
>> +       test_commit cc-trailer &&
>> +       clean_fake_sendmail &&
>> +       git send-email -1 --to=3Drecipient@example.com \
>> +               --cc-cmd=3D"$(pwd)/expected-cc-script.sh" \
>> +               --smtp-server=3D"$(pwd)/fake.sendmail" &&
>> +       test_cmp expected-cc commandline1
>> +'
>> OK I'm afraid I don't fully understand the test harness as this breaks a
>> bunch of other tests. If anyone can offer some pointers on how to fix
>> I'd be grateful.
>
> There are several problems:
>
> * test_commit bombs because there is already a tag named "cc-trailer"
> created by an earlier test. Fix this by choosing a different name for
> the commit. Even better would be to avoid making the commit in the
> first place since it doesn't appear to be relevant to the test, and
> the test works fine without it.

Ahh that makes sense. Again perhaps in the t/README "Keep in mind:"

 - All the tests in a given test file run sequentially and share
   repository state. This means you should take care not to break
   assumptions of later tests as to which commits exist in the test
   repository.

?

>
> * The directory in which the expected-cc-script.sh is created contains
> a space; this is intentional to catch bugs in tests and Git itself. In
> this case, your test is exposing what might be considered a bug in
> git-send-email itself, in which it invokes the --cc-cmd as "/path/with
> space/expected-cc-script.sh", which is interpreted as trying to invoke
> program "/path/with" with argument "space/expected-cc-script.sh". One
> fix (which you could submit as a preparatory patch, making this a
> 2-patch series) would be this:
>
> --- 8< ---
> diff --git a/git-send-email.perl b/git-send-email.perl
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1724,7 +1724,7 @@ sub recipients_cmd {
>     my ($prefix, $what, $cmd, $file) =3D @_;
>
>      my @addresses =3D ();
> -    open my $fh, "-|", "$cmd \Q$file\E"
> +   open my $fh, "-|", "\Q$cmd\E \Q$file\E"
>      or die sprintf(__("(%s) Could not execute '%s'"), $prefix, $cmd);
>      while (my $address =3D <$fh>) {
>           $address =3D~ s/^\s*//g;
> --- 8< ---
>
> However, it's possible that might break existing users who rely on
> --cc-cmd=3D"myscript --option arg" working. It's not clear which
> behavior is correct.
>
> * Subsequent tests fail because you've added a commit which they are
> not expecting. If you look at tests earlier in the file, you will see
> that they deal with this by removing the added commit (via "git reset
> --hard HEAD^") by the time the test finishes. However, as noted above,
> this new test doesn't actually need to make this commit in the first
> place.
>
> So, with fixes, your test might look like this:
>
> --- 8< ---
> test_expect_success $PREREQ 'cc trailer with get_maintainer output' '
>     test_commit cc-trailer-get-maintainer &&
>     test_when_finished "git reset --hard HEAD^" &&
>     clean_fake_sendmail &&
>     git send-email -1 --to=3Drecipient@example.com \
>         --cc-cmd=3D"$(pwd)/expected-cc-script.sh" \
>         --smtp-server=3D"$(pwd)/fake.sendmail" &&
>     test_cmp expected-cc commandline1
> '
> --- 8< ---
>
> Or, if you drop the unnecessary test_commit():
>
> --- 8< ---
> test_expect_success $PREREQ 'cc trailer with get_maintainer output' '
>     clean_fake_sendmail &&
>     git send-email -1 --to=3Drecipient@example.com \
>         --cc-cmd=3D"$(pwd)/expected-cc-script.sh" \
>         --smtp-server=3D"$(pwd)/fake.sendmail" &&
>     test_cmp expected-cc commandline1
> '
> --- 8< ---

Thanks for the comments. v2 being rolled ;-)

--
Alex Benn=C3=A9e
