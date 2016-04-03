From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 5/5] t/t5520: test --[no-]autostash with pull.rebase=true
Date: Sun, 3 Apr 2016 15:28:04 -0400
Message-ID: <CAPig+cSR9Um5FUWzkzHGAM5RanaKssAysA5hGOP4+E5oA0Y5oA@mail.gmail.com>
References: <1459258200-32444-1-git-send-email-mehul.jain2029@gmail.com>
	<1459258200-32444-6-git-send-email-mehul.jain2029@gmail.com>
	<CAPig+cQ93+dCqJMRcQYSRHLDuYtwkeK_aSrfv2=2=g7ZhO85TQ@mail.gmail.com>
	<CA+DCAeQPr2vxvm6MKiOLpDtmpC2d=RcvYhuFeimSn+xX2TAvtQ@mail.gmail.com>
	<CAPig+cQyHu1J=FYOtgsmi3ghuN7YyjNgAz-VgO06isfrS+kUSg@mail.gmail.com>
	<CA+DCAeT1DQvHnRpJeApcm2vO6KhXaMaRXZg9HCUmiiBv=hfxzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 03 21:28:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amngy-0002YV-IW
	for gcvg-git-2@plane.gmane.org; Sun, 03 Apr 2016 21:28:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752748AbcDCT2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2016 15:28:07 -0400
