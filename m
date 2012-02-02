From: "Neal Groothuis" <ngroot@lo-cal.org>
Subject: Re: Finding all commits which modify a file
Date: Thu, 2 Feb 2012 09:55:47 -0500 (EST)
Message-ID: <5456.38.96.167.131.1328194547.squirrel@mail.lo-cal.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 15:55:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rsy4p-00072s-NY
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 15:55:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402Ab2BBOzt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 09:55:49 -0500
Received: from dharma.lo-cal.org ([208.70.151.129]:56637 "EHLO
	dharma.lo-cal.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932099Ab2BBOzr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 09:55:47 -0500
Received: from mail.lo-cal.org (localhost [127.0.0.1])
	by dharma.lo-cal.org (Postfix) with ESMTP id AFE4C2AEA83;
	Thu,  2 Feb 2012 08:55:47 -0600 (CST)
Received: from 38.96.167.131
        (SquirrelMail authenticated user ngroot)
        by mail.lo-cal.org with HTTP;
        Thu, 2 Feb 2012 09:55:47 -0500 (EST)
User-Agent: SquirrelMail/1.4.13
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189649>

> "Neal Groothuis" <ngroot@lo-cal.org> writes:
>
>> Is there a situation where checking for TREESAMEness before
>> simplification
>> is desirable and checking after would not be?
>
> When you do not want to see a side branch that does not contribute to
the end result at all, obviously ;-). Outside that situation, before or
after should not make a difference, I would think.

In that case, you wouldn't be using the --full-history flag at all, yeah?

Right now, we can see where the file gets changed (A1), we just can't see
where it gets changed back (B2).  In fact, if I run git-log --full-history
--simplify-merges foo.txt, it looks like A1 was the last thing to make
changes to foo.txt, which seems misleading to me---history has been
simplified to the point of not being true.
