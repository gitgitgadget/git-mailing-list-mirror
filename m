From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: What's cooking in git.git (Aug 2008, #01; Tue, 05)
Date: Wed, 6 Aug 2008 07:21:28 -0700
Message-ID: <20080806142128.GA28231@spearce.org>
References: <7vmyjqsm04.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 16:22:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQjuJ-0003Ww-MM
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 16:22:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756060AbYHFOV3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2008 10:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754908AbYHFOV3
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 10:21:29 -0400
Received: from george.spearce.org ([209.20.77.23]:51678 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752612AbYHFOV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 10:21:28 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 4141438420; Wed,  6 Aug 2008 14:21:28 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vmyjqsm04.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91514>

Junio C Hamano <gitster@pobox.com> wrote:
> [New Topics]
> * sp/smart-http (Sun Aug 3 00:25:17 2008 -0700) 2 commits
>  - [do not merge -- original version] Add Git-aware CGI for Git-aware
>    smart HTTP transport
>  - Add backdoor options to receive-pack for use in Git-aware CGI
> 
> The "magic" detection protocol was revised to use POST to info/refs; the
> top one queued is from before that discussion.

I'm surprised you queued these.  They really are not ready for
application to a tree.  For example the CGI is really messed up for
trying to do Transfer-Encoding: chunked on its own, JH was right and
Apache does it for us.  That removed a good chunk of code from it.

Writing the client for this is slightly non-trivial.  I more-or-less
want to shove it into send-pack, not http-push, as the bulk of the
protocol we need to speak is there in send-pack.

Anyway, I'm going to try to get back to this topic more later
this week.  I have been focusing on JGit this week (or at least
trying to) as I really need to get some stuff done there for EGit.

-- 
Shawn.
