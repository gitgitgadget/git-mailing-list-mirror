From: Jim Cromie <jim.cromie@gmail.com>
Subject: [feature wishlist] add commit subcommand to git add -i
Date: Sun, 14 Aug 2011 02:38:36 -0600
Message-ID: <CAJfuBxwW8Dyp8FTS13uPOBKZGL9JOEqaSOhGN+zBJ_8BHpJE3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 14 10:39:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsWDw-0001dd-TB
	for gcvg-git-2@lo.gmane.org; Sun, 14 Aug 2011 10:39:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752515Ab1HNIjJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Aug 2011 04:39:09 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:47628 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904Ab1HNIjG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2011 04:39:06 -0400
Received: by pzk37 with SMTP id 37so1547309pzk.1
        for <git@vger.kernel.org>; Sun, 14 Aug 2011 01:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=d2mhc3/YCRL1g5WxhuJgcejlN3mlGGnPZJHsZ/effzk=;
        b=MX0zFdr4CJ5A2h0MFusHONiDJgcinmZlt8bcVOjvfobuCf3DuIMpkuw6qAHQrhdPYd
         pI/H88PqAA+Vpxt+Lv1wlr6XaY6pT2IRYlRLCPXCgDx/VMeCNLbm7HSyV4BdGAi2LDsn
         4QbUq6CCpMHd7lUXSAOOsmkhADop6M/JBecvk=
Received: by 10.142.148.2 with SMTP id v2mr1226833wfd.368.1313311146089; Sun,
 14 Aug 2011 01:39:06 -0700 (PDT)
Received: by 10.143.98.2 with HTTP; Sun, 14 Aug 2011 01:38:36 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179312>

when using git add -i, it would be handy to have a [c]ommit option.

This would save some typing:
q # to quit git add -i
$> commit ....
git add -i <file> # to resume incremental adds

*** Commands ***
  1: [s]tatus	  2: [u]pdate	  3: [r]evert	  4: [a]dd untracked
  5: [p]atch	  6: [d]iff	  7: [q]uit	  8: [h]elp
  9: [c]commit
What now>

[f]ragment would also be handy, which would break each chunk of a diff
into a separate commit, with the summary line provided automatically
<file> @@ -696,7 +692,7 @@ int foo ...

This would help a bit with random cleanups, since rebase -i could then
be used to
reorder and recombine the fragments, and edit the commit messages afterwards.


going further, if git rebase -i  had ability to  "back" a fixup patch
back to where it should have been, and adjust the intervening patches
where conflict would normally happen, that would be awesome.
Simplistically, this would just shift the patch 1 step back iteratively,
until it wouldnt apply properly, and then --abort, stopping at the last
clean rebase.

apologies if this is too hair-brained, or already done.
