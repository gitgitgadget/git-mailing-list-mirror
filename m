From: "David Tweed" <david.tweed@gmail.com>
Subject: Re: abouy git reset command
Date: Tue, 13 May 2008 13:34:56 +0100
Message-ID: <e1dab3980805130534w42ce098qf2ffe2fc89fab98b@mail.gmail.com>
References: <17202423.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: amishera <amishera2007@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 13 14:36:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jvtjh-00036K-M2
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 14:36:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754554AbYEMMfP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 08:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754807AbYEMMfP
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 08:35:15 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:58387 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754304AbYEMMfO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 08:35:14 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1553465ywe.1
        for <git@vger.kernel.org>; Tue, 13 May 2008 05:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=FeQzOU3TpSS90WAQQwihDit95M8YVjJp9Cu7R725xmg=;
        b=tofltLltsy9z6Sb4oDoE4I56go8ka8LBP/2wThqyymR7InTszoUN+h3E+/LL1lowTP6LbZ60YgauHQBrwUE/fipLBYS3XJ9r0M4uYsP4xFnidxQpemFNFYdZ0uw3C8Znesw6cana9mlpaJ5h+eDQ1zYXKRy1jbRKouPJmMiVu5c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=v4rR4eA50h9z0iZScH1Iy14s9DkifUgAKyLT1S91CgIAK/RRQoMW1CiFRVqyJqvdRBjDKuZYjfqUNMbSDywYNirfMIvVTERmXrI1saTmoFYFfD3tjMsIclJz0TA7yrEdVvL98SXW+aY+netHALMPHZmXxhOU6k+fmL27BJ7Cq4I=
Received: by 10.150.83.22 with SMTP id g22mr6927734ybb.134.1210682096523;
        Tue, 13 May 2008 05:34:56 -0700 (PDT)
Received: by 10.150.145.6 with HTTP; Tue, 13 May 2008 05:34:56 -0700 (PDT)
In-Reply-To: <17202423.post@talk.nabble.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82026>

On Tue, May 13, 2008 at 8:07 AM, amishera <amishera2007@gmail.com> wrote:
> Moreover, can any body tell me the use of
>
> git reset --soft

Jakub answered about "git reset --soft" on its own, so I'll just
mention the situation I use, say, "git reset --soft HEAD~5" which is:
suppose you realise that you made a really bad mistake 5 commits ago
(say some obscure bug that could cause data loss) and you've just
discovered and fixed it in your working tree (checking in bits to the
index). You don't want to risk ever running a version of your program
built from any of those commits. What you really _ought_ to do is
essentially redo those 5 commits removing the bug, but depending how
rigorous and time constrained your development is you might just want
to commit your new fixed state with one big change log. "git reset
--soft HEAD~5" moves HEAD back five commits but leaves your working
tree and index alone, so the next "git commit" will commit your fixed
current state after the new HEAD. It's clearly not what you want to do
if you're working in a careful development team, but I find it useful
on rare occasions.

-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"while having code so boring anyone can maintain it, use Python." --
attempted insult seen on slashdot
