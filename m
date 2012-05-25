From: Caleb Marchent <cmarchent@aminocom.com>
Subject: Re: Interpretation of '/' changed sparse-checkout
Date: Fri, 25 May 2012 10:21:10 +0000 (UTC)
Message-ID: <loom.20120525T120226-506@post.gmane.org>
References: <loom.20120521T183651-286@post.gmane.org> <loom.20120523T160215-390@post.gmane.org> <20120524142858.GA10938@do>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 25 12:21:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXreI-0004FY-Mm
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 12:21:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753265Ab2EYKV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 May 2012 06:21:26 -0400
Received: from plane.gmane.org ([80.91.229.3]:35733 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752697Ab2EYKVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2012 06:21:25 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1SXre4-0003X8-KI
	for git@vger.kernel.org; Fri, 25 May 2012 12:21:22 +0200
Received: from mail.aminocom.com ([62.255.172.253])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 25 May 2012 12:21:20 +0200
Received: from cmarchent by mail.aminocom.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 25 May 2012 12:21:20 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 62.255.172.253 (Mozilla/5.0 (X11; Linux i686) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1084.46 Safari/536.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198473>

Nguyen Thai Ngoc Duy <pclouds <at> gmail.com> writes:

> 
> As a user I agree that "/" should mean "everything under the sky" and
> your use case should work (i.e. it is broken in 1.7.10.2). If you can
> build git, you can try the patch below. I'll submit a patch for
> inclusion to git later (perhaps with optimization for this special case).
> 

Many Thanks Duy!, that patch works so please do submit the patch.


That just leaves the other issue I noted in my original posting - if I 
exclude a path from the top-level with a 1.7.2.5 format sparse-checkout
 file, git 1.7.10.2 will exclude a sub-directory with the same name:

/
!exclude/

Unfortunately (for me), I think this is correct behaviour of 1.7.10.2 
because in 1.7.10.2 you can now do: 

/
!/exclude/
/exlucde/reinclude/

which makes sense and correctly excludes "/exclude", but not 
"/exclude/reinclude/exclude". The flexibility to have:

/
!CVS/

or something like that is required; so I don't believe should be changed?
