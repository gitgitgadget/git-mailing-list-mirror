From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: RFC: rebase without pain
Date: Sat, 14 Jun 2008 15:17:58 +0400
Message-ID: <20080614111758.GB5737@dpotapov.dyndns.org>
References: <5B4BD573-8C89-4E27-8ADB-F870EA503D00@vicaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Luke Lu <git@vicaya.com>
X-From: git-owner@vger.kernel.org Sat Jun 14 13:19:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7TnB-0003Pf-D9
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 13:19:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873AbYFNLSI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 07:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbYFNLSH
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 07:18:07 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:30143 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221AbYFNLSE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 07:18:04 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2955624fgg.17
        for <git@vger.kernel.org>; Sat, 14 Jun 2008 04:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=GOyFl4szU39/E+PNLPosm+CgP4p7vJO5BFGxFplzytY=;
        b=SxGVi3TgEstVIx6DBZX+8INPp1wAO+ZatQL60ZfKVWg5ElO3aDHsLoRlzWCJtIo6l5
         cZHLRGSIBE62BBSg4BYZCPu8IGYaR1UlSlJfe7FPFvzf8oV5rkMcrg6Xa4V/Jkam+Z9a
         A16xrQ1dUKckPyVyzFBgeJZTq7O0MTaMuUgHs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=IY9S8782BSaW0eOU1SRVRo/Hw10hMrGk2vWPurocduEukXqKXQm+IbRNxiwIu1KLxJ
         ZgXh6cYm/3azY2OWythcr07l+SdL3Bdyk4HvZ4ZSY5kXWK0ry7xlvfGLquP3AuJAyW+X
         XFrsLE8fSdZqb50vZVtUXAaQBs84XdoSgRZ10=
Received: by 10.86.60.15 with SMTP id i15mr5426044fga.53.1213442282103;
        Sat, 14 Jun 2008 04:18:02 -0700 (PDT)
Received: from localhost ( [85.140.168.68])
        by mx.google.com with ESMTPS id l12sm7125672fgb.6.2008.06.14.04.18.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 14 Jun 2008 04:18:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5B4BD573-8C89-4E27-8ADB-F870EA503D00@vicaya.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85011>

On Fri, Jun 13, 2008 at 06:38:44PM -0700, Luke Lu wrote:
> This may have been discussed before, but I could not find it. If so, I  
> apologize for the noise and hope somebody is working on the issue.

I think we have had a somewhat similar discussion not so long ago.
It was called "inexplicable failure to merge recursively across
cherry-picks". I think you can find it here:
http://kerneltrap.org/mailarchive/git/2007/10/9/333729

Please, read carefully this Linus' posts:
http://kerneltrap.org/mailarchive/git/2007/10/10/334129
http://kerneltrap.org/mailarchive/git/2007/10/11/335451

> 
> Based on my observation, rebase is the single most interesting and  
> misunderstood feature in git compared with other VCS. Once I  
> discovered rebase -i, I can't stop using it, because I'd like to keep  
> my history clean for readability and maintenance purpose.

The downside of rebase is that you are *re-writing* branch history. It
is okay when you do that in your private branch, but when you publish
something there is no way back. It is like when you prepare on some
article, you can make a lot of drafts but when you publish it then
it is published. Any attempt to falsify history will cause a lot of
confusion. Also, please, notice that even if a branch was rebased
without a single conflict, it does not mean that it will work. So,
you can break things just by rebasing and it will be impossible to
find later who caused the breakage. Sometimes, even if the final
state after rebase is working, the intermediate commits may not work
or even not compile.

So, I don't think that rebasing published history is a good idea.

Dmitry
