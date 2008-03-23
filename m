From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: What I miss from Cogito...
Date: Sun, 23 Mar 2008 13:38:41 -0400
Message-ID: <20080323173841.GA24943@mit.edu>
References: <47E69044.3000207@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Sun Mar 23 18:39:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdUAc-0000Zb-W1
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 18:39:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753009AbYCWRjG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 13:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753307AbYCWRjE
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 13:39:04 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:62441 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753009AbYCWRjE (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Mar 2008 13:39:04 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m2NHd0s1029329;
	Sun, 23 Mar 2008 13:39:01 -0400 (EDT)
Received: from closure.thunk.org (c-98-216-98-217.hsd1.ma.comcast.net [98.216.98.217])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m2NHcnkj007257
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 23 Mar 2008 13:38:55 -0400 (EDT)
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@mit.edu>)
	id 1JdU9b-0006aA-H2; Sun, 23 Mar 2008 13:38:43 -0400
Content-Disposition: inline
In-Reply-To: <47E69044.3000207@zytor.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77931>

On Sun, Mar 23, 2008 at 10:15:48AM -0700, H. Peter Anvin wrote:
> 2. cg-restore
>
>    Cogito separated "reset" and "restore".  This is a syntactic sugar
>    issue, but having to type "git reset --hard -- path" makes me
>    nervous, especially since hitting Enter at the wrong time could have
>    serious and irrevocable consequences.
>
>    I also note that this particular use of "git reset" is actually
>    undocumented, but it seems to work.

I didn't think "git reset --hard -- <pathame>" was valid, since it's
not documented in the man page.

I have the following in my path as "git-revert-file" (which is easier
to type and less dangerous than typing "git reset --hard -- <path>"):

#!/bin/sh
#
prefix=$(git rev-parse --show-prefix)

for i in $*
do
        git show HEAD:$prefix$i > $i
done


							- Ted
