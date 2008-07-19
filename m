From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Ensure that SSH runs in non-interactive mode
Date: Sat, 19 Jul 2008 19:52:10 +0200
Organization: glandium.org
Message-ID: <20080719175210.GA7835@glandium.org>
References: <1216487215-6927-1-git-send-email-fredrik@dolda2000.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Fredrik Tolf <fredrik@dolda2000.com>
X-From: git-owner@vger.kernel.org Sat Jul 19 19:53:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKGcM-0008Fd-5D
	for gcvg-git-2@gmane.org; Sat, 19 Jul 2008 19:53:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754825AbYGSRwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2008 13:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754707AbYGSRwP
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jul 2008 13:52:15 -0400
Received: from vuizook.err.no ([194.24.252.247]:54495 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754553AbYGSRwO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2008 13:52:14 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1KKGbF-0000Q2-UX; Sat, 19 Jul 2008 19:52:12 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1KKGbK-000276-CA; Sat, 19 Jul 2008 19:52:10 +0200
Content-Disposition: inline
In-Reply-To: <1216487215-6927-1-git-send-email-fredrik@dolda2000.com>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89118>

On Sat, Jul 19, 2008 at 07:06:55PM +0200, Fredrik Tolf wrote:
> OpenSSH has the nice feature that it sets the IP TOS value of its
> connection depending on usage. When used in interactive mode, it
> is set to Minimize-Delay, and other wise to Maximize-Throughput. Its
> usage by Git is best served by Maximize-Throughput, for obvious
> reasons.
> 
> However, it seems to use a DWIM heuristic for detecting interactive
> mode. The current implementation enters interactive mode if either
> a PTY is allocated or X11 forwarding is enabled, and even though Git
> SSH:ing does not allocate a PTY, X11 forwarding is often turned on
> by default. By removing the DISPLAY env variable before forking, SSH
> can thus be forced into non-interactive mode, without any obvious
> ill effects.

Wouldn't adding the -x option be better ? Also adding -T could be a good
idea.

Mike
