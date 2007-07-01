From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
Subject: Re: [PATCH] Document git-stash
Date: Sun, 01 Jul 2007 18:06:29 +0900
Message-ID: <200707010910.l619A23b027837@mi0.bluebottle.com>
References: <20070701080757.GA6093@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: GIT <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jul 01 11:10:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4vRh-0007cq-9S
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 11:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755300AbXGAJKG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jul 2007 05:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755275AbXGAJKG
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jul 2007 05:10:06 -0400
Received: from mi0.bluebottle.com ([206.188.25.15]:59834 "EHLO
	mi0.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753569AbXGAJKE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jul 2007 05:10:04 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi0.bluebottle.com (8.13.1/8.13.1) with ESMTP id l619A23b027837
	for <git@vger.kernel.org>; Sun, 1 Jul 2007 02:10:02 -0700
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:to:cc:date:subject:in-reply-to:mime-version:
	content-type:content-transfer-encoding:x-trusted-delivery;
	b=AtsA/Sk+daL0UKxlksWh/D2XJv8FIqkIlBeb/EWgI0JP15MycVttfg+4UDpuorrr3
	vgvPufAjmxTx0fK4v+05b7lo4KvThJrHMR9WzVPn36Ldp+R3vat4Kzj8Bpintlv
Received: from nanako3.mail.bluebottle.com ([222.175.53.18])
	(authenticated bits=0)
	by fe1.bluebottle.com (8.13.1/8.13.1) with ESMTP id l6199W3E028945
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 1 Jul 2007 02:09:50 -0700
cc: Junio C Hamano <gitster@pobox.com>
In-Reply-To: <20070701080757.GA6093@coredump.intra.peff.net>
X-Trusted-Delivery: <e12031108a3628f43f84733881aab5f7>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51286>

Hi,

Quoting Jeff King <peff@peff.net>:

>> +(no subcommand)::
>> +
>> +	Save your local modifications to a new 'stash', and run `git-reset
>> +	--hard` to revert them.
>
> For orthogonality's sake, should this be 'git-stash save', aliased to
> just 'git-stash'? It would make this heading a little more intuitive,
> and the very first paragraph (describing all of the modes) a little more
> clear.

Johannes earlier asked for the same thing, and I think it is a good change.

>> +apply [<stash>]::
>> +
>> +	Restores the changes recorded in the stash on top of the current
>
> s/Restores/Restore/ to match the imperative of the other command
> descriptions.
>
>> +	working tree state.  When no `<stash>` is given, applies the latest
>> +	one.  The working directory must match the index.  When the changes
>> +	conflict, you need to resolve them by hand and mark the result with
>> +	`git add` as usual.  When the changes are cleanly merged, your
>> +	earlier local changes stored in the stash becomes the differences
>> +	between the index and the working tree (i.e. `git diff`), except
>> +	that newly created files are registered in the index (i.e. `git diff
>> +	--cached` is necessary to review the newly added files).
>
> I'm not quite sure I understand what this is saying.

I don't understand myself anymore, either (^_^;) I just tried to follow
Jnio's earlier suggestion in his message.  He said this.

| The three-way merge is done correctly here, and I would imagine
| the users would feel the UI quite natural _if_ this merge
| conflicts.  "git diff" would show only the conflicted paths
| (because the updates coming from the old working tree is placed
| in the index for cleanly merged paths), editing a conflicted
| file and "git add $that_path" would resolve.  That's exactly the
| same workflow for a conflicted merge.
|
| However, I think it is a bit counterintuitive to update the
| working tree change to the index if the merge did not conflict.
| It might be better to run an equivalent of "git reset", so that
| after "git save restore", the user can say "git diff" (not "git
| diff HEAD") to view the local changes.  Perhaps...

>> +clear::
>> +	Removes all the stashed states.
>
> Maybe a note to indicate that this can lose data? Something like:
>
>   ...stashed states. Note that those states will then be subject to
>   pruning, and may be difficult or impossible to recover.

I see.  When I wrote it, I thought that saying "removes" was enough.  It
seemed obvious to me that you would lose it when you remove it.

Thanks for fixing my language.  I am not very good at writing English,
but you probably have already found it out (^_^;).

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
Finally - A spam blocker that actually works.
http://www.bluebottle.com
