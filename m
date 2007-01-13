From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Importing from tarballs; add, rm, update-index?
Date: Sat, 13 Jan 2007 16:27:00 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0701131620100.19099@beast.quantumfyre.co.uk>
References: <6efbd9b70701120541n5dc4d0e1va50ae96543d8c80@mail.gmail.com>
 <7virfct737.fsf@assigned-by-dhcp.cox.net> <slrneqfnb8.a6s.Peter.B.Baumann@xp.machine.xx>
 <7vejq0t4ij.fsf@assigned-by-dhcp.cox.net> <20070112210403.GB6262@xp.machine.xx>
 <7v7ivrpx9y.fsf@assigned-by-dhcp.cox.net> <20070113093322.GA4825@xp.machine.xx>
 <Pine.LNX.4.63.0701131204511.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070113161936.GB4825@xp.machine.xx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 13 17:27:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5lim-0000HG-CP
	for gcvg-git@gmane.org; Sat, 13 Jan 2007 17:27:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422711AbXAMQ1F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Jan 2007 11:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422715AbXAMQ1F
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jan 2007 11:27:05 -0500
Received: from neutron.datavampyre.co.uk ([212.159.54.235]:47493 "EHLO
	neutron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422711AbXAMQ1E (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jan 2007 11:27:04 -0500
Received: (qmail 9392 invoked by uid 103); 13 Jan 2007 16:27:43 +0000
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.88.7/2437. spamassassin: 3.1.3. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.032475 secs); 13 Jan 2007 16:27:43 -0000
Received: from unknown (HELO beast.quantumfyre.co.uk) (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 13 Jan 2007 16:27:43 +0000
X-X-Sender: jp3@beast.quantumfyre.co.uk
To: Peter Baumann <siprbaum@stud.informatik.uni-erlangen.de>
In-Reply-To: <20070113161936.GB4825@xp.machine.xx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36756>

On Sat, 13 Jan 2007, Peter Baumann wrote:

> I'd favour the following model:
>
> git-add: register the content of a previously unkown file to git
>    (there was now struct chache_entry in the index previously which
>     described a file with the same name)
>
> git-rm: remove a struct cache_entry from the index and after some
>    safty checks remove the file, too. (see in the mailinglist archive;
>    there was much talk about git-rm and its semantic)
>
> git-refresh (or git-stage or git-update or what-ever you call it):
>    replace the cache_entry by a new one
>
> And this all about content; the content which would represent my next
> tree object. Because developers don't think of "add" if they want to
> remove a file from the commit. If the power users liked to have only one
> command, wich does remove, add and update then lets not call it add.
> Better make this commmand the above mentioned git-refresh which would do
> "the right thing" if called with a new file/removed file
>
> Im simply think its confusing to call the described command git-add, as
> we have it now. It's at least *very* confusing for new starters.

Personally I actually find having a single add command to be the simplest 
conceptual model ...

I think of it like this:

* start off with current content (index matches HEAD matches working tree)
* I do some stuff (add files, edit files, delete files)
* I add my changes to the index
* I do more stuff
* I add my changes to the index
* I do more stuff
* I realise that the latest changes are actually different, so I commit 
the index, and then keep going, or I add the changes and commit.

The only thing I find slightly confusing is that the staging area for the 
next commit is called the index.

(But then maybe I've been reading this list too long - though I have only 
actually starting playing with git recently)

-- 
Julian

  ---
Power, like a desolating pestilence,
Pollutes whate'er it touches...
 		-- Percy Bysshe Shelley
