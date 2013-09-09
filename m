From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/4] Re: [PATCH 3/4] t: rev-parse-parents: avoid yoda conditions
Date: Sun, 8 Sep 2013 19:45:07 -0500
Message-ID: <CAMP44s2U2pUNHjhq9x1tcJfanDpYNOyORwyWkvwtoCUA9Jv+yA@mail.gmail.com>
References: <20130904171356.GD2582@serenity.lan>
	<xmqq1u54o5c4.fsf@gitster.dls.corp.google.com>
	<20130904183559.GA3465@sigill.intra.peff.net>
	<CAMP44s3O=cHAtHOj41MccBDOausukb49MV-E6jib6n6czs+p3Q@mail.gmail.com>
	<20130908040615.GA14019@sigill.intra.peff.net>
	<CAMP44s16RZ9JguL=NPcD8TE-gdG7vGEa5KLHzv4bf_VLLEhPRw@mail.gmail.com>
	<20130908042649.GC14019@sigill.intra.peff.net>
	<CAMP44s1uasvGmCMkMF2N0eTMgOdksG0HqeidXK+159HAi4jkpA@mail.gmail.com>
	<20130908050227.GG14019@sigill.intra.peff.net>
	<CAMP44s1HXeQ1pgCeY=RsDcx4H--YHBfzmoQ4rjJ37t5N30pq5A@mail.gmail.com>
	<20130908234519.GA11860@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 09 02:45:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIpbf-0005qw-Jy
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 02:45:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125Ab3IIApK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 20:45:10 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:32856 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848Ab3IIApJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 20:45:09 -0400
Received: by mail-la0-f44.google.com with SMTP id eo20so4467570lab.3
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 17:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=wwZbTALJ3MF0Z97F1b6jO2DmwpdKUIRUexBfP302pac=;
        b=QBoT+gFjQFNy2XF8/TGAC7o/piSS4E2RTv/h5A+5OJp9OsB/MwH02PejnvJDeutiIk
         IJdzfWl/dF1pBOsMUQvGIotHqKTox5h/d7JyY/kPoICMG/5XsolSxi95EUNQpEYhQOlB
         jWHrrUdJ9srEZUEc5b2ppdrIGFhz1lcZZel6sZmdROY0Aa/Qd1Hx0G3ZhZRMfpV6tMKa
         K+UAGXQ8O+WiiGxQ9AkWP9BV38ilmBjZ36Gk/IrfsH6juuKj2sUQF+cVRDIaT2Niy6gl
         bQK3RFFU8RxcwldyfbFnsBKgQ+iGG19TCroOhnZizKM78+sqv7DlXRbLve1Auv0zeG8s
         K5JQ==
X-Received: by 10.112.143.3 with SMTP id sa3mr13921019lbb.12.1378687507590;
 Sun, 08 Sep 2013 17:45:07 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sun, 8 Sep 2013 17:45:07 -0700 (PDT)
In-Reply-To: <20130908234519.GA11860@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234294>

On Sun, Sep 8, 2013 at 6:45 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Sep 08, 2013 at 06:25:45PM -0500, Felipe Contreras wrote:
>
>> > And I do not think it is a problem. The point of the function is not to
>> > abstract away the idea of comparison. The point is to give a hook for
>> > people on systems without "diff -u" to run the test suite.
>>
>> The point according to whom? I say it's the other way around.
>
> The point according to 82ebb0b (add test_cmp function for test scripts,
> 2008-03-12). I wish I had simply called it test_diff back then, and then
> this conversation could have never occurred.

So? That's the original intention from the author, it's not the point
of the function from the project's point of view, or what the point
_should_ be.

>> Either way the fact that others are doing it differently doesn't mean
>> that's the best way, that would be argumentum ad populum, and mothers
>> are keen to remind us that if other kids are jumping the bridge, that
>> doesn't mean we should too.
>
> Did I once say "my way of thinking about it is the best way"? No. I said
> "I think it is a matter of preference". I mentioned other systems using
> a particular ordering to show that the set of people who prefer it the
> other way is non-zero.

That doesn't show it they prefer it that way. They could be in the
same situation than us, they might prefer it a different way, but they
are stuck with what they chose long time ago.

> Feel free to respond, but I have no interest in discussing this any
> further with you. This thread has become a giant time sink, and I have
> nothing else to say on the matter that I have not already said.

It's all right, I don't think you were contributing much more than;
diff -u does $expect $actual.

In case the above gets misconstrued as an insult, it's not meant that
way, Jeff said it himself; he cannot depart his view away from the
diff -u implementation.

-- 
Felipe Contreras
