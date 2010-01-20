From: Crane Cai <crane.cai@amd.com>
Subject: [question] retrieve some patches from another repository
Date: Wed, 20 Jan 2010 13:46:14 +0800
Message-ID: <20100120054614.GA1965@crane-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 20 06:50:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXTSU-0002UC-7D
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 06:50:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795Ab0ATFuU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 00:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403Ab0ATFuT
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 00:50:19 -0500
Received: from va3ehsobe003.messaging.microsoft.com ([216.32.180.13]:1653 "EHLO
	VA3EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751236Ab0ATFuS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jan 2010 00:50:18 -0500
Received: from mail136-va3-R.bigfish.com (10.7.14.247) by
 VA3EHSOBE003.bigfish.com (10.7.40.23) with Microsoft SMTP Server id
 8.1.240.5; Wed, 20 Jan 2010 05:50:17 +0000
Received: from mail136-va3 (localhost.localdomain [127.0.0.1])	by
 mail136-va3-R.bigfish.com (Postfix) with ESMTP id DAE8D19E0272	for
 <git@vger.kernel.org>; Wed, 20 Jan 2010 05:50:16 +0000 (UTC)
X-SpamScore: 1
X-BigFish: VPS1(zz168aJzz1202hzzz32i6bh43j62h)
X-Spam-TCS-SCL: 1:0
Received: from mail136-va3 (localhost.localdomain [127.0.0.1]) by mail136-va3
 (MessageSwitch) id 1263966613515743_26184; Wed, 20 Jan 2010 05:50:13 +0000
 (UTC)
Received: from VA3EHSMHS003.bigfish.com (unknown [10.7.14.252])	by
 mail136-va3.bigfish.com (Postfix) with ESMTP id 7A640E005D	for
 <git@vger.kernel.org>; Wed, 20 Jan 2010 05:50:13 +0000 (UTC)
Received: from svlb1extmailp02.amd.com (139.95.251.11) by
 VA3EHSMHS003.bigfish.com (10.7.99.13) with Microsoft SMTP Server (TLS) id
 14.0.482.32; Wed, 20 Jan 2010 05:50:12 +0000
Received: from svlb1twp01.amd.com ([139.95.250.34])	by svlb1extmailp02.amd.com
 (Switch-3.2.7/Switch-3.2.7) with ESMTP id o0K5p5il012572	for
 <git@vger.kernel.org>; Tue, 19 Jan 2010 21:51:08 -0800
X-WSS-ID: 0KWJ6VH-03-00D-02
X-M-MSG: 
Received: from SSVLEXBH1.amd.com (ssvlexbh1.amd.com [139.95.53.182])	by
 svlb1twp01.amd.com (Tumbleweed MailGate 3.7.2) with ESMTP id 2990B19A2117	for
 <git@vger.kernel.org>; Tue, 19 Jan 2010 21:50:05 -0800 (PST)
Received: from SSVLEXMB1.amd.com ([139.95.53.181]) by SSVLEXBH1.amd.com with
 Microsoft SMTPSVC(6.0.3790.3959);	 Tue, 19 Jan 2010 21:50:08 -0800
Received: from storexbh1.amd.com ([10.1.1.17]) by SSVLEXMB1.amd.com with
 Microsoft SMTPSVC(6.0.3790.3959);	 Tue, 19 Jan 2010 21:50:07 -0800
Received: from sshaexmb1.amd.com ([10.237.2.11]) by storexbh1.amd.com with
 Microsoft SMTPSVC(6.0.3790.3959);	 Wed, 20 Jan 2010 00:50:05 -0500
Received: from crane-desktop.amd.com ([10.237.82.14]) by sshaexmb1.amd.com
 with Microsoft SMTPSVC(6.0.3790.3959);	 Wed, 20 Jan 2010 13:50:01 +0800
Received: by crane-desktop.amd.com (sSMTP sendmail emulation); Wed, 20 Jan
 2010 13:46:14 +0800
Mail-Followup-To: Crane Cai <crane.cai@amd.com>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-OriginalArrivalTime: 20 Jan 2010 05:50:01.0483 (UTC) FILETIME=[68233DB0:01CA9994]
X-Reverse-DNS: unknown
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137520>

Hi,

Sorry to disturb you. I know this mail list is mainly for git development. Till
now I have not found some normal user mail list, at last I choose it to ask a
question.

My target is:
repository A - linux upstream:
a->b->c->d->[merge from repository B]->e->f
repository B - a maintainer's tree:
x->y->z->[merge from repository A]->...
I want to retrieve the patches for one driver and its related
changes from commit "a" till maintainer's master.

So I do as this:
* git checkout repo B's master
* because maintainer's tree is derived from upstream point "a" will be included,
  use git format-patch repo a source-code-name

There are 2 issues in it:
* merge point will cause duplicated patch generated, for example repo B has x,
  y, z, then accepted by repo A in merge point, and then merge back to repo B
  (they are different with commit id), they will generate 2 twice.
* some commits do not only change the driver source code, and they change some
  other files also. Unfortunately git format-patch cut them. It cause compile
  error.

My question:
  Does some one know git have the ability to do it or do I need to do it
manually?


-- 
Best Regards,
- Crane
