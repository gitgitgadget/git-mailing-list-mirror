From: Ted Pavlic <ted@tedpavlic.com>
Subject: Re: [PATCH] Simple update to bash completions to prevent unbound
 variable errors.
Date: Mon, 12 Jan 2009 23:30:16 -0500
Message-ID: <496C18D8.9070707@tedpavlic.com>
References: <496C0003.7040909@tedpavlic.com> <7vy6xfew2n.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 05:31:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMawL-0004IN-VL
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 05:31:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753086AbZAMEaV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 23:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752905AbZAMEaV
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 23:30:21 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:32797 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752816AbZAMEaU (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jan 2009 23:30:20 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id CFE5080D8032;
	Mon, 12 Jan 2009 23:24:36 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hvf0Q0JLkWQ2; Mon, 12 Jan 2009 23:24:36 -0500 (EST)
Received: from TedBook.local (cpe-76-181-62-78.columbus.res.rr.com [76.181.62.78])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 6D7FD80D802F;
	Mon, 12 Jan 2009 23:24:36 -0500 (EST)
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
In-Reply-To: <7vy6xfew2n.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105451>

>> A vim modeline has also been added for consistency.
>
> Yuck.

Better that than have a mixture of spaces and tabs.

>> +# __git_ps1 accepts 0 or 1 arguments (i.e., format string)
>> +# returns text to add to bash PS1 prompt (includes branch name)
>
> Good.  Would be better if you described what $1 and $2 mean.

In that case, there's only $1 (the format string).

Note that in most cases, I didn't know what $1 and $2 were. I was just 
trying to fix it so that it would work on my system.

>> -		if [ -n "$1" ]; then
>> +		if [ $# -gt 0 ]&&  [ -n "$1" ]; then
>
> I found the previous round's [ -n "${1-}" ] much easier to read, if we were to
> do this.  If -n "${1-}", then "$1" is definitely set so nothing need to
> change in the then ... else part.

Hey -- I agree, but no one else liked ${1-}. And hg's bash completion 
seems far superior because they avoid ever having to worry about it. 
They actually thought about the arguments ahead of time.

>> +# __gitcomp_1 requires 2 arguments
>
> ... and $1 and $2 mean?

No clue. Patches are welcome.

> Yuck.  If you are taking advantage of the fact that "local one"
> will bind one to emptiness anyway, can't you do something like:
>
> 	local one=${1-} two=${2-} cur=${3-} four=${4-}

Why even use one, two three, and four then?

I had ${#-} throughout, but I was told that that was ugly. So the best I 
could do was come up with the above mess.

--Ted

-- 
Ted Pavlic <ted@tedpavlic.com>

   Please visit my ALS association page:
         http://web.alsa.org/goto/tedpavlic
   My family appreciates your support in the fight to defeat ALS.
