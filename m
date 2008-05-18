From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH] mergetool: export variables for use by custom
	mergetools
Date: Sun, 18 May 2008 01:07:39 +0100
Message-ID: <20080518000739.GA29689@hashpling.org>
References: <8b4e944ac849029f31f403ab75198ed6fb4197c1.1211056369.git.davvid@gmail.com> <20080517233414.GA28196@hashpling.org> <b6840c770805171655y691fbd0vd2d65d0914757b63@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, tytso@mit.edu,
	git@vger.kernel.org
To: Evgeny <evgeny.zislis@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 18 02:09:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxWSV-0000y9-0B
	for gcvg-git-2@gmane.org; Sun, 18 May 2008 02:09:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755196AbYERAHq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2008 20:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754797AbYERAHp
	(ORCPT <rfc822;git-outgoing>); Sat, 17 May 2008 20:07:45 -0400
Received: from pih-relay04.plus.net ([212.159.14.131]:40413 "EHLO
	pih-relay04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754526AbYERAHp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2008 20:07:45 -0400
X-Greylist: delayed 2006 seconds by postgrey-1.27 at vger.kernel.org; Sat, 17 May 2008 20:07:45 EDT
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay04.plus.net with esmtp (Exim) id 1JxWRA-0007Ve-Ek; Sun, 18 May 2008 01:07:40 +0100
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id m4I07efh030148;
	Sun, 18 May 2008 01:07:40 +0100
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id m4I07dvj030147;
	Sun, 18 May 2008 01:07:39 +0100
Content-Disposition: inline
In-Reply-To: <b6840c770805171655y691fbd0vd2d65d0914757b63@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Plusnet-Relay: f830f1943af8b23c63ef00174ea1c241
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82369>

On Sun, May 18, 2008 at 02:55:10AM +0300, Evgeny wrote:
> Ohh, so the documentation is not clear then.

That's a pity, I did make an effort with the documentation, but
explaining things is not my strongest ability.

> 
> [mergetool "p4merge"]
> 	cmd = p4merge.sh "$PWD/$BASE" "$PWD/$REMOTE" "$PWD/$LOCAL" "$PWD/$MERGED"
> 	keepBackup = false
> 
> [merge]
> 	tool = p4merge
> 

"$PWD/" looks very wrong. Perhaps p4merge.sh is changing its working
directory and not handling the passed paths correctly?

> Thanks for the explanation!
> I believe that an example in the documentation could be a nice
> addition, to clear things up in the future.

Yes, there were a few examples in the original patch mail text (note
that 'path' has sinces changed to 'MERGED'), but they never made it to
the documentation. There's also some discussion about eval vs. leaking
environment variables:

http://thread.gmane.org/gmane.comp.version-control.git/74059

-- 
Charles Bailey
http://ccgi.hashpling.plus.com/blog/
