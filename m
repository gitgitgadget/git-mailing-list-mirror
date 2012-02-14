From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 0/2] test: tests for the "double > from mailmap" bug
Date: Tue, 14 Feb 2012 15:15:52 -0600
Message-ID: <20120214211552.GA9651@burratino>
References: <1329235894-20581-1-git-send-email-felipe.contreras@gmail.com>
 <20120214203431.GB13210@burratino>
 <CAMP44s3YRHgMPX2Hzydm_TLB27OABWETjABMcwrHmDk-=pN2hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 14 22:16:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxPjR-0001mp-FQ
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 22:16:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761216Ab2BNVQJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Feb 2012 16:16:09 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:61257 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757277Ab2BNVQG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2012 16:16:06 -0500
Received: by yhoo21 with SMTP id o21so338932yho.19
        for <git@vger.kernel.org>; Tue, 14 Feb 2012 13:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lRAst9BbpXRdk0/TP/cF+vnrGO0FN5iJJaEDgTyKYUA=;
        b=TK90f8GzqVT+IKr8L2oZIdgOTlvYfTbjziwZHVQ0PTHkZZrjOWOBRk1cKwY5L9PT0W
         dXh4Wxd7nW693Ly0nZEwvFvwi59U8nYOoQxk9PdSnq5vr+lkwgWi1uxQp/hNvgIMRBnE
         wM1uJxpTNpmcuAndeEpOK9jc/Ug3ryVZwPsR4=
Received: by 10.50.196.228 with SMTP id ip4mr37502834igc.28.1329254165848;
        Tue, 14 Feb 2012 13:16:05 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id va6sm21264455igc.4.2012.02.14.13.16.05
        (version=SSLv3 cipher=OTHER);
        Tue, 14 Feb 2012 13:16:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAMP44s3YRHgMPX2Hzydm_TLB27OABWETjABMcwrHmDk-=pN2hw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190759>

=46elipe Contreras wrote:
> On Tue, Feb 14, 2012 at 10:34 PM, Jonathan Nieder <jrnieder@gmail.com=
> wrote:

>> To summarize the previous discussion[1]: some people had comments, a=
nd
>> you seem to have found value in exactly none of them. =C2=A0OK. =C2=A0=
CC-ing
>> Peff, since he at least probably has looked over this code before.
>
> Just because you have comments doesn't mean I *must* address them. We
> have a difference of opinion, nothing wrong with that.

I said "OK", didn't I?

[...]
>> In fact it seems to be intended to test the case addressed by f02635=
8e
>> (name changing, email not) in various mailmap callers: "git shortlog=
 -e",
>> "git log --pretty", "git blame".
>
> No. As the summary says, it's intended to add a simple name
> translation test, which is missing from all the tests that spawn from
> the repository generated in 'Shortlog output (complex mapping)' test.
> This is the most minimal patch that can be generated if you add a
> commit to this repository, and any further tests that are related to
> it would look the same.
>
> As Junio pointed out what is missing from the explanation is that thi=
s
> simple name translation test is targeted toward the 'git blame'
> commands, because such translation is not tested for them currently.

Um.  So this has nothing to do with f026358e at all?  Mentioning that
commit and that this test does not pass with an older codebase is not
useful to the humans that will look over this test later?

Adding explanation and rearranging things so people encountering this
later have to spend _less_ time to understand it is something I
consider useful.  It means people are less likely to randomly break
things.  I don't actually understand where the difference of opinion
comes from here.
