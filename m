From: =?UTF-8?Q?Felipe_Gon=C3=A7alves_Assis?= <felipeg.assis@gmail.com>
Subject: Re: [PATCH 5/5] merge-recursive: test more consistent interface
Date: Sun, 21 Feb 2016 16:55:09 -0300
Message-ID: <CALMa68qBtw+MdhDsOFofEDoySuTU5BJ2tQvEKrynQxcXKWkhGw@mail.gmail.com>
References: <1456067358-19781-1-git-send-email-felipegassis@gmail.com>
	<1456067358-19781-6-git-send-email-felipegassis@gmail.com>
	<CAPig+cSAWjqD7weNLyk4MrAU1Q7+R6z16GndKkByHo2Uc4yWqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Felipe_Gon=C3=A7alves_Assis?= <felipegassis@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Feb 21 20:55:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXa69-0000ue-Bs
	for gcvg-git-2@plane.gmane.org; Sun, 21 Feb 2016 20:55:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbcBUTzL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Feb 2016 14:55:11 -0500
Received: from mail-ig0-f174.google.com ([209.85.213.174]:35715 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447AbcBUTzK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Feb 2016 14:55:10 -0500
Received: by mail-ig0-f174.google.com with SMTP id hb3so64783811igb.0
        for <git@vger.kernel.org>; Sun, 21 Feb 2016 11:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=J+gOpH6RVj6uEGdlvOlMGjLkaOVyI9xgK4YyZRJ+P4c=;
        b=k/1kMSWO/8EzRSqxVoG3GAjZUv43TmbDieWCmyxqFmdgG25AWCrSjAMNQzOctBMoAv
         WJchAhxNnapXwaQqvjnbCDiI37xg9pa+CO5ob1/6S6uHIxn/Ns/CrstntlKvcCig3Ptd
         zqjjIA4qfh4fuT7tJOFv1IxB2CbsHjJz0eJ09gW4pEGh4G0owZ05qD+EXgXKS3Llp4tl
         3d0TBGduRil7ATYPK3Om0rt/0G+2ZC0DaZD9egkvITOzHJavZIVwFYL4WOBgeGGvPyEP
         ITD3RdRN0cqXjaUfHaYH8Ml3GwQXtYqmirx8HLGa6+ueQyj97tA8taZBT6z9ZoRo9uij
         lMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=J+gOpH6RVj6uEGdlvOlMGjLkaOVyI9xgK4YyZRJ+P4c=;
        b=Pv1tEIT9c59cIyXroH+qfjv6mn+CGxqjAnGRy0zGJxGGRh40gjtTEsaPAgWzNkGFfW
         ACOR+m6EVVbDGiiJkElFg478s1hCncsOCWlRbjwmmbm7uCbh3gtprwqhOVc9zl9EZRr3
         O2L7rhimQKAhZzQChdf/tLZ9MlqRaWT69JCOMqmHcNmS29ZJHBNlq/qK7SK4qMXjRH8k
         IoDi1FTXujc90z04kz6mANwzjcmYIrIQmjFFBjR168Oc9ybHaMXUhALxYwg7M6cJOUkl
         SkNPOwEQFjw7bczNzLuo6ZwD2Pj/VPZHSU3vuJtTGuWLb5LLyDy0R7vQGAM3zbMXYqTZ
         Zrdw==
X-Gm-Message-State: AG10YORW1n3fGsxeJXtZ5SMgjvmiv0e6gWZY3AZN0qtGK01HGJDiJ+2qz+HuoAKk+MVef+H4+kFp3QmqABCVVg==
X-Received: by 10.50.98.74 with SMTP id eg10mr738355igb.17.1456084509481; Sun,
 21 Feb 2016 11:55:09 -0800 (PST)
Received: by 10.107.3.94 with HTTP; Sun, 21 Feb 2016 11:55:09 -0800 (PST)
In-Reply-To: <CAPig+cSAWjqD7weNLyk4MrAU1Q7+R6z16GndKkByHo2Uc4yWqg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286827>

On 21 February 2016 at 15:40, Eric Sunshine <sunshine@sunshineco.com> w=
rote:
> On Sun, Feb 21, 2016 at 10:09 AM, Felipe Gon=C3=A7alves Assis
> <felipeg.assis@gmail.com> wrote:
>> merge-recursive: test more consistent interface
>
> The real meat of this patch (it seems) is that you're adding tests to
> verify that --find-renames=3D and --rename-threshold=3D are aliases, =
so it
> might make sense for the summary line to state that.
>
>     t3034: test that --find-renames=3D and --rename-threshold=3D are =
aliases
>
>> Update basic tests to use the new option find-renames instead of
>> rename-threshold. Add tests to verify that rename-threshold=3D<n> be=
haves
>> as a synonym for find-renames=3D<n>. Test that find-renames resets
>> threshold.
>
> Likewise, the order of these sentences seems wrong. The important bit
> should be mentioned first, which is that the one is an alias for the
> other.
>
> (In fact, if you take advice given below in the actual patch content,
> then this paragraph can probably be dropped altogether since the othe=
r
> two bits don't really belong in this patch.)
>
>> Signed-off-by: Felipe Gon=C3=A7alves Assis <felipegassis@gmail.com>
>> ---
>> diff --git a/t/t3034-merge-recursive-rename-options.sh b/t/t3034-mer=
ge-recursive-rename-options.sh
>> @@ -115,25 +115,25 @@ test_expect_success 'the default similarity in=
dex is 50%' '
>>
>>  test_expect_success 'low rename threshold' '
>>         git read-tree --reset -u HEAD &&
>> -       test_must_fail git merge-recursive --rename-threshold=3D25 H=
EAD^ -- HEAD master &&
>> +       test_must_fail git merge-recursive --find-renames=3D25 HEAD^=
 -- HEAD master &&
>
> Since you're building this series atop 10ae752 (merge-recursive:
> option to specify rename threshold, 2010-09-27) in 'next', the
> --find-renames=3D option already exists, so these tests, which were
> added in 3/5, can instead use --find-renames=3D from the start, thus
> making this patch (5/5) much less noisy since this change and several
> below will disappear altogether.
>
> Taking the above and review comments from earlier patches into
> account, it might make sense to re-order the series as follows:
>
> 1/5: add --find-renames & --find-renames=3D tests (including "last wi=
ns")
> 2/5: add --find-renames=3D / --rename-threshold=3D aliases tests
> 3/5: add --no-renames tests (including "last wins")
> 4/5: fix --find-renames to reset threshold to default (including test=
)
> 5/5: fix merge-strategies.txt typo
>
> The position of the typo fix patch isn't significant; I just
> arbitrarily plopped it at the end. Also, the order of patches 2 & 3 i=
s
> arbitrary.
>

=46air enough. As I said, I ordered the three test commits so that the
first one could be applied soon after the commit introducing
"rename-thresholds", the second soon after the commit introducing
"no-renames" and the third one soon after the fixup for the commit
introducing "find-renames" (which would ideally be correct from the
start), but then this is probably more aesthetic than practical.

I am currently working on the following order, which follows your const=
raints.
1/5: fix typo (I don't like typos)
2/5: tests involving --find-renames
3/5: tests involving --no-renames
4/5: tests involving --rename-threshold (this represents what would be
reverted if the feature was discontinued)
5/5: fix --find-renames + test

> More below...
>
>
>> +test_expect_success 'last wins in --no-renames --find-renames' '
>> +       git read-tree --reset -u HEAD &&
>> +       test_must_fail git merge-recursive --no-renames --find-renam=
es HEAD^ -- HEAD master &&
>> +       check_find_renames_50
>> +'
>> +
>> +test_expect_success 'last wins in --find-renames --no-renames' '
>> +       git read-tree --reset -u HEAD &&
>> +       git merge-recursive --find-renames --no-renames HEAD^ -- HEA=
D master &&
>> +       check_no_renames
>> +'
>> +
>> +test_expect_success 'rename-threshold=3D<n> is a synonym for find-r=
enames=3D<n>' '
>> +       git read-tree --reset -u HEAD &&
>> +       test_must_fail git merge-recursive --rename-threshold=3D25 H=
EAD^ -- HEAD master &&
>> +       check_find_renames_25
>> +'
>
> I rather expected to see this test come first, as all the others are
> rather subordinate to it.
>

But it already is the first test involving "rename-threshold". The
preceding tests verify the rename detection functionality with the
recommended interface. Then we have tests for the deprecated option.
This tail is exactly what we would remove if it was discontinued.

What did you mean?

>>  test_expect_success 'last wins in --no-renames --rename-threshold=3D=
<n>' '
>>         git read-tree --reset -u HEAD &&
>>         test_must_fail git merge-recursive --no-renames --rename-thr=
eshold=3D25 HEAD^ -- HEAD master &&
>> @@ -161,4 +185,16 @@ test_expect_success 'last wins in --rename-thre=
shold=3D<n> --no-renames' '
>>         check_no_renames
>>  '
>>
>> +test_expect_success 'last wins in --rename-threshold=3D<n> --find-r=
enames' '
>> +       git read-tree --reset -u HEAD &&
>> +       test_must_fail git merge-recursive --rename-threshold=3D25 -=
-find-renames HEAD^ -- HEAD master &&
>> +       check_find_renames_50
>> +'
>> +
>> +test_expect_success 'last wins in --find-renames --rename-threshold=
=3D<n>' '
>> +       git read-tree --reset -u HEAD &&
>> +       test_must_fail git merge-recursive --find-renames --rename-t=
hreshold=3D25 HEAD^ -- HEAD master &&
>> +       check_find_renames_25
>> +'
>> +
>>  test_done
