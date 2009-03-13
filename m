From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH JGIT] Allow writeObject() write to OutputStream
Date: Fri, 13 Mar 2009 08:08:06 -0700
Message-ID: <20090313150806.GE22920@spearce.org>
References: <1236844931-12807-1-git-send-email-j16sdiz+freenet@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Daniel Cheng (aka SDiZ)" <j16sdiz+freenet@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 13 16:12:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Li91C-0002Lr-TI
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 16:09:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751866AbZCMPIJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 11:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752717AbZCMPIJ
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 11:08:09 -0400
Received: from george.spearce.org ([209.20.77.23]:53832 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852AbZCMPII (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 11:08:08 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id D6D9D38211; Fri, 13 Mar 2009 15:08:06 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1236844931-12807-1-git-send-email-j16sdiz+freenet@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113195>

"Daniel Cheng (aka SDiZ)" <j16sdiz+freenet@gmail.com> wrote:
> 
> This patch make factor out the object writing code in ObjectWriter,
> allow it to write to any OutputStream. 
> Subclass class may then override
>   writeObject(final int type, long len, InputStream is, boolean store)
> to make it write to alternative locations.
> 
> There are some discussion on devl@freenetproject.org to use raw 
> (uncompressed) object to freenet. This patch allow the testing.

Ok, I understand the code as-is, but I'm not sure I understand the
reasoning for the change, or where you are trying to go with it.

Are you guys talking about making every object a loose object on
freenet, and avoiding pack files?  Or making a form of JGit that
access a Repository directly stored on freenode?

I ask because there's some folks starting to talk about putting JGit
onto a distributed hash table sort of system like Hadoop HBase,
to allow the underlying storage to scale efficiently for really
big hosting sites.  I would rather see a pooling of effort here
than folks going in different directions.
 
-- 
Shawn.
