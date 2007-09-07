From: Junio C Hamano <gitster@pobox.com>
Subject: Re: how to access working tree from .git dir?
Date: Fri, 07 Sep 2007 13:43:09 -0700
Message-ID: <7v642m436q.fsf@gitster.siamese.dyndns.org>
References: <1189120800.6203.23.camel@beauty>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Josh England" <jjengla@sandia.gov>
X-From: git-owner@vger.kernel.org Fri Sep 07 22:43:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITkff-00042Z-NC
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 22:43:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758419AbXIGUnP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 16:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758414AbXIGUnO
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 16:43:14 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:48595 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758408AbXIGUnO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 16:43:14 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 03EB712E301;
	Fri,  7 Sep 2007 16:43:32 -0400 (EDT)
In-Reply-To: <1189120800.6203.23.camel@beauty> (Josh England's message of
	"Thu, 06 Sep 2007 17:20:00 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58071>

"Josh England" <jjengla@sandia.gov> writes:

> In messsing around with hooks, I've discovered that not all hooks are
> run in the same environment.  In particular, the current working
> directory in the post-receive hook (maybe others as well) is the GIT_DIR
> (.git) directory, instead of the root of the working tree (as in
> pre-commit).

It is not even "instead of"; that's the only sane thing to do
for post-receive, which is in response to git-push and usually
used for a bare repository, i.e. without any work tree.
