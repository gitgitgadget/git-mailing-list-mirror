From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: git push mirror mode V4 (replacement stack)
Date: Mon, 12 Nov 2007 11:00:16 +0000
Message-ID: <20071112110016.GG301@shadowen.org>
References: <20071109233041.GC301@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 12:01:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrX2C-0004ke-3k
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 12:00:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758023AbXKLLAg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 06:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757474AbXKLLAg
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 06:00:36 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:4848 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755903AbXKLLAf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 06:00:35 -0500
Received: from localhost ([127.0.0.1] helo=pinky)
	by hellhawk.shadowen.org with esmtp (Exim 4.63)
	(envelope-from <apw@shadowen.org>)
	id 1IrX1q-0006A4-5n; Mon, 12 Nov 2007 11:00:31 +0000
Content-Disposition: inline
In-Reply-To: <20071109233041.GC301@shadowen.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64598>

On Fri, Nov 09, 2007 at 11:30:41PM +0000, Andy Whitcroft wrote:
> Following this mail is a complete replacement git push mirror mode
> stack (V4).  It folds down all the various patches into a logical
> sequence (thanks Dscho).  This stack passes the entire test suite,
> and I have been using the same code for real work here.

Ok, I have spotted one oddity with this feature.  The symbolic refs are
getting converted to real refs in the mirror.  Generally speaking this
is the <remote>/HEAD refs but I guess it may be possible to have others.

I have had a looked about and I am actually confused as to whether we
maintain remote symbolic refs at all?  Cirtainly git-clone.sh seems to
do some hoop jumping, comparing the sha1's of all of the fetched branches
and replacing the HEAD reference with a symbolic reference should it find
a match.

I am unsure if this a huge problem or not.  Its not preventing me using
it as an effective mirror, but if we assume one is making the mirror as
a backup, then there would be slightly more than an rsync to convert the
the repo back into your original, though I guess there already is as you
would want to insert your config into the remote also.

Perhaps someone with a better understanding could point me to where we
we maintain these refs, if we indeed do?

-apw
