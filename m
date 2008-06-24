From: "David Jeske" <jeske@google.com>
Subject: Re: why is git destructive by default? (i suggest it not be!)
Date: Tue, 24 Jun 2008 04:40:16 -0000
Message-ID: <31555.0678795718$1214283260@news.gmane.org>
References: <alpine.LFD.1.10.0806232356340.2979@xanadu.home>
	<willow-jeske-01l5PFjPFEDjCfzf-01l5fAcTFEDjCWA4>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Jun 24 06:54:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB0Xi-0002JB-En
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 06:54:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbYFXExP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 00:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbYFXExP
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 00:53:15 -0400
Received: from w2.willowmail.com ([64.243.175.54]:60006 "HELO
	w2.willowmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750751AbYFXExP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 00:53:15 -0400
Received: (qmail 8118 invoked by uid 90); 24 Jun 2008 04:52:53 -0000
X-Mailer: Willow v0.02
Received: from 67.188.42.104 at Tue, 24 Jun 2008 04:40:16 -0000
In-Reply-To: <alpine.LFD.1.10.0806232356340.2979@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85988>

-- Nicolas Pitre wrote:
> I hope you'll feel much safer then.

I moved a branch around and then deleted it, and I don't see any record in the
reflog of where it was, or that it ever was.

Am I missing something about how branches are used? I see some language in "git
tag" about how attempts are made to assure that others can't move around
semi-immutable tags during push, but I don't see any such language about
branches. What prevents someone from accidentally deleting an old branch that
nobody is watching, but is important to the history and then not noticing as gc
silently deletes the old deltas?

I've had need to pull out versions several years old multiple times in my
career, so this is the kind of thing I'm thinking about.

git config --global gc.reflogexpire            "10 years"'
git config --global gc.reflogexpireunreachable "10 years"

Makes me feel safer that the data will be in there, but even with the reflog
and access to the repository, I doubt I could FIND the place an old branch was
supposed to be if it was inadvertently deleted in a 2-million line source tree.
Am I just looking in the wrong places?
