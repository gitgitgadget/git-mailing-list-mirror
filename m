From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [PATCH 1/2] branch: optionally setup branch.*.merge from upstream local branches
Date: Tue, 19 Feb 2008 11:33:36 -0500
Message-ID: <76718490802190833p68d361b4jf93ac196fe671d6b@mail.gmail.com>
References: <1203438278-73786-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 19 17:34:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRVQ6-0003yV-7Z
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 17:34:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753437AbYBSQdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 11:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753426AbYBSQdj
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 11:33:39 -0500
Received: from wa-out-1112.google.com ([209.85.146.176]:23063 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752168AbYBSQdi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 11:33:38 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3568878wah.23
        for <git@vger.kernel.org>; Tue, 19 Feb 2008 08:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Rihh8EGhOf005z4KjC9BGggrdXs9FfoQ6hGBlk94vn0=;
        b=oRxgxpmDy050MG3x8+DRgV98M0pR8mTm9N/o2D2vBqJR64n1s1lDg65yzsN4XDLBLm7PQLMxpdOXZOwBYspzVzFHpjLYFa0gnONDNK5rByw3AsTq9D6+AlSIzx/HLHLf/EjzV0VTLBHVTUfd7dPzwo07emDhsBMSVRAFa0rAhWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JGLYWnudgGp22hyXZlH8dWNCRHqW4A4U8DLb5AJ23ZMocGW/THCipStsWkpF+p2VkTgssHFk8c+y5WvqmjLpW9WQDXvKeYXJYh7PMoxi9A218QeQnn1hq48l0r5DWGmL2Z6O1wykf4lxlPZx7ZCOnL7L+K7EndHZ8FIrj0wt71M=
Received: by 10.115.79.1 with SMTP id g1mr760076wal.2.1203438816245;
        Tue, 19 Feb 2008 08:33:36 -0800 (PST)
Received: by 10.114.145.13 with HTTP; Tue, 19 Feb 2008 08:33:36 -0800 (PST)
In-Reply-To: <1203438278-73786-1-git-send-email-jaysoffian@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74430>

On Feb 19, 2008 11:24 AM, Jay Soffian <jaysoffian@gmail.com> wrote:
> git branch / git checkout -b now honor --track when the upstream branch
> is local. Previously --track was silently ignored for local upstream
> branches.
>
> The configuration setting branch.autosetupmerge can now be set to
> "always" which is equivalent to using --track. Setting
> branch.autosetupmerge to boolean true will retains the former behavior
> of only setting up branch.*.merge for remote upstream branches.

I re-used my commit message w/o thinking enough. The truth is:

 * '--track' fails if the starting point isn't a branch.

 * autosetupmerge=always sets up tracking if the starting point is a branch
   (local or remote), otherwise (if starting point is not a branch) it is
   ignored.

j.
