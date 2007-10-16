From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Switching from CVS to GIT
Date: Tue, 16 Oct 2007 08:42:53 +0200
Message-ID: <47145D6D.80001@viscovery.net>
References: <1192293466.17584.95.camel@homebase.localnet> <uy7e6keyv.fsf@gnu.org> <1192381040.4908.57.camel@homebase.localnet> <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr> <47125F74.9050600@op5.se> <Pine.LNX.4.64.0710141934310.25221@racer.site> <47126957.1020204@op5.se> <Pine.LNX.4.64.0710142112540.25221@racer.site> <20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org> <Pine.LNX.4.64.0710151859590.7638@iabervon.org> <uodezisvg.fsf@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>, raa.lkml@gmail.com,
	Johannes.Schindelin@gmx.de, ae@op5.se,
	Benoit SIGOURE <tsuna@lrde.epita.fr>,
	"git@vger.kernel.org >> Git Mailing List" <git@vger.kernel.org>,
	Make Windows <make-w32@gnu.org>
To: Eli Zaretskii <eliz@gnu.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 08:43:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihg8x-0005gL-FP
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 08:43:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760194AbXJPGm5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 02:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760178AbXJPGm5
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 02:42:57 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:16797 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759191AbXJPGm4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 02:42:56 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Ihg8Y-0000US-A4; Tue, 16 Oct 2007 08:42:42 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 62F716B7; Tue, 16 Oct 2007 08:42:53 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <uodezisvg.fsf@gnu.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61094>

Eli Zaretskii schrieb:
> If that's the issue, then it's not a good idea to call `stat' and
> `readdir' on Windows at all.  `stat' is a single system call on Posix
> systems, while on Windows it usually needs to go out of its way
> calling half a dozen system services to gather the `struct stat' info.

Thanks to Marius Storm-Olsen we already have a stat replacement that's twice 
as fast as msvcrt's stat. I calls only one API function 
(GetFileAttributesEx, but of course I don't know what's going on under its 
hood), because we need only a small part of struct stat filled in correctly.

-- Hannes
