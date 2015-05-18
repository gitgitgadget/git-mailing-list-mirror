From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] subdirectory tests: code cleanup, uncomment test
Date: Mon, 18 May 2015 14:29:47 -0700
Message-ID: <CAGZ79kZ9h=Oev_mymFBRNyAGokAe8-vWh_D12VZYHTUv20Djvg@mail.gmail.com>
References: <xmqqlhglbt4k.fsf@gitster.dls.corp.google.com>
	<1431983426-4346-1-git-send-email-sbeller@google.com>
	<xmqqvbfpa8ff.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 18 23:29:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuSbi-000350-6o
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 23:29:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752412AbbERV3t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 17:29:49 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:33990 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254AbbERV3s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 17:29:48 -0400
Received: by ieczm2 with SMTP id zm2so109839629iec.1
        for <git@vger.kernel.org>; Mon, 18 May 2015 14:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4Pf/VauiHjKLA3C7z3f7T6/W0zXqfT4TgpM06OvNra8=;
        b=BeZw1o/ToX502rDFJ4ohVpDos9AJf3Wt1ywKly6cNwUTQrU40JzXqUiA0isSBFyv/J
         ty7v+8yTlKOrZc1Ie/HXjIfKgQAKu2m8Bnvp/Y97eaSaLNDQP9kCtB8uCIrd6ygOXg72
         PEhdsO83T1pHjU8ukuhzZmDiziTXnIAr070ytMezFnfpZShUaY8tHTjHWBE6lyDaouDC
         aa7xVIrwSS/poJpeobK/ZtbLZNrJfpVaPxFK0cRfSKpoW1KYQLPmeq55GqCe4ymEqHye
         tQ3i4U1wtvM5Vb9NYUnmN8WCzHN8UeRrEmb0r+jerL/QpuITUkK5bb3xEgogCtIbaDcU
         hHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=4Pf/VauiHjKLA3C7z3f7T6/W0zXqfT4TgpM06OvNra8=;
        b=WDmG0pQAGrXg8u1dZlSH8cEW2WLhR9HEUvfFcTmzWeF/bXOP9KPTkFAHEJu0A7ILRQ
         oXZM2PCFzNgM9HP5NVnnySAxZ5i9qByXj0rBNWsCyUqRIZV12pW3YqjF/E7TgyAhFh57
         6uVrVnqHOsWHNZKSvH+PDA2SXSQTvw77b1W9aOiS3n0bK7r/pk8f94JcI4hdRzja5BnX
         tzObjRHfSVuyMCOGeXAog3/eDPkwyBNPpf3ZgC2ziZ9mLLpLdJIvhuAGWektQxYzBiXw
         8NGVLjFd42IvITQab4jIUaeQCER5+30t04ttKKL6eCcnOLYqvp35gG1VYo8nxrUbuev6
         0e2w==
X-Gm-Message-State: ALoCoQl5Dt7ZK1YHUHEEe+XXHKFMDeoN5Eh045TqYQn1D21x0W26BPtXmMe3jp1Rh/Ghaat4JLwd
X-Received: by 10.50.143.97 with SMTP id sd1mr17141616igb.10.1431984587620;
 Mon, 18 May 2015 14:29:47 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Mon, 18 May 2015 14:29:47 -0700 (PDT)
In-Reply-To: <xmqqvbfpa8ff.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269323>

On Mon, May 18, 2015 at 2:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Originally the test in t1020 was meant to not include setting the GIT_DIR
>> when testing inside a bare repository as it did not work without setting
>> GIT_DIR explicitly.
>>
>> Nowadays the test as originally intended works, so add it to the test
>> suite. We'll keep the test, which has been run through all years as another
>> test for finding regressions.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>
>> Junio, thanks for providing the context!
>>
>> I tried tracking down when this changes via bisect, though I messed up.
>> By looking through the code I find these commits most promising to have
>> fixed the underlying issue (I am no expert on subdirectory treatment)
>> 337e51c (Use git_config_early() instead of git_config() during repo setup, 2010-11-26)
>> 72183cb (Fix gitdir detection when in subdir of gitdir, 2009-01-16)
>> 9951d3b (setup: clean up setup_discovered_git_dir(), 2010-11-26)
>
> Thanks for digging.
>
> I personally do not think we would need to say "historic" (as it
> makes it sound as if we do not care if the use case is deprecated
> and dropped in the future) but I do not offhand think of a better
> label for that test (other than doing the cop-out "test (1)" vs
> "test (2)"), so let's queue this as-is.

At first I was in the mood of labeling that test

    no file/rev ambiguity check inside a bare repo with GIT_DIR help
for older Gits

as in nursing homes for elder people, but I refrained from doing so
as it sounded derogatory in my mind and it broke the line limit.

I am not happy with (historic) either, maybe "(explicit GIT_DIR)"
is describing the test better without giving the reader the thoughts
as you raised here?

>
>
>>
>>  t/t1020-subdirectory.sh | 11 +++++++----
>>  1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/t/t1020-subdirectory.sh b/t/t1020-subdirectory.sh
>> index 2edb4f2..022641d 100755
>> --- a/t/t1020-subdirectory.sh
>> +++ b/t/t1020-subdirectory.sh
>> @@ -162,16 +162,20 @@ test_expect_success 'no file/rev ambiguity check inside .git' '
>>       )
>>  '
>>
>> -test_expect_success 'no file/rev ambiguity check inside a bare repo' '
>> +test_expect_success '(historic) no file/rev ambiguity check inside a bare repo' '
>> +     test_when_finished "rm -fr foo.git" &&
>>       git clone -s --bare .git foo.git &&
>>       (
>>               cd foo.git &&
>> +             # older Git needed help by exporting GIT_DIR=.
>> +             # to realize that it is inside a bare repository.
>> +             # We keep this test around for regression testing.
>>               GIT_DIR=. git show -s HEAD
>>       )
>>  '
>>
>> -# This still does not work as it should...
>> -: test_expect_success 'no file/rev ambiguity check inside a bare repo' '
>> +test_expect_success 'no file/rev ambiguity check inside a bare repo' '
>> +     test_when_finished "rm -fr foo.git" &&
>>       git clone -s --bare .git foo.git &&
>>       (
>>               cd foo.git &&
>> @@ -180,7 +184,6 @@ test_expect_success 'no file/rev ambiguity check inside a bare repo' '
>>  '
>>
>>  test_expect_success SYMLINKS 'detection should not be fooled by a symlink' '
>> -     rm -fr foo.git &&
>>       git clone -s .git another &&
>>       ln -s another yetanother &&
>>       (