Received: from mail-ig0-f196.google.com ([209.85.213.196]:33176 "EHLO
	mail-ig0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752485AbcDCT2G (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2016 15:28:06 -0400
Received: by mail-ig0-f196.google.com with SMTP id nt3so10489180igb.0
        for <git@vger.kernel.org>; Sun, 03 Apr 2016 12:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=0ZpwMFm1SXqDtNwLtAUHJtCRPf26X+dgnv9ZRIhcVi0=;
        b=GTG8QRcMTy51E6ifXGGfD1EoWQKm3vyxS/DVSint4+/r5ftjrfwCVtiIp8NfYGnOWA
         yCstrx027Vs38YUGNSk3D3ouOJdQdDYEd4/TmT7tuVJKNGeRr/aR6nkRHdu11w06gpsY
         CtzwWE4aTmHrRpqT/fCrlhb06qKyLSWvjTVIxfYQVD5T2I+Jes7J5d1m173pKZoU6CiU
         t5tuPZujLjzeqd333YS9fDaMQXRXMQCosRH1m4ZJRaAJUKjm/aBao/1NhuCs5fWDIf5s
         vpHTTgvHw3HEgO9CiKuxFFCQunwsD7Pc6xZdGXeQQgEyF2Yurkw+CjUrhAt6/T5iLAdf
         qs7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=0ZpwMFm1SXqDtNwLtAUHJtCRPf26X+dgnv9ZRIhcVi0=;
        b=AL0CkWS4yj+oulBW0R9frcGwMKyJy66bHtClxc+IByv3hEoddi0eQU9qLEXwwCjGnX
         yac/oVnjn76NkiiPPLLC8PfjKxS2rjiZMzpdgO0ocaF5gToGgu5e9tBGzN4+Rxve7X6/
         6TiKrLpchilKmo5/FixM6vqiVEbx05hnDwNxVq4vJ92hu6F1mzKZ1jXqZ9Lj9RnikSg9
         w8HaVTfcp6dzt8lkqopxWe6BOL7BrjjWCgvVqwOEVA2grldS78FZI/IaTa4aOHcQ3NA0
         BLPRducm6LOzt1I1oiuSV9Vd9MzZ6ruSLlmBJCI0tqvKa+zt5v13h9iMQ75EiN6yBu8T
         LL3w==
X-Gm-Message-State: AD7BkJLnmdV6ZZ4jcf0iePij1UCxOeCmbO4wYBmUFVY64i39XvZza+0UPNHF76bCdgwgte+zXNMmfbFNgyNtMQ==
X-Received: by 10.107.130.138 with SMTP id m10mr6701463ioi.34.1459711684578;
 Sun, 03 Apr 2016 12:28:04 -0700 (PDT)
Received: by 10.79.12.139 with HTTP; Sun, 3 Apr 2016 12:28:04 -0700 (PDT)
In-Reply-To: <CA+DCAeT1DQvHnRpJeApcm2vO6KhXaMaRXZg9HCUmiiBv=hfxzw@mail.gmail.com>
X-Google-Sender-Auth: EtWmQWr31OZFeJqa-evagENVFYU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290648>

On Fri, Apr 1, 2016 at 6:27 AM, Mehul Jain <mehul.jain2029@gmail.com> wrote:
> I tried out this method also. Below is the script that I wrote for this:
>
> test_autostash () {
>     OLDIFS=$IFS
>     IFS=',    ='
>     while read -r expect cmd config_variable value
>     do
>         test_expect_success "$cmd, $config_variable=$value" '
>             if [ "$value" = "" ]; then
>                 test_unconfig $config_variable
>             else
>                 test_config $config_variable $value
>             fi &&
>
>             git reset --hard before-rebase &&
>             echo dirty >new_file &&
>             git add new_file &&
>
>             if [ $expect = "ok" ]; then
>                 git pull '$cmd' . copy &&
>                 echo test_cmp_rev HEAD^ copy &&
>                 test "$(cat new_file)" = dirty &&
>                 test "$(cat file)" = "modified again"
>             else
>                 test_must_fail git pull '$cmd' . copy 2>err &&
>                 test_i18ngrep "uncommitted changes." err
>             fi
>         '
>     done
>     IFS=$OLDIFS
> }
>
> test_autostash <<-\EOF
>     ok,--rebase,rebase.autostash=true
>     [...]
>     err,--no-autostash,pull.rebase=true
>     EOF
>
> Things worked out perfectly.
>
> Unfortunately there was a strange behaviour that I noticed
> and frankly I don't understand why it happened.
>
> In test_autostash() there's a line
>
>     echo test_cmp_rev HEAD^ copy &&
>
> Originally it should have been
>
>     test_cmp_rev HEAD^ copy &&
>
> but this raise following error while testing
>
>     ./t5520-pull.sh: 684: eval: diff -u: not found

This is caused by the custom IFS=',\t=' which is still in effect when
test_cmp_rev() is invoked. You need to restore IFS within the loop
itself.

> I'm not able to understand why putting an "echo" before
> test_cmp didn't raise the above error. This looks quite
> strange. Any thoughts?

With 'echo', test_cmp_rev() is never even invoked (the command is just
printed by 'echo'), and 'echo' succeeds (returns 0), so the test
succeeds, but isn't actually doing an revision verification.

The test also behaves incorrectly on these lines:

    git pull '$cmd' . copy &&

and:

    test_must_fail git pull '$cmd' . copy 2>err &&

Those single quotes around $cmd are within the second argument to
test_expect_success(), which itself is a single quoted string. So,
'$cmd' is actually ending and re-starting the "outer" quoted string.
This isn't a problem when $cmd has a single token (such as
"--rebase"), but it causes test_expect_success() to complain about
incorrect number of arguments when $cmd is composed of multiple tokens
(such as "--rebase --autostash").

Moreover, $cmd shouldn't be quoted at all. When $cmd is "--rebase
--autostash", you want git-pull to see the --rebase and --autostash as
separate arguments, but the quoting causes them to be treated as a
single argument, which git-pull doesn't recognize. So, dropping the
quotes around $cmd is the correct thing to do.

> Though the above code works perfectly and can be used in
> place of previous tests. Only problem remains is tests titles.
> Currently with this script, test titles will be:
>
> ok 21 - --rebase, rebase.autostash=true
> ok 22 - --rebase --autostash, rebase.autostash=true
> ok 23 - --rebase --autostash, rebase.autostash=false
> ok 24 - --rebase --autostash, rebase.autostash=
> ok 25 - --rebase --no-autostash, rebase.autostash=true
> ok 26 - --rebase --no-autostash, rebase.autostash=false
> ok 27 - --rebase --no-autostash, rebase.autostash=
> ok 28 - --autostash, pull.rebase=true
> ok 29 - --no-autostash, pull.rebase=true
>
> Any thoughts/suggestions on them?

I don't see a particular problem with the titles. You could prefix
them with "pull " if that's what you mean.
