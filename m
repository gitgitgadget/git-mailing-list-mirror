From: Ed Avis <eda@waniasset.com>
Subject: Re: 'git show' with multiple revisions
Date: Wed, 29 Apr 2015 15:47:33 +0000 (UTC)
Message-ID: <loom.20150429T174544-7@post.gmane.org>
References: <loom.20150428T120412-982@post.gmane.org> <20150429020452.GA873@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 29 17:48:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnUDI-0008Rf-DF
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 17:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753667AbbD2Prs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 11:47:48 -0400
Received: from plane.gmane.org ([80.91.229.3]:52467 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753639AbbD2Prr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 11:47:47 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1YnUDB-0008Mi-1P
	for git@vger.kernel.org; Wed, 29 Apr 2015 17:47:45 +0200
Received: from 80.169.169.174 ([80.169.169.174])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 29 Apr 2015 17:47:45 +0200
Received: from eda by 80.169.169.174 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 29 Apr 2015 17:47:45 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 80.169.169.174 (Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:36.0) Gecko/20100101 Firefox/36.0 Cyberfox/36.0.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267976>

Jeff King <peff <at> peff.net> writes:

>I think you want `git cat-file`:
>
>  {
>	echo REV1:FILE
>	echo REV2:FILE
>  } |
>  git cat-file --batch
>
>This prints a header line for each output object which contains the size
>of the object (so a parser reads a header line, then N bytes, then a
>header line, N bytes, and so on).

This looks like what I want but the object ids printed appear to be the id
of the file in a given revision - not the id of the revision itself.
So the ids in the output are not the same as the ones in the input.

That's fine, as long as I can assume that the output entries are in the same
order as the input?

-- 
Ed Avis <eda@waniasset.com>
