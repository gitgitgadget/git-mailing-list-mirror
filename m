From: Seb <spluque@gmail.com>
Subject: Re: interactive rebase results across shared histories
Date: Tue, 23 Feb 2016 11:39:25 -0600
Organization: Church of Emacs
Message-ID: <87io1f5nsi.fsf@gmail.com>
References: <87io1j6laz.fsf@gmail.com> <56C91D21.90306@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 18:40:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYGx1-0005Wv-5h
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 18:40:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754333AbcBWRj4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 12:39:56 -0500
Received: from plane.gmane.org ([80.91.229.3]:57927 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753551AbcBWRjz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 12:39:55 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1aYGwC-0004ns-Mt
	for git@vger.kernel.org; Tue, 23 Feb 2016 18:39:52 +0100
Received: from s0106503955564c1f.wp.shawcable.net ([24.77.8.70])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Feb 2016 18:39:52 +0100
Received: from spluque by s0106503955564c1f.wp.shawcable.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Feb 2016 18:39:52 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: s0106503955564c1f.wp.shawcable.net
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Cancel-Lock: sha1:LwYeqHeGB3Ad+LRH08y1PUM/I8w=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287085>

On Sun, 21 Feb 2016 03:12:49 +0100,
Moritz Neeb <lists@moritzneeb.de> wrote:

> Hi Seb,
> On 02/20/2016 11:58 PM, Seb wrote:
>> Hello,

>> I've recently learnt how to consolidate and clean up the master
>> branch's commit history.  I've squashed/fixuped many commits thinking
>> these would propagate to the children branches with whom it shares
>> the earlier parts of the its history.  However, this is not the case;
>> switching to the child branch still shows the non-rebased (dirty)
>> commit history from master.  Am I misunderstanding something with
>> this?

> I am not sure what you meand by "child branch". If I understand
> corretly, you have something like:

[...]

> Maybe, to get a better understanding, you could use visualization tool
> like "tig" or "gitk" to observe what happens to your commits (hashes)
> and branches (labels) and just play around with some of these
> operations.

OK, I've followed this advice and looked at the dependency graphs in
gitk before and after rebasing, I've managed to obtain what I was
after.  The repository now has two branches: master and topic.  However,
Gitk reveals a problem with a string of commits that are not part of any
branch:

A---B---H---I                   (master)
     \
      C---D---E                 (loose string of commits)
       \
        D'---E'---F---G         (topic)

How do I remove these loose commits (C, D, E)?

Thanks for your feedback,

-- 
Seb
