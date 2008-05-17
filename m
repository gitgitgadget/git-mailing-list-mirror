From: Evgeny <evgeny.zislis@gmail.com>
Subject: git mergetool
Date: Sat, 17 May 2008 20:21:03 +0300
Message-ID: <b6840c770805171021g63df7d0dm4532655ed49209bc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, tytso@mit.edu
X-From: git-owner@vger.kernel.org Sat May 17 19:22:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxQ6Y-000636-Hu
	for gcvg-git-2@gmane.org; Sat, 17 May 2008 19:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752888AbYEQRVI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2008 13:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753135AbYEQRVG
	(ORCPT <rfc822;git-outgoing>); Sat, 17 May 2008 13:21:06 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:11479 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752888AbYEQRVF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2008 13:21:05 -0400
Received: by ug-out-1314.google.com with SMTP id h2so139678ugf.16
        for <git@vger.kernel.org>; Sat, 17 May 2008 10:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=C+aXSINlGLbhsHuPASBvZaVdMbqytVIx5DR0LaiBiBo=;
        b=RangtDjddN9KEirjKG4hULK1ULRvHpeBeGy91MW5kBcJUEDOp8IbM20uZBJ3vjAxQodAEDgEVUfaKlQdTcAx22BqrfZHKdwRan1Lf7FjWUhm0DA+kRiqF+JsRnR9tX8M9ttKspL7yJUldkWP5nedaeUUMy8qjyp2hdy06QnRbhw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=hKMg1ZtJEAVNu1DAeTGOLaGJepcOD8VhVxwVMeRskTFmj3CzDHiDLRTHqF+Zxq7F4jZ5qUMMq77BapMEWfWl1gOilOLJaxxgB2UylpPhzi1BIX/yTJrNQljCDzdeqiVlS6LggCcd1CD2Gw5me9FUe8F/YWh5nXi533Ef3zGZ0IQ=
Received: by 10.67.115.15 with SMTP id s15mr1208684ugm.63.1211044863448;
        Sat, 17 May 2008 10:21:03 -0700 (PDT)
Received: by 10.67.26.8 with HTTP; Sat, 17 May 2008 10:21:03 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82354>

Hello Git developers,
and especially Theodore (whos email is in the footer of man git-mergetool)

Background:
   I am trying to use a custom mergetool with git.
   P4Merge from http://www.perforce.com/perforce/products/merge.html

   The documentation explains that environment variables $BASE,
$LOCAL, $REMOTE, $MERGED
   are set for the invocation of the mergetool command.

Problem:
   I wrote a wrapper for P4Merge, and I check for these environment
variables - but they are not there.
   After a closer inspection of git-mergetool I see that infact these
variables are not being sent to the
   external command at all, and are just in the context of the
git-mergetool script.

Solution:
   There are two ways, that i know of, to make the executed command
receive these variables :
     1. use "export" on them
     2. use "env LOCAL=$LOCAL env REMOTE=$REMOTE ....  $extcommand" to
set an environment for just that command

My System Information:
   git 1.5.5.1  (from macports)
   Mac OS X 10.5.2

Hopefully this will get fixed in future versions, so I wont need to
patch git-mergetool locally on my machine with every update.

Regards,
Evgeny
