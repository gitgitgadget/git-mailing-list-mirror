From: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: Re: First web interface and service API draft
Date: Fri, 22 Apr 2005 10:23:42 -0400
Message-ID: <20050422142342.GG30915@delft.aura.cs.cmu.edu>
References: <1114166517.3233.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 16:21:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOyzu-0006J8-Bn
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 16:19:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbVDVOXp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 10:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbVDVOXp
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 10:23:45 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:53136 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S261895AbVDVOXn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2005 10:23:43 -0400
Received: from jaharkes by delft.aura.cs.cmu.edu with local (Exim 3.36 #1 (Debian))
	id 1DOz4I-0000Z9-00; Fri, 22 Apr 2005 10:23:42 -0400
To: Christian Meder <chris@absolutegiganten.org>
Mail-Followup-To: Christian Meder <chris@absolutegiganten.org>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1114166517.3233.4.camel@localhost>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 22, 2005 at 12:41:56PM +0200, Christian Meder wrote:
> -------
> /<project>/blob/<blob-sha1>
> /<project>/commit/<commit-sha1>

It is trivial to find an object when given a sha, but to know the object
type you'd have to decompress it and check inside. Also the way git
stores these things you can't have both a blob and a commit with the
same sha anyways.

So why not use,
    /<project/<hexadecimal sha1 representation>
	will give you the raw object.

    /<project/<hexadecimal sha1 representation>.html (.xml/.txt)
	will give you a parsed version for user presentation

And since hexadecimal numbers only have [0-9a-f] as valid characters,
you can still have additional directories that can be guaranteed unique
as long as the first two characters are not a valid hexadecimal value.
So things like /branch/linus, or /changelog/, /log/, /diff/. Yeah, you
can't use /delta/ without looking at more than the first two characters,
but that's where dictionaries can come in handy.

Jan

