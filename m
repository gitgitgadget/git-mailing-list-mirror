From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: hg-to-git performance on big repos
Date: Sat, 22 Mar 2008 10:27:58 -0400
Message-ID: <20080322142758.GT7991@mit.edu>
References: <20080322162618.K47359@geo.geo.loc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Fedor V. Sergeev" <theodor@geo.phys.spbu.ru>
X-From: git-owner@vger.kernel.org Sat Mar 22 15:29:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jd4iK-00054p-LH
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 15:28:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755098AbYCVO2J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2008 10:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754674AbYCVO2I
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 10:28:08 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:60223 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754654AbYCVO2H (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Mar 2008 10:28:07 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m2MES0aS011582;
	Sat, 22 Mar 2008 10:28:00 -0400 (EDT)
Received: from closure.thunk.org (c-98-216-98-217.hsd1.ma.comcast.net [98.216.98.217])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m2MERwfB009825
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 22 Mar 2008 10:28:00 -0400 (EDT)
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@mit.edu>)
	id 1Jd4hS-0003dl-Ia; Sat, 22 Mar 2008 10:27:58 -0400
Content-Disposition: inline
In-Reply-To: <20080322162618.K47359@geo.geo.loc>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77813>

On Sat, Mar 22, 2008 at 04:34:22PM +0300, Fedor V. Sergeev wrote:
> Folks,
> 
> I'm trying to convert a relatively big Mercurial repo (70K commits)
> into Git using contrib/hg-to-git.  It initially goes fine but starts
> to slow down nearly exponentially as the number of converted
> changesets goes up.
> 
> git-fast-import seems to just hang around, while all the work (100% cpu)
> is spent in that python thing. It does not eat up memory, pstack looks
> fine, but after some 10K commits it just crawls.

I don't know if it will be better, but at the time when I needed to
convert e2fsprogs, I liked the results of hg-fast-export, found at:

        url = git://repo.or.cz/fast-export.git

You might hg-fast-import and see if it does any better for your repo.

Does it have a large number of branches or tags, by any chance?

     	       	     	       		   	 - Ted
