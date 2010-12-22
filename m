From: Evgeniy Ivanov <lolkaantimat@gmail.com>
Subject: Using overlay filesystem for "other" files idea
Date: Thu, 23 Dec 2010 02:02:00 +0300
Message-ID: <AANLkTi=f2MXoWE_Dx_thWb3VXGu-V-9cJAC8F_RzGAg=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 23 00:02:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVXhA-0003uP-Hk
	for gcvg-git-2@lo.gmane.org; Thu, 23 Dec 2010 00:02:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752533Ab0LVXCB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Dec 2010 18:02:01 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44288 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751850Ab0LVXCB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Dec 2010 18:02:01 -0500
Received: by iwn9 with SMTP id 9so5674118iwn.19
        for <git@vger.kernel.org>; Wed, 22 Dec 2010 15:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=R2RBC2nysgM6kMwNc9foFZmMKvL+W7UEY2pCWvPR2N8=;
        b=QR3qzyTL1of+rXHGVRNWttc7lrHC5H88ZlLTuQ8qkXoI9D6Y7DhxhBmKrPL//1DuWI
         2JbQ3qCIhH7UKMZIG5UNxkjOgSF7EqzhZ0x8wUerV12NaQNThdtzGB5xHS5Zcn+FAMHd
         PtCiswypYxYdWT9yVsZxefkiRsHqE01K/6T4E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=MB2QYe/NiCxx+w8HFD6txBQKSnzDm1HKhMmJuWj5FC/EOGyRZeR2Brv/yOvBCOkiAa
         WTNhbz4AySR6fCOXyM2hsUUugq+s+q8sNLdQf4a5/1qbTrW1sppJE3xH5OJxEV+ROSnX
         X86l+s7XYZTaXz3DVuQ7Pkgg9QQIuvAUR4KJ4=
Received: by 10.231.171.197 with SMTP id i5mr7427204ibz.54.1293058920507; Wed,
 22 Dec 2010 15:02:00 -0800 (PST)
Received: by 10.231.62.20 with HTTP; Wed, 22 Dec 2010 15:02:00 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164098>

Hello,

I got following idea.

If different branches seriously differ and you switch branches, then
it's more likely you will loose most part of build files (e.g. when
run build).
Also in projects that may have some bugs in build system (e.g. buggy
makefiles) there is a chance you will not get clean build environment.
E.g. somebody forgot to add include file as dependency in Makefile ---
oops, you're in trouble.
Even without bugs in build system, some temp files are overwritten
each time you run build for a custom branch.

I think using overlays for other files can help much to solve this
issue. You can have git repository in regular directory (like now) and
overlay fs mounted over this repository (for each branch its own
overlay).
Another benefit is clearing source tree after build.

What do you think, guys? If it sounds good, I could work on this,
maybe even on my work.


-- 
Evgeniy Ivanov
