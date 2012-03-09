From: lists@haller-berlin.de (Stefan Haller)
Subject: Re: [RFC PATCH] push: start warning upcoming default change for push.default
Date: Fri, 9 Mar 2012 22:08:30 +0100
Message-ID: <1kgpkt9.lt61vy108h530M%lists@haller-berlin.de>
References: <4F5A4C45.7070406@xiplink.com>
Cc: Matthieu.Moy@imag.fr (Matthieu Moy), git@vger.kernel.org,
	gitster@pobox.com
To: marcnarc@xiplink.com (Marc Branchaud),
	cmn@elego.de (=?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?=)
X-From: git-owner@vger.kernel.org Fri Mar 09 22:08:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S673G-0005sZ-6a
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 22:08:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755221Ab2CIVId (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 16:08:33 -0500
Received: from server90.greatnet.de ([83.133.96.186]:44043 "EHLO
	server90.greatnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753576Ab2CIVIc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 16:08:32 -0500
Received: from [192.168.0.42] (nat1.ableton.net [217.110.199.117])
	by server90.greatnet.de (Postfix) with ESMTPA id 5346A3B0630;
	Fri,  9 Mar 2012 22:08:30 +0100 (CET)
In-Reply-To: <4F5A4C45.7070406@xiplink.com>
User-Agent: MacSOUP/2.8.3 (Mac OS X version 10.7.3 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192741>

Marc Branchaud <marcnarc@xiplink.com> wrote:

> I think that an incantation like
> 
>   git checkout -b topic origin/master
> 
> makes it pretty clear that topic is meant to be merged into origin's 
> master branch.  And so a simple "git push" as you describe I think 
> *should* update origin's master branch.

Not for us, no.  (But this is maybe a different topic.)

In our workflow (centralized repository), we never ever have a local
branch with a different name than its upstream branch. Never.

When we say

  git checkout -b topic origin/master

then it's always a mistake, and what we really meant was

  git checkout -b --no-track topic origin/master

This has bitten us a few times in the past (people accidentally pushing
their topic branches to master this way), and it's very annoying.


But coming back to the subject of push.default: in our environment,
"upstream" is the only default that is useful with the current behaviour
of git.

(I could dream of a git mode where it's not necessary to explicitly set
an upstream branch, and all git operations such as status, pull, or even
saying "@{u}" would automatically use "remotes/origin/samename" as the
upstream branch.  In that case, "current" would be a more convenient
default value for push.default; but I guess that hypothetical mode would
imply this anyway.)


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
