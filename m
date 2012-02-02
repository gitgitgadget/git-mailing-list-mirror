From: "norbert.nemec" <norbert.nemec@native-instruments.de>
Subject: Re: How to find and analyze bad merges?
Date: Thu, 02 Feb 2012 13:16:07 +0100
Message-ID: <jgduqg$p9f$1@dough.gmane.org>
References: <jgdgcv$h8n$1@dough.gmane.org> <jgdn5j$v4g$1@dough.gmane.org> <87haz97c2k.fsf@thomas.inf.ethz.ch> <4F2A70DA.6020107@native-instruments.de> <CAFfmPPMc1V97OPHyrZp+p4YUek1c6fCncyj0s1YU9xjxQBCsDA@mail.gmail.com> <20120202120340.GA25190@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 02 13:16:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rsvap-0006Fa-B9
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 13:16:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755980Ab2BBMQg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 07:16:36 -0500
Received: from plane.gmane.org ([80.91.229.3]:41228 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755968Ab2BBMQd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 07:16:33 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RsvaX-00065P-MQ
	for git@vger.kernel.org; Thu, 02 Feb 2012 13:16:29 +0100
Received: from 46.231.181.199 ([46.231.181.199])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 13:16:29 +0100
Received: from norbert.nemec by 46.231.181.199 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 13:16:29 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 46.231.181.199
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <20120202120340.GA25190@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189636>

Am 02.02.12 13:03, schrieb Jonathan Nieder:
> David Barr wrote:
>
>> Do the -c --cc or -m flags for git log help in this case?
>> They alter the way merge diffs are presented, as described under Diff Formatting
>> in the git-log(1)  man page.
>
> I suspect Norbert was running into history simplification, so the --full-history
> flag would be the relevant one.

Not quite.

As far as I understand it, history simplification hides the whole branch 
if its changes did not end up in the current branch.

When I tried it out, the --full-history prevented hiding the 
bugfix-commit itself, but it did not show the critical merge commit in 
the log.

> See the thread [1] for a few relevant side-notes.
 >
 > [1] http://thread.gmane.org/gmane.comp.version-control.git/188904

As I understand this thread, the user only requested all commits that 
"modify a file". Our merge-commit strictly speaking did not modify the 
file but simply kept one of the versions, completely swamping all 
modifications from one branch. Exactly the case that is still not 
covered by --full-history.
