From: Ed Avis <eda@waniasset.com>
Subject: Re: Suggestion: make git checkout safer
Date: Thu, 4 Jun 2015 11:00:09 +0000 (UTC)
Message-ID: <loom.20150604T124827-124@post.gmane.org>
References: <loom.20150603T104534-909@post.gmane.org> <20150603090654.GD32000@peff.net> <loom.20150603T110826-777@post.gmane.org> <20150603093514.GF32000@peff.net> <loom.20150603T114527-151@post.gmane.org> <20150603194756.GB29730@vps892.directvps.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 04 13:00:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0StB-0007G0-5r
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jun 2015 13:00:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753136AbbFDLAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2015 07:00:41 -0400
Received: from plane.gmane.org ([80.91.229.3]:46445 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752720AbbFDLAj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2015 07:00:39 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Z0St2-000791-6I
	for git@vger.kernel.org; Thu, 04 Jun 2015 13:00:36 +0200
Received: from 80.169.169.174 ([80.169.169.174])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 04 Jun 2015 13:00:36 +0200
Received: from eda by 80.169.169.174 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 04 Jun 2015 13:00:36 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 80.169.169.174 (Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:38.0) Gecko/20100101 Firefox/38.0 Cyberfox/38.0.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270766>

Kevin Daudt <me <at> ikke.info> writes:

>If people execute git checkout . as a habbit
>without thinking, they will soon train to do git checkout -f . without
>thinking, and then you still have the same problem.

I don't quite agree; you only learn to use the -f flag if the plain command
doesn't do what you want.  With rm, I want to remove that file, dammit!  The
-f flag is often a necessity to stop the tool getting in my way.  But when
fixing up a working tree, I rarely want to silently trash any local changes.

>I do share your sentiment that it's easy to loose uncomitted changes to
>git checkout <path>, but like Jeff said, the entire goal of this command
>is to reset specific files from the index or commits.

Well that's not quite the flavour given by the documentation, which says

    >Updates files in the working tree to match...

'Updating' files sounds like a fairly safe thing to do, right?  Like 'cvs
update' or 'svn update', which don't just overwrite working tree changes.
The doc doesn't really make clear that any local changes will be discarded;
indeed the only mention of that is

       -f, --force
         When switching branches... this is used to throw away local changes.

To the casual reader, following 'the exception proves the rule', it appears
that local changes are not thrown away except in this case.

-- 
Ed Avis <eda@waniasset.com>
