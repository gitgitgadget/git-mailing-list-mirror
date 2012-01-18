From: Jehan Bing <jehan@orb.com>
Subject: Re: How to migrate a complex directory structure from SVN to GIT?
Date: Wed, 18 Jan 2012 10:47:48 -0800
Message-ID: <4F1713D4.9000602@orb.com>
References: <1326828837924-7197567.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 18 19:48:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnaYE-0003yK-UU
	for gcvg-git-2@lo.gmane.org; Wed, 18 Jan 2012 19:48:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758072Ab2ARSr6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jan 2012 13:47:58 -0500
Received: from lo.gmane.org ([80.91.229.12]:36633 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758066Ab2ARSr6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2012 13:47:58 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RnaY8-0003uH-Vc
	for git@vger.kernel.org; Wed, 18 Jan 2012 19:47:56 +0100
Received: from 173-167-111-189-sfba.hfc.comcastbusiness.net ([173.167.111.189])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Jan 2012 19:47:56 +0100
Received: from jehan by 173-167-111-189-sfba.hfc.comcastbusiness.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Jan 2012 19:47:56 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 173-167-111-189-sfba.hfc.comcastbusiness.net
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <1326828837924-7197567.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188755>

On 2012-01-17 11:33, Asuka wrote:
> I would like to migrate all branches and tags .. but unfortunately sometimes
> I have just a trunk directory and no branches or tags directory. Sometimes
> the branches are in a subdirectory, sometimes in a subsubdirectory. So how
> can migrate my svn in an efficient way?

 From the look of your example, each project is either a trunk, or have 
subdirectories for trunk/branches/tags so I don't think it's a problem. 
If you don't have branches or tags, just don't specify them when you 
clone your subversion repository.

If however you have a more complex layout, you can use "git svn init", 
then edit .git/config to suit your needs, then run "git svn fetch".
And by "suit your needs", I mean you can add multiple "fetch=..." lines.
In my case, I ended up having one "fetch=..." for each trunk, branch and 
tag.
It was not efficient, it took 2 weeks to convert <30k revisions, ~200 
branches/project, ~80 projects, but it works well enough for me.

	Jehan
