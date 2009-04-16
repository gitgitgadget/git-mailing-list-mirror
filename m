From: Miles Bader <miles@gnu.org>
Subject: Re: renaming remote branches
Date: Thu, 16 Apr 2009 17:00:39 +0900
Message-ID: <buoab6h2fko.fsf@dhlpc061.dev.necel.com>
References: <buo3ac9jn18.fsf@dhlpc061.dev.necel.com>
	<20090416065934.GA20071@coredump.intra.peff.net>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 16 10:02:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuMYD-0004wR-08
	for gcvg-git-2@gmane.org; Thu, 16 Apr 2009 10:02:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661AbZDPIAu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2009 04:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbZDPIAu
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Apr 2009 04:00:50 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:62601 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123AbZDPIAt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2009 04:00:49 -0400
Received: from relay31.aps.necel.com ([10.29.19.54])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id n3G80b24002272;
	Thu, 16 Apr 2009 17:00:39 +0900 (JST)
Received: from relay31.aps.necel.com ([10.29.19.20] [10.29.19.20]) by relay31.aps.necel.com with ESMTP; Thu, 16 Apr 2009 17:00:39 +0900
Received: from dhlpc061 ([10.114.114.58] [10.114.114.58]) by relay31.aps.necel.com with ESMTP; Thu, 16 Apr 2009 17:00:39 +0900
Received: by dhlpc061 (Postfix, from userid 31295)
	id B93AE52E277; Thu, 16 Apr 2009 17:00:39 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-Reply-To: <20090416065934.GA20071@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 16 Apr 2009 02:59:34 -0400")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116681>

Jeff King <peff@peff.net> writes:
> In your situation, I would probably do:
>   ssh remote-host 'cd remote-dir && git branch -m OLD NEW'
> but that is not always an option, depending on your setup.

Yup, don't have real ssh access.

>> Also, I note that the old name ("OLD") remains in .git/info/refs, both
>> locally and in the remote; is this a problem?  I can update the local
>> .git/info/refs by running "git update-server-info", but I'm not sure how
>> to do in for the remote repo without having a login there...
>
> If you are not sharing your repo over a dumb transport (like http), then
> the contents of .git/info/refs shouldn't matter. If you are, then you
> should enable the post-update hook to run update-server-info after every
> push (i.e., it is not just the deletion that is a problem, but none of
> your pushes is being marked in .git/info/refs).

Hmmm, there's no way to update the hooks without shell access, right...?

[lots of stuff seems undoable without shell access, i.e., changing
.git/descriptions; it'd be nice if there was at least some way to frob
all this stuff ...]

-Miles

-- 
Accordion, n. An instrument in harmony with the sentiments of an assassin.
