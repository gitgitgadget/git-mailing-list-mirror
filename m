From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: merge time
Date: Mon, 30 Jul 2007 14:44:43 +0200
Message-ID: <46ADDD3B.3000806@dawes.za.net>
References: <630183.45851.qm@web51001.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matthew L Foster <mfoster167@yahoo.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 14:45:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFUcq-0000D4-I3
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 14:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754207AbXG3Mp0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 08:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754069AbXG3MpZ
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 08:45:25 -0400
Received: from balanced.mail.policyd.dreamhost.com ([208.97.132.119]:45607
	"EHLO spunkymail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754005AbXG3MpZ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jul 2007 08:45:25 -0400
Received: from [192.168.201.100] (dsl-146-24-241.telkomadsl.co.za [165.146.24.241])
	by spunkymail-a2.g.dreamhost.com (Postfix) with ESMTP id CA59687D41;
	Mon, 30 Jul 2007 05:45:23 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.5 (Windows/20070716)
In-Reply-To: <630183.45851.qm@web51001.mail.re2.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54229>

Matthew L Foster wrote:
> Sorry to bring up the time issue again [that I am perhaps still confused about] but I have been
> playing around with git more and I think I can phrase my question/observation better.
> 
> From viewing gitweb.cgi I have observed a situation where Linus creates a tag, say rc1, and then
> he later merges changes but some subset of those changes/commits show up in the list in time order
> as taking place _before_ the rc1 tag was made even though they were merged after. Do I describe a
> real or possible phenomenon? And does this happen because the developer that made the subset of
> changes in question commit them to his/her local repository in time order before the rc1 tag was
> made? So an external repository had the change before the rc1 tag was made but Linus' repository
> didn't? But internally git on Linus' machine knows that the gitweb.cgi displayed time order is
> wrong as far as the state is concerned because each repository's index file keeps local track of
> the true local state [just time isn't reconcilable], or am I missing something(s)?
> 
> Is it possible for gitweb.cgi to have a new view mode that sorts/displays the list based on merge
> time for commits (the time merged into Linus' or whatever repository) so the above situation
> doesn't happen? The actual time of a local commit should be the time it was merged locally not the
> time it was created externally/originally, right? Where can I find the gitweb.cgi source/package?
> I could maybe hack gitweb.cgi myself.
> 
> Please CC me on any replies since I am not subscribed to the list.
> 
> -Matt

The last time this topic came up, folks either created (or pointed to) 
reflogs as a way to determine the changes to the local state of a repo.

i.e. by checking the reflog for a ref, you could say that that ref was 
changed from v2.6.20 to v2.6.21 at such and such date and time.

That would allow you to determine what commits were available via that 
ref at a particular time, regardless of the actual commit dates.

To the best of my knowledge, though, reflogs are not enabled by default 
on bare repos, and gitweb makes no use of the reflogs anyway.

Rogan
