From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: Re: [PATCH 5/5] t/t5520: test --[no-]autostash with pull.rebase=true
Date: Fri, 1 Apr 2016 15:57:27 +0530
Message-ID: <CA+DCAeT1DQvHnRpJeApcm2vO6KhXaMaRXZg9HCUmiiBv=hfxzw@mail.gmail.com>
References: <1459258200-32444-1-git-send-email-mehul.jain2029@gmail.com>
	<1459258200-32444-6-git-send-email-mehul.jain2029@gmail.com>
	<CAPig+cQ93+dCqJMRcQYSRHLDuYtwkeK_aSrfv2=2=g7ZhO85TQ@mail.gmail.com>
	<CA+DCAeQPr2vxvm6MKiOLpDtmpC2d=RcvYhuFeimSn+xX2TAvtQ@mail.gmail.com>
	<CAPig+cQyHu1J=FYOtgsmi3ghuN7YyjNgAz-VgO06isfrS+kUSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 12:27:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alwIp-0004mQ-O1
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 12:27:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755099AbcDAK1a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 06:27:30 -0400
Received: from mail-qg0-f66.google.com ([209.85.192.66]:35896 "EHLO
	mail-qg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752317AbcDAK12 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 06:27:28 -0400
Received: by mail-qg0-f66.google.com with SMTP id n34so10847033qge.3
        for <git@vger.kernel.org>; Fri, 01 Apr 2016 03:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=6KKyMEQ6CqCsT2j+Fg7ssJsDDgBzOLpnFd2OX6oVI78=;
        b=hWoy1s0oj6xuzUeOFYsdYfJkB2eQLtFnuHCQ+nXMN5SwBTs5wmzDCBQwb6L8jeaM6E
         fr+qu0hGcOHCM+Tu5aP/MgDIZARgtDzqaYtDUzSQUKAv/oULIF1l8e4bIeZUDliCBBKh
         BP5MFjIVnkenPKaSuZhm9ihm2NSAj+d079gwEBN+Ubyo5MsGespxTHeVGrzYt6TZej7s
         lZzH+S1OvA7V7Vj07WRYgiPJygSO7XAMHeeHb78vZFSQabUm9S6Ga8n0240fgKftqeeK
         zayEPKQFvtYJCJ4tVksz1nKGqsBSV5EmmUO+B2jSsTtc0VLndDRvuvSE60Y6equeGOoG
         JT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=6KKyMEQ6CqCsT2j+Fg7ssJsDDgBzOLpnFd2OX6oVI78=;
        b=lkqSEJwH0SkrFGaGJ8N6X35liJChZTvaLBFf7YSb3kGM0K05LR6aNiU48v60TRdHOU
         ZOKXjoAg+HdtE8mPFWapTSrlOAv/GIdUXOZklbAYmx0an3NkUyV5AdJKJuibbV1uXsz1
         r4lKvH8s+8B10yBNqdqXP85/ExqGXEKJWAr4ivYirMUD93ZZrT+kcR+SMZH4eCxJvsjN
         VmV4Qp6BgbVqXbS8c2tHEuNDzoDQd2HQ1XCXck0h94///vlNO92aUX312NJ99MdcpEfe
         ekLGQnZHQtcs2DiShIkkK5QMPqLxvSq8dJhRNzSoXpV098041C9llRdkFWl1G/E+gA8A
         g0Jg==
X-Gm-Message-State: AD7BkJItmi463afk8Vsso+dlGCGZusT/SKXrdzrCvPUnUxaQ8Zs4qLDK22O0e1I3vdLsjfcaiSf3gy4M2S8PUA==
X-Received: by 10.140.240.3 with SMTP id l3mr25423738qhc.93.1459506447804;
 Fri, 01 Apr 2016 03:27:27 -0700 (PDT)
Received: by 10.55.10.135 with HTTP; Fri, 1 Apr 2016 03:27:27 -0700 (PDT)
In-Reply-To: <CAPig+cQyHu1J=FYOtgsmi3ghuN7YyjNgAz-VgO06isfrS+kUSg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290516>

Hi Eric,

On Thu, Mar 31, 2016 at 2:01 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> One other possibility would be to make this all table-driven by
> collecting all of the above state information into a table and then
> feeding that into a function (either as its argument list or via
> stdin). For instance:
>
>     test_autostash <<\-EOF
>     ok,--rebase,rebase.autostash=true
>     ok,--rebase --autostash,rebase.autostash=true
>     ok,--rebase --autostash,rebase.autostash=false
>     ok,--rebase --autostash,rebase.autostash=
>     err,--rebase --no-autostash,rebase.autostash=true
>     err,--rebase --no-autostash,rebase.autostash=false
>     err,--rebase --no-autostash,rebase.autostash=
>     ok,--autostash,pull.rebase=true
>     err,--no-autostash,pull.rebase=true
>    EOF
>
> The function would loop over the input, split each line apart by
> setting IFS=, and then run the test based upon the state information.
> "ok" means autostash is expected to succeed, and err means it is
> expected to fail. The function would want to specially recognize the
> "foo.bar=" in the last argument in order to invoke test_unconfig()
> rather than test_config().

I tried out this method also. Below is the script that I wrote for this:

---

test_autostash () {
    OLDIFS=$IFS
    IFS=',    ='
    while read -r expect cmd config_variable value
    do
        test_expect_success "$cmd, $config_variable=$value" '
            if [ "$value" = "" ]; then
                test_unconfig $config_variable
            else
                test_config $config_variable $value
            fi &&

            git reset --hard before-rebase &&
            echo dirty >new_file &&
            git add new_file &&

            if [ $expect = "ok" ]; then
                git pull '$cmd' . copy &&
                echo test_cmp_rev HEAD^ copy &&
                test "$(cat new_file)" = dirty &&
                test "$(cat file)" = "modified again"
            else
                test_must_fail git pull '$cmd' . copy 2>err &&
                test_i18ngrep "uncommitted changes." err
            fi
        '
    done
    IFS=$OLDIFS
}


test_autostash <<-\EOF
    ok,--rebase,rebase.autostash=true
    ok,--rebase --autostash,rebase.autostash=true
    ok,--rebase --autostash,rebase.autostash=false
    ok,--rebase --autostash,rebase.autostash=
    err,--rebase --no-autostash,rebase.autostash=true
    err,--rebase --no-autostash,rebase.autostash=false
    err,--rebase --no-autostash,rebase.autostash=
    ok,--autostash,pull.rebase=true
    err,--no-autostash,pull.rebase=true
    EOF


---

Things worked out perfectly.

Unfortunately there was a strange behaviour that I noticed
and frankly I don't understand why it happened.

In test_autostash() there's a line

    echo test_cmp_rev HEAD^ copy &&

Originally it should have been

    test_cmp_rev HEAD^ copy &&

but this raise following error while testing

    ./t5520-pull.sh: 684: eval: diff -u: not found

I'm not able to understand why putting an "echo" before
test_cmp didn't raise the above error. This looks quite
strange. Any thoughts?

Though the above code works perfectly and can be used in
place of previous tests. Only problem remains is tests titles.
Currently with this script, test titles will be:

ok 21 - --rebase, rebase.autostash=true
ok 22 - --rebase --autostash, rebase.autostash=true
ok 23 - --rebase --autostash, rebase.autostash=false
ok 24 - --rebase --autostash, rebase.autostash=
ok 25 - --rebase --no-autostash, rebase.autostash=true
ok 26 - --rebase --no-autostash, rebase.autostash=false
ok 27 - --rebase --no-autostash, rebase.autostash=
ok 28 - --autostash, pull.rebase=true
ok 29 - --no-autostash, pull.rebase=true

Any thoughts/suggestions on them?

Thanks,
Mehul
