From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] Implement git-quiltimport (take 2)
Date: Thu, 18 May 2006 04:48:26 -0600
Message-ID: <m1ejyr38xx.fsf@ebiederm.dsl.xmission.com>
References: <m1k68l6hga.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0605161001190.3866@g5.osdl.org>
	<m1bqtx6el6.fsf@ebiederm.dsl.xmission.com>
	<7vbqtxaj5k.fsf@assigned-by-dhcp.cox.net>
	<m13bf95ixo.fsf@ebiederm.dsl.xmission.com>
	<7v1wut2p5z.fsf@assigned-by-dhcp.cox.net>
	<m1bqtw4hk7.fsf_-_@ebiederm.dsl.xmission.com>
	<7vsln8cwn6.fsf@assigned-by-dhcp.cox.net>
	<m1zmhg31cm.fsf@ebiederm.dsl.xmission.com>
	<7vy7x09qet.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 18 12:49:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fgg46-0006sc-5j
	for gcvg-git@gmane.org; Thu, 18 May 2006 12:49:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbWERKtF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 May 2006 06:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbWERKtF
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 06:49:05 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:21659 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751095AbWERKtE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 May 2006 06:49:04 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id k4IAmRAj026583;
	Thu, 18 May 2006 04:48:27 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id k4IAmQbF026582;
	Thu, 18 May 2006 04:48:26 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy7x09qet.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Wed, 17 May 2006 16:34:34 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20280>

Junio C Hamano <junkio@cox.net> writes:

> ebiederm@xmission.com (Eric W. Biederman) writes:
>
>> Junio C Hamano <junkio@cox.net> writes:
>>
>>> What's the expected workflow for you to work on a 1300 patch
>>> series you get from Andrew in the next installment to deal with
>>> 88 unattributed patches?  Answer the question 88 times and make
>>> sure you get the answers right every time?  Or abort and
>>> hand-edit them to help mailinfo to notice the correct
>>> attribution and re-run?
>>
>> For the internal consumption case it isn't a big deal.  I
>> can specify --author with something bogus and it works. 
>
> Yes.
>
>>> I know I am guilty of suggesting "going interactive", but I have
>>> a feeling that having an optional file that maps patch-name to
>>> author might be easier to work with.  If the old patches are
>>> recycled in the updated -mm set, you probably can reuse the
>>> mapping for them, adding entries for newly introduced "unnamed"
>>> patches as needed.
>>
>> Short of getting the script where it has a sane restart in the
>> middle mode going interactive and asking questions makes a lot
>> of sense.  Especially with smaller trees.
>
> Yes perhaps on smaller trees, but that does not mean much.  For
> smaller trees and/or smaller patch series almost anything would
> do.

Yes, a smaller patch series, that is what I meant.
Most quilt trees that I know about are in needed small.

Andrews is the only one I know of that has gets as far as sucking in
other quilt trees.

> How about doing something like this, so that the user can record
> the fixup information, especially with --dry-run patch?  Then
> the next round from the updated -mm tree the user would not have
> to retype them again ("then..fi" part should be indented in the
> final version, but I did not want indentation changes to
> distract you):

This might be a sane work flow.  My imagination actually had
the user making a copy of the quilt tree and editing it by
hand.  My --dry-run doesn't ask the question it just throws
errors so --dry-run isn't quite the right name.

So I guess with something like --dry-run there isn't a restart
problem.  The question is if we don't edit the patches themselves
where do we put your author-fixup tag?  .dotest? 

Eric
