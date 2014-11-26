From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Subject: Extended splitting for "git add --interactive"
Date: Wed, 26 Nov 2014 15:55:19 +0100
Message-ID: <5475F7E7020000A100018050@gwsmtp1.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 26 16:00:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xte52-0006EO-6y
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 16:00:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752733AbaKZPAZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2014 10:00:25 -0500
Received: from rrzmta2.uni-regensburg.de ([194.94.155.52]:49516 "EHLO
	rrzmta2.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752601AbaKZPAZ convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-git@vger.kernel.org:1:1>);
	Wed, 26 Nov 2014 10:00:25 -0500
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Nov 2014 10:00:24 EST
Received: from rrzmta2.uni-regensburg.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 464EB52FDA
	for <git@vger.kernel.org>; Wed, 26 Nov 2014 15:55:21 +0100 (CET)
Received: from gwsmtp1.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
	by rrzmta2.uni-regensburg.de (Postfix) with ESMTP id 2B2A151CE7
	for <git@vger.kernel.org>; Wed, 26 Nov 2014 15:55:21 +0100 (CET)
Received: from uni-regensburg-smtp1-MTA by gwsmtp1.uni-regensburg.de
	with Novell_GroupWise; Wed, 26 Nov 2014 15:55:20 +0100
X-Mailer: Novell GroupWise Internet Agent 14.0.1 
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260283>

Hi!

This is for git-1.7.12 (an older version from the SLES11 SP3 SDK). If the issue is solved meanwhile, I'll be happy, and I apologize for being too lazy to find out.

Currently Git cannot split a block of changes like

-AAA
-BBB
+CCC
+DDD

Into
-AAA
+CCC
and
-BBB
+DDD

So you'll have to edit it and waste me extra time (People probably use split if they know what they are doing, so maybe allow that).

Another split that is not possible is a split across an empty line, like:

+AAA
+     <empty line (in reality)>
+BBB

One could split that either into two parts with the empty lines belonging to one of AAA or BBB, or into three parts where the empty line is just another junk to accept or refuse. See comment above on why I'd like that.

Regards,
Ulrich Windl
