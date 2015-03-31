From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH] t9814: Guarantee only one source exists in git-p4 copy tests
Date: Tue, 31 Mar 2015 14:26:56 +0100
Message-ID: <CAE5ih7-jrh2dE=LS7dWyM-xxpGe5yFPnDfZUYGX-=0o4uaM72A@mail.gmail.com>
References: <1427545730-3563-1-git-send-email-vitor.hda@gmail.com>
	<1427671914-12131-1-git-send-email-vitor.hda@gmail.com>
	<xmqqk2xzxk3y.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Pete Wyckoff <pw@padd.com>, Git Users <git@vger.kernel.org>,
	Vitor Antunes <vitor.hda@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 15:27:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YcwCV-00023i-I6
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 15:27:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754783AbbCaN1O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 09:27:14 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:34020 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754434AbbCaN1M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 09:27:12 -0400
Received: by obbgh1 with SMTP id gh1so26005830obb.1
        for <git@vger.kernel.org>; Tue, 31 Mar 2015 06:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=xHdU0QGIiCfqPetPo5TjIQ0HKcwFo0hRRnphjhLI48M=;
        b=PVVTCrGmes+/1DuI64RemB4sCRBhTqIJBadR9AdrHpexWVaQmrpcR/8fndPIt4knQ3
         uSAksKFzYpzgGpi8pualj5AIz04P9FSGDz+eQCcZEjYAViltFQptUyS6efdbYx1+WSkA
         6XQxIh+VBMrXeRG94v7xkWg3VWti1/twWkJ/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=xHdU0QGIiCfqPetPo5TjIQ0HKcwFo0hRRnphjhLI48M=;
        b=azJtvqHW3AQoKz8FNt5LbT7orlPSoyqOvDNUmzh1sFVM15ADDgL2+GCFtzrBxNjSXy
         VP14MlXNnhxitxYMb0s/RX9Os/DV0e819vxjd9PDyS5Bn7y8Zaqulvnt6hKZKAB4UOK4
         JJ3TnZlqqXjrUcaoAfUbZjjYITRQ83I0Yfu/ePNk0VkF/Y7KM/QgaIPMD30KOPTjru1K
         uth2PeaKSAVgq8csVs4kmh8jqHy2Z8w8LfrG1Ci0WJZ7BWZZXgcq/ST9eSeTL6DXE+rF
         jdE+lRH4X9/4x4H9YHnvkk0h76ZKgG1SS90QMiMjodEaRCpucvTUyVgRsQSVTB4GcuGj
         t/gg==
X-Gm-Message-State: ALoCoQkcZVpY9cIvOaHeoC84Y8B0UthfLMoWjiJxl3AmGZa3KtbeOaXImlDK7r3oL62XEkIuSADD
X-Received: by 10.182.142.101 with SMTP id rv5mr31257525obb.13.1427808416443;
 Tue, 31 Mar 2015 06:26:56 -0700 (PDT)
Received: by 10.60.162.74 with HTTP; Tue, 31 Mar 2015 06:26:56 -0700 (PDT)
In-Reply-To: <xmqqk2xzxk3y.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266524>

I'm on holiday this week, so I'll not get a chance to look at these
properly until next week.

Luke


