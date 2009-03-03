From: Peter Rosin <peda@lysator.liu.se>
Subject: Re: [PATCH] git filter-branch: Process commits in --date-order
Date: Tue, 03 Mar 2009 01:39:07 +0100
Message-ID: <49AC7C2B.2050505@lysator.liu.se>
References: <1236035454-12236-1-git-send-email-peda@lysator.liu.se> <alpine.DEB.1.00.0903030126530.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 03 02:10:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeJ93-0005mC-5J
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 02:10:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbZCCBIa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 20:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751892AbZCCBIa
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 20:08:30 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:35440 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882AbZCCBI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 20:08:29 -0500
X-Greylist: delayed 1754 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Mar 2009 20:08:29 EST
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id E707A40015;
	Tue,  3 Mar 2009 01:39:04 +0100 (CET)
Received: from [192.168.0.33] (81-234-184-159-o1095.tbon.telia.com [81.234.184.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id BEF0640004;
	Tue,  3 Mar 2009 01:39:04 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <alpine.DEB.1.00.0903030126530.10279@pacific.mpi-cbg.de>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111987>

Hi Johannes,

Den 2009-03-03 01:28 skrev Johannes Schindelin:
> Hi,
> 
> On Tue, 3 Mar 2009, Peter Rosin wrote:
> 
>> When converting an svn repository to git, I am filtering the commits
>> using --msg-filter. During this conversion I want to use the
>> .git-rewrite/map data to fill in references to other commits. In the
>> svn repo, there is a commit message e.g. "Cherry-pick r207", and I
>> want to append "r207 = <commit>" to the git commit message, as r207
>> no longer means very much. This works fine when the git commit
>> corresponding to r207 has been filtered before the current commit, and
>> is present in the map. When filtering in --topo-order, this is not
>> always the case, making it impossible to look up the git commit.
> 
> I'd rather have this as an option.  God knows what breaks with time-skewed 
> repositories if you use date-order instead of topo-order, and I'd rather 
> not break that not quite uncommon case.

Well, from the git rev-list docs:

        --date-order
               This option is similar to --topo-order in the sense that no
               parent comes before all of its children, but otherwise things
               are still ordered in the commit timestamp order.

Sounds pretty safe to me?

Cheers,
Peter
