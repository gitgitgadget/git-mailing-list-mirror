From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: Getting a branch's time of creation
Date: Wed, 17 Mar 2010 09:32:04 -0700
Message-ID: <86wrxakiyj.fsf@blue.stonehenge.com>
References: <27933166.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: jateeq <jawad_atiq@hotmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 17 17:32:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrwAo-0005KL-PW
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 17:32:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755982Ab0CQQcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Mar 2010 12:32:10 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:31901 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755913Ab0CQQcG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 12:32:06 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 9E7921DE251; Wed, 17 Mar 2010 09:32:04 -0700 (PDT)
x-mayan-date: Long count = 12.19.17.3.10; tzolkin = 8 Oc; haab = 8 Cumku
In-Reply-To: <27933166.post@talk.nabble.com> (jawad_atiq@hotmail.com's message of "Wed, 17 Mar 2010 07:45:07 -0700 (PDT)")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142410>

>>>>> "jateeq" == jateeq  <jawad_atiq@hotmail.com> writes:

jateeq> I am trying to find the time at which a remote branch was created, so
jateeq> that I can use the '--since' option in git log to limit the commits to
jateeq> only ones that were created for that branch (read below to see why I
jateeq> can't use 'git log <branchnname>). So my question: does git remember
jateeq> the time at which a branch was created, and how can it be listed?

You're probably looking for the commit at the common ancestor
of a given branch (which is a point, not a line, remember) and a branch
you're interested in, like maybe "master".

consider something like:

git log $(git merge-base origin/somebranch origin/master)..origin/master

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.vox.com/ for Smalltalk and Seaside discussion
