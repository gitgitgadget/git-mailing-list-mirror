From: "Brown, Len" <len.brown@intel.com>
Subject: RE: new file leaked onto release branch
Date: Wed, 14 Dec 2005 17:06:54 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30056B86DD@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Linus Torvalds" <torvalds@osdl.org>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 14 23:10:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ememp-0002KI-H4
	for gcvg-git@gmane.org; Wed, 14 Dec 2005 23:07:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbVLNWHe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Dec 2005 17:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbVLNWHe
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Dec 2005 17:07:34 -0500
Received: from fmr14.intel.com ([192.55.52.68]:42724 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S932497AbVLNWHd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Dec 2005 17:07:33 -0500
Received: from fmsfmr101.fm.intel.com (fmsfmr101.fm.intel.com [10.253.24.21])
	by fmsfmr002.fm.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id jBEM6tLN029919;
	Wed, 14 Dec 2005 22:06:55 GMT
Received: from fmsmsxvs043.fm.intel.com (fmsmsxvs043.fm.intel.com [132.233.42.129])
	by fmsfmr101.fm.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with SMTP id jBEM6rBb009378;
	Wed, 14 Dec 2005 22:06:55 GMT
Received: from fmsmsx331.amr.corp.intel.com ([132.233.42.156])
 by fmsmsxvs043.fm.intel.com (SAVSMTP 3.1.7.47) with SMTP id M2005121414065519305
 ; Wed, 14 Dec 2005 14:06:55 -0800
Received: from fmsmsx312.amr.corp.intel.com ([132.233.42.227]) by fmsmsx331.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Wed, 14 Dec 2005 14:06:55 -0800
Received: from hdsmsx401.amr.corp.intel.com ([10.127.2.60]) by fmsmsx312.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Wed, 14 Dec 2005 14:06:54 -0800
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: new file leaked onto release branch
Thread-Index: AcYA72HXjFt3SwIRRx6cMTC41YxtBAACWHEA
To: "Junio C Hamano" <junkio@cox.net>
X-OriginalArrivalTime: 14 Dec 2005 22:06:54.0865 (UTC) FILETIME=[B1A21010:01C600FA]
X-Scanned-By: MIMEDefang 2.52 on 10.253.24.21
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13649>

 
>I pointed out one anomaly which is the commit should never have
>been created because it was not even a fast forward but already
>up-to-date case, and it was followed up with exchange of a few
>messages between Linus and you.  But even if we got that mixed
>up, the resulting merge should not have contained the file
>neither parents had.  That part worries me the most.
>
>One question.  You mentioned these in your message, you have
>a "git.commit wrapper" that contains these lines:
>
>    git-update-index --add --remove `quilt files`
>    git commit
>
>I am not familiar with 'quilt', but is "quilt files" the command
>to show the list of files with patches applied to the working
>tree?

yes, but only by the last applied "on the top of the stack."
When I do a commit, there is only 1 patch applied so this works okay.
(then I push the next patch after the commit and repeat...)

>If so, the above do tell git about the modified (including added
>or removed) files that the applied quilt patches touch, which
>sounds like the correct thing to do.
>
>But the resulting commit from that procedure would not be a
>merge commit, and the commit in question that had the rsinfo
>file magically appeared from nowhere is a merge, so this does
>not seem to have much to do with the current problem...
>
>Still puzzlled, sorry.

I'm not stuck by this problem, since I created a new release
branch based before the funny merge and it seems to be
working properly.  I'm sorry I can't re-create the problem
again.  Next time something like this happens and I notice it
I'll be sure to keep the ingredients for the failure on hand.

thanks,
-Len
