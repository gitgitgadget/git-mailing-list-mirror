From: "Han-Wen Nienhuys" <hanwenn@gmail.com>
Subject: git-rev-list diff options broken
Date: Tue, 6 Nov 2007 19:14:14 -0300
Message-ID: <f329bf540711061414k1627521bvaf4a7a06460cc3fd@mail.gmail.com>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 06 23:14:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpWgp-0000zO-Hq
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 23:14:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754140AbXKFWOQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 17:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754045AbXKFWOQ
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 17:14:16 -0500
Received: from nz-out-0506.google.com ([64.233.162.230]:2181 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753512AbXKFWOQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 17:14:16 -0500
Received: by nz-out-0506.google.com with SMTP id s18so1486515nze
        for <git@vger.kernel.org>; Tue, 06 Nov 2007 14:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=4C3dhe9tnPk3rCSxManexksORf8CBYeTQtGM1oHUebU=;
        b=UI5fqBINV/8PcnY6wee+ULmqPwGz62D71O9Z0ol3YFyh/pQbz46uYQ22NQw2d4vejDJ01CA2DCi2dnGsth5lYVxQYu45WvX0teQdV7e8ZmG5sJoqxiqjEv35Lu8ah/NCXamdx6q/BnkbHZrsbiOIGlZzCjvBPM0Sjg85KuZw1Ac=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=pUB82oHiI8II6zcwThLHir0q4z24xX7lLGWowa/bDrEc7exjgeNqiK/g4X6qTyUNtp6b4jbyVxEVPoEvCtuNcAHhkOo1NZhQUvQtIHn4DEb2kxF/fHI+CyzpUrwGDYmh7aqnMN3MkfV12s9cddz6OoQKPIT31iuluzLGryJzoiA=
Received: by 10.115.94.1 with SMTP id w1mr6789804wal.1194387254364;
        Tue, 06 Nov 2007 14:14:14 -0800 (PST)
Received: by 10.114.76.4 with HTTP; Tue, 6 Nov 2007 14:14:14 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63736>

Hi,

the git-rev-list manpage says


**
Diff Formatting
~~~~~~~~~~~~~~~

Below are listed options that control the formatting of diff output.
Some of them are specific to gitlink:git-rev-list[1], however other diff
options may be given. See gitlink:git-diff-files[1] for more options.
**

however, the source code says


	if ((!list &&
	     (!(revs.tag_objects||revs.tree_objects||revs.blob_objects) &&
	      !revs.pending.nr)) ||
	    revs.diff)
		usage(rev_list_usage);

so any attempt at showing diffs with git-rev-list will fail. What's
the deal with this?


-- 
Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
