From: "Scott R. Godin" <scottg.wp-hackers@mhg2.com>
Subject: Re: git http-backend error message
Date: Mon, 05 Apr 2010 10:52:47 -0400
Organization: MAD House Graphics
Message-ID: <hpctg0$416$1@dough.gmane.org>
References: <A55E5483-425E-4303-87F2-FABC46F6BFE5@pelagicore.com> <7v3a01v796.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 05 16:53:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nynft-0005Fp-Fi
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 16:53:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755215Ab0DEOxG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 10:53:06 -0400
Received: from lo.gmane.org ([80.91.229.12]:55852 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755060Ab0DEOxB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 10:53:01 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Nynfe-0004Mx-PL
	for git@vger.kernel.org; Mon, 05 Apr 2010 16:52:58 +0200
Received: from c-71-58-29-3.hsd1.de.comcast.net ([71.58.29.3])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 16:52:58 +0200
Received: from scottg.wp-hackers by c-71-58-29-3.hsd1.de.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 16:52:58 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: c-71-58-29-3.hsd1.de.comcast.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9) Gecko/20100330 Fedora/3.0.4-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.4
In-Reply-To: <7v3a01v796.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143989>

On 03/15/2010 01:12 PM, Junio C Hamano wrote:
> Jeremiah Foster<jeremiah.foster@pelagicore.com>  writes:
>> 	Or is it smarter to just create a bare repository, clone some
>> 	content into it, and then push?
>
> It depends on what you are trying to achieve by pushing into this
> repository that is not bare, iow what this pushed-into repository is used
> for.
>
> Pushing into a repository is done for two reasons:
>
>   - You push into repository A so that the development done in other
>     repositories B, C, D,... can all be collected, kept safe, and
>     transferred out to other repositories (iow, B, C, D uses A as a shared
>     meeting place).
>
>     This is the primary use case of "push", and because in repository A
>     there will not be any development of its own, people make A a (shared)
>     bare repository.
>
>   - You do perform your own development in repository A, and you would want
>     to interact with other repositories B, C, D,..., by doing "git pull B"
>     etc., but for network configuration reasons, you can only make
>     connection to A from B, C, D..., and not in the other direction.  In
>     this case, because "git pull B" run on A is "git fetch B" followed by
>     "git merge", you substitute the first "git fetch B" part by running
>     "git push A" on B instead, because you can make connections from B to A
>     but not A to B.
>
>     In this case, you do not want your "git push A" run on B to overwrite
>     the branch that is checked out in A, and the above error is issued if
>     you attempted to do so.  This would show a proper arrangement for such
>     a "push instead of fetch":
>
>     http://git.wiki.kernel.org/index.php/GitFaq#push-is-reverse-of-fetch

Thanks, this actually helped clear up a few things for me as well. I 
haven't yet started working with remotes; mostly I've been using it to 
take care of things on my end (this is a bit less problematic since I 
mostly use it for web devel tracking anyway) and then rsync to the 
webserver. However, this is definitely going in my collection of notes 
and bookmarks for reference when I get to that point.


-- 
(please respond to the list as opposed to my email box directly,
unless you are supplying private information you don't want public
on the list)
