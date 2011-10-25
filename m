From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Behavior of "git push --mirror repo"
Date: Tue, 25 Oct 2011 12:25:10 +0200
Message-ID: <j862ts$d75$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 25 12:27:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIeEA-0006H0-3g
	for gcvg-git-2@lo.gmane.org; Tue, 25 Oct 2011 12:27:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754282Ab1JYK1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Oct 2011 06:27:21 -0400
Received: from lo.gmane.org ([80.91.229.12]:45769 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753465Ab1JYK1U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2011 06:27:20 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RIeE3-0006F9-6z
	for git@vger.kernel.org; Tue, 25 Oct 2011 12:27:19 +0200
Received: from jambul.zib.de ([130.73.68.203])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 25 Oct 2011 12:27:19 +0200
Received: from sschuberth by jambul.zib.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 25 Oct 2011 12:27:19 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: jambul.zib.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184201>

Hi,

I cloned a repository from "origin" to my local disk. I only have a local branch for "master", although there are more remote branches. Now I want to initialize a new empty bare repository with an exact copy of the repository, including all branches, also those remote branches that I have no local branch for. So I did:

$ git remote add sf <url>
$ git push --mirror sf

Which prints:

 * [new branch]      master -> master
 * [new branch]      refs/notes/commits -> refs/notes/commits
 * [new branch]      refs/original/refs/heads/master -> refs/original/refs/heads/master
 * [new branch]      origin/HEAD -> origin/HEAD
 * [new branch]      origin/bourke -> origin/bourke
 * [new branch]      origin/colorscheme -> origin/colorscheme
 * [new branch]      origin/cpuinfo -> origin/cpuinfo
 * [new branch]      origin/demo-ssao -> origin/demo-ssao
 * [new branch]      origin/master -> origin/master
 * [new branch]      origin/mesh-improvements -> origin/mesh-improvements
 * [new branch]      origin/mesh-iterators-subdiv -> origin/mesh-iterators-subdiv
 * [new tag]         gale2-static-dummy-window -> gale2-static-dummy-window

In the target repository "sf" I now alony have the "master" branch and the "gale2-static-dummy-window" tag, but none of the remote branches from "origin". I was reading the --mirror option as if this should happen:

 * [new branch]      origin/bourke -> sf/bourke

etc.

Is this behavior expected? If yes, what the correct way to mirror a repository then (without creating a local branch for each remote branch first)?

Thanks.

-- 
Sebastian Schuberth
