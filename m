From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: setting up tracking on push
Date: Tue, 10 Mar 2009 16:26:03 -0400
Message-ID: <49B6CCDB.8010305@xiplink.com>
References: <buofxhr2vta.fsf@dhlpc061.dev.necel.com>	<76718490903052049k217e9c12gb7881f8904fdd9d@mail.gmail.com>	<alpine.DEB.1.00.0903061144480.10279@pacific.mpi-cbg.de>	<buoy6vi297q.fsf@dhlpc061.dev.necel.com>	<49b12ff7.nCWIz4ABJcgwW3BZ%obrien654j@gmail.com>	<76718490903060743m425c2d55n6e8737c893c936e8@mail.gmail.com> <87d4cuobrc.fsf@catnip.gol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Tue Mar 10 22:04:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lh97n-0005Q7-Lj
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 22:04:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753942AbZCJVDA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 17:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753899AbZCJVDA
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 17:03:00 -0400
Received: from iad2.emailsrvr.com ([207.97.227.212]:60203 "EHLO
	smtp112.iad.emailsrvr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753867AbZCJVC7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Mar 2009 17:02:59 -0400
X-Greylist: delayed 2213 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Mar 2009 17:02:59 EDT
Received: from relay21.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay21.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id 25D581B4042;
	Tue, 10 Mar 2009 16:26:04 -0400 (EDT)
Received: by relay21.relay.iad.mlsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 09F611B4004;
	Tue, 10 Mar 2009 16:26:04 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <87d4cuobrc.fsf@catnip.gol.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112848>

Miles Bader wrote:
> Jay Soffian <jaysoffian@gmail.com> writes:
>> I don't think we need a new command, but it would probably fit into
>> git remote
>>
>> $ git remote track <remote> [<branch>]
> 
> That seems a bit backwards -- it's more of a branch operation than a
> remote operation...

Agreed.

We just ran into this situation today with pull: Someone wanted one of their local branches to start tracking a remote.

It would be good if the branch command allowed modification of a branch's properties.  At the very least, branch-creation commands like "git branch --track foobranch origin/master" could offer to modify if the branch already exists, instead of just quitting.

BTW, I think the following (untested) incantation adds tracking to a branch:

	git config branch.foobranch.remote origin
	git config branch.foobranch.merge refs/heads/master

(Substitute "origin" and "master" to suit your needs.)

		M.
