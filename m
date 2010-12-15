From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: html userdiff is not showing all my changes
Date: Wed, 15 Dec 2010 10:29:01 +0100
Message-ID: <4D088A5D.60705@drmicha.warpmail.net>
References: <561247.22837.qm@web110707.mail.gq1.yahoo.com> <4D08850D.3010402@drmicha.warpmail.net> <20101215091250.GO3069@login.drsnuggles.stderr.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: matthijs@stdin.nl, Scott Johnson <scottj75074@yahoo.com>,
	git@vger.kernel.org, trast@student.ethz.ch
X-From: git-owner@vger.kernel.org Wed Dec 15 10:31:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSnhv-0004bb-VJ
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 10:31:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847Ab0LOJb3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Dec 2010 04:31:29 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:36219 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751722Ab0LOJb1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Dec 2010 04:31:27 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 12420B8F;
	Wed, 15 Dec 2010 04:31:27 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 15 Dec 2010 04:31:27 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=6u+a2TpomhFhZqfdv6dgpJ+2r7g=; b=mwK8lEy2F5ZQ5EzIqEuLr/ljmTD+QCMUnzaF9osyLATAbUxGal+aK7gJjtSlBcI7ae4ROqX0mCXCrfmPeO2DfD5tf8tGzRn3fZ5Frk6MTmbwgVeLqAKupAF7FnDuhyDTFhAdwdLOPYnqLFlvDSpTtXsUzJ2kcVInZfgoJQK2Q34=
X-Sasl-enc: sckQFH3xe6RCVus+r9YSSy/32UkFjUGnEk3r04C/a3VZ 1292405486
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 42113441DCD;
	Wed, 15 Dec 2010 04:31:26 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <20101215091250.GO3069@login.drsnuggles.stderr.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163749>

Matthijs Kooijman venit, vidit, dixit 15.12.2010 10:12:
> Hi Michael,
> 
>> If a wordRegex can make parts of diff disappear than there is problem
>> deeper in the diff machinery.
> It can do exactly that. The word regex determines what is a word, but
> everything else is counted as "whitespace". The word diff view shows
> only differences in words, not in whitespace (which is intentional,
> since whitespace changes in things like LaTeX or HTML are not
> interesting). Note that it doesn't show whitespace _differences_, but it
> does show the whitespace itself (taken from the "new" version of the
> file).

Yep, I just found out myself experimenting with a wordRegex for csv.
Seems like quite a "Gimme rope" feature...

So, it's the regex.

> So, if the word regex somehow doesn't match the second line at all (or
> at least not the differen part), the differences could get ignored.
> 
>> Can you trim this down to a minimal example?
> That would be useful in any case.

What strikes me is that both lines are semantically identical, yet one
is treated correctly and the other isn't.

Michael
