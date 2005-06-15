From: Pavel Roskin <proski@gnu.org>
Subject: cg-restore - restoring modified files
Date: Tue, 14 Jun 2005 21:45:21 -0400
Message-ID: <1118799921.3890.45.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Jun 15 03:41:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DiMtu-0000b9-5p
	for gcvg-git@gmane.org; Wed, 15 Jun 2005 03:41:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261477AbVFOBpd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Jun 2005 21:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261478AbVFOBpd
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jun 2005 21:45:33 -0400
Received: from h-64-105-159-118.phlapafg.covad.net ([64.105.159.118]:54969
	"EHLO dv.roinet.com") by vger.kernel.org with ESMTP id S261477AbVFOBpZ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2005 21:45:25 -0400
Received: from dv.roinet.com (localhost.localdomain [127.0.0.1])
	by dv.roinet.com (8.13.4/8.13.4) with ESMTP id j5F1jMmn014170
	for <git@vger.kernel.org>; Tue, 14 Jun 2005 21:45:22 -0400
Received: (from proski@localhost)
	by dv.roinet.com (8.13.4/8.13.4/Submit) id j5F1jMiL014167
	for git@vger.kernel.org; Tue, 14 Jun 2005 21:45:22 -0400
X-Authentication-Warning: dv.roinet.com: proski set sender to proski@gnu.org using -f
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.2 (2.2.2-8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello!

I believe the documented behavior of cg-restore is inconsistent.

"Restore given files to their original state. Without any parameters, it
recovers any files removed locally whose removal was not recorded by
`cg-rm`."

I interpret it that cg-restore without arguments restores removed files
but not modified ones.

"If passed a set of file names, it restores those files to their state
as of the last commit (including bringing files removed with cg-rm back
to life; FIXME: does not do that part yet)."

I interpret it that cg-restore with arguments restores both removed and
modified files.

Maybe we need an option whether to restore modified files?  Or maybe
they should always be restored (I think it would more consistent)?  Then
the help text should be more clear about modified files.

The actual behavior is that modified files are never restored.  We need
"-f" option for git-checkout-cache to overwrite existing files, and it's
not used whether the filenames are specified or not.  I wanted to send a
patch, but after reading help I'm not sure what exactly cg-restore is
supposed to do.

-- 
Regards,
Pavel Roskin

