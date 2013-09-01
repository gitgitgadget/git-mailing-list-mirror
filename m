From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 11/11] t6050-replace: use some long option names
Date: Sun, 01 Sep 2013 12:01:32 +0200 (CEST)
Message-ID: <20130901.120132.1611298105222242724.chriscool@tuxfamily.org>
References: <20130831190528.26699.33964.chriscool@tuxfamily.org>
	<20130831191215.26699.76207.chriscool@tuxfamily.org>
	<CAPig+cSwQdhybTzRwqGLbdxGRcAZfBeU6jjWYy43G0oT0hxkNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, philipoakley@iee.org,
	trast@inf.ethz.ch, j6t@kdbg.org
To: sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Sun Sep 01 12:01:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VG4Tl-0001NG-M1
	for gcvg-git-2@plane.gmane.org; Sun, 01 Sep 2013 12:01:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757217Ab3IAKBo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Sep 2013 06:01:44 -0400
Received: from mail-2y.bbox.fr ([194.158.98.15]:53911 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755596Ab3IAKBn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Sep 2013 06:01:43 -0400
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id C30565E;
	Sun,  1 Sep 2013 12:01:36 +0200 (CEST)
In-Reply-To: <CAPig+cSwQdhybTzRwqGLbdxGRcAZfBeU6jjWYy43G0oT0hxkNw@mail.gmail.com>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233580>

From: Eric Sunshine <sunshine@sunshineco.com>
>
>> diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
>> index 0b07a0b..5dc26e8 100755
>> --- a/t/t6050-replace.sh
>> +++ b/t/t6050-replace.sh
>> @@ -122,9 +122,9 @@ test_expect_success '"git replace" listing and deleting' '
>>       test "$HASH2" = "$(git replace -l)" &&
>>       test "$HASH2" = "$(git replace)" &&
>>       aa=${HASH2%??????????????????????????????????????} &&
>> -     test "$HASH2" = "$(git replace -l "$aa*")" &&
>> +     test "$HASH2" = "$(git replace --list "$aa*")" &&
>>       test_must_fail git replace -d $R &&
>> -     test_must_fail git replace -d &&
>> +     test_must_fail git replace --delete &&
>>       test_must_fail git replace -l -d $HASH2 &&
> 
> Is this sort of change a good idea? A person reading the code, but not
> familiar with this particular patch, might not understand the
> seemingly random choice of short versus long option usage. Such a
> person might be led to wonder if there is some subtle difference
> between the short and long forms,

I don't think that we should care about people who might wonder if
there are subtle differences between short and long forms, because of
such tests.

The doc says that there is no difference, and there is also no
difference in other git commands, and git replace is an advanced
command, and very few regular users probably read tests, ...

> and then unnecessarily spend time
> digging into the code and documentation in an attempt to figure it
> out. Alternately, someone reading the code might be led to assume that
> the person who added the tests was being sloppy.

Why not just assume that the person who added the tests is so great as
to even take care of testing the long options names?

> Hopefully, t0040-parse-options should already be proof enough that
> long options are correctly handled, 

Yeah, indeed!

> but if you really want to test
> them here too, it seems like a separate test would be more appropriate
> than randomly changing short form options to long in various tests.

Introducing some randomness in tests also has some value, you
know. And at the same time it doesn't even slow down the test suite
while adding separate tests would slow it down, and make readers spend
more time reading the whole test suite, and would be a bigger burden
for git developers to maintain for no good reason.

Best,
Christian.
