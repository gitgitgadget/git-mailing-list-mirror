From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Merging limitations after directory renames -- interesting test repo
Date: Fri, 18 Feb 2011 13:58:48 -0500
Message-ID: <AANLkTimsQmOLDENX27YqpicBeFFZrfgEAsLvFiJqoV7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 18 19:59:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqVXv-0007hq-Hb
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 19:59:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752729Ab1BRS7K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Feb 2011 13:59:10 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:61024 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999Ab1BRS7J convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Feb 2011 13:59:09 -0500
Received: by ywo7 with SMTP id 7so1726101ywo.19
        for <git@vger.kernel.org>; Fri, 18 Feb 2011 10:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        bh=loADecbzAP9bMNUBSu74e6E9IdshG9clzvoYhjmxujs=;
        b=IF8ecw4Z7gPUGpE3y/5cOKEwWpB7Dmi8R1IVSCVlVCRDXg2E4vDTwJbgxXNa6AGeGB
         BWovRbPufl1ox2f2/lFTYY5xdnOg63pfvvluq4uazhvkbETycQ/O1dBRWIzidgKU3pUX
         hR4lfqPvnuErYaiG4MrYT0ogPIr+4QuOqACNk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=llO3ZhGr97ZI0uJstLW3O/roAha/ESSqLwgtnnPB2dlmrCNz3LmI5p2M8TL5UD09eU
         HCtRYgisXLZyCuQ/KXsAvKhgKr5xGaFdmXPjlfkEAv5KoTBKH3axNQQ4e2z7JpPTVwwx
         DiwNkvbQwm9rjD6RvNqK3KRDX3OiWUkCYXn6M=
Received: by 10.90.75.18 with SMTP id x18mr1585608aga.5.1298055548157; Fri, 18
 Feb 2011 10:59:08 -0800 (PST)
Received: by 10.90.53.7 with HTTP; Fri, 18 Feb 2011 10:58:48 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167225>

Briefly,

=46etch git://dev.laptop.org/git/users/martin/etherpad and try to merge
pg and master. A ton of work is left to do by hand, and you don't even
get useful conflicts.

 - Many paths that shoud succeed don't seem to succeed. After using
git merge, tell me if this file doesn't look like at least git should
have _attempted_ a diff3 on it:
   gitk --all  -- etherpad/bin/rebuildjar.sh
trunk/etherpad/bin/rebuildjar.sh
trunk/trunk/etherpad/bin/rebuildjar.sh

 - Git diff seems confused, says "path needs merge" instead of giving
me a diff. May be related to the first problem
    git diff -- etherpad/bin/rebuildjar.sh

   However I can
   git diff master -- etherpad/bin/rebuildjar.sh
   git diff pg -- etherpad/bin/rebuildjar.sh

Note note! The "pg" branch you see has been artificially rebuilt so I
may have made a mistake. However, I've reviewed all the commits and it
seems correct. Original repo comes from SVN via hg -- see
git://github.com/ether/pad.git

Most importantly, even if I misfired here or there, the resulting
history of the paths reads like something git _can_ make sense of if
it traces the history of the paths carefully.

cheers,



m
--=20
=A0martin.langhoff@gmail.com
=A0martin@laptop.org -- Software Architect - OLPC
=A0- ask interesting questions
=A0- don't get distracted with shiny stuff=A0 - working code first
=A0- http://wiki.laptop.org/go/User:Martinlanghoff
