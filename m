From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v10 2/3] t7507-commit-verbose: store output of grep in a file
Date: Sun, 27 Mar 2016 13:03:53 -0400
Message-ID: <CAPig+cQucLoednXHatos0yF66JGN+njhLarK=WYam=qtwV5y=Q@mail.gmail.com>
References: <01020153b478cf07-758c7f14-33a1-4a67-9bc9-4688de3d6742-000000@eu-west-1.amazonses.com>
	<01020153b478cf9b-1417ac08-005c-4d72-91f1-0b07f00a24d5-000000@eu-west-1.amazonses.com>
	<CAPig+cRQ5hOLi3539Emq=YexHRXqdesf+Yo2cY+NkiPO_9Vhyg@mail.gmail.com>
	<CAFZEwPMaZkUi+DvohhVrc_dW_8cdfJsZX-YA_SRWDp021UvDLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 27 19:04:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akE6Y-0004j0-Sh
	for gcvg-git-2@plane.gmane.org; Sun, 27 Mar 2016 19:03:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752500AbcC0RDz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Mar 2016 13:03:55 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:34610 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586AbcC0RDy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Mar 2016 13:03:54 -0400
Received: by mail-vk0-f68.google.com with SMTP id e6so12546446vkh.1
        for <git@vger.kernel.org>; Sun, 27 Mar 2016 10:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=u0yHojG8HdGfEJXiJBzfhya2Y1dp64fuYMHXKi+kVMM=;
        b=n7kmjP/64VWS18Tn0Vd8ETLtEArNtWZRA/gNKEiWb0Tuf+towBfe2o4C9TyBZpfd98
         9BqOGE2B8JtkfRig7GLF/pEt+GFDOQKZK7QQ0lzsCxnKyyuCeOf60z3exGpUS2cAW76/
         8SzHg3LuHAF7tf1n0XYY4xZqWyWWAasNa0QcXmIUWZFaC1y9akbnJAnxu5GLyuQYCh1m
         oyk39RadwEXSaWJXvQnuW+MpS1yqyfGbevUQPNuAe4jAdL5Rm5Rtq49gP93zjdQ2Gk5n
         +Km00kjdEfkx9WOZQ3J/Njw4zJar/p+wi5VavWOVFssyo9s1QZTm84+vyIPymKUcS8WX
         7keA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=u0yHojG8HdGfEJXiJBzfhya2Y1dp64fuYMHXKi+kVMM=;
        b=UTUXpMbo7fvmRHTcr/ccxcwX7ma054wKFmHi8J/Of3pEYs3x8J+wwcfkonbbJzk61d
         b4EMsh/KmkAL43Dio2piLopu/BTrZc4xWSDeTWravxmp8QTyytpfJxR5aNghaCCKgbjc
         0L8tR5uRfPojE8IFAhzD5Wont+q9EolLYa6P/cHu95JZI4jNQ14CYERv62KUWjFqr2do
         UuYV15kdwW75u535gbnimo/7OcVfGWCAX3qbfV1S5BzyNr0ZwotfPF7mEzvyJM0N0dyg
         FpBHDRQv4NduSWcMqZvohqos2oo7uAHbVNLtSqrmwVZoI+H3/Ywh1hri/F+XAGR0Ds2n
         WUNw==
X-Gm-Message-State: AD7BkJI5Wvdw9oECGmufSGMhJsRTsy5V7o6QHuu9bbNKOYgxPZEqgQX7n7oxdyhibasp9TZbUKCf6ZPTGtYKwA==
X-Received: by 10.176.2.143 with SMTP id 15mr12398659uah.113.1459098233112;
 Sun, 27 Mar 2016 10:03:53 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Sun, 27 Mar 2016 10:03:53 -0700 (PDT)
In-Reply-To: <CAFZEwPMaZkUi+DvohhVrc_dW_8cdfJsZX-YA_SRWDp021UvDLQ@mail.gmail.com>
X-Google-Sender-Auth: L5QjQQYsxHVYt-ZBuD3ptFtV3iA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290015>

