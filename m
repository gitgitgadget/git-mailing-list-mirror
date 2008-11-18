From: Pete Harlan <pgit@pcharlan.com>
Subject: Re: Error in git-cherry-pick manpage?
Date: Tue, 18 Nov 2008 11:34:07 -0800
Message-ID: <492318AF.8080004@pcharlan.com>
References: <20081114151426.GA20985@merkur.sol.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, jensseidel@users.sf.net
X-From: git-owner@vger.kernel.org Tue Nov 18 20:35:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2WMQ-0005dn-Hp
	for gcvg-git-2@gmane.org; Tue, 18 Nov 2008 20:35:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752349AbYKRTeK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2008 14:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752269AbYKRTeJ
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Nov 2008 14:34:09 -0500
Received: from lax-green-bigip-5.dreamhost.com ([208.113.200.5]:39395 "EHLO
	swarthymail-a7.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751935AbYKRTeI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Nov 2008 14:34:08 -0500
Received: from [192.168.0.2] (031.132-78-65.ftth.swbr.surewest.net [65.78.132.31])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by swarthymail-a7.g.dreamhost.com (Postfix) with ESMTP id 7229BDE573;
	Tue, 18 Nov 2008 11:34:07 -0800 (PST)
User-Agent: Mozilla-Thunderbird 2.0.0.17 (X11/20081018)
In-Reply-To: <20081114151426.GA20985@merkur.sol.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101280>

Jens Seidel wrote:
> Hi,
> 
> I try to use git cherry-pick to combine multiple commits but I'm confused
> about the second sentence of the description:
> 
> "Given one existing commit, apply the change the patch introduces, and
> record a new commit that records it. This requires your working tree to be
> clean (no modifications from the HEAD commit)."
> 
> I intent to use it as follows:
> 
>  git cherry-pick -x --no-commit 2e855ae
>  git cherry-pick -x --no-commit 0c1151
>  ...
> 
> After the first invocation my working tree will not be clean but contain
> changes in the index.
> 
> Does this mean that's a wrong usage of cherry-pick?

If it is, you might try this:

  git cherry-pick -x 2e855ae             # Let it commit
  git cherry-pick -x --no-commit 0c1151  # Will stage changes
  git commit --amend
  # Repeat last two steps as needed...

--Pete
