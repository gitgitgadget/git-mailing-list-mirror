From: Jonathan del Strother <maillist@steelskies.com>
Subject: Re: My stash wants to delete all my files
Date: Tue, 25 Sep 2007 10:27:06 +0100
Message-ID: <DCBF8566-9B43-4EFA-A8B2-2EAB516C273F@steelskies.com>
References: <5A9D6E3B-7B0E-4414-9AFB-C1C8B2EE6A9D@steelskies.com> <7vabrb8rin.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v901)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 25 11:28:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ia6i1-0006tw-4A
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 11:28:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbXIYJ1z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 05:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbXIYJ1y
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 05:27:54 -0400
Received: from juliet.asmallorange.com ([207.210.105.70]:44375 "EHLO
	juliet.asmallorange.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864AbXIYJ1x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 05:27:53 -0400
Received: from host217-35-101-26.in-addr.btopenworld.com ([217.35.101.26]:50633 helo=[192.168.1.2])
	by juliet.asmallorange.com with esmtpa (Exim 4.68)
	(envelope-from <maillist@steelskies.com>)
	id 1Ia6hS-00008m-6E; Tue, 25 Sep 2007 05:27:26 -0400
In-Reply-To: <7vabrb8rin.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.901)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - juliet.asmallorange.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - steelskies.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59102>


On 25 Sep 2007, at 02:26, Junio C Hamano wrote:

> Jonathan del Strother <maillist@steelskies.com> writes:
>
>> $ git stash list
>> stash@{0}: On master: --apply
>> stash@{1}: WIP on master: 09e3c30... Better handling of cell sizes in
>> the grid
>>
>> $ git stash show stash@{1}
>> ...
>> 19 files changed, 0 insertions(+), 3805 deletions(-)
>>
>> Hmm.  Looks like it's trying to delete all of my versioned files.
>> "git stash apply stash@{1}" confirms this.   Obviously that's not  
>> what
>> I tried to stash - my WIP when I stashed was a few additions, a  
>> couple
>> of new unversioned files, and moving a few lines of code from one  
>> file
>> to another.
>>
>> Any ideas what happened there?  I can't seem to reproduce the problem
>> in a test repository.
>
> ...
> Whenever anybody wonders where inadvertent reverting changes
> come from, two most likely reasons are incorrect push into the
> current branch's tip initiated from elsewhere, or incorrect
> fetch into the current branch's tip initiated from the
> repository.

I'm working on a single isolated repository, so haven't pushed,  
pulled, fetched, or anything.


> 	git ls-tree stash@{1}
>        git rev-parse stash@{1}^1
>        git diff stash@{1}^1 stash@{1}^2
>

ls-tree is empty.  rev-parse confirms I was on the right revision when  
I stashed, and the diff shows everything being deleted.


> Does the third command show you what you thought you have
> told "git add" to put in the index just before you made the
> stash?

I don't think I git-added anything - just made changes to the working  
copy.  (It *does* stash those, right??)


I'm at a loss to explain what happened here...
