From: Stefan Beller <sbeller@google.com>
Subject: Re: 'git mv' doesn't move submodule if it's in a subdirectory
Date: Fri, 15 Apr 2016 11:24:56 -0700
Message-ID: <CAGZ79kajE-R84=dSpBBFttwwDg4DbF59gnmzaN-C2w6U3rFwVw@mail.gmail.com>
References: <5710A2D3.8090003@otterhall.com>
	<CAGZ79kaN-s74cJkgOq3+7e57-BKevMr8pr=tAHVEpELetVYnTA@mail.gmail.com>
	<CAGZ79kZifiEY1rg6KNFRnkOemjJhY9fFpxHmK0gB8fLh1siAxw@mail.gmail.com>
	<xmqqlh4ebumv.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?Q?Albin_Otterh=C3=A4ll?= <gmane@otterhall.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 20:25:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ar8QP-00076I-Nu
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 20:25:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbcDOSY6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 14:24:58 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:38013 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046AbcDOSY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 14:24:57 -0400
Received: by mail-ig0-f176.google.com with SMTP id ui10so30355361igc.1
        for <git@vger.kernel.org>; Fri, 15 Apr 2016 11:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=kr9zMk4Jg1kg7JOpNTeGTc3gxTw67BM3QRNw8FtG/nQ=;
        b=IUHhBzo0ae+GxRV9JFbzzjETPhx4DonVr0EvCiYG48igGi3XCWcrb2NM/ahwoPMj3Y
         ZKCQkVbjiRTkcf6r0+7AATQGwMptbSty7tBir/ukl5zyoIfQSZnlkP0K6O+h6Gnv2e6j
         YAL7ms+wfR7leJzdr65N5gBnMGh5HG1FAo3jys/S6Mvr74OKyvcZ2iZ9A6UfHnBc4w+R
         OyKgSFE+7NdjqHViEg2Cw5/n+QNbzaE10ree9Z24hgXVr8eS0iB9ukXmLO//z0MrVec/
         8uJNDthyBz74p/qJXqqMm6zYJZmoQycwe8PUkNGt4W1KQm10A0oDJFK0qXU8TbXOYmqO
         DLvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=kr9zMk4Jg1kg7JOpNTeGTc3gxTw67BM3QRNw8FtG/nQ=;
        b=B59gzhngs9GO/LIlHRwuDY0CssoxkBgNXcJfUVqknTdQDkSeCstgTQu/T6b5pnAQ75
         pwxmfNMFV+t0LB7OSn5E3xGseXpNXRXrnI5L7baxEXfFgbMrC9yEodJ4b9oMLIzFZwY8
         1HWnMrjSdow8oRDysRwiAzRPif82cqfR3oTZpgHDiZ3x7+DVguncUck2fdjbHJiFPUpL
         5eVjfR20ZPklk62/X1CTDvxEuFIy+/0hwbiJi4u1h5TlVe95hlfJIQ5G06X7JFGllGr2
         s2NO4tTfeuGMENBylZkU6u/Bxgbfi1KwH/LTLNTUeZiot4XOzVKt2efAvhr8PXPDcv3L
         66xg==
X-Gm-Message-State: AOPr4FWuIiMnx9lSqITR6TiDk2y1BWFdCy8J3BUorOO+8pygE38WfO8s8fq76SoCf7Gr1RIGqN7250lucOhckMWu
X-Received: by 10.50.112.10 with SMTP id im10mr6639302igb.93.1460744696536;
 Fri, 15 Apr 2016 11:24:56 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Fri, 15 Apr 2016 11:24:56 -0700 (PDT)
In-Reply-To: <xmqqlh4ebumv.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291632>

On Fri, Apr 15, 2016 at 11:21 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> I think I can reproduce the problem. A regression test (which currently fails)
>> could look like
>
> Thanks.  I however do not think this is a regression.
>
> Changes around 0656781f (mv: update the path entry in .gitmodules
> for moved submodules, 2013-08-06) did introduce "git mv dir1 dir2"
> when 'dir1' is a submodule, but I do not think it went beyond that.
> I do not see any effort to treat a submodule that is discovered by
> scanning a directory that was given from the command line,
> i.e. prepare_move_submodule() is not called for them, and the
> entries in the submodule_gitfile[] array that correspond to them are
> explicitly set to NULL in the loop.

Also I just realize this is not exactly the same bug as reported.
Albin complains about the .gitmodules file not being adjusted, whereas
the test case I wrote breaks commands in your superproject, i.e. `git status`
or `git diff` just dies.

(Manually inspecting the .gitmodules file turns out it is not adjusted as well.)

>
>
>> diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
>> index 4008fae..3b96a9a 100755
>> --- a/t/t7001-mv.sh
>> +++ b/t/t7001-mv.sh
>> @@ -292,6 +292,9 @@ test_expect_success 'setup submodule' '
>>         echo content >file &&
>>         git add file &&
>>         git commit -m "added sub and file" &&
>> +       mkdir -p deep/directory/hierachy &&
>> +       git submodule add ./. deep/directory/hierachy/sub &&
>> +       git commit -m "added another submodule" &&
>>         git branch submodule
>>  '
>>
>> @@ -475,4 +478,14 @@ test_expect_success 'mv -k does not accidentally
>> destroy submodules' '
>>         git checkout .
>>  '
>>
>> +test_expect_failure 'moving a submodule in nested directories' '
>> +       (
>> +               cd deep &&
>> +               git mv directory ../ &&
>> +               git status
>> +               # currently git status exits with 128
>> +               # fatal: Not a git repository:
>> directory/hierachy/sub/../../../../.git/modules/deep/directory/hierachy/sub
>> +       )
>> +'
>> +
>>  test_done
