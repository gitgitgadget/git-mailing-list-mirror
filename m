From: Sam Vilain <sam@vilain.net>
Subject: Re: git-svn not fetching all revisions
Date: Wed, 11 Nov 2009 17:00:48 +1300
Message-ID: <4AFA36F0.6070501@vilain.net>
References: <4AF9AC1A.5000100@better.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marcus Better <marcus@better.se>
X-From: git-owner@vger.kernel.org Wed Nov 11 05:01:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N84O6-00053r-SV
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 05:00:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753107AbZKKEAo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 23:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752412AbZKKEAo
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 23:00:44 -0500
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:34449 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050AbZKKEAn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 23:00:43 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 214FF3236F;
	Wed, 11 Nov 2009 17:00:49 +1300 (NZDT)
X-Virus-Scanned: Debian amavisd-new at catalyst.net.nz
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Tn4w5Dno7T8O; Wed, 11 Nov 2009 17:00:48 +1300 (NZDT)
Received: from [IPv6:2404:130:0:1000:21d:7dff:fe90:5fe0] (unknown [IPv6:2404:130:0:1000:21d:7dff:fe90:5fe0])
	(Authenticated sender: samv)
	by mail.catalyst.net.nz (Postfix) with ESMTPSA id 8D1F83234C;
	Wed, 11 Nov 2009 17:00:48 +1300 (NZDT)
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
In-Reply-To: <4AF9AC1A.5000100@better.se>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132612>

Marcus Better wrote:
> The problem is that the trunk was replaced by a branch at some point.
> When I do "git svn clone -s svn://host/repo/project" it only fetches the
> "old" trunk up to the time of the switch, and then stops. Newer
> revisions of the "new" trunk are not fetched and cannot be seen with
> "find-rev".

Yeah.  Try doing it in parts - fetch the two stages of the history
explicitly using the revision range arguments to 'git svn fetch' - and
then graft the histories together and fix up with git filter-branch.  A
bit of a hassle, but unfortunately there's not much other option...

Sam
