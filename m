From: Robert Luberda <robert@debian.org>
Subject: Re: [PATCH/RFC] git svn: don't introduce new paragraph for git-svn-id
Date: Sat, 25 Aug 2012 01:14:50 +0200
Organization: Debian
Message-ID: <50380AEA.6020000@debian.org>
References: <1343856197-6393-1-git-send-email-robert@debian.org> <20120801214318.GA10384@dcvr.yhbt.net> <5019AD3A.8030609@debian.org> <20120801230118.GA15479@dcvr.yhbt.net> <50315ED1.6080803@debian.org> <20120821214538.GA4879@dcvr.yhbt.net> <7vsjbfc1q7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>,
	Robert Luberda <robert@debian.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 25 01:22:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T53CW-0007MP-Pa
	for gcvg-git-2@plane.gmane.org; Sat, 25 Aug 2012 01:22:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755458Ab2HXXV7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Aug 2012 19:21:59 -0400
Received: from master.debian.org ([70.103.162.29]:47844 "EHLO
	master.debian.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755242Ab2HXXV5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2012 19:21:57 -0400
Received: from localhost ([127.0.0.1] helo=vox.robbo.home)
	by master.debian.org with esmtp (Exim 4.72)
	(envelope-from <robert@debian.org>)
	id 1T53CI-0005mj-0z; Fri, 24 Aug 2012 23:21:50 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by vox.robbo.home (Postfix) with ESMTP id 028E8E2F7B;
	Sat, 25 Aug 2012 01:14:50 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.6esrpre) Gecko/20120817 Icedove/10.0.6
In-Reply-To: <7vsjbfc1q7.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204239>

Junio C Hamano wrote:
> Eric Wong <normalperson@yhbt.net> writes:
>>
>> I think having "svn" in "svn.trimsvnlog" twice is redundant and not ideal.
>> Perhaps just --trim-log and svn.trimlog?
> 
> Do we ever want to trim "our" log when relaying the Git commits back
> to subversion?  Having "svn" in "trimsvnlog" makes it clear that the
> logs from subversion side is getting trimmed.

`git commit' already trims the messages (except for removing the leading
whitespaces from the first non-whitespace-only line) and git svn doesn't
change that.

The new option affects the way the messages are imported from svn to
git, with one exception when the --add-author-from option of dcommit is
used (in which case it may skip adding an extra new line character
before the `From: ' line). For that reason --trim-svn-log might be a
better name.

Regards,
robert
