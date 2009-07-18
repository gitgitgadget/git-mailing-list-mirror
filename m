From: Michael G Schwern <schwern@pobox.com>
Subject: git silently ignores aliases of existing commands
Date: Fri, 17 Jul 2009 17:52:49 -0700
Message-ID: <4A611CE1.3080709@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 18 03:06:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRyNW-0004i1-6A
	for gcvg-git-2@gmane.org; Sat, 18 Jul 2009 03:06:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758232AbZGRBGJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2009 21:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758235AbZGRBGJ
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 21:06:09 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63914 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758195AbZGRBGH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2009 21:06:07 -0400
X-Greylist: delayed 793 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Jul 2009 21:06:07 EDT
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 08F628F48
	for <git@vger.kernel.org>; Fri, 17 Jul 2009 20:52:52 -0400 (EDT)
Received: from [10.23.42.2] (unknown [69.64.236.3]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 899128F47 for
 <git@vger.kernel.org>; Fri, 17 Jul 2009 20:52:51 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.22 (Macintosh/20090605)
X-Enigmail-Version: 0.95.7
X-Pobox-Relay-ID: 525E030A-7335-11DE-8971-AEF1826986A2-02258300!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123499>

Everyone says "git tag" does the wrong thing by default and what you really
want is an annotated tag with "git tag -a".  So I figured I'd fix the default
and in my .gitconfig added:

[alias]
    tag = tag -a

and considered it done.  Weeks later I discovered git was ignoring that alias
and I was still making lightweight tags.

It would be nice if git used the alias *before* the installed command.  This
lets me fix/change default behaviors without having to come up with a new
command.  (Another handy example:  blame = blame -w)  It doesn't do anything
useful right now anyway.

Whether or not that changes, if an alias is being ignored git should warn me.
 This informs the user their perfectly sensible action has not done what they
expected.  In addition, should git add a command in the future which conflicts
with the name of an alias they'll know.


PS  I couldn't find anything obvious about where to send bug reports / feature
requests in the git man page, just "general upbringing" pointing here.  It
would be helpful if it was a bit more clear.  None of "bug", "report" or
"issue" pointed at anything relevant.

-- 
184. When operating a military vehicle I may *not* attempt something
     "I saw in a cartoon".
    -- The 213 Things Skippy Is No Longer Allowed To Do In The U.S. Army
           http://skippyslist.com/list/
