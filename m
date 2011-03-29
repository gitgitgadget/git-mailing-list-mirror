From: Johan Herland <johan@herland.net>
Subject: Re: [Q] Mark files for later commit?
Date: Tue, 29 Mar 2011 09:38:41 +0200
Message-ID: <201103290938.41528.johan@herland.net>
References: <AANLkTi=rPAQas3gvHJ+EFYTXP_YXuULQMk8o8pgkj=9T@mail.gmail.com>
 <7voc4uto9o.fsf@alter.siamese.dyndns.org>
 <4D91858F.7030404@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Daniel =?utf-8?q?Nystr=C3=B6m?= <daniel.nystrom@timeterminal.se>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Mar 29 09:38:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4TVq-0002Hf-HO
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 09:38:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751908Ab1C2Hip (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 03:38:45 -0400
Received: from smtp.getmail.no ([84.208.15.66]:49568 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751376Ab1C2Hio (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 03:38:44 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LIT00FJR6KID900@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Tue, 29 Mar 2011 09:38:42 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id E791F1EA5549_D918C81B	for <git@vger.kernel.org>; Tue,
 29 Mar 2011 07:38:41 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id D39451EA3C78_D918C81F	for <git@vger.kernel.org>; Tue,
 29 Mar 2011 07:38:41 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LIT006T56KHBZ00@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 29 Mar 2011 09:38:41 +0200 (MEST)
User-Agent: KMail/1.13.6 (Linux/2.6.37-ARCH; KDE/4.6.1; x86_64; ; )
In-reply-to: <4D91858F.7030404@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170242>

On Tuesday 29 March 2011, Michael J Gruber wrote:
> Note that you can share
> notes when you set up refspecs etc in a push/pull based workflow. (I'm
> not sure how well we support merging/pulling notes refs yet.)

Since v1.7.4, you can use "git notes merge" for merging notes ref. It's not 
yet integrated with "pull", though, so typically you want to fetch it to a 
different ref name, and then manually "git notes merge" that into the 
original notes ref.

E.g. if you want to sync "refs/notes/foo" with remote "bob", you can "git 
fetch bob refs/notes/foo:refs/notes/bobs_foo", and then
merge them with "git notes --ref=foo merge bobs_foo".

> This does not work well in a patch/e-mail-based workflow.

...although there have been mailing list discussions on getting notes added 
to "git format-patch" output (after the "---"), and then picked up again by 
"git am".


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
