From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Applying patches in a directory that isn't a repository
Date: Thu, 28 Jun 2007 23:29:24 -0700
Message-ID: <7v3b0bi88r.fsf@assigned-by-dhcp.pobox.com>
References: <93c3eada0706280153w1898be80u7785ef2b2b1dd188@mail.gmail.com>
	<93c3eada0706282307i7a22bd27w6ca10839d36ea4eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: geoffrey.russell@gmail.com
X-From: git-owner@vger.kernel.org Fri Jun 29 08:29:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I49yy-0003RF-7o
	for gcvg-git@gmane.org; Fri, 29 Jun 2007 08:29:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752771AbXF2G30 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jun 2007 02:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752646AbXF2G30
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jun 2007 02:29:26 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:60064 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752158AbXF2G3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jun 2007 02:29:25 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070629062925.OCMP1257.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Fri, 29 Jun 2007 02:29:25 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id HJVQ1X0081kojtg0000000; Fri, 29 Jun 2007 02:29:24 -0400
In-Reply-To: <93c3eada0706282307i7a22bd27w6ca10839d36ea4eb@mail.gmail.com>
	(Geoff Russell's message of "Fri, 29 Jun 2007 15:37:31 +0930")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51150>

"Geoff Russell" <geoffrey.russell@gmail.com> writes:

> But "git am" needs (AFAIK) a full repository. Is there a way to apply
> a patch without
> .git being present?

If the recipient does not have a git repository, there is no
point using "git am", as it is about making commits out of
e-mails.

git-apply acts as a plain "patch applicator".

Another possibility is to use "GNU patch", with -p1.  That
historically has been how the patches were applied, and the
output from git-diff is designed to be very compatible with it,
unless you choose to use more advanced features that "GNU patch"
does not support yet (notably, renames, mode changes, and binary
diffs).
