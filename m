From: Pete Harlan <pgit@tento.net>
Subject: Regression? Ambiguous tags listed as "tags/<foo>"
Date: Sat, 23 Jan 2016 15:56:12 -0800
Message-ID: <CAAB=nN=RSQuDPdg6Y2heeBXpQVdWSwFAcDDTfxE=XRSOu5gGEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 24 00:56:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aN82T-0006lW-Pp
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 00:56:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752566AbcAWX4P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2016 18:56:15 -0500
Received: from mail-ob0-f180.google.com ([209.85.214.180]:35066 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751711AbcAWX4N (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2016 18:56:13 -0500
Received: by mail-ob0-f180.google.com with SMTP id yo10so65613727obb.2
        for <git@vger.kernel.org>; Sat, 23 Jan 2016 15:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tento-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=4qUu6f8LoaXemqiyNKrDh4X1a+2hhu0jwdUFgLSXSsk=;
        b=DnwuSSIge6OShimkNvOiTL1iv3jqNELRkKUYLaBWSgjTr3R9xEhJ7dTmEpePqcRD3d
         V3sazvrt3F8rnehpwSXj5Sld6/eA0z6uaa1QcqkjEp1F+ydbxiivkw34K17OaLLdyoxG
         S/GnS41XPZXNMxbe9lWTNmcA4sQttjF8PmhAkMeuRnqF9mSsRz/6CO17/M7+rke0zSdH
         OG99vq5oSFjvyJfSErz3pGoUQZ+1+FL4LYDrIYWG5RUZseD7Vbsrc0MFujbp40s0QOpc
         DoOhtDE39jIvRoQk+FCZX95gMJXVoEAaRelgHJsXp9D/19hBcxkjCiNbTZxiJfsbHjV8
         CXAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=4qUu6f8LoaXemqiyNKrDh4X1a+2hhu0jwdUFgLSXSsk=;
        b=lfONmVd9xWPTHbdEEA6LaAE2sP3OJ69fBSlA8Y7YEZLrdHTb3IVS+icGfZx+Nw+Z+t
         nRCsKCKZsPdSG1AokEPU/Eb4sr+D5KnO95IO+uGQFHmk/4m1ilsTV5JveMLfEFrMVXgU
         tHsLH/aDiNQ2wLPxgxm2Ne5JO8GHFQ89w4D0T27sO8lpuzhF1c4XFDH9jbzAOfXRqU6A
         txQAWGoe7TyaiBnD0AHDAP8uW/+HlL4NnMCEtnv0KeNiQ4KbSgOc8Ks//HfFU7kJXzT4
         Sf3pkSXc570k2dK2TEfcsMMCchnwnuFNvgIGtMn7mNT8J2yHgxUC3tyX3AmmYx+vY5SL
         yQnw==
X-Gm-Message-State: AG10YORzF/1BAf/GTi+Zh8UtLEN91fDc/W1dS0GYRyrvjRyA+rq4uQWDQ5SBjs/Y2enLpMBN6znp/8DGiq1Ybrx5
X-Received: by 10.60.232.42 with SMTP id tl10mr8200090oec.69.1453593372707;
 Sat, 23 Jan 2016 15:56:12 -0800 (PST)
Received: by 10.202.192.213 with HTTP; Sat, 23 Jan 2016 15:56:12 -0800 (PST)
X-Originating-IP: [65.78.132.210]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284633>

There was a behavior change in "git tag" in b7cc53e9 (tag.c: use
'ref-filter' APIs, 2015-07-11, v2.5.0-276-gb7cc53e), such that "git
tag" now writes "foo" as "tags/foo" if there is also a branch named
"foo":

    % git tag
    tags/branchortag
    tagonly

Previous behavior:

    % git tag
    branchortag
    tagonly

I prefer the previous behavior.  Perhaps the change was intentional,
but I didn't see it documented.

Thanks,

Pete Harlan
pgit@tento.net
