From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 00/13] remote-hg: general updates
Date: Wed, 3 Apr 2013 03:20:30 -0600
Message-ID: <CAMP44s3czwYv7CDOkJ6t7=gYEC9s1Z2ygexfZwSs5JFfzGHGvw@mail.gmail.com>
References: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com>
	<20130402200948.GF2222@serenity.lan>
	<2670C2C0-E30F-47DA-8901-899FEE11059E@quendi.de>
	<CAMP44s3DETFBhexPhEEMP1TZGNrc91266=t16H2t_+VB_4V38w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Wed Apr 03 11:21:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNJsN-0005SG-K4
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 11:21:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761042Ab3DCJUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Apr 2013 05:20:33 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:47931 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760829Ab3DCJUb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Apr 2013 05:20:31 -0400
Received: by mail-la0-f46.google.com with SMTP id fq12so1231029lab.33
        for <git@vger.kernel.org>; Wed, 03 Apr 2013 02:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=0oWan8jHmZZ5ysCONsVSNiupV0D/7ovB7AHgnGYza5o=;
        b=A6rWQmHC6bOIFkU1WXI8qHlLbcINDQg4xUTHAFAPWT+GBiyJi4dNMAu6wAtWUd2b3/
         wfyL038j1dnc7mVtBwNUrAWFooV4Jh9LgyO7wErleFVfhsXgW+bwaOcs8LWvIjfg9D1N
         tsfe3FxzJ5B5NYlYcJWaHbpq//Mvmc7FPaft1/cg+94a4jV6i6LTCYcl+7Qshq4+oLev
         S2G3HIBe2Rp5OXBeLpZY5ikKrSS8DELoEOoPd20lshmnM7rIDc9kcjfgOpeKbAm6pc4f
         /0JTB5GlT2gJhp4Q+y6THz2IpFjxJXee2uorkhnz3267Gbw3WAWLxRfw73mUTUSplm6z
         DCzA==
X-Received: by 10.152.104.199 with SMTP id gg7mr504069lab.14.1364980830110;
 Wed, 03 Apr 2013 02:20:30 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Wed, 3 Apr 2013 02:20:30 -0700 (PDT)
In-Reply-To: <CAMP44s3DETFBhexPhEEMP1TZGNrc91266=t16H2t_+VB_4V38w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219928>

On Tue, Apr 2, 2013 at 7:31 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:

>> * added many new test cases, sadly still including some xfails. Several of these (both passing and xfailing) also apply to remote-hg (i.e. the issue is also present in contrib's remote-hg)
>
> I ran these test-cases with remote-hg, and the same test-cases pass. I
> only had to do minor modifications, most of the failures came from
> subtle differences such as different strategies to sanitize authors,
> and which branch to pick for HEAD.

After doing some modifications in remote-hg, here are the test cases
of gitifyhg v0.8 without modifications:

========================================================= test session
starts ==========================================================
platform linux2 -- Python 2.7.3 -- pytest-2.3.4
collected 80 items

test/test_author.py ........F
test/test_clone.py ......xx.........x...x..
test/test_notes.py ..FxF
test/test_pull.py ....x..xx..
test/test_push.py ..............x........FF...
test/test_special_cases.py ...

===============================================================
FAILURES ===============================================================
/home/felipec/tmp/gitifyhg/test/helpers.py:118: assert 'totally
<bad...e used in hg>' == 'totally <unknown>'
/usr/lib/python2.7/site-packages/sh.py:309: ErrorReturnCode_128:
/home/felipec/tmp/gitifyhg/test/test_notes.py:107: assert not 'error'
in 'searching for changes\nno changes found\nFrom
hg::file:///tmp/pytest-91/test_simple_push_updates_notes_after_contentf...rror:
refs/notes/hg does not point to a valid object!\nerror:
refs/notes/hg-origin does not point to a valid object!\n'
/home/felipec/tmp/gitifyhg/test/helpers.py:108: assert [u'Added tag
...780a9c', u'a'] == ['I tagged thi...nd user', 'a']
/home/felipec/tmp/gitifyhg/test/test_push.py:410: assert 'default' ==
'branch_one'
=========================================== 5 failed, 66 passed, 9
xfailed in 75.23 seconds ============================================

-- 
Felipe Contreras
