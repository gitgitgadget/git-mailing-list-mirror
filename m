From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Summer of Code - Cached Packs/Object Lists
Date: Sun, 22 Mar 2009 19:52:44 -0700
Message-ID: <20090323025244.GO23521@spearce.org>
References: <20090323015936.GM23521@spearce.org> <fsmk86y8vqj4f56b08UYAxe124vaj_firegpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Coppi <thisnukes4u@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 03:54:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlaIp-0007sD-VO
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 03:54:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755456AbZCWCwr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 22:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755398AbZCWCwr
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 22:52:47 -0400
Received: from george.spearce.org ([209.20.77.23]:43643 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755390AbZCWCwq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 22:52:46 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id ECB1638211; Mon, 23 Mar 2009 02:52:44 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <fsmk86y8vqj4f56b08UYAxe124vaj_firegpg@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114235>

Thomas Coppi <thisnukes4u@gmail.com> wrote:
> On Sun, Mar 22, 2009 at 7:59 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
>> You could do both. ??But I think most people on the list will argue
>> that doing both is overkill and only one is necessary, and further,
>> that only the one that offers the "biggest bank for the buck"
>> should be implemented.
>
> Alright, that seems reasonable.  Given that I think I would lean
> towards implementing an object list caching mechanism, since that seems
> to be more generally applicable.  The logic for this would then need to
> be in the rev-list code(as mentioned in the JGit discussion), correct?

Probably.  IIRC upload-pack forks a rev-list to produce the
object list, and pipes that into the forked pack-objects' stdin.
Thus rev-list is probably what would need to know how to include
the cached list to its output.

-- 
Shawn.
