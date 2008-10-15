From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH (GITK) v3 0/4] Enhance encoding support.
Date: Wed, 15 Oct 2008 23:38:18 +1100
Message-ID: <18677.58426.326371.788610@cargo.ozlabs.ibm.com>
References: <1223885554-27718-1-git-send-email-angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 14:39:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kq5fI-0003Pj-OO
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 14:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752710AbYJOMih (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 08:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752663AbYJOMih
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 08:38:37 -0400
Received: from ozlabs.org ([203.10.76.45]:59488 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752103AbYJOMig (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 08:38:36 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id B96C0DE2F7; Wed, 15 Oct 2008 23:38:21 +1100 (EST)
In-Reply-To: <1223885554-27718-1-git-send-email-angavrilov@gmail.com>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98269>

Alexander Gavrilov writes:

> Since git apparently cannot work with filenames in non-locale
> encodings anyway, I did not try to do anything about it apart
> from fixing some obvious bugs.

What we did before was read filenames and convert them from the system
encoding (done implicitly by gets) before unquoting filenames that
were quoted.  What we do now with your patch 1/2 is that we read the
filenames in binary and unquote any quoted filenames before converting
from the system encoding.  So I don't think your patch would have made
as much difference as it might appear.  If there is a reason for
unquoting before converting from the system encoding rather than
after, it seems pretty subtle to me and wasn't explained in the patch
description.  An explanation, preferably with examples, would be
useful.

Also, you didn't say whether you found the "obvious bugs" by
inspection or by encountering their effects in actual running (and if
so, what those effects were).  That information is also good to have
in the patch description.

Paul.
