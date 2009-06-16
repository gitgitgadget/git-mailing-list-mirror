From: Martin Nordholts <enselic@gmail.com>
Subject: git-branch: Actually using the current branch as default start-point
Date: Tue, 16 Jun 2009 21:13:09 +0200
Message-ID: <4A37EEC5.4020007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 16 21:21:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGeDP-0003mp-85
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 21:21:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759536AbZFPTU4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 15:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758489AbZFPTUy
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 15:20:54 -0400
Received: from iph2.telenor.se ([195.54.127.133]:38215 "EHLO iph2.telenor.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757488AbZFPTUy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 15:20:54 -0400
X-Greylist: delayed 588 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Jun 2009 15:20:53 EDT
X-SMTPAUTH: 
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AuoCACOLN0rDNmV6hWdsb2JhbACYUgEBAQoLCgUVrAOQeoQLBQ
X-IronPort-AV: E=Sophos;i="4.42,231,1243807200"; 
   d="scan'208";a="21234803"
Received: from ironport2.bredband.com ([195.54.101.122])
  by iph2.telenor.se with ESMTP; 16 Jun 2009 21:11:06 +0200
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ArtSACOLN0rVcX8QPGdsb2JhbAAImEABAQEBN6wOkHqECwU
X-IronPort-AV: E=Sophos;i="4.42,231,1243807200"; 
   d="scan'208";a="502919330"
Received: from c-107f71d5.017-113-6c756e10.cust.bredbandsbolaget.se (HELO [192.168.1.2]) ([213.113.127.16])
  by ironport2.bredband.com with ESMTP; 16 Jun 2009 21:11:06 +0200
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121707>

Hi

The git-branch documentation states that the start-point defaults to
the current branch if omitted. I interpret that to mean that

  git checkout origin/somebranch
  git branch newbranch

is equivalent to

  git branch newbranch origin/somebranch

but that is currently not the case. If you checkout a remote branch
then you are not considered to _be_ on the remote branch, so the
start-point will behave as if an arbitrary commit was specified,
i.e. tracking will not be setup correctly.

This is an easy patch and I have something working, I just need to 
finalize it. Does this sound like a sane patch to you?

Best regards,
Martin Nordholts
