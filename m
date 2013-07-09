From: Aaron Schrab <aaron@schrab.com>
Subject: Re: [PATCH 7/7] push: document --lockref
Date: Tue, 9 Jul 2013 16:17:24 -0400
Message-ID: <20130709201724.GI4604@pug.qqx.org>
References: <7vfvvwk7ce.fsf@alter.siamese.dyndns.org>
 <1373399610-8588-1-git-send-email-gitster@pobox.com>
 <1373399610-8588-8-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 09 22:27:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UweVa-0003Re-2b
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 22:27:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753257Ab3GIU1a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 16:27:30 -0400
Received: from pug.qqx.org ([50.116.43.67]:54304 "EHLO pug.qqx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752808Ab3GIU13 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 16:27:29 -0400
X-Greylist: delayed 604 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Jul 2013 16:27:29 EDT
Received: by pug.qqx.org (Postfix, from userid 1000)
	id 84D4B1D3C0; Tue,  9 Jul 2013 16:17:24 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1373399610-8588-8-git-send-email-gitster@pobox.com>
User-Agent: Mutt/1.5.21+145 (gd0ebb66) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230001>

At 12:53 -0700 09 Jul 2013, Junio C Hamano <gitster@pobox.com> wrote:
>+This is meant to make `--force` safer to use.  Imagine that you have
>+to rebase what you have already published.  You will have to
>+`--force` the push to replace the history you originally published
>+with the rebased history.  If somebody else built on top of your
>+original history while you are rebasing, the tip of the branch at
>+the remote may advance with her commit, and blindly pushing with
>+`--force` will lose her work.  By using this option to specify that
>+you expect the history you are updating is what you rebased and want
>+to replace, you can make sure other people's work will not be losed
>+by a forced push. in such a case.

s/losed/lost/

How does this behave if --force is not used?  I think it would be best 
if it was a no-op in that case to make it easy to add a config option to 
turn this on by default.
