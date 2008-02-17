From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [RFC PATCH 1/2] git-branch: allow --track to work w/local branches
Date: Sun, 17 Feb 2008 13:05:36 -0500
Message-ID: <76718490802171005xaed572dkd59ed822897fdb3a@mail.gmail.com>
References: <1203133557-50013-1-git-send-email-jaysoffian@gmail.com>
	 <7v7ih5fpve.fsf@gitster.siamese.dyndns.org>
	 <alpine.LSU.1.00.0802161143290.30505@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 17 19:06:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQnu3-0004eh-G7
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 19:06:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754006AbYBQSFl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 13:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752158AbYBQSFj
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 13:05:39 -0500
Received: from wa-out-1112.google.com ([209.85.146.177]:5902 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753976AbYBQSFh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 13:05:37 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2343598wah.23
        for <git@vger.kernel.org>; Sun, 17 Feb 2008 10:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=cZuc4mjLbHAmoDYpGMukTSA7/N6yDZI8pwORaBBNn0s=;
        b=f2hchyql9EafMoesiJUt3i1m7f2sme3Cp9+NZzD6tffgPCmPVqH714ER/1xc6AnQ32ZA34T42GzyBstLGCg7j3/IKBjs88ghH8oKnJFfOS200RndDiLJP52q9stZhI1uqvWx8YHqMBZK28Ktb5BW+L9TCwxbJTeRERKJTvNcS5E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bx1kF9SwIbCs2j6lcqPxM2/5zRXSCTfHXhzFq1o++kxK2yq4T0aeyvk/Gkb5UpwVBzKIRLxZptoO5fGweX25TgeglLtDaA3ne5B1rvbfUmmSsuIql48dRFbZaxO7voyXLNVsjv3LSdbWhl5w2Z5Aclb5gfsljyZpG0Zwo9LzS/8=
Received: by 10.114.78.1 with SMTP id a1mr87934wab.14.1203271536753;
        Sun, 17 Feb 2008 10:05:36 -0800 (PST)
Received: by 10.114.255.11 with HTTP; Sun, 17 Feb 2008 10:05:36 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0802161143290.30505@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74149>

On Feb 16, 2008 6:45 AM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> AFAIR the problem was that you were (rightfully) annoyed when you were
> setting up your local branches, and all of a sudden, they were set up with
> loads of tracking information, cluttering your config.
>
> Basically, that is the reason why we disallowed tracking information to be
> set up for local branching.

Hrmm, I was annoyed that when setting up my local branches, they *don't*
get tracking information. Otherwise I can't use "git pull" with them,
which I'd like to. So maybe something like:

 * Using --track or --notrack adds (or doesn't) the information, because
  well, I specified it explicitly.

 * Otherwise (if neither --track nor --notrack) is specified, check the
  setting of branch.autosetupmerge. Currently it's a boolean, but
  perhaps it can take on a new setting and have:
 - false
 - true
 - always ; new setting which means to setup tracking information for
          ; both local and remote branches

?

j.
