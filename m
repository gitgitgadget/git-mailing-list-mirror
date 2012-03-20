From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: git merge
Date: Tue, 20 Mar 2012 18:49:48 -0500
Message-ID: <4F69179C.3030808@gmail.com>
References: <4F685237.5060402@labage.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 21 00:50:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SA8of-0008Is-Gm
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 00:50:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753218Ab2CTXuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Mar 2012 19:50:07 -0400
Received: from plane.gmane.org ([80.91.229.3]:48273 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752675Ab2CTXuE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2012 19:50:04 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1SA8oT-0008Bj-DH
	for git@vger.kernel.org; Wed, 21 Mar 2012 00:50:01 +0100
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Mar 2012 00:50:01 +0100
Received: from nkreitzinger by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Mar 2012 00:50:01 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.28) Gecko/20120306 Thunderbird/3.1.20
In-Reply-To: <4F685237.5060402@labage.be>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193554>

On 3/20/2012 4:47 AM, Fabien Dubail wrote:
>
> I've conflicts when I merge branches. I can resolve some conflicts but
> not all. The remaining conflicts will be solved by someone else?
> To do that I would like to merge only some files and resolve 'my'
> conflicts. (something like: 'git checkout branch files' but with merge)
> Than remaining files will be merged by someone else and remaining
> conflicts will be resolved .
> Is-it possible to do that with git and how? Or is there an other way?
>
One way you can do it is to create a branch containing your resolutions. 
  Then the other person pulls your branch.  They would redo the merge on 
their own branch and checkout your resolutions to apply your work, and 
resolve the remainder himself.  This could go on for mutltiple people. 
You can edit the merge commit message to document who resolved which 
conflicts.

Maybe someone has a better way.  We did a "distributed merge" this way. 
  I pulled everyone else's branches containing their resolutions and 
then redid the merge and checkout out their resolutions from their 
branches and resolved my portion assigned to me personally.  Actually, I 
think I did mine in a separate branch and then when all were done I 
redid the merge and checked out out everyone's portions from their 
respective branches (including mine) to accomplish the distributed merge 
(merge conflict resolution).  (In our case, we were actually doing 
git-rebase "merge", but I think it would work for git-merge also.)

Maybe someone else has a better way.

v/r,
neal
