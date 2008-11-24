From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH 3/3] Add -k/--keep-going option to mergetool
Date: Mon, 24 Nov 2008 21:59:27 +0000
Message-ID: <20081124215927.GA5293@hashpling.org>
References: <1226580075-29289-1-git-send-email-charles@hashpling.org> <1226580075-29289-2-git-send-email-charles@hashpling.org> <1226580075-29289-3-git-send-email-charles@hashpling.org> <1226580075-29289-4-git-send-email-charles@hashpling.org> <7vy6zl7drn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Andreas Ericsson <ae@op5.se>, "Theodore Ts'o" <tytso@mit.edu>,
	William Pursell <bill.pursell@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 24 23:01:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4jUG-000363-Bk
	for gcvg-git-2@gmane.org; Mon, 24 Nov 2008 23:00:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752994AbYKXV7l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2008 16:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752932AbYKXV7l
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Nov 2008 16:59:41 -0500
Received: from pih-relay06.plus.net ([212.159.14.19]:48513 "EHLO
	pih-relay06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752491AbYKXV7k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2008 16:59:40 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay06.plus.net with esmtp (Exim) id 1L4jSt-0006mV-Gn; Mon, 24 Nov 2008 21:59:31 +0000
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id mAOLxUBA005779
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 24 Nov 2008 21:59:30 GMT
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id mAOLxRpY005778;
	Mon, 24 Nov 2008 21:59:27 GMT
Content-Disposition: inline
In-Reply-To: <7vy6zl7drn.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Plusnet-Relay: 225c838a5facd9a883c690ae1027848a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101627>

On Fri, Nov 14, 2008 at 09:35:08PM -0800, Junio C Hamano wrote:
> Charles Bailey <charles@hashpling.org> writes:
> 
> > This option stops git mergetool from aborting at the first failed merge.
> > This allows some additional use patterns. Merge conflicts can now be
> > previewed one at time and merges can also be skipped so that they can be
> > performed in a later pass.
> 
> Hmm, with this command line:
> 
> > -'git mergetool' [--tool=<tool>] [-y|--no-prompt|--prompt] [<file>]...
> 
> I wonder why this even needs to be an option.  If you do not want to
> resolve all of them, you can limit the amount of work you would do by
> giving list of paths to work on, can't you?
> 

I have to say that since having this in my tree I've benefitted hugely
from using a visual diff tool as a merge preview tool. I'm working on
a (far from ideal) project where two branches are diverging fast due
to differing goals, yet there is a need for an end product with the
functionality of both branches in it.

This means that I often end up needing to do frequent large merges.
Often it is not until I have the merge open in front of me that it
becomes obvious that while a particular file needs merging, the best
merge strategy will only be obvious after resolving the conflicts in
other parts of the system.

Often several hours of work will just be four or five invocations of
git mergetool until something which compiles emerges. Stopping to view
what the next unmerged file path is and pasting it into another
mergetool command line seems like an unnecessary distraction.

Charles.
