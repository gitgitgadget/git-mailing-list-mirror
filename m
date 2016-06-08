From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH 2/4] t6030: explicitly test for bisection cleanup
Date: Wed, 8 Jun 2016 13:37:24 +0530
Message-ID: <CAFZEwPMpa1BHTP5BEqBHpYiab9G32tVXvLTZ95xhVeOcObCCBg@mail.gmail.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com>
 <20160607205454.22576-2-pranit.bauva@gmail.com> <CAPig+cRxGAR8s_Yn7EmCs0zQe2=F7RnhSw+0mtiZOfJtFkD_FQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 10:07:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAYWY-0001js-Nu
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 10:07:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754715AbcFHIHd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 04:07:33 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:33076 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753153AbcFHIHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 04:07:25 -0400
Received: by mail-yw0-f195.google.com with SMTP id y6so75411ywe.0
        for <git@vger.kernel.org>; Wed, 08 Jun 2016 01:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KSgRHn5gvbmYAPIITrt/mqm0MuGjhoDXlj4dbpwjYTA=;
        b=q4/ltPmLf4jgu7eam3wtaKbinAgtATE9yb2iTTVSjx1hYT+bML4BrctgXm0rFmMu3J
         /WTuCS//Mk0wT4MQQd6SWLyXEZ0HMVCpycl3eCLY5bJU47z2UaEs8yxvJIxoUYVkKu9M
         2z+hZeC/jG3Qkv+gpJCeDL5A/UwM6XPp7Lh5FRUw18LVSGeGIIEB2t4rZcPdnXD4NRd+
         oOcpqPpfC0gkC0oEKANnH53lGUJDNwARlYIjhJQPgfCwg/2NkuHE++4SBwTYbL6G5dqm
         sgQf3ytL1NEV3mu+wnroDoXphryQT6ULetcVU0D9xw7avnVm8aWT8uKgzakBmEiyAqkB
         0TiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KSgRHn5gvbmYAPIITrt/mqm0MuGjhoDXlj4dbpwjYTA=;
        b=Loq/Imbs6PBIRmdAUOl3qhLiN5klfdKBp4S3YUQ+O7RphcXWA8XRfb1aiSHnBYFHPy
         1hs6psy0uFvGwmXSErmYC8OGSfdIxlHrAXHbCHRwoEu57MgESuCD2DvnichekPMakHkG
         5sW/FuXjXoaDwGEHAaB4k7SEj/DHt7wEMj8j1LzDkDivfmwFkoQm5eUbBDtiFL0R4giI
         2z3zTY1rwfdJSUdMtsVQwrgccfDWn3XKm4Y1XpPYp80v7OVv3oxCbAt0vFg0NY+qBCk9
         KYj2iQbIcTbWz8CWv52B01WZq7/d7BxQ7s4FMlWqhfrk13tXCOKG74WfKYeFueF5c6pJ
         ioQg==
X-Gm-Message-State: ALyK8tJxWCwf/dnAD3UkaxP0VOtFU8QQNOmbRqib/F7BuAbjBnY8KxRmMYQexUmTB3dStMkm2tTmWsVT2wX/lA==
X-Received: by 10.13.198.5 with SMTP id i5mr1985242ywd.263.1465373244750; Wed,
 08 Jun 2016 01:07:24 -0700 (PDT)
Received: by 10.129.124.132 with HTTP; Wed, 8 Jun 2016 01:07:24 -0700 (PDT)
In-Reply-To: <CAPig+cRxGAR8s_Yn7EmCs0zQe2=F7RnhSw+0mtiZOfJtFkD_FQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296765>

Hey Eric,

On Wed, Jun 8, 2016 at 4:51 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Jun 7, 2016 at 4:54 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> This is not an improvement in the test coverage but it helps in making
>> it explicit as to what exactly would be the error as other tests are
>> focussed on testing other things.
>
> It's not clear why you consider this as *not* improving test coverage.

My mistake as I forgot to include a comment in this patch. I did it in
the previous patch[1]. I manually changed the file names and saw that
there were a couple of tests failing in each case.

>> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
>> ---
>> diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
>> @@ -894,4 +894,21 @@ test_expect_success 'bisect start takes options and revs in any order' '
>> +test_expect_success 'git bisect reset cleans bisection state properly' '
>> +       git bisect reset &&
>> +       git bisect start &&
>> +       git bisect good $HASH1 &&
>> +       git bisect bad $HASH4 &&
>> +       git bisect reset &&
>> +       test -z "$(git for-each-ref "refs/bisect/*")" &&
>
> I wonder if this would be more easily read as:
>
>     git for-each-ref "refs/bisect/*" >actual &&
>     test_must_be_empty actual &&

I just tried to imitate what the test t6030 previously had (a lot of
occurrences). Should I still change it to your specified format?
Should I also change the others as a side cleanup "while I am at it"?

>> +       ! test -s "$GIT_DIR/BISECT_EXPECTED_REV" &&
>> +       ! test -s "$GIT_DIR/BISECT_ANCESTORS_OK" &&
>> +       ! test -s "$GIT_DIR/BISECT_LOG" &&
>> +       ! test -s "$GIT_DIR/BISECT_RUN" &&
>> +       ! test -s "$GIT_DIR/BISECT_TERMS" &&
>> +       ! test -s "$GIT_DIR/head-name" &&
>> +       ! test -s "$GIT_DIR/BISECT_HEAD" &&
>> +       ! test -s "$GIT_DIR/BISECT_START"
>
> Is it the intention that these should verify that the files don't
> exist? Maybe use test_path_is_missing() instead?

True. In fact it would be much more appropriate to use
test_path_is_missing() as we are using remove_path() and thus there
shouldn't even exist a file with file size != 0. Thanks!

>> +'
>> +
>>  test_done

[1]: http://thread.gmane.org/gmane.comp.version-control.git/294520


Regards,
Pranit Bauva
