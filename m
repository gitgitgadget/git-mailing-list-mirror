From: Ted Pavlic <ted@tedpavlic.com>
Subject: Re: diff settings
Date: Sun, 25 Jan 2009 21:06:47 -0500
Message-ID: <497D1AB7.7000208@tedpavlic.com>
References: <alpine.GSO.2.00.0901240936080.23073@kiwi.cs.ucla.edu> <87ocxwv6qg.fsf@iki.fi> <alpine.GSO.2.00.0901241159050.23073@kiwi.cs.ucla.edu> <497CD352.2060402@tedpavlic.com> <alpine.GSO.2.00.0901251307030.12651@kiwi.cs.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Teemu Likonen <tlikonen@iki.fi>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Keith Cascio <keith@CS.UCLA.EDU>
X-From: git-owner@vger.kernel.org Mon Jan 26 03:08:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRGtj-0004n5-Ii
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 03:08:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754054AbZAZCGz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 21:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbZAZCGz
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 21:06:55 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:51509 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754023AbZAZCGy (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Jan 2009 21:06:54 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 3080580D8035;
	Sun, 25 Jan 2009 21:00:49 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3pqojfwmDdnp; Sun, 25 Jan 2009 21:00:49 -0500 (EST)
Received: from TedBook.local (cpe-76-181-62-78.columbus.res.rr.com [76.181.62.78])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id B827080D8016;
	Sun, 25 Jan 2009 21:00:48 -0500 (EST)
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
In-Reply-To: <alpine.GSO.2.00.0901251307030.12651@kiwi.cs.ucla.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107158>

>> Mercurial has a "defaults.*" that does exactly what you want. That is, you can
>> [defaults]
>> diff = -w
>> and "hg diff" will automatically do "hg diff -w". Such a feature might be a
>> nice addition to git.
> Thank you, that is very interesting.  I just submitted a patch this morning that
> does exactly what you describe, but I called it "primer" instead of "defaults"
> because it seemed more explicit.  Check it out.

I saw that. However, in Mercurial's case, the [defaults] section applies 
to all commands (including new ones introduced by extensions). That is, 
it looks like your patch adds a diff.primer, but Mercurial would add a 
primer.* that allows you to have a primer.diff, primer.commit, etc.

For example, wouldn't it be nice to have something like...

[defaults]
diff = -w
commit = -a

etc.? Right now the only way you can do that is with aliases (e.g., I 
have an alias from "ci" to "commit -a").

This task is pretty easy in Mercurial because Mercurial porcelains are 
implemented as modules that are all executed through the central "hg" 
command. This isn't the case with git.

(on a somewhat unrelated note, Mercurial does have a [diff] section that 
allows for, say, forcing the use of git diff and other things)

--Ted



-- 
Ted Pavlic <ted@tedpavlic.com>

   Please visit my ALS association page:
         http://web.alsa.org/goto/tedpavlic
   My family appreciates your support in the fight to defeat ALS.
