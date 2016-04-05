From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v12 4/5] t7507-commit-verbose: improve test coverage by
 testing number of diffs
Date: Tue, 5 Apr 2016 21:24:02 +0530
Message-ID: <CAFZEwPO_Y6-jEGXDspExhmaWO36QWhaK813TcEUWSqB_byZngQ@mail.gmail.com>
References: <01020153d952bd99-d3812bd6-d189-4780-ab48-f015696e9cf0-000000@eu-west-1.amazonses.com>
	<01020153d952be6c-04f90bd2-291e-4eca-99fd-e897d8601132-000000@eu-west-1.amazonses.com>
	<CAPig+cRBwOjxA2cB=ZR__o7LsHxk9Rbzfv7ngRxv8h6=koQSRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 17:56:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anTIv-0005e1-BD
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 17:54:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758631AbcDEPyF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2016 11:54:05 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:34210 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752116AbcDEPyD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2016 11:54:03 -0400
Received: by mail-yw0-f195.google.com with SMTP id f6so2463229ywa.1
        for <git@vger.kernel.org>; Tue, 05 Apr 2016 08:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=3UizpTp1IZdNPQDRb634hubncp2mzrCW3ssViQKlvdM=;
        b=UiukCsUQga+GUSGu4ET+UVtLu8yaSOwwCtEcOK+HIaUweXVY4/6kwTnp250Lh32yvu
         U6PcVMaASeYLxXgJzd8Pd86mxP9h/X4TcbP2eZyjPtU6C0dH6M5cVb9puBeLhHnrGBZ1
         aQ6zLPi7OTK0dSVeA/od+6aevuB+M9Ur3R73Lf0qwoHqISq9j2Mr8X04fr4aYuxPb86j
         c/jYakBh8ibnzcjUh/y1v3GZQJXNpe9T34/CLmrBwH8Lw5VEJQ8mQCOwDln1okef2NBi
         w5yeJD/UhTlb0zvhBCepMzBilG9i3L0C6M1UsU1Wu2Gc36f4+EZBPD7NrIOn18D0LmWH
         kXGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=3UizpTp1IZdNPQDRb634hubncp2mzrCW3ssViQKlvdM=;
        b=BDxprPqoBnFPwKH7rFVs4YcogtsKFhJnwPozpyTceeEFRsj0h2cllpY/W9YzqCotcX
         XHKUry2Nr1eJ04feizeyIMTa3xeRiHQ3w9lvuwt2XpGfAt2+KzYR277X0Z99AgH+Hr4g
         /wtznRbC8oJMDYDnzdgTBz1HZlni2XJf3F77kDFNInJQr8njYfo4Oh3/IajH/ZC55Dtl
         swOG9AM8xdONse2xcecI/1sJSVzuR7sbBrMtg6pS/c09DkYQ9fXiLkmB/VhzkSTRaiJb
         pm+N9wJMYTrFBj8CN2UCdhUBXb9PH1qySAXO87r0GFg8YPv4v6a7noLSBEJFVcXtPPRS
         GwjQ==
X-Gm-Message-State: AD7BkJJEc3vH2MP2AJRgdXLwYLbH0Wo8QkHU9CJ4owCk7XIYW2zgoaSdPehHSIw19qgPuKgQzIHcPzL0Qf4Ddw==
X-Received: by 10.129.155.137 with SMTP id s131mr7725966ywg.24.1459871642228;
 Tue, 05 Apr 2016 08:54:02 -0700 (PDT)
Received: by 10.13.219.81 with HTTP; Tue, 5 Apr 2016 08:54:02 -0700 (PDT)
In-Reply-To: <CAPig+cRBwOjxA2cB=ZR__o7LsHxk9Rbzfv7ngRxv8h6=koQSRw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290788>

On Mon, Apr 4, 2016 at 5:32 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, Apr 2, 2016 at 7:33 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> Make the fake "editor" store output of grep in a file so that we can
>> see how many diffs were contained in the message and use them in
>> individual tests where ever it is required. Also use write_script()
>> to create the fake "editor".
>>
>> A subsequent commit will introduce scenarios where it is important to be
>> able to exactly determine how many diffs were present.
>
> These two sentences are backward. The "subsequent commit" bit is
> justification for why you are making the "editor" store the output,
> thus it belongs with the first paragraph. The bit about write_script()
> is just a minor aside which can go in its own paragraph.
>
> I think it's also important to explain that you're changing the
> behavior of write_script() so that it always succeeds, regardless of
> whether grep found diff headers or not, and to give the reason for
> making this change ("so that you don't have to use 'test_must_fail'
> for cases when no diff headers are expected and can instead easily use
> 'test_line_count = 0'").
>
> The patch itself looks fine and is easy enough to read.

I will include some more explanation as you suggest.

>
>> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
>> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
>> ---
>> diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
>> index 2ddf28c..0f28a86 100755
>> --- a/t/t7507-commit-verbose.sh
>> +++ b/t/t7507-commit-verbose.sh
>> @@ -3,11 +3,10 @@
>>  test_description='verbose commit template'
>>  . ./test-lib.sh
>>
>> -cat >check-for-diff <<EOF
>> -#!$SHELL_PATH
>> -exec grep '^diff --git' "\$1"
>> +write_script "check-for-diff" <<\EOF &&
>> +grep '^diff --git' "$1" >out
>> +exit 0
>>  EOF
>> -chmod +x check-for-diff
>>  test_set_editor "$PWD/check-for-diff"
>>
>>  cat >message <<'EOF'
>> @@ -23,7 +22,8 @@ test_expect_success 'setup' '
>>  '
>>
>>  test_expect_success 'initial commit shows verbose diff' '
>> -       git commit --amend -v
>> +       git commit --amend -v &&
>> +       test_line_count = 1 out
>>  '
>>
>>  test_expect_success 'second commit' '
>> @@ -39,13 +39,15 @@ check_message() {
>>
>>  test_expect_success 'verbose diff is stripped out' '
>>         git commit --amend -v &&
>> -       check_message message
>> +       check_message message &&
>> +       test_line_count = 1 out
>>  '
>>
>>  test_expect_success 'verbose diff is stripped out (mnemonicprefix)' '
>>         git config diff.mnemonicprefix true &&
>>         git commit --amend -v &&
>> -       check_message message
>> +       check_message message &&
>> +       test_line_count = 1 out
>>  '
