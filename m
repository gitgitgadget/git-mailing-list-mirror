From: Francis Moreau <francis.moro@gmail.com>
Subject: git-cherry doesn't detect a "copied" commit
Date: Tue, 20 Oct 2015 18:32:12 +0200
Message-ID: <CAC9WiBhM4edBFCYx35xZJB79AZWo49mkO-Pxnb1q4aLDmBufWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 20 18:32:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZoZpj-0004eD-OU
	for gcvg-git-2@plane.gmane.org; Tue, 20 Oct 2015 18:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752552AbbJTQcP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2015 12:32:15 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:36031 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752203AbbJTQcM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2015 12:32:12 -0400
Received: by ioll68 with SMTP id l68so28204657iol.3
        for <git@vger.kernel.org>; Tue, 20 Oct 2015 09:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=BLuzoF+BfZjGdwmFYoYsKBLsplc1pf50OYKFi2xF+UQ=;
        b=x02iTP25EPaZgeIsx+rthWcYYKlbQrGeciBBhEwJv1WOO/UuulNAcsZpygrpKi/9AU
         RZrOoODkViV64VdDeOAoSr7QhlB/6HzwkLtV5rRS4vr5bF6SH3/HSZ5Z6OtyQn1QEbhg
         PMWWeHc3ghMkRm+XTmfBM4kUaoEWi3qb4KGCkk2Xg9kBemmAQjZLFO1wh/Q/wySVMEN2
         ohF1arCOJSndbiGmiu9wlL0T+6S+/UGnJysQ3krtNTOzO9j7i4JlsJ4enFgyITLpQzNS
         +mNH3uIxoYNJNHp72RC/HKhelHPS+k1ad/DLd0+ucdfykAxK2auAzXMc46dZigMK5Mxp
         JD6g==
X-Received: by 10.107.46.228 with SMTP id u97mr4688621iou.165.1445358732254;
 Tue, 20 Oct 2015 09:32:12 -0700 (PDT)
Received: by 10.79.77.1 with HTTP; Tue, 20 Oct 2015 09:32:12 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279922>

Hi,

I'm seeing something odd with git-cherry: it doesn't seem to detect
that a commit has been cherry-picked from master branch.

This happens with the systemd git repository (from github) so it
should be fairly simple to reproduce.

What I did:

$ git --version
git version 2.6.0
$ git checkout -b foo v210
$ git cherry-pick -x 9ea28c55a2488e6cd4a44ac5786f12b71ad5bc9f
$ git branch --contains 9ea28c55a2488e6cd4a44ac5786f12b71ad5bc9f
master
$ git cherry master HEAD
+ fef60bf34d1b372bea1db2515a8d936386dfc523

so git-cherry tells me that the cherry-picked commit has not
equivalent in master, which is no the case.

What am I missing ?

Thanks
-- 
Francis
