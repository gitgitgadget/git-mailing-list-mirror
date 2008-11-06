From: Jens Seidel <jensseidel@users.sf.net>
Subject: Re: Bug: "git-svn fetch" segfaults on unknown user
Date: Fri, 7 Nov 2008 00:08:05 +0100
Message-ID: <20081106230804.GA27848@merkur.sol.de>
References: <20081106143826.GA26900@merkur.sol.de> <237967ef0811060643g1037b8dbuf3660dfa8e3ff625@mail.gmail.com> <20081106154808.GA27102@merkur.sol.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 07 00:10:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyDze-0006KR-CN
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 00:10:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751982AbYKFXJE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2008 18:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751866AbYKFXJE
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 18:09:04 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:33518 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831AbYKFXJD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 18:09:03 -0500
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id 071CCF63BED8
	for <git@vger.kernel.org>; Fri,  7 Nov 2008 00:09:00 +0100 (CET)
Received: from [77.179.124.209] (helo=merkur.sol.de)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.109 #226)
	id 1KyDyF-0006ZT-00
	for git@vger.kernel.org; Fri, 07 Nov 2008 00:08:59 +0100
Received: from jens by merkur.sol.de with local (Exim 4.69)
	(envelope-from <tux-master@web.de>)
	id 1KyDxN-0007FS-EA
	for git@vger.kernel.org; Fri, 07 Nov 2008 00:08:05 +0100
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20081106154808.GA27102@merkur.sol.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Sender: tux-master@web.de
X-Provags-ID: V01U2FsdGVkX19dJmiy9kLRtc6+gDgWFSrHRwtCIdt9d1Tcxgit
	19BYXfQEOVK3fEtPP34vPdq6YiUQYn2amy82ZRXgw5sY/Dzx4Y
	aGGsjfHEg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100270>

On Thu, Nov 06, 2008 at 04:48:09PM +0100, Jens Seidel wrote:
> On Thu, Nov 06, 2008 at 03:43:18PM +0100, Mikael Magnusson wrote:
> > 2008/11/6 Jens Seidel <jensseidel@users.sf.net>:
> > > I noticed the following bug in git-svn version 1.6.0.3 (svn 1.5.5):
> > >
> > > "git-svn fetch" segfaults
> 
> "gdb -c core" is useless, it just mentions the error occured in
> "perl git-svn fetch" and there is no stacktrace (don't know how to
> debug perl).
> 
> I removed now both [svn] options and it failed again. So it seems a problem
> with file:// access while svn+ssh:// works well.

Could this be possible?

I tried now also to svnsync the same repository on the server which I access with
svn+ssh://. "svn-git fetch" fails on this as well, strange ...  The hook scripts
or the property added by "svnsync init" are not responsible, right?

> > Are you sure this isn't the regular svn 1.5.x crash? Ie, does
> > compiling subversion with --disable-runtime-module-search fix it?

No, it did not help.

I tried to reproduce it with a simple svn repository instead of my larger (not
public) one but failed.

What further information do you need? Is there any way to obtain more debug info?

Jens
