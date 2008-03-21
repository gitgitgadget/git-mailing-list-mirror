From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Cygwin: problem with renaming and case
Date: Fri, 21 Mar 2008 13:57:42 -0400
Message-ID: <32541b130803211057h22310557ne605e39e6b894e11@mail.gmail.com>
References: <47E3DD28.4030302@tiscali.it>
	 <alpine.LFD.1.00.0803211037160.3020@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Frank <streamlake@tiscali.it>, git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Mar 21 18:58:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JclVp-0006zD-7m
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 18:58:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755928AbYCUR5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 13:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755891AbYCUR5r
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 13:57:47 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:47888 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755428AbYCUR5q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 13:57:46 -0400
Received: by fg-out-1718.google.com with SMTP id l27so1419687fgb.17
        for <git@vger.kernel.org>; Fri, 21 Mar 2008 10:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=EemksOSir0fKlxsrsSOjTcNX+v172AfwjX7/ilUlXM4=;
        b=lyhZg/tT1Z4tGJ1xsGXd4MmWFWwYwYfL4/s+HAAj+rgArNeteQ1WsdtKHSNWPPkdZVIvtb3hSoe+BpjR6dPyseirhtasPMdcnFl5DhOFg9DBYam4u6QXfPYr9Mqb+R2yal9hE4dUcgjQEPX2Rr3HXzbdeqAPuhZXjp2aYI5mwFs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UAocBWp5Ho1vfI/otZEvSI4mmjsU1Jnt2K3u75hJw9vdsG+INgQCPT5eWj615O2XgdDk5AuVJBaRtOWo02fNlHUAh32qx+JtfITG8Vsfjh4o1zqV6YY9hFTmp3n9ddHo8LNLZ+vzwgosBX6sSIQZl6LEYsBXhpGXp3pYTfpDZBc=
Received: by 10.82.155.10 with SMTP id c10mr8039452bue.28.1206122262733;
        Fri, 21 Mar 2008 10:57:42 -0700 (PDT)
Received: by 10.82.166.12 with HTTP; Fri, 21 Mar 2008 10:57:42 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.00.0803211037160.3020@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77752>

On Fri, Mar 21, 2008 at 1:46 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>  Now, you're tracking "Aaa.txt" in the branch you're leaving, and git knows
>  that, but git also knows that the branch you're leaving is *not* tracking
>  "aaa.txt", so obviously the copy of "aaa.txt" that the filesystem reports
>  is not saved anywhere, and git says "I refuse to overwrite it, because
>  that would destroy your untracked content".

I don't know if this helps, but if git would delete the files it's
planning to forget before checking the existence of files it's
planning to create, case sensitivity problems like these would
automatically disappear and you wouldn't have to worry about case (and
accent, and and...) folding by hand.

Unfortunately, that would mean git is changing things around before it
can safely make a decision about whether that's a good idea.  That
said, it would be possible to put things back, since it knows the
files it deleted are stored safely in the original branch anyway.

Have fun,

Avery
