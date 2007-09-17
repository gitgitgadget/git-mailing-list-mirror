From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git pull fails on a repository > 1.5G.
Date: Mon, 17 Sep 2007 12:18:06 -0700
Message-ID: <7v7imp14pd.fsf@gitster.siamese.dyndns.org>
References: <a901b49a0709170159g477525bcr5383a1a051ae5e3d@mail.gmail.com>
	<a901b49a0709170239t39123a27t3ff3462855c7eb57@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	"Dhirendra Singh Kholia" <dhiru.kholia@gmail.com>
To: "pradeep singh" <pradeep.rautela@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 21:18:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXM6u-0000sF-Rx
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 21:18:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754659AbXIQTSQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 15:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754640AbXIQTSQ
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 15:18:16 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:39565 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752594AbXIQTSP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 15:18:15 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 35054136D4F;
	Mon, 17 Sep 2007 15:18:30 -0400 (EDT)
In-Reply-To: <a901b49a0709170239t39123a27t3ff3462855c7eb57@mail.gmail.com>
	(pradeep singh's message of "Mon, 17 Sep 2007 15:09:44 +0530")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58470>

"pradeep singh" <pradeep.rautela@gmail.com> writes:

>> The remote repo has some changes to a file with some simple printk's
>> some some code changes.
>>
>> I have my git repo in /mnt/reiser/project .
>>
>> I changed to the my repo.

"changed" meaning you did:

          $ cd /mnt/reiser/project

right?

>> i did a git-pull ssh://user1@10.100.205.34/opt/test/project test .[to
>> pull from another test machine].

It is not clear if this "another test machine" is the "remote
repo with printk" you earlier talked about.  Are they the same?
I am assuming they are.  What was the command?  Was

	$ git-pull ssh://user1@10.100.205.34/opt/test/project test .

what you typed (I am hoping that you did not give the extra " ."
at the end)?

>> I got some conflicts in a file but in some important files it
>> did not update it.

You earlier talked about "printk's to a file" in the remote, and
then you talk about two other classes of files.  How are they
related?  Is the "files it did not update it" being "important"
a helpful information to diagnose this issue?

Getting conflicts is perfectly normal.  If you changed something
and the branch you are pulling from changed the area nearby, you
would get conflicts and need to resolve.  Are you saying the
file you got conflict in should not have get conflicts?  If so,
what makes you think so?  They did not see parallel developments
while they diverged?

It also is perfectly normal if "git-pull" does not rewrite every
file in your work tree.  If a file was modified by you (in the
repository /mnt/reiser/project) since the history diverged from
the history "another test machine" has, while the repository on
that another test machine did not modify that file in any way,
the merge result is _your_ version and in such a case "git-pull"
will keep your copy intact.

What made you think that some files that were not updated should
have been updated?  IOW, are you sure they should have been
updated while git did not update them?  What error messages did
you get when you did the above "pull"?  What did they say?

> What is happening here? :-/
>
> I am puzzled.
> Can anybody please help me???

Sorry, you provided too little information to start even
speculating if there is anything wrong going on, let alone
diagnosing if there indeed is something wrong.