On 30 March 2015 at 04:03, Junio C Hamano <gitster@pobox.com> wrote:
> Vitor Antunes <vitor.hda@gmail.com> writes:
>
>> * Modify source file (file2) before copying the file.
>> * Check that only file2 is the source in the output of "p4 filelog".
>> * Remove all "case" statements and replace them simple tests to check that
>>   source is "file2".
>>
>> Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
>> ---
>
> I am not a Perfoce user, so I'd like to ask Pete's and Luke's
> comments on these changes.
>
>>  t/t9814-git-p4-rename.sh |   46 +++++++++++++++++++++++++++++++---------------
>>  1 file changed, 31 insertions(+), 15 deletions(-)
>>
>> diff --git a/t/t9814-git-p4-rename.sh b/t/t9814-git-p4-rename.sh
>> index 8b9c295..d8fb22d 100755
>> --- a/t/t9814-git-p4-rename.sh
>> +++ b/t/t9814-git-p4-rename.sh
>> @@ -132,6 +132,9 @@ test_expect_success 'detect copies' '
>>               cd "$git" &&
>>               git config git-p4.skipSubmitEdit true &&
>>
>> +             echo "file8" >> file2 &&
>
> Style: please lose SP between redirection and its target, i.e.
>
>         echo file8 >>file2 &&
>
> The same comment applies to everywhere else.
>
>> +             git commit -a -m "Differentiate file2" &&
>> +             git p4 submit &&
>>               cp file2 file8 &&
>>               git add file8 &&
>>               git commit -a -m "Copy file2 to file8" &&
>> @@ -140,6 +143,10 @@ test_expect_success 'detect copies' '
>>               p4 filelog //depot/file8 &&
>>               p4 filelog //depot/file8 | test_must_fail grep -q "branch from" &&
>>
>> +             echo "file9" >> file2 &&
>> +             git commit -a -m "Differentiate file2" &&
>> +             git p4 submit &&
>> +
>>               cp file2 file9 &&
>>               git add file9 &&
>>               git commit -a -m "Copy file2 to file9" &&
>> @@ -149,28 +156,39 @@ test_expect_success 'detect copies' '
>>               p4 filelog //depot/file9 &&
>>               p4 filelog //depot/file9 | test_must_fail grep -q "branch from" &&
>>
>> +             echo "file10" >> file2 &&
>> +             git commit -a -m "Differentiate file2" &&
>> +             git p4 submit &&
>> +
>>               echo "file2" >>file2 &&
>>               cp file2 file10 &&
>>               git add file2 file10 &&
>>               git commit -a -m "Modify and copy file2 to file10" &&
>>               git diff-tree -r -C HEAD &&
>> +             src=$(git diff-tree -r -C HEAD | sed 1d | sed 2d | cut -f2) &&
>> +             test "$src" = file2 &&
>>               git p4 submit &&
>>               p4 filelog //depot/file10 &&
>> -             p4 filelog //depot/file10 | grep -q "branch from //depot/file" &&
>> +             p4 filelog //depot/file10 | grep -q "branch from //depot/file2" &&
>> +
>> +             echo "file11" >> file2 &&
>> +             git commit -a -m "Differentiate file2" &&
>> +             git p4 submit &&
>>
>>               cp file2 file11 &&
>>               git add file11 &&
>>               git commit -a -m "Copy file2 to file11" &&
>>               git diff-tree -r -C --find-copies-harder HEAD &&
>>               src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
>> -             case "$src" in
>> -             file2 | file10) : ;; # happy
>> -             *) false ;; # not
>> -             esac &&
>> +             test "$src" = file2 &&
>>               git config git-p4.detectCopiesHarder true &&
>>               git p4 submit &&
>>               p4 filelog //depot/file11 &&
>> -             p4 filelog //depot/file11 | grep -q "branch from //depot/file" &&
>> +             p4 filelog //depot/file11 | grep -q "branch from //depot/file2" &&
>> +
>> +             echo "file12" >> file2 &&
>> +             git commit -a -m "Differentiate file2" &&
>> +             git p4 submit &&
>>
>>               cp file2 file12 &&
>>               echo "some text" >>file12 &&
>> @@ -180,15 +198,16 @@ test_expect_success 'detect copies' '
>>               level=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f1 | cut -d" " -f5 | sed "s/C0*//") &&
>>               test -n "$level" && test "$level" -gt 0 && test "$level" -lt 98 &&
>>               src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
>> -             case "$src" in
>> -             file10 | file11) : ;; # happy
>> -             *) false ;; # not
>> -             esac &&
>> +             test "$src" = file2 &&
>>               git config git-p4.detectCopies $(($level + 2)) &&
>>               git p4 submit &&
>>               p4 filelog //depot/file12 &&
>>               p4 filelog //depot/file12 | test_must_fail grep -q "branch from" &&
>>
>> +             echo "file13" >> file2 &&
>> +             git commit -a -m "Differentiate file2" &&
>> +             git p4 submit &&
>> +
>>               cp file2 file13 &&
>>               echo "different text" >>file13 &&
>>               git add file13 &&
>> @@ -197,14 +216,11 @@ test_expect_success 'detect copies' '
>>               level=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f1 | cut -d" " -f5 | sed "s/C0*//") &&
>>               test -n "$level" && test "$level" -gt 2 && test "$level" -lt 100 &&
>>               src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
>> -             case "$src" in
>> -             file10 | file11 | file12) : ;; # happy
>> -             *) false ;; # not
>> -             esac &&
>> +             test "$src" = file2 &&
>>               git config git-p4.detectCopies $(($level - 2)) &&
>>               git p4 submit &&
>>               p4 filelog //depot/file13 &&
>> -             p4 filelog //depot/file13 | grep -q "branch from //depot/file"
>> +             p4 filelog //depot/file13 | grep -q "branch from //depot/file2"
>>       )
>>  '
