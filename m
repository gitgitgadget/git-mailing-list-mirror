From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Documentation: add a planning document for the next	CLI
 revamp
Date: Thu, 30 Oct 2008 16:02:29 +0100
Message-ID: <4909CC85.1080803@op5.se>
References: <1225338485-11046-1-git-send-email-sam@vilain.net> <20081030143918.GB14744@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sam Vilain <sam@vilain.net>, git@vger.kernel.org,
	Sam Vilain <samv@vilain.net>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Oct 30 16:04:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvZ3x-0000cI-Op
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 16:03:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754882AbYJ3PCj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 11:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754804AbYJ3PCj
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 11:02:39 -0400
Received: from mail.op5.se ([193.201.96.20]:58574 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754078AbYJ3PCi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 11:02:38 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 8E14E1B80048;
	Thu, 30 Oct 2008 15:57:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5R5uHok4PsZV; Thu, 30 Oct 2008 15:57:04 +0100 (CET)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 513401B80087;
	Thu, 30 Oct 2008 15:57:04 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20081030143918.GB14744@mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99482>

Theodore Tso wrote:
> On Wed, Oct 29, 2008 at 08:48:05PM -0700, Sam Vilain wrote:
>> From: Sam Vilain <samv@vilain.net>
>>
>> For cross-command CLI changes to be effective, they need to be
>> cohesively planned.  Add a planning document for this next set of
>> changes.
> 
> Here are my favorites:
> 
> * Add the command "git revert-file <files>" which is syntactic sugar for:
> 
>         git checkout HEAD -- <files>
> 
>   Rationale: Many other SCM's have a way of undoing local edits to a
>   file very simply, i.e."hg revert <file>" or "svn revert <file>", and
>   for many developers's workflow, it's useful to be able to undo local
>   edits to a single file, but not to everything else in the working
>   directory.  And "git checkout HEAD -- <file>" is rather cumbersome
>   to type, and many beginning users don't find it intuitive to look in
>   the "git-checkout" man page for instructions on how to revert a
>   local file.
> 

I like it, although I guess one would have to add a "--staged" flag to
git revert-file to be able to checkout files from index as well, or people
will wonder why that can't be done.

> * Change the argument handling for "git format-patch" so it is
>   consistent with everything else which takes a set of commits.  Yes,
>   it means that where people have gotten used to typing "git
>   format-patch origin", they'll have to type instead: "git
>   format-patch origin..", but's much more consistent.  We've done the
>   best we can by documenting the existing behavior, but if'we re going
>   to make major, potentially incompatible, CLI changes, this is
>   something to at least consider.  Maybe with a config file for people
>   who really don't want to retrain their fingers to type the two extra
>   periods?
> 

"git format-patch" does exactly the same thing as other commit-range handling
commands do, which is assume that the missing commit end-point is HEAD, so it
actually is consistent, although it doesn't quite look as if it is.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
