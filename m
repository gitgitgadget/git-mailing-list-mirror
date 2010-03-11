From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: Doing a dummy or empty merge
Date: Thu, 11 Mar 2010 09:21:20 -0800
Message-ID: <86wrxiepv3.fsf@blue.stonehenge.com>
References: <8440EA2C12E50645A68C4AA9887166513FC480@SERVER.webdezign.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Richard Lee" <richard@webdezign.co.uk>
X-From: git-owner@vger.kernel.org Thu Mar 11 18:21:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Npm4j-0002cf-Ol
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 18:21:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933389Ab0CKRVZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Mar 2010 12:21:25 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:11173 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933360Ab0CKRVV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 12:21:21 -0500
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id D13861DE35D; Thu, 11 Mar 2010 09:21:20 -0800 (PST)
x-mayan-date: Long count = 12.19.17.3.4; tzolkin = 2 Kan; haab = 2 Cumku
In-Reply-To: <8440EA2C12E50645A68C4AA9887166513FC480@SERVER.webdezign.local> (Richard Lee's message of "Thu, 11 Mar 2010 12:41:02 -0000")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141988>

>>>>> "Richard" == Richard Lee <richard@webdezign.co.uk> writes:

Richard> At this point I want to merge this test branch into the live branch
Richard> despite not having made any commits apart from deployment related
Richard> changes on the test branch. I want this to be a dummy merge so that a
Richard> merge is recorded into the live branch, but the contents of the live
Richard> branch remain untouched. This is as if I made an empty commit on the
Richard> live branch.

I think you'll get what you want with a "merge -s ours" from test
to live.  That says that "I've looked at test, and I've looked at
the parents of live, and this is how I want the result to look".

Further commits on test can then be merged to live automatically using this
new merge as the (initial) base.  Of course, later commits after that will use
subsequent bases, but that should already work the way you want.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.vox.com/ for Smalltalk and Seaside discussion
