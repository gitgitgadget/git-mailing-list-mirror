From: Petr Baudis <pasky@suse.cz>
Subject: Re: Files that want to delete themselves
Date: Wed, 24 Sep 2008 20:04:36 +0200
Message-ID: <20080924180436.GJ10544@machine.or.cz>
References: <19654453.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andrew Vit <andrew@avit.ca>
X-From: git-owner@vger.kernel.org Wed Sep 24 20:06:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiYkH-0008Et-EZ
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 20:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602AbYIXSEj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 14:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752341AbYIXSEj
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 14:04:39 -0400
Received: from w241.dkm.cz ([62.24.88.241]:48568 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751318AbYIXSEi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 14:04:38 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 9F22C3939B21; Wed, 24 Sep 2008 20:04:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <19654453.post@talk.nabble.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96673>

  Hi,

On Wed, Sep 24, 2008 at 10:55:02AM -0700, Andrew Vit wrote:
> I have a Rails project that I'm managing with git and I have a strange
> problem with one of the plugin directories. Every time I do `git add .` it
> tries to delete itself... Any idea what might be happening?

  so how does that look like in git diff? My guess is you have a .git/
subdirectory there and thus Git assumes that it is a submodule? I don't
think we actually have a way to specify that some directory should NOT
be considered a submodule even if it is a git checkout... So you will
probably either have to actually convert this to a submodule in your
project (probably the sanest thing to do), move the .git subdirectory
away or submit a patch that will add say a .gitattributes flag not to
consider this subdirectory to be a submodule (which might make some
sense).

-- 
				Petr "Pasky" Baudis
People who take cold baths never have rheumatism,
but they have cold baths.
