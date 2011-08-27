From: seanh <snhmnd@gmail.com>
Subject: Re: Files that cannot be added to the index
Date: Sat, 27 Aug 2011 17:35:36 +0200
Message-ID: <20110827153536.GA291@sooty-2.local>
References: <CAMvu5bLuRWinMYNc4NoRKQKiLCWLcwkpowEFT4GQ0mcJYj6eOg@mail.gmail.com>
 <4E57A93A.6090405@drmicha.warpmail.net>
 <20110826205919.GB8107@sooty-2.local>
 <20110826211233.GB3093@digium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Shaun Ruffell <sruffell@digium.com>
X-From: git-owner@vger.kernel.org Sat Aug 27 17:36:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxKvU-00012f-Qb
	for gcvg-git-2@lo.gmane.org; Sat, 27 Aug 2011 17:36:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302Ab1H0PgA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Aug 2011 11:36:00 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47092 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882Ab1H0Pf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Aug 2011 11:35:59 -0400
Received: by fxh19 with SMTP id 19so3275288fxh.19
        for <git@vger.kernel.org>; Sat, 27 Aug 2011 08:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=+dV924BCrr8OiIl3yNxzMdqf4gUvIiO1LhYdVXHBleo=;
        b=w6G6FkbRZxKU9PRaAr8bduseVcy8cwQPSeR4RcxMdOMqVIjXVMdDtigMXlFRTYpIMb
         Iqbeq8GdJgQJ4qZWI+fZY4tcnr26WO6Td+5KdHThbUXzfrNFNQbDpYUq3kExsj1r31ax
         KQEivWW5AYQSBDgGGhOocYiuLFhwXPVi11Jro=
Received: by 10.223.57.12 with SMTP id a12mr3643064fah.97.1314459358043;
        Sat, 27 Aug 2011 08:35:58 -0700 (PDT)
Received: from sooty-2.local (brln-4dbabee1.pool.mediaWays.net [77.186.190.225])
        by mx.google.com with ESMTPS id 22sm2222493fay.28.2011.08.27.08.35.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 27 Aug 2011 08:35:56 -0700 (PDT)
Mail-Followup-To: Shaun Ruffell <sruffell@digium.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20110826211233.GB3093@digium.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180233>

On Fri, Aug 26, 2011 at 04:12:33PM -0500, Shaun Ruffell wrote:
> Not sure if this is your problem exactly but awhile back I ran into
> something similar to what you describe and tracked it down to the
> fact that my filesystem was case insensitive. i.e.

My filesystem (HFS+ on OSX Lion) is case-insensitive, yeah. I bet you're
right, because in one repo the modified file shows up in `git status` as
LOG.txt but in the output from `ls` it is called `Log.txt`. It's the
same in the other repo that has the problem, the case of the filename
that is having the problem is different in `git status` and `ls`.

Perhaps the problem might have been introduced by moving the repo from a
case-sensitive to an insensitive filesystem? Or by originally starting
the repo on a sensitive fs and then using git clone to clone it onto an
insensitive one. Or, maybe at some point I committed a change to the
case of the filename and that introduced a problem on case-insenstive
filesystems.

Did you find a way around the problem? I guess that the repo does not
really have any uncommitted changes, so I just want to convince `git
status` and `git diff` of this.
