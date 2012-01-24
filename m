From: lists@haller-berlin.de (Stefan Haller)
Subject: Re: Most reliable method to detect a merge commit in pre-commit hook
Date: Tue, 24 Jan 2012 16:10:48 +0100
Message-ID: <1kedu51.n7co6x1s8qhdbM%lists@haller-berlin.de>
References: <jfmegi$scg$1@dough.gmane.org>
To: sschuberth@gmail.com (Sebastian Schuberth), git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 24 16:11:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rpi28-0007Zf-GB
	for gcvg-git-2@lo.gmane.org; Tue, 24 Jan 2012 16:11:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753576Ab2AXPL3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jan 2012 10:11:29 -0500
Received: from server90.greatnet.de ([83.133.96.186]:60883 "EHLO
	server90.greatnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752722Ab2AXPL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2012 10:11:28 -0500
Received: from [192.168.0.42] (nat1.ableton.net [217.110.199.117])
	by server90.greatnet.de (Postfix) with ESMTPA id 2E91F2A04F0;
	Tue, 24 Jan 2012 16:08:51 +0100 (CET)
In-Reply-To: <jfmegi$scg$1@dough.gmane.org>
User-Agent: MacSOUP/2.8.3 (Mac OS X version 10.7.2 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189048>

Sebastian Schuberth <sschuberth@gmail.com> wrote:

> I'd like our pre-commit hook to skip some checks if the commit that's
> about to be made is a merge commit. What's the most reliable way to 
> detect a merge commit from within a pre-commit hook script? Currently,
> the only way I see is to check whether .git/MERGE_MSG exists, but I'd
> feel safer to check whether the commit is going to have more than one
> parent or so. Is that possible / a better detection?

I haven't found a better way either, so this is the method we use too.
The problem is that it fails when you are amending a merge commit; so
the output of our pre-commit hook advises the user to manually do a "git
commit --no-verify" in that case.


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
