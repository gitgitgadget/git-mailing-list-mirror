From: Mike Hommey <mh@glandium.org>
Subject: Re: Undo git-rm without commit?
Date: Wed, 26 Mar 2008 07:24:22 +0100
Organization: glandium.org
Message-ID: <20080326062422.GA18856@glandium.org>
References: <D6386C1A-92D3-4E11-8DE6-CC7553211A33@faithfulgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joe Fiorini <joe@faithfulgeek.org>
X-From: git-owner@vger.kernel.org Wed Mar 26 07:25:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeP4Y-0001Vc-2d
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 07:25:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753064AbYCZGYh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 02:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753083AbYCZGYh
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 02:24:37 -0400
Received: from vuizook.err.no ([194.24.252.247]:55405 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752993AbYCZGYg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2008 02:24:36 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JeP3j-0007NY-74; Wed, 26 Mar 2008 07:24:33 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JeP3e-0004xa-SP; Wed, 26 Mar 2008 07:24:22 +0100
Content-Disposition: inline
In-Reply-To: <D6386C1A-92D3-4E11-8DE6-CC7553211A33@faithfulgeek.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78263>

On Wed, Mar 26, 2008 at 02:17:18AM -0400, Joe Fiorini wrote:
> I hadn't done a git-commit yet, but I used git-rm thinking it would  
> remove files that I had just added.  Instead, it deleted everything I  
> had added from the disk.  Is there a way to undo this?  I'm doubtful,  
> but would love to not have to rewrite what I was working on.

Your best take would be to take a look at the unreachable loose objects
in your repository. One way to have a list of them would be to do a
git prune -n. Then you can look at the contents of each blob in those
with either git cat-file -p $sha1, or git show $sha1.

Mike

PS: What you wanted to use is git reset, not git rm.
