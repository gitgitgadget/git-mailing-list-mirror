From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git cheat sheet
Date: Wed, 29 Aug 2007 01:11:07 -0700
Message-ID: <7vfy22squc.fsf@gitster.siamese.dyndns.org>
References: <200708290348.02853.zack@kde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Zack Rusin <zack@kde.org>
X-From: git-owner@vger.kernel.org Wed Aug 29 10:11:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQIe1-0004HX-1J
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 10:11:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753410AbXH2ILQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 04:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753795AbXH2ILQ
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 04:11:16 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:48532 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752272AbXH2ILO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 04:11:14 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id DE4B7126CD3;
	Wed, 29 Aug 2007 04:11:31 -0400 (EDT)
In-Reply-To: <200708290348.02853.zack@kde.org> (Zack Rusin's message of "Wed,
	29 Aug 2007 03:48:02 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56907>

Zack Rusin <zack@kde.org> writes:

> http://ktown.kde.org/~zrusin/git/git-cheat-sheet.svg

Nice drawing and no typo.  Very nicely done.

Some minor nits (-), improvement suggestions (+), and
corrections (*).

- Recommended form for diff between 1 and 2 is "git diff $id1
  $id2", not dotted form "$id1..$id2"

+ "git log -p $file" gives a false impression that it is about a
  single file.  Better written as "git log -p $file $dir/ec/tory/"
  to suggest both usage.

- Although they do the same thing ("annotate" is there only for
  backward compatibility) "git blame" is recommended over "git
  annotate", if only because that's the command name more often
  talked about in the community.  If you are going to list only
  one, blame is the name to keep.

+ To start from a particular revision, use "git blame $version $file".

- "git reset --hard HEAD"; you do not have to write HEAD there.

- "Revert" has a specific meaning to git but people from
  different background interpret the word differently.  Both
  "git revert HEAD" and "git revert $id" are about creating a
  new commit to reverse the effect of the named commit.

* "git pull $branch1 $branch2" is wrong.  If you are merging
  branch1 into branch2, you need to be on branch2 (i.e. have
  done "git checkout branch2") and then say "git merge branch1".

+ "git commit" is not about publishing at all.  A major point
  about distributed SCMs is that unlike centralized systems, the
  act of committing is separate from the act of publishing.
  IOW, you can make commits without having to worry about
  publishing that to the public, and that allows you to more
  freely experiment.

+ A new section "Making Progress" and include commit, merge and
  rebase there, perhaps?
