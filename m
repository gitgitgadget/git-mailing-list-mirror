From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2 3/3] rev-list --min-parents,--max-parents: doc and test
 and completion
Date: Tue, 22 Mar 2011 19:47:30 -0500
Message-ID: <20110323004730.GA10014@elie>
References: <cover.1300702130.git.git@drmicha.warpmail.net>
 <8bad49d4e4897be623b7af3096498a5803dbbd89.1300702130.git.git@drmicha.warpmail.net>
 <20110321184514.GA1850@elie>
 <4D8855D4.6080804@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Mar 23 01:47:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2CEi-0004Lm-AM
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 01:47:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116Ab1CWArj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 20:47:39 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:45174 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444Ab1CWAri (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 20:47:38 -0400
Received: by gxk21 with SMTP id 21so3140386gxk.19
        for <git@vger.kernel.org>; Tue, 22 Mar 2011 17:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=5icH8V7EORp+gnY68zO5AOQ49LA5KPWLXlg9yzJ/hMc=;
        b=D22+ecyJNQhxHCj4N2gYjv7KySvAUjNG6PayFOm5E8dpEx3xV3t4sTDWhJ+CHQEk9T
         KZxmc/Q83Mj5PJpOQC4EL8xaVRmdtChD1qUDgbdoGaRn6CNwSn2wPviYqOdJc8TkQI8h
         2IbqYk8Ql1RFVWmlhCco4+13q1vniHWbRpi6A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=WnQLii91dlXEgjUuNZyktc/3R2k5pB3ckDIHjEt1gldOy1cs8h4CYOso5yGpBJ+t1t
         jBL7p8/ptLwSYLhWykxu5cCPm3TT4QO4RID6l/UK/Svwqs7Nh65HG3urqNcqv3z+FL4K
         IQxjGx5XaQS0c0UbBlwKdyEP33u/SUMShR818=
Received: by 10.100.112.20 with SMTP id k20mr4142266anc.163.1300841257797;
        Tue, 22 Mar 2011 17:47:37 -0700 (PDT)
Received: from elie (adsl-68-255-102-141.dsl.chcgil.ameritech.net [68.255.102.141])
        by mx.google.com with ESMTPS id r8sm5103465ane.45.2011.03.22.17.47.34
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Mar 2011 17:47:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4D8855D4.6080804@drmicha.warpmail.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169791>

Michael J Gruber wrote:
> Jonathan Nieder venit, vidit, dixit 21.03.2011 19:45:
>> Michael J Gruber wrote:

>>> Based on mg/rev-list-one-side-only (in next) to save Junio a build conflict
>>> resolution.
>>
>> Not a serious problem, but I wish it hadn't been.  What particular
>
> But why? Basing it on something earlier would have served no purpose
> (that I know of) at all.
>
> I should have mentioned the dependency in v1.

*nod*  Sorry, I was just confused before --- I hadn't understood why
you were doing it.  Giving a heads up like you did about interaction
between topics is indeed very useful.

To answer your question about why: basing it on master would mean
that Junio could merge it to master without merging
mg/rev-list-one-side-only first.  Similarly, I had wanted to test
against master because master is what I use day-to-day so applying
it there would avoid confusing unrelated changes.

>> Seems hackish.  Maybe --no-max-parents could denote infinity?
>
> For me, "-1" is a quite natural way to reset a count type parameter

Natural to me in code, but not on the command line.  I can write a
separate patch for --no-max-parents if you'd like.

> There is no problem parsing for "--max-parents=infinity" and/or
> "--no-max-parents" or even (better?) "--max-parents=" without number,
> it's only a matter of bike shedding decisions.

Well, if it doesn't matter what color it is, I guess I shouldn't have
mentioned it then?

> Hmmm, are there whitespace issues which am warns about and diff does
> not, or have I missed a warning?

Yep, diff doesn't warn about anything without --check.

>>> +test_expect_success 'rev-list override and infinities' '
>>> +
>>> +	check_revlist "--min-parents=2 --max-parents=1 --max-parents=3" tripus normalmerge &&
>>> +	check_revlist "--min-parents=1 --min-parents=2 --max-parents=7" tetrapus tripus normalmerge &&
>>> +	check_revlist "--min-parents=2 --max-parents=8" tetrapus tripus normalmerge &&
>>> +	check_revlist "--min-parents=2 --max-parents=-1" tetrapus tripus normalmerge
>>> +'
>> 
>> 7 and 8 don't mean infinity any more, do they?  What is this test
>> checking?
>
> The test checks "override and infinities", where the plural indicates
> the fact that it tests different ways of spelling (practical) infinity
> such as the very suggestive "8" which nobody cares about but me.

Ah, so that's what you meant.  git.git has very few octopus merges,
so even "4" is a practical infinity there (well, technically there's
an early 6-parent commit).

Regards,
Jonathan
