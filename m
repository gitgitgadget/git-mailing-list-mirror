From: "David A. Greene" <greened@obbligato.org>
Subject: Re: Odd rebase behavior
Date: Fri, 18 Dec 2015 11:43:16 -0600
Message-ID: <nngmvt73b63.fsf@lnx-dag.us.cray.com>
References: <877fkf9j5h.fsf@waller.obbligato.org>
	<20151216221716.GD1581@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sandals@crustytoothpaste.net, peff@peff.net,
	gitster@pobox.com
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Dec 18 18:43:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9z42-0000E4-Ed
	for gcvg-git-2@plane.gmane.org; Fri, 18 Dec 2015 18:43:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933105AbbLRRna (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2015 12:43:30 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:60358 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933068AbbLRRn3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2015 12:43:29 -0500
Received: from chippewa-nat.cray.com ([136.162.34.1] helo=lnx-dag.us.cray.com)
	by johnson.obbligato.org with esmtpsa (TLS1.1:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.85)
	(envelope-from <greened@obbligato.org>)
	id 1a9z44-0001j7-9s; Fri, 18 Dec 2015 11:43:36 -0600
In-Reply-To: <20151216221716.GD1581@serenity.lan> (John Keeping's message of
	"Wed, 16 Dec 2015 22:17:16 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282710>

John Keeping <john@keeping.me.uk> writes:

> It seems that the problem is introduces by --preserve-merges (and
> -Xsubtree causes something interesting to happen as well).  I see the
> following behaviour:

Thanks for narrowing this down!  Is it possible this is actually a
cherry-pick problem since --preserve-merges forces rebase to use
cherry-pick?

> git rebase -Xsubtree=files_subtree --onto files-master master
>
> 	fatal: Could not parse object 'b15c4133fc3146e1330c84159886f0f7a09fbf43^'
> 	Unknown exit code (128) from command: git-merge-recursive
> b15c4133fc3146e1330c84159886f0f7a09fbf43^ -- HEAD
> b15c4133fc3146e1330c84159886f0f7a09fbf43

Ah, good!  I had seen this behavior as well but couldn't remember what I
did to trigger it.

I don't think I have the expertise to fix rebase and/or cherry-pick.
What's the process for adding these tests to the testbase and marking
them so the appropriate person can fix them?  I see a lot of TODO tests.
Should I mark these similarly and propose a patch to the testbase?

                             -David
