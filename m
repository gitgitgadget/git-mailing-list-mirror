From: linux@horizon.com
Subject: Re: How can I specify a non-standard TCP port for a git+ssh connection?
Date: 2 Dec 2005 14:31:01 -0500
Message-ID: <20051202193101.29853.qmail@science.horizon.com>
X-From: git-owner@vger.kernel.org Fri Dec 02 20:33:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EiGcj-000197-Ji
	for gcvg-git@gmane.org; Fri, 02 Dec 2005 20:31:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbVLBTbJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Dec 2005 14:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbVLBTbJ
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Dec 2005 14:31:09 -0500
Received: from science.horizon.com ([192.35.100.1]:38440 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1750875AbVLBTbJ
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 2 Dec 2005 14:31:09 -0500
Received: (qmail 29854 invoked by uid 1000); 2 Dec 2005 14:31:01 -0500
To: aj@andaco.de, git@vger.kernel.org, torvalds@osdl.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13122>

Actually, you don't need any git support.  ssh allows you to set up
"virtual hosts" with any combination of options you like.

Host <virtual>
        HostName <physical>
	Port <nonstandard>
        User <whoever>
        IdentityFile    <custom>
        ForwardAgent    no

So typing "ssh <virtual>" will have the effect of
ssh <whoever>@<physical> -p <nonstandard> -i <custom> -a

Quite often, you let <virtual> == <physical>, so it's "custom settings
for talking to this host", but you can have multiple different virtual
names that all map to the same physical host.

But the point is that as long as you can pass a hostname through to ssh,
you can carry as many custom settings as you like with it.
