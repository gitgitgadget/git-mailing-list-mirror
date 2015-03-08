From: David Kastrup <dak@gnu.org>
Subject: Re: Git very slow ?
Date: Sun, 08 Mar 2015 17:21:22 +0100
Message-ID: <87zj7nmpdp.fsf@fencepost.gnu.org>
References: <20150307013007.GA13250@milliways>
	<20150308155136.GA6273@vps892.directvps.nl>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ken Moffat <zarniwhoop@ntlworld.com>, git@vger.kernel.org
To: Kevin D <me@ikke.info>
X-From: git-owner@vger.kernel.org Sun Mar 08 17:21:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUdxV-0000jF-HH
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 17:21:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752659AbbCHQVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 12:21:37 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:52027 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752569AbbCHQVg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 12:21:36 -0400
Received: from localhost ([127.0.0.1]:51070 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1YUdxO-0006Kz-N4; Sun, 08 Mar 2015 12:21:35 -0400
Received: by lola (Postfix, from userid 1000)
	id E50BBE04F4; Sun,  8 Mar 2015 17:21:22 +0100 (CET)
In-Reply-To: <20150308155136.GA6273@vps892.directvps.nl> (Kevin D.'s message
	of "Sun, 8 Mar 2015 16:51:36 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265098>

Kevin D <me@ikke.info> writes:

> On Sat, Mar 07, 2015 at 01:30:07AM +0000, Ken Moffat wrote:
>> Hi, please CC me if that is not your usual fashion, because I am not
>> subscribed.
>> 
>> I use git for my build scripts - those are accessed over nfs.  Since
>> I started using 2.1 and later (I don't think I used 2.0) commands
>> such as 'commit' take a long time before anything happens.  I
>> assumed that the newer version meant this would take longer.
>> 
>> But today^Wyesterday I was bisecting the kernel on a local
>> filesystem - even when the number of revisions left to test was in
>> the single digits, git bisect took a long time to decide which
>> revision should be the next one to test.  The filesystems are ext4.
>> Is this sort of delay normal now?
>> 
>> What really prompted me to ask is that I ran git blame on a script,
>> to see when I made a particular change so that I could add that
>> information to a ticket, and almost gave up waiting because it felt
>> as if it was taking for ever.
>> 
>
> What kind of repository are we talking about? How many files, how big?
> Git should not have become significantly slower recently.

Particularly not git-blame in 2.1.  I should be quite surprised to see
any git-blame call running noticeably slower in 2.1 than in any
preceding version.

What may have happened is that the repository recently got repacked
aggressively and thus any access to older revisions got slower.
However, that change would be mostly tied to the repository rather than
the version of Git you access it with.

-- 
David Kastrup