[forwarding this to the list since Pranit (presumably) accidentally
replied only to me but it's relevant to the ongoing discussion]

On Sun, Mar 27, 2016 at 1:42 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> On Sun, Mar 27, 2016 at 8:37 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Sat, Mar 26, 2016 at 3:48 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>>> So that we can see how many diffs were contained in the message and use
>>> them in individual tests where ever it is required. Also use
>>> write_script() to create the fake "editor".
>>
>> It is important to explain *why* you want to be able to count how many
>> diffs were in the editor message. In particular, you will be adding
>> new tests in a subsequent patch which will expect a specific number of
>> diffs (rather than any number of diffs)
>>
>> Also, you need to explain why you're changing the existing tests to
>> count the number of diffs. Is it simply "because you can" or is it
>> because you suspect that a change you're making in a subsequent patch
>> might accidentally cause too many diffs to show up in the existing
>> test cases?
>
> Sorry for not writing commit messages properly. It is a part I am working on.
> How does this paragraph sound to you in addition to the previous commit message?
> "A subsequent commit will introduce a scenario where it is important
> to be able to exactly determine how many diffs were present."
>
>>> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
>>> ---
>>> diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
>>> @@ -3,9 +3,11 @@
>>> -cat >check-for-diff <<EOF
>>> -#!$SHELL_PATH
>>> -exec grep '^diff --git' "\$1"
>>> +write_script "check-for-diff" <<'EOF' &&
>>
>> The 'EOF' is more commonly written as \EOF in Git test scripts.
>>
>>> +! test -s out ||
>>> +rm out &&
>>
>> Why not just "rm -f out"? But, more importantly, why do you need to
>> remove the file at all? The '>' redirection operator (used below) will
>> overwrite the file, so no need to remove it beforehand.
>
> I wasn't aware about '-f' option. It is important to remove the file.
> I initially tried without removing the file and it caused problems.
> This is because let's say the previous test had 1 diff which was
> stored in out. Now, if in the next test, it is expected to have 0
> diffs then grep would fail to execute and nothing will be re-written
> to out and out will contain the 1 diff from previous test. An
> explanation for this should be mentioned in the commit message?
>
>>> +! grep '^diff --git' "$1" ||
>>> +grep '^diff --git' "$1" >out
>>
>> Um, what? Why two greps? I would have expected you to simply re-use
>> the existing grep (minus the backslash) while adding the redirection:
>>
>>     -exec grep '^diff --git' "\$1"
>>     +exec grep '^diff --git' "$1" >out
>
> The reason of two greps in that if in some test it fails to find any
> diffs, the editor will return an error. Of course we could test this
> scenario by using test_must_fail as in previous patches, but I think
> it would be more clearer if we could test for the existence of out
> which is done in patch 3/3. I will explanation for this in commit
> message.
>
>>>  EOF
>>>  chmod +x check-for-diff
>>
>> Mentioned previously[1]: Drop the 'chmod' since write_script() does it for you.
>>
>> [1]: http://article.gmane.org/gmane.comp.version-control.git/289832
>
> Then you mentioned that you were talking[1] about some other review.
> So I thought you mean to keep as it is. I guess I misinterpreted it.
> And I did not test that before. Now, I have tested that it works if we
> remove chmod.
> [1] : http://thread.gmane.org/gmane.comp.version-control.git/288820/focus=289832
>
>>>  test_set_editor "$PWD/check-for-diff"
>>> @@ -23,7 +25,8 @@ test_expect_success 'setup' '
>>>  test_expect_success 'initial commit shows verbose diff' '
>>> -       git commit --amend -v
>>> +       git commit --amend -v &&
>>> +       test_line_count = 1 out
>>>  '
>>>
>>>  test_expect_success 'second commit' '
>>> @@ -39,13 +42,15 @@ check_message() {
>>>
>>>  test_expect_success 'verbose diff is stripped out' '
>>>         git commit --amend -v &&
>>> -       check_message message
>>> +       check_message message &&
>>> +       test_line_count = 1 out
>>>  '
>>>
>>>  test_expect_success 'verbose diff is stripped out (mnemonicprefix)' '
>>>         git config diff.mnemonicprefix true &&
>>>         git commit --amend -v &&
>>> -       check_message message
>>> +       check_message message &&
>>> +       test_line_count = 1 out
>>>  '
