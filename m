From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/4] Re: [PATCH 3/4] t: rev-parse-parents: avoid yoda conditions
Date: Sun, 8 Sep 2013 18:25:45 -0500
Message-ID: <CAMP44s1HXeQ1pgCeY=RsDcx4H--YHBfzmoQ4rjJ37t5N30pq5A@mail.gmail.com>
References: <20130903170419.GA29921@google.com>
	<xmqqli3co7ov.fsf@gitster.dls.corp.google.com>
	<20130904171356.GD2582@serenity.lan>
	<xmqq1u54o5c4.fsf@gitster.dls.corp.google.com>
	<20130904183559.GA3465@sigill.intra.peff.net>
	<CAMP44s3O=cHAtHOj41MccBDOausukb49MV-E6jib6n6czs+p3Q@mail.gmail.com>
	<20130908040615.GA14019@sigill.intra.peff.net>
	<CAMP44s16RZ9JguL=NPcD8TE-gdG7vGEa5KLHzv4bf_VLLEhPRw@mail.gmail.com>
	<20130908042649.GC14019@sigill.intra.peff.net>
	<CAMP44s1uasvGmCMkMF2N0eTMgOdksG0HqeidXK+159HAi4jkpA@mail.gmail.com>
	<20130908050227.GG14019@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 09 01:26:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIoMl-00076A-L0
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 01:26:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879Ab3IHXZr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 19:25:47 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:65285 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750835Ab3IHXZq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 19:25:46 -0400
Received: by mail-lb0-f177.google.com with SMTP id p5so4363053lbi.36
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 16:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=bfqjKKOsA4QMqgWAw90EiWuSMEG+WCUE3dDG56QqA9A=;
        b=L6PWz1ZdeFz1XQh+WbEtnGTS+EEcwLBZEZkpP+YFCv8Fm6iLCSDF+j3CJUQEJLuPaf
         45X4TaR1JhQZ1aST4P3ylUNpbbucYZ5eQBcqTnGcjme72DgncJCc11oBYa1dGJPzhgwz
         c+3KeFzA93soE/7QBtRKJg1HCQUZpdzXX9Jz4gyN9G5+cOynQlwibUaoFMGiWBThJU93
         Yl+ZFKch6fON7ViwxZOgcxLQ3MWaFXlNpgFXqJqz7Fbo1OoTiuo2hFJI1cpSa9X0Gjlx
         g3HXguqBXW+1ynhAWZNjWnwKN3vhHv1iHnU5fUKbExouAcWFCd2huhOqHulfLzpW4qxL
         Nr8w==
X-Received: by 10.112.156.166 with SMTP id wf6mr13630563lbb.13.1378682745637;
 Sun, 08 Sep 2013 16:25:45 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sun, 8 Sep 2013 16:25:45 -0700 (PDT)
In-Reply-To: <20130908050227.GG14019@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234283>

On Sun, Sep 8, 2013 at 12:02 AM, Jeff King <peff@peff.net> wrote:
> On Sat, Sep 07, 2013 at 11:52:10PM -0500, Felipe Contreras wrote:
>
>> > Ah, you mean "if you think that the compare function should behave like
>> > C *_cmp functions, it should be A-B". Perhaps it is simply that I do not
>> > think of the function in those terms, but more like "show me the
>> > differences from B to A".
>>
>> But that is the problem, you are unable to ignore the implementation.
>> You don't see test_cmp(), you see 'diff -u'.
>
> Yes, I already said earlier in the thread:
>
>   I certainly think of "test_cmp A B" as "differences from A to B", and
>   the order makes sense. IOW, the "test_cmp is diff" abstraction is
>   leaky, and that is fine (if it were not leaky, then order would not
>   matter at all, but it clearly does).

Then I don't think you can give a fair and objective opinion about
what should be the ideal ordering of the arguments. You would be
forever biased to whatever is the order of 'diff -u'.

> And I do not think it is a problem. The point of the function is not to
> abstract away the idea of comparison. The point is to give a hook for
> people on systems without "diff -u" to run the test suite.

The point according to whom? I say it's the other way around.

>> > John mentioned JUnit, NUnit, and PHPUnit earlier in the thread. I
>> > believe that Ruby's Test::Unit::Assertions also has
>> > assert_equal(expected, actual).
>>
>> That's because they all do first expect, then actual.
>>
>> assert_equal( expected, actual, failure_message = nil )
>> assert_not_equal( expected, actual, failure_message = nil )
>>
>> That's why.
>
> I do not see any reason why "not_equal" would not also work as
> "assert_not_equal(actual, expected)". Maybe I am missing your point.

All right, maybe it's because Ruby started in Japan, and their
sentences have very different orderings, maybe it's legacy from
another test framework, maybe there's no reason at all and somebody
just randomly picked them.

Either way the fact that others are doing it differently doesn't mean
that's the best way, that would be argumentum ad populum, and mothers
are keen to remind us that if other kids are jumping the bridge, that
doesn't mean we should too.

-- 
Felipe Contreras
