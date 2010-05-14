From: Jeff King <peff@peff.net>
Subject: Re: Git hangs on compressing objects
Date: Fri, 14 May 2010 00:46:05 -0400
Message-ID: <20100514044605.GD6075@coredump.intra.peff.net>
References: <AANLkTik4WMqjkqYady6BQAf2OTPLzCeMoedwrGj8s10T@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ryan Ray <ryan.ray@methodologie.com>
X-From: git-owner@vger.kernel.org Fri May 14 06:46:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCmmt-0004z9-JP
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 06:46:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125Ab0ENEqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 00:46:10 -0400
Received: from peff.net ([208.65.91.99]:55656 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751622Ab0ENEqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 May 2010 00:46:09 -0400
Received: (qmail 28513 invoked by uid 107); 14 May 2010 04:46:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 14 May 2010 00:46:08 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 14 May 2010 00:46:05 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTik4WMqjkqYady6BQAf2OTPLzCeMoedwrGj8s10T@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147046>

On Thu, May 13, 2010 at 01:05:40PM -0700, Ryan Ray wrote:

> ryanray:fhlb2009ar ryan.ray$ git push
> Counting objects: 322, done.
> Delta compression using up to 4 threads.
> ^Cmpressing objects:  94% (243/258)
> 
> Iv'e tried this countless times today. It just doesn't finish. My
> local dir is 6 revisions ahead of master so I prefer not to can my
> local dir and re-clone.
> 
> Any suggestions? Can I figure out which file (243) is hanging it?

Are you sure it's hung and not just being slow? Is it still pegging at
least one CPU? Is it hitting the disk? Do you have any very large files,
especially ones that might push you into swapping?

No, there isn't a good way to see which object it is working on. You
would have to run it in a debugger (which I would consider anyway, then
you can see what it is actually doing while hung).

-Peff
