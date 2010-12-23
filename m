From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: StandardInput Not Continuing Process
Date: Thu, 23 Dec 2010 12:18:15 -0500
Message-ID: <345E4AAA-63E3-4949-8486-A636793DDBC8@silverinsanity.com>
References: <AANLkTikBdOLjzJxikXCwTs52RByfNZzKamK+F-JhY0mQ@mail.gmail.com> <AANLkTikvrDWYT8h_MCESd9sg4_8ykSOq3XFEsoNsYDuZ@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Chase Brammer <cbrammer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 23 18:27:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVowd-0006Ht-Bj
	for gcvg-git-2@lo.gmane.org; Thu, 23 Dec 2010 18:27:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753387Ab0LWR1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Dec 2010 12:27:08 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:40529 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753281Ab0LWR1H convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Dec 2010 12:27:07 -0500
X-Greylist: delayed 528 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Dec 2010 12:27:06 EST
Received: by silverinsanity.com (Postfix, from userid 5001)
	id C78821FFC12F; Thu, 23 Dec 2010 17:18:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.5 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-74-65-60-43.rochester.res.rr.com [74.65.60.43])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id DA3C51FFC056;
	Thu, 23 Dec 2010 17:18:12 +0000 (UTC)
In-Reply-To: <AANLkTikvrDWYT8h_MCESd9sg4_8ykSOq3XFEsoNsYDuZ@mail.gmail.com>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164134>


OnOn Wed, Dec 8, 2010 at 10:25 AM, Chase Brammer <cbrammer@gmail.com> wrote:
> 
> I am try to directly interact with Git by using only stdin, stdout,
> and stderr.  So
> not going through a terminal at all, but calling Git directly.   I am
> having an issue
> with being able to continue a process that requires input.
> 
> For example, doing a clone from a HTTPS server may require a username/password.
> I writing the password as utf, and also tried just UTF byes (ie no
> prepended 16-bit int)
> but am unable to get the process to continue and start the clone process.
> 
> Is there some signal, or trick to getting the process to continue?  I
> thought that sending a
> "\n" would work, but that doesn't seem to be working either.

Depending on what language you're using and your pipe settings, you might need to issue an fflush(git_stdin).

~~ Brian
