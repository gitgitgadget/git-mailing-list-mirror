From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] rev-list --min-parents,--max-parents: doc and test
 and completion
Date: Mon, 21 Mar 2011 12:49:17 -0500
Message-ID: <20110321174917.GA8202@elie>
References: <cover.1300459016.git.git@drmicha.warpmail.net>
 <182c5ece22835559a9762e242adb701547cf6575.1300459017.git.git@drmicha.warpmail.net>
 <20110318211418.GA23407@elie>
 <4D8711DD.2040407@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Mar 21 18:49:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1jEQ-0007Kf-T9
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 18:49:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752348Ab1CURt0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 13:49:26 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:59978 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604Ab1CURtZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 13:49:25 -0400
Received: by yia27 with SMTP id 27so2531368yia.19
        for <git@vger.kernel.org>; Mon, 21 Mar 2011 10:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=2738CaekVyCWXidOIuV5C4r9/ZC7/rq6Ou7zu+O3RtQ=;
        b=axvXvPZslGNAP6dT4SsEPOo7f2X1LgRTcMQqknYVhyVNbaLTqcAaJsQicoHlw69ad/
         DQfEZVQUxU6sfp3wZLH6mFYTBoBn6A+4obv4Y3yKA1q1fIqBCBEdRJPXnhLE04VjyCxy
         KsoOfo6HGp9zorXoUreooZL3dSfTO+WjP5nQk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=XLY/MsTyEjGpE0/XwmzTH2GMXfc5PwvbhgBK54kvSXqId82//PHfoSGQNzZEHFVm+w
         q5nt963Xy34uJI9xPA3OTOWYxrM/jI4mPvvXL0IJ3UVscgxEeMJQy75aFPVLfnx3nQeC
         TmqCzoMNdOQ83JhVMbSB+oA6my6uPLNRtDQxQ=
Received: by 10.90.19.40 with SMTP id 40mr4114729ags.77.1300729763316;
        Mon, 21 Mar 2011 10:49:23 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.ameritech.net [69.209.56.53])
        by mx.google.com with ESMTPS id w6sm7758270anf.6.2011.03.21.10.49.21
        (version=SSLv3 cipher=OTHER);
        Mon, 21 Mar 2011 10:49:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4D8711DD.2040407@drmicha.warpmail.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169619>

Michael J Gruber wrote:

> Come on, with a cover-letter saying doc and tests are in 3/3, how much
> effort is it to read that before 1/3 if you care?

Nonzero.  Now multiply that by the number of people who are going to
look at the history over the years.

> The tests are bogus before the code and the doc pointless before it.
>
> Squashing 1 and 3 is okay, of course. For my own digestion, smaller
> bites are better.

The reason I mentioned the possibility of docs and tests before
implementation is that that can be a good way to get feedback on the
design of something when the implementation is not even ready yet.
Which doesn't apply hear, of course.

Anyway, I don't care too much about this, but I wanted to make the
convention clear (if I have understood it correctly, at least).

>>    Avoiding the for loop means errors from 'echo' before the last
>>    iteration are not ignored; a more verbose way to write the same
>
> Do we really need to safe-guard echo and prints?

No; sorry about that.  I get worried about for loops because they
have a tendency to start using git commands later, but I shouldn't
have mentioned it.

> Thanks for both of the above, that makes things much better. Although I
> have to treat the case with empty rev-list specially now, or use the
> verbose version.

Sorry I missed it; good catch.  I don't recommend

	printf ${1+'%s\n' "$@"}

> Dodeka, really? I leave that to you.
> I might add a tetrapus, though.

I meant "greater than eight", since it seemed like a test that in
some alternate universe could fail.  I'll write a test on top.

(Dodecapus comes from [1].)
http://thread.gmane.org/gmane.comp.version-control.git/15486 )I mentioned dodecapus

> wins against? Against itself, i.e. it overrides previous occurences. But
> I'll separate these.

Thanks.  The details weren't important.

>> 	test_expect_failure '--max-parents=gobbledegood errors out' '
>> 		...
>> 	'
>
> I don't really want to parse for the string "infinity" nor go for strtol
> instead of atoi. Why shouldn't something "unparseable" be 0?

Three reasons:

 1) why shouldn't it be -1 or 27?  When in doubt, it's best to let
    the operator know so she can specify what is wanted unambiguously.
 2) to catch typos on the commandline and bugs in scripts
 3) less importantly, erroring out makes it less likely someone is
    going to rely on it (since we didn't point out their typo) and
    thus makes future extensions easier

Thanks again.  Now to look at v2. :)
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/15486
