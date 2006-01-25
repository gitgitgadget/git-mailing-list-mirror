From: Pavel Roskin <proski@gnu.org>
Subject: Re: Caching directories
Date: Wed, 25 Jan 2006 02:29:32 -0500
Message-ID: <1138174172.27366.116.camel@dv>
References: <1138076423.15105.36.camel@dv>
	 <7vvew8zwfe.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 25 08:30:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F1f6S-0004Ik-VI
	for gcvg-git@gmane.org; Wed, 25 Jan 2006 08:30:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWAYH37 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jan 2006 02:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbWAYH37
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jan 2006 02:29:59 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:29591 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1750759AbWAYH36
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2006 02:29:58 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1F1f66-0007hB-4S
	for git@vger.kernel.org; Wed, 25 Jan 2006 02:29:43 -0500
Received: from proski by dv.roinet.com with local (Exim 4.60)
	(envelope-from <proski@dv.roinet.com>)
	id 1F1f5w-0001su-Ud; Wed, 25 Jan 2006 02:29:32 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvew8zwfe.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.5.4 (2.5.4-10) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15121>

On Tue, 2006-01-24 at 21:52 -0800, Junio C Hamano wrote:
> Pavel Roskin <proski@gnu.org> writes:
> 
> > Maybe it's time to start caching directories in git?  I mean,
> > directories corresponding to tree objects could have their stats
> > recorded in the cache.  This would allow to distinguish between tracked
> > and untracked directories without scanning them recursively.
> 
> I do not understand the above logic.  
> 
> Given a directory path, finding out if the directory has
> something tracked in it is an O(log n) operation in the current
> index that does not "cache directory".  Your message implies
> that you feel we could use the index file to list "untracked
> directories" without recursively scanning the directory tree,
> but to me, the only way to do that is to record a new directory
> in the index file every time somebody (either Makefile or the
> user) creates a junk directory.  That does not make much sense
> to me, so I am probably misreading what you really meant.

Sorry, it looks like my post was based on incorrect assumptions.  The
new --directory option to git-ls-files seems to be exactly what I want.
It allowed me to simplify cg-clean immensely.  Further simplification
will be possible once the support for .gitignore in parent directories
is fixed.

> I have no idea what 'clean' does, so would not comment on that
> part of your message.

It means removing untracked files and directories.

-- 
Regards,
Pavel Roskin
