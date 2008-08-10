From: Jan Engelhardt <jengelh@medozas.de>
Subject: Re: Two-step tag fetching
Date: Sun, 10 Aug 2008 11:27:20 -0400 (EDT)
Message-ID: <alpine.LNX.1.10.0808101124370.1727@fbirervta.pbzchgretzou.qr>
References: <alpine.LNX.1.10.0808101115290.1727@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 10 17:28:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSCqF-0008Bw-R3
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 17:28:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753781AbYHJP1W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 11:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753902AbYHJP1W
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 11:27:22 -0400
Received: from sovereign.computergmbh.de ([85.214.69.204]:36145 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753718AbYHJP1V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 11:27:21 -0400
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id 8E84E18032C9B; Sun, 10 Aug 2008 17:27:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id 8537B1C415402
	for <git@vger.kernel.org>; Sun, 10 Aug 2008 11:27:20 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.10.0808101115290.1727@fbirervta.pbzchgretzou.qr>
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91847>


On Sunday 2008-08-10 11:19, Jan Engelhardt wrote:
>
>
>I have a somewhat older development tree at git://dev.medozas.de/linux 
>(about 2.6.26-rc6), and without any tags. Now, adding in Linus's 
>repository makes it gather all the new stuff, and all the missing tags:
>[...]
>What interests me here is why there are two "From" lines.

I just noticed the same with stable-2.6.19.y.git (and all others), like

>From git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.19.y
 * [new branch]      master     -> stable19/master
 * [new tag]         v2.6.19.7  -> v2.6.19.7
From git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.19.y
 * [new tag]         v2.6.19.1  -> v2.6.19.1
 * [new tag]         v2.6.19.2  -> v2.6.19.2
 * [new tag]         v2.6.19.3  -> v2.6.19.3
 * [new tag]         v2.6.19.4  -> v2.6.19.4
 * [new tag]         v2.6.19.5  -> v2.6.19.5
 * [new tag]         v2.6.19.6  -> v2.6.19.6

And my suspicion is that v2.6.19.1--v2.6.19.6 have been repacked into 
packed-refs, and v2.6.19.7 has been added later and is a loose tag (as 
is the master branch). So the packed-refs (with less recent history) are 
fetched later, which conflicts with the output from Linus's repo where I 
get the (possibly packed) tags first, in chronological order.
