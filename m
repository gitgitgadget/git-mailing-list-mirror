From: Tait <git.git@t41t.com>
Subject: Re: is gitosis secure?
Date: Mon, 15 Dec 2008 13:28:53 -0800
Message-ID: <20081215212853.GM9772@ece.pdx.edu>
References: <200812090956.48613.thomas@koch.ro> <bd6139dc0812090138l5dbaf20bsd1cde00f52bb94e5@mail.gmail.com> <87hc58hwmi.fsf@hades.wkstn.nix> <gi1qsl$22p$1@ger.gmane.org> <alpine.DEB.1.10.0812132126470.17688@asgard.lang.hm> <4944D4F7.7050501@siamect.com> <alpine.DEB.1.10.0812140304320.17688@asgard.lang.hm> <4944E7E1.2030907@siamect.com> <alpine.DEB.1.10.0812141655150.17688@asgard.lang.hm> <20081215071737.GA32387@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 15 22:30:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCL18-000818-R2
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 22:30:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755736AbYLOV26 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 16:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755019AbYLOV26
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 16:28:58 -0500
Received: from rcpt.cat.pdx.edu ([131.252.208.107]:39413 "EHLO
	rcpt.cat.pdx.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754640AbYLOV25 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 16:28:57 -0500
Received: from nemo.ece.pdx.edu (root@nemo.ece.pdx.edu [131.252.209.162])
	by rcpt.cat.pdx.edu (8.14.2/8.14.2/Debian-2build1) with ESMTP id mBFLStxM024934
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 15 Dec 2008 13:28:55 -0800
Received: from nemo.ece.pdx.edu (tait@localhost [127.0.0.1])
	by nemo.ece.pdx.edu (8.13.6/8.13.1) with ESMTP id mBFLSsJT029197
	for <git@vger.kernel.org>; Mon, 15 Dec 2008 13:28:55 -0800 (PST)
Received: (from tait@localhost)
	by nemo.ece.pdx.edu (8.13.6/8.12.6/Submit) id mBFLSso2029196
	for git@vger.kernel.org; Mon, 15 Dec 2008 13:28:54 -0800 (PST)
X-Authentication-Warning: nemo.ece.pdx.edu: tait set sender to git.git@t41t.com using -f
Content-Disposition: inline
In-Reply-To: <20081215071737.GA32387@glandium.org>
User-Agent: Mutt/1.5.7i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (rcpt.cat.pdx.edu [131.252.208.107]); Mon, 15 Dec 2008 13:28:55 -0800 (PST)
X-Spam-Status: No, score=2.0 required=6.0 tests=LLARGE autolearn=no
	version=3.2.5
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on rcpt.cat.pdx.edu
X-Virus-Scanned: ClamAV 0.92.1/8762/Mon Dec 15 06:57:35 2008 on rcpt.cat.pdx.edu
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103210>


> But ssh itself allows you to do proxying. See ProxyCommand in
> ssh_config's manpage.

I think that's exactly the point David Lang is making.

For the security-paranoid, maybe the approach gitosis should take
is to develop an ssh subserver (like sftp). The possibilities for
restricted access and configuration are greatly expanded by such an
approach. One could configure "sgit" to chroot into some account-specific
subdirectory. The sshd configuration can be tweaked to allow sgit access
but not terminal or exec request (or port forwarding) access, perhaps
dependent on group membership.
