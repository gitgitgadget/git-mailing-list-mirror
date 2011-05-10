From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Approxidate with YYYY.MM
Date: Tue, 10 May 2011 08:35:46 +0200
Message-ID: <4DC8DCC2.8050208@drmicha.warpmail.net>
References: <CAE5FB52-0F90-4F21-828F-7E40ED596B33@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Tue May 10 08:35:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJgXz-000871-ID
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 08:35:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752889Ab1EJGft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 02:35:49 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:59519 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752507Ab1EJGfs (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 May 2011 02:35:48 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 09EF420975;
	Tue, 10 May 2011 02:35:48 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 10 May 2011 02:35:48 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=Glj6hJo/4BxLZ0DXXuv5jh9GzQk=; b=gZ0y5j/PBhYDPR6ySOB+fATvj66f17u2WQWQHhdMU1A14/BN8F+2huzv+g6H1Syr6s40+3TIBTIoZDlb/55pbx6QTSzTVS8mSRBMlyM+ts5/N/HHGLfQbf1cL3Ijrb6bAYfl+ebzIZ82USZPPzXmgEpIfbebKF87YzaArhCkhRY=
X-Sasl-enc: ruRRRuZvYn68KOvBohqC/O4ud6SJf1hipEC0UI97ovkm 1305009347
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 7622C404E2E;
	Tue, 10 May 2011 02:35:47 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <CAE5FB52-0F90-4F21-828F-7E40ED596B33@gernhardtsoftware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173315>

Brian Gernhardt venit, vidit, dixit 09.05.2011 21:02:
> (This is in response to a discussion on #parrot.)
> 
> Rakudo (https://github.com/rakudo/rakudo/) uses tags of the form
> YYYY.MM for their monthly releases.  When we were attempting to find
> the cause of a slowdown, somewhat was trying to find what commits
> occurred after the 2011.01 release with "git log --after=2011.01".
> His mistake was pointed out but this led to the confusion of why this
> was parsed as "May 1 2011" instead of "Jan 1 2011".  Shouldn't
> date.c:match_multi_number() parse something with only two numbers as
> a beginning of month instead of allowing it to pass through to the
> generic parsing?

I just don't think there is a format like that. There is dd.mm.[yy]yy
and apparently also yyyy.mm.dd, but without leading zeros in mm for the
latter. Our date parser also takes "." for a space so that you don't
need to quote a space ("1.day.ago"). I can see the logic behind parsing
2011.01 as January 2011, but it's a stretch from the existing formats:

http://en.wikipedia.org/wiki/Calendar_date#Date_format

> I'm currently nearing finals in school, so lack the time for an RFC
> patch at the moment.

Good luck :)

Michael
