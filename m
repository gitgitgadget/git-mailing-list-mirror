From: Dave Jones <davej@redhat.com>
Subject: bisection oddity.
Date: Mon, 12 Mar 2007 15:28:21 -0400
Message-ID: <20070312192821.GA24992@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 12 20:28:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQqC8-0006Kr-Sn
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 20:28:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752404AbXCLT23 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 15:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752428AbXCLT23
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 15:28:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48433 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752398AbXCLT22 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 15:28:28 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l2CJSRVi008805
	for <git@vger.kernel.org>; Mon, 12 Mar 2007 15:28:27 -0400
Received: from gelk.kernelslacker.org (vpn-248-5.boston.redhat.com [10.13.248.5])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l2CJSLEf011477
	for <git@vger.kernel.org>; Mon, 12 Mar 2007 15:28:21 -0400
Received: from gelk.kernelslacker.org (localhost.localdomain [127.0.0.1])
	by gelk.kernelslacker.org (8.13.8/8.13.8) with ESMTP id l2CJSL7g025175
	for <git@vger.kernel.org>; Mon, 12 Mar 2007 15:28:21 -0400
Received: (from davej@localhost)
	by gelk.kernelslacker.org (8.13.8/8.13.8/Submit) id l2CJSLai025174
	for git@vger.kernel.org; Mon, 12 Mar 2007 15:28:21 -0400
X-Authentication-Warning: gelk.kernelslacker.org: davej set sender to davej@redhat.com using -f
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42065>

I'm chasing a kernel bug that was introduced somewhere between
v2.6.20 and 2.6.21rc1, and bisect has done this so far..

git-bisect start
# bad: [c8f71b01a50597e298dc3214a2f2be7b8d31170c] Linux 2.6.21-rc1
git-bisect bad c8f71b01a50597e298dc3214a2f2be7b8d31170c
# good: [fa285a3d7924a0e3782926e51f16865c5129a2f7] Linux 2.6.20
git-bisect good fa285a3d7924a0e3782926e51f16865c5129a2f7
# bad: [574009c1a895aeeb85eaab29c235d75852b09eb8] Merge branch 'upstream' of git://ftp.linux-mips.org/pub/scm/upstream-linus
git-bisect bad 574009c1a895aeeb85eaab29c235d75852b09eb8
# bad: [43187902cbfafe73ede0144166b741fb0f7d04e1] Merge master.kernel.org:/pub/scm/linux/kernel/git/gregkh/driver-2.6
git-bisect bad 43187902cbfafe73ede0144166b741fb0f7d04e1
# good: [1545085a28f226b59c243f88b82ea25393b0d63f] drm: Allow for 44 bit user-tokens (or drm_file offsets)
git-bisect good 1545085a28f226b59c243f88b82ea25393b0d63f
# good: [c96e2c92072d3e78954c961f53d8c7352f7abbd7] Merge master.kernel.org:/pub/scm/linux/kernel/git/gregkh/usb-2.6
git-bisect good c96e2c92072d3e78954c961f53d8c7352f7abbd7

What I'm puzzled at is that this lands me at 2.6.20-rc5, which is *before*
the range I'm interested in.  What happened here?

	Dave

-- 
http://www.codemonkey.org.uk
