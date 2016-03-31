From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v11 3/4] t7507-commit-verbose: improve test coverage by
 testing number of diffs
Date: Fri, 1 Apr 2016 00:12:20 +0530
Message-ID: <CAFZEwPP1iQQq5WXsBa-4vZ3wXH-DeNUw5JtqsgYmeUSo-XPYxQ@mail.gmail.com>
References: <01020153cd2340f8-4665cd5f-cd5c-41ab-a162-20acc43ca52e-000000@eu-west-1.amazonses.com>
	<01020153cd2341ef-eed17644-85ee-4d1d-8051-b5d56bd9ae52-000000@eu-west-1.amazonses.com>
	<xmqqa8leo6a6.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 20:42:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alhY3-0001V2-1N
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 20:42:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757885AbcCaSmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 14:42:22 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35305 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757865AbcCaSmV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 14:42:21 -0400
Received: by mail-yw0-f195.google.com with SMTP id u8so13030503ywa.2
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 11:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=nHEHvHnFhF9yJR4tWR0Q+4+6nI+f7C1hd4CF/saYFCA=;
        b=ID6tAgHqP4NpQyASBXZn3wUz79/rp0DwC3LwvVi2ycvHqtF5OUVBGaCVl9dso8l0wS
         MeOU/NnEVmtyI/xRE+y6W6iurkM2AkmnMX5ruu974fFvFY9EkM5V0BIhNsmxpVLFwGxl
         9ODPQXzMzLaq3Es4cD0CVWVcUcFUM48o5KDeCk35fgCGf5FKLhFEfK6qyDivfFVnNGdr
         n/xOzzRXFlGzN/2vMPXtnvckxo6nweeJ8z51RsicPxCQRXKSvSAJYKX3AjY0WLCTJnLQ
         gETmYa+WYYiilHZZiFdrEL+pZkAMBZPYaaogPGLILf6LN84xcKaQD5hn/liaGzXZVQLo
         36IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=nHEHvHnFhF9yJR4tWR0Q+4+6nI+f7C1hd4CF/saYFCA=;
        b=jh+F9s6IVtMWIM5KbPn+6UvJi8leMtkYlJ87fTJSVmsMvu8LmcV+1vnVdN7VDjUIMw
         CxSZ1nZm5sADK3/wLpmWjdx0uQb6W5xOyXkk8BTuz33n3p+zbhpVEGatFY8xI3hgYUfD
         o1se/qyQOiASI6s/D+DMQYoO4/m7IntbWpzpHIHdMpmulKeeFsYf3n8D7XtPT8Qf1yZJ
         V9vazFEdlAD0tskedQV11ri/9JQUG2E72JRrSAT35vGypgqc3ZiVDFlhKSZUAi5J8LIj
         fVxQQ8Eln3yxjYDcwJPDyvKW6d7BET7VcfdPTSkJmBu8xlIjjoPLGLIC1vlmrnnTWBMY
         gObg==
X-Gm-Message-State: AD7BkJJ08Vrs6EAUEwTZ2kOAW+eh6gS/PEnssWiUXkKkA4TpWuXTbwBOlF1AXxXyT+0PKftD35uCJdfp/+g2Mg==
X-Received: by 10.129.9.214 with SMTP id 205mr8346954ywj.53.1459449740995;
 Thu, 31 Mar 2016 11:42:20 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Thu, 31 Mar 2016 11:42:20 -0700 (PDT)
In-Reply-To: <xmqqa8leo6a6.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290444>

On Thu, Mar 31, 2016 at 11:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Pranit Bauva <pranit.bauva@gmail.com> writes:
>
>> Make the fake "editor" store output of grep in a file so that we can
>> see how many diffs were contained in the message and use them in
>> individual tests where ever it is required. Also use write_script()
>> to create the fake "editor".
>>
>> A subsequent commit will introduce scenarios where it is important to be
>> able to exactly determine how many diffs were present.
>>
>> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
>> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
>>
>> Previous version of this patch:
>>  - [v10]: $gmane/288820
>>
>> Changes this version wrt previous one:
>> I decided to include no of diffs in every test and rewrote the commit
>> message so as to sell this idea. This was given as an option to me by
>> Eric and the other option being to drop unnecessary testing of lines
>> where it isn't required. Also this patch uses a suggestion given by Eric
>> to make the "editor" look more clean as compared to the editor in my
>> previous version.
>> ---
>
> OK, by always exiting 0 from the editor, you do not interfere with
> the "git commit" that invoked it, and you inspect the editor's
> finding after "git commit" returns.  The approach taken by this
> patch looks a lot more sensible than the previous one.
>
> You'd need the three-dash right before "Previous version of..."
> line, though.

That's silly of me to forget this. Will do it.

>>  t/t7507-commit-verbose.sh | 16 +++++++++-------
>>  1 file changed, 9 insertions(+), 7 deletions(-)
>>
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
>> -     git commit --amend -v
>> +     git commit --amend -v &&
>> +     test_line_count = 1 out
>>  '
>>
>>  test_expect_success 'second commit' '
>> @@ -39,13 +39,15 @@ check_message() {
>>
>>  test_expect_success 'verbose diff is stripped out' '
>>       git commit --amend -v &&
>> -     check_message message
>> +     check_message message &&
>> +     test_line_count = 1 out
>>  '
>>
>>  test_expect_success 'verbose diff is stripped out (mnemonicprefix)' '
>>       git config diff.mnemonicprefix true &&
>>       git commit --amend -v &&
>> -     check_message message
>> +     check_message message &&
>> +     test_line_count = 1 out
>>  '
>>
>>  cat >diff <<'EOF'
>>
>> --
>> https://github.com/git/git/pull/218
