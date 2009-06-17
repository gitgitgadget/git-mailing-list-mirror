From: Minty <mintywalker@gmail.com>
Subject: git rebase --interactive squash/squish/fold/rollup
Date: Wed, 17 Jun 2009 13:06:54 +0100
Message-ID: <e1868cfe0906170506o37a75c35m47f9456bf8ae47c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 17 14:13:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGu1b-0005SX-Am
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 14:13:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758300AbZFQMNq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2009 08:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755769AbZFQMNp
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 08:13:45 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:50488 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754742AbZFQMNp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2009 08:13:45 -0400
Received: by bwz9 with SMTP id 9so263319bwz.37
        for <git@vger.kernel.org>; Wed, 17 Jun 2009 05:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=zaFKJ3bal5XFuoMINqmI1gwIUhZ1sGW2ClSVmvIi9Y0=;
        b=Y15e3U3VylKCw77I9yw5ESRWNHDd0YrGAIz2i5xMOgXuHIARagEpkuxNQzIzc/BPMS
         zSQVHt4PFxSFPs6MdLkNm6KWk9hpB73vdDMtHBtfp9jCUiJLJO12HEEB3aCRl5oJAI2E
         BGzwi5P2/p/kywu3dEumLXfAK35HKqqyeeYSg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=pC++wik0AnprY+/mudJmuw8sSTtlatVbBuzbmGOTFa2npKsxLuIj6J8wmKvrsbehOx
         Pzct8Inbu61tNU/yDqEA8cQxIlZ0kTKa6zHOrt6wF7I6QpM9SNYb3t9NyIbuofkM/iBU
         PEV/z2Ew8KWr4G0+xYQNHogXVlBQinbFSZIw4=
Received: by 10.204.58.130 with SMTP id g2mr86118bkh.45.1245240414512; Wed, 17 
	Jun 2009 05:06:54 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121738>

I was wondering if there was a git rebase --interactive "squash"
alternative, that instead of letting me edit and manually combine the
commit messages from multiple commits that I want squashed together,
instead simply used the first and folded the other commits into that?

I often find myself in the following pattern:

branch, hack, commit.
hack, commit, hack, commit
git rebase --interactive master
squash later commits into an earlier one
repeated [hack, commit]+, rebase, squash
merge

At which point, 99% of the time I want to fold the later commits into
an earlier commit, keep the commit message of the first and throw the
remaining commit messages into /dev/null.

I understand this is just a matter of editting the commit messages,
but I'm lazy and I find myself repeatadly dumbly deleting the latter
commit messages again and again.

A $EDITOR macro/extension might address this, but it seems (to me)
cleaner to extend the rebase command set:

< pick, edit, squash
> pick, edit, squash, fold

"fold" is perhaps the wrong word.  "squish" is perhaps too similar.
"rollup" maybe?

In any event, functionally it would do exactly the same as "squash",
except rather than let you edit the commit messages it would instead
simply use the commit message of the first commit.  And throw the
other commit messages away.

I'm not adverse at having a go at putting a patch together (although
this is not my forte), but I thought I'd check there wasn't prior art
or a good reason why this would be a "bad thing" to have?

Murray.
