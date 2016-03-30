From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 5/5] t/t5520: test --[no-]autostash with pull.rebase=true
Date: Wed, 30 Mar 2016 16:31:07 -0400
Message-ID: <CAPig+cQyHu1J=FYOtgsmi3ghuN7YyjNgAz-VgO06isfrS+kUSg@mail.gmail.com>
References: <1459258200-32444-1-git-send-email-mehul.jain2029@gmail.com>
	<1459258200-32444-6-git-send-email-mehul.jain2029@gmail.com>
	<CAPig+cQ93+dCqJMRcQYSRHLDuYtwkeK_aSrfv2=2=g7ZhO85TQ@mail.gmail.com>
	<CA+DCAeQPr2vxvm6MKiOLpDtmpC2d=RcvYhuFeimSn+xX2TAvtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 22:31:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alMln-0000uu-0W
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 22:31:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751976AbcC3UbK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 16:31:10 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:33731 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860AbcC3UbI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 16:31:08 -0400
Received: by mail-vk0-f67.google.com with SMTP id a62so8504580vkh.0
        for <git@vger.kernel.org>; Wed, 30 Mar 2016 13:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=oDz84Z8jMV5iBRyMJGZeqqBKs/8NCWxDBfXktDIZhaA=;
        b=KLZWf0xH6oynwllgWS/ITSC+GmqptLrJNcDryz1zDv/iyIn6bTdmZzirIdO6bTXsj6
         +v9zh6rx+6KSb26sfgkOe5hdKa45m6Aya/G1r6UMsjWGmfVGv1+Nb3/fQB6mT3c490WS
         sOQhsIOspPXxKc/QtHZw6fP9U7vYlOcBl/y56uig+Qr6Xx9RKu+e8k0hz5Iv227rEy4I
         N56UG/RZGIY8+Cf0OuTvla2+mG4bJdFsPMs2NBAhEhLllzkGUxaPGzrHQn4oDnxUiyXv
         C+betNqkXZVK3wCUqmkZDDcT+pG/xH0F27eVReObHzvue0Fq2o31nai2gkmHkHPrON8/
         78Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=oDz84Z8jMV5iBRyMJGZeqqBKs/8NCWxDBfXktDIZhaA=;
        b=lMGCgfg5Jx9LBkrf4+1Z2KzMfRmowBu24PXoRe3PDkC6mBPUuPmxi5VcXgJJrWu/W5
         pt/gKdmkVz0cVUzAI44PpZZscbv6+uZCiCWmmXIsOW6mvHxKtHPJvBqKrX5ExVdNw2SE
         KIKdaNRqwy7lTOUZKKbsvWpZH0OQd2ng49z+OiUI3pMnSkbK3UxHIBK8AHYYpOgHCCk/
         eaM+IVY1ord94BS9phT0QZSV/xozz9Jcvwle6wVW9K89Eo6i5i0h7o8MNnyyNvBOcxwc
         2ext9s1w8fJ33OOsdqlaXYFd/uBRS7kemsYbbS4TjLYrykEkJDBdScD5lEto3eYFaC47
         H6cg==
X-Gm-Message-State: AD7BkJJBpVtsDdCVtvgv1DJdP3Wo853WRi6V3cL2Fzvwgp+os5al4L2WppCjN45YcS4ATgfrTxJ5KHms1ZmwVg==
X-Received: by 10.31.141.2 with SMTP id p2mr6658372vkd.37.1459369867562; Wed,
 30 Mar 2016 13:31:07 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Wed, 30 Mar 2016 13:31:07 -0700 (PDT)
In-Reply-To: <CA+DCAeQPr2vxvm6MKiOLpDtmpC2d=RcvYhuFeimSn+xX2TAvtQ@mail.gmail.com>
X-Google-Sender-Auth: l_kdth29wydvGRBmwa34N4xcP3k
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290344>

On Wed, Mar 30, 2016 at 3:00 PM, Mehul Jain <mehul.jain2029@gmail.com> wrote:
> On Wed, Mar 30, 2016 at 2:46 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> With the exception of the missing --rebase argument, this is exactly
>> the same code as in test_rebase_autostash(), right? Rather than
>> repeating this code yet again, it might be nice to augment that
>> function to accept a (possibly) optional argument controlling whether
>> --rebase is used.
>
> Thanks for the idea. I have come up with something like this:
>
> test_pull () {
>         git reset --hard before-rebase &&
>         echo dirty >new_file &&
>         git add new_file &&
>         git pull $@ . copy &&
>         test_cmp_rev HEAD^ copy &&
>         test "$(cat new_file)" = dirty &&
>         test "$(cat file)" = "modified again"
> }
>
> test_pull_fail () {
>         git reset --hard before-rebase &&
>         echo dirty >new_file &&
>         git add new_file &&
>         test_must_fail git pull $@ . copy 2>err &&
>         test_i18ngrep "uncommitted changes." err
> }

Considering that these are specifically testing behavior related to
autostashing, it might make sense to have "autostash" in the function
names, but that's a very minor point.

> test_expect_success 'pull --rebase succeeds with dirty working
> directory and rebase.autostash set' '
>         test_config rebase.autostash true &&
>         test_pull --rebase
> '
> [...]
> test_expect_success 'pull --no-autostash & pull.rebase=true' '
>         test_config pull.rebase true &&
>         test_pull_fail --no-autostash
> '
>
> I'm sorry if this is bit difficult to digest without diff output. I
> just wanted to
> know if the above mention functions looks suitable to you.

This is exactly what I had in mind for simplifying the tests, and it's
perfectly easy to read in this form (a diff would be worse for this
illustration).

One other possibility would be to make this all table-driven by
collecting all of the above state information into a table and then
feeding that into a function (either as its argument list or via
stdin). For instance:

    test_autostash <<\-EOF
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

The function would loop over the input, split each line apart by
setting IFS=, and then run the test based upon the state information.
"ok" means autostash is expected to succeed, and err means it is
expected to fail. The function would want to specially recognize the
"foo.bar=" in the last argument in order to invoke test_unconfig()
rather than test_config().

However, this may be a case of diminishing returns. The tests as you
illustrated them are sufficiently simple and easy to grok that the
table-driven approach may not add much value (aside from making it
easier to see at a glance if any cases were omitted).
