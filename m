From: Miles Bader <miles@gnu.org>
Subject: Re: way to automatically add untracked files?
Date: Sun, 05 Aug 2007 16:34:58 +0900
Message-ID: <87hcnejuxp.fsf@catnip.gol.com>
References: <873ayymzc1.fsf@catnip.gol.com>
	<fc339e4a0708042100jdf0a0f1jd1fddfb5dc1c1052@mail.gmail.com>
	<alpine.LFD.0.999.0708042157150.5037@woody.linux-foundation.org>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 05 09:34:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHadP-0000ZX-Br
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 09:34:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754869AbXHEHek (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 03:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754862AbXHEHek
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 03:34:40 -0400
Received: from smtp02.dentaku.gol.com ([203.216.5.72]:37241 "EHLO
	smtp02.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754859AbXHEHej (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 03:34:39 -0400
Received: from 203-216-96-074.dsl.gol.ne.jp ([203.216.96.74] helo=catnip.gol.com)
	by smtp02.dentaku.gol.com with esmtpa (Dentaku)
	id 1IHadK-0000t4-8k; Sun, 05 Aug 2007 16:34:38 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id E2F57300F; Sun,  5 Aug 2007 16:34:58 +0900 (JST)
System-Type: i686-pc-linux-gnu
In-Reply-To: <alpine.LFD.0.999.0708042157150.5037@woody.linux-foundation.org> (Linus Torvalds's message of "Sat\, 4 Aug 2007 22\:03\:03 -0700 \(PDT\)")
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54962>

Linus Torvalds <torvalds@linux-foundation.org> writes:
> But git certainly has the capability. "git commit -a" will notice all the 
> files that went away and automatically remove them, so
>
> 	git add .
> 	git commit -a
>
> will do what you want (except, as we found out last week, we've had a huge 
> performance regression, so that's actually a really slow way to do it, and 
> so it's actually faster to do
>
> 	git ls-files -o | git update-index --add --stdin
> 	git commit -a

I notice that "git ls-files -o" doesn't do normal ignore-processing, so
for instance all my .o and editor backup files show up in the output...
Is that expected or is it a bug (I tried versions "1.5.2.4" and
"1.5.3.rc3.91.g5c75-dirty")?

If I do:

   git-ls-files -o --exclude-per-directory=.gitignore --exclude-from=$HOME/.gitignore

it works more like I'd expect.

Thanks,

-Miles

-- 
`The suburb is an obsolete and contradictory form of human settlement'
