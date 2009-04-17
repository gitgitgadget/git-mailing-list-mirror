From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 3/3] Extracted AWT-independent superclass from
	DefaultSshSessionFactory
Date: Fri, 17 Apr 2009 08:16:45 -0700
Message-ID: <20090417151645.GQ23604@spearce.org>
References: <85647ef50904160711w6fbcfcedk2b9a9e1740a4ddd3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Constantine Plotnikov <constantine.plotnikov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 17 17:18:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Luppx-0007tg-FN
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 17:18:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760010AbZDQPQs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 11:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759084AbZDQPQr
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 11:16:47 -0400
Received: from george.spearce.org ([209.20.77.23]:47812 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756999AbZDQPQq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 11:16:46 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 02F4438211; Fri, 17 Apr 2009 15:16:45 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <85647ef50904160711w6fbcfcedk2b9a9e1740a4ddd3@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116745>

Constantine Plotnikov <constantine.plotnikov@gmail.com> wrote:
> The part of DefaultSshSessionFactory that does not depend on
> AWT was refactored to the super class SshConfigSessionFactory.
> The parts of DefaultSshSessionFactory that were used only by
> the OpenSshConfig class were moved to that class.
> 
> Signed-off-by: Constantine Plotnikov <constantine.plotnikov@gmail.com>

Thanks. I applied this, but with a couple of style nitpicks corrected.

> --- a/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java
> @@ -95,6 +97,9 @@ public static OpenSshConfig get() {
>  	/** Cached entries read out of the configuration file. */
>  	private Map<String, Host> hosts;
> 
> +	/** IANA assigned port number for SSH. */
> +	static final int SSH_PORT = 22;
> +

Static constants should be at the top of the class, not after the
instance members.

-- 
Shawn.
