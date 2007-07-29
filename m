From: David Kastrup <dak@gnu.org>
Subject: Submit/Workflow question
Date: Sun, 29 Jul 2007 17:56:54 +0200
Message-ID: <85abtfw6d5.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 29 17:57:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFB94-0007Sg-AT
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 17:57:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763282AbXG2P5X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 11:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762085AbXG2P5X
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 11:57:23 -0400
Received: from mail-in-10.arcor-online.net ([151.189.21.50]:33215 "EHLO
	mail-in-10.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759502AbXG2P5W (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jul 2007 11:57:22 -0400
Received: from mail-in-04-z2.arcor-online.net (mail-in-04-z2.arcor-online.net [151.189.8.16])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id 1A3FB1F5A8E
	for <git@vger.kernel.org>; Sun, 29 Jul 2007 17:57:22 +0200 (CEST)
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net [151.189.21.45])
	by mail-in-04-z2.arcor-online.net (Postfix) with ESMTP id EF81DABAEC
	for <git@vger.kernel.org>; Sun, 29 Jul 2007 17:57:21 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-017-015.pools.arcor-ip.net [84.61.17.15])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id D32C01DB655
	for <git@vger.kernel.org>; Sun, 29 Jul 2007 17:57:21 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id E74AD1C39595; Sun, 29 Jul 2007 17:56:54 +0200 (CEST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3804/Sun Jul 29 06:09:31 2007 on mail-in-05.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54118>


Suppose that I have created a half-baked patch A suiting my personal
needs and went on from there, having something like

...->A->B->...

Now at some point of time I decide that really A should be made fit
for submission.  Basically, I'd want to do
git-reset --hard A
[edit some]
git-commit --amend -a
git-format-patch HEAD~1

in order to arrive at a nice submittable patch.  However, I don't want
to lose B and the following stuff, and the resulting HEAD should
include the improved of A (it is fine if that needs additional steps,
and it is fine if it is just HEAD that gets the fixed version, not B).

So how to do this?  Branch at A^, rebase on A, fix the stuff, commit
with --amend -a, rebase on master, rename the temporary branch to
master (killing the old master), format and submit the patch?

Or is there some bad thinko in there?  Or is this too complicated?

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
