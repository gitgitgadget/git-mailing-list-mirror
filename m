From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH v2] Make git selectively and conditionally ignore
 certain stat fields
Date: Tue, 15 Jan 2013 08:09:41 +0100 (CET)
Message-ID: <1119893992.2134035.1358233781666.JavaMail.root@dewire.com>
References: <7vy5fv71ad.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, j sixt <j.sixt@viscovery.net>,
	Shawn Pearce <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 08:10:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tv0eq-0005mj-6T
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 08:10:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752046Ab3AOHJn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 02:09:43 -0500
Received: from zimbra.dewire.com ([83.140.172.131]:47050 "EHLO
	zimbra.dewire.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971Ab3AOHJn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 02:09:43 -0500
Received: from localhost (localhost [127.0.0.1])
	by zimbra.dewire.com (Postfix) with ESMTP id 22663826D9;
	Tue, 15 Jan 2013 08:09:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at dewire.se
Received: from zimbra.dewire.com ([127.0.0.1])
	by localhost (zimbra.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HhrSH8ablQuU; Tue, 15 Jan 2013 08:09:41 +0100 (CET)
Received: from zimbra.dewire.com (zimbra.dewire.com [10.1.2.96])
	by zimbra.dewire.com (Postfix) with ESMTP id B475E8267B;
	Tue, 15 Jan 2013 08:09:41 +0100 (CET)
In-Reply-To: <7vy5fv71ad.fsf@alter.siamese.dyndns.org>
X-Originating-IP: [213.67.12.15]
X-Mailer: Zimbra 7.2.0_GA_2681 (ZimbraWebClient - FF3.0 (Mac)/7.2.0_GA_2681)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213602>



----- Ursprungligt meddelande -----
> Robin Rosenberg <robin.rosenberg@dewire.com> writes:
> 
> > Semantically they're somewhat different. My flags are for ignoring
> > a value when it's not used as indicated by the value zero, while
> > trustctime is for ignoring untrustworthy, non-zero, values.
> 
> Yeah, I realized that after writing that message.
> 
> > Another thing that I noticed, is that I probably wanto to be able
> > to filter on the precision
> > of timestamps. Again, this i JGit-related. Current JGit has
> > milliseconds precision (max), whereas
> > Git has down to nanosecond precision in timestamps. Newer JGits may
> > get nanoseconds timestamps too,
> > but on current Linux versions JGit gets only integral seconds
> > regardless of file system.
> >
> > Would the names, milli, micro, nano be good for ignoring the tail
> > when zero, or n1..n9 (obviously
> > n2 would be ok too). nN = ignore all but first N nsec digits if
> > they are zero)?
> 
> It somehow starts to sound like over-engineering to solve a wrong
> problem.
> 
> I'd say a simplistic "ignore if zero is stored" or even "ignore this
> as one of the systems that shares this file writes crap in it" may
> be sufficient, and if this is a jGit specific issue, it might even
> make sense to introduce a single configuration variable with string
> "jgit" somewhere in its name and bypass the stat field comparison
> for known-problematic fields, instead of having the user know and
> list what stat fields need special attention.

My first patch was something like that, just not using the word jgit. As
for what fields to ignore, it's something that can be configured by EGit
and documented on the EGit/JGit wiki. 

-- robin
