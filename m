From: Jacek Masiulaniec <jacekm@dobremiasto.net>
Subject: git status -s -v: no override
Date: Fri, 15 Apr 2011 22:34:55 +0100
Message-ID: <BANLkTimKO7ihPpJ80Ad1kbYaMv1ycu0y9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 23:35:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAqfQ-0004kX-PQ
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 23:35:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757256Ab1DOVe5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2011 17:34:57 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:38922 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757160Ab1DOVe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2011 17:34:56 -0400
Received: by gyd10 with SMTP id 10so984652gyd.19
        for <git@vger.kernel.org>; Fri, 15 Apr 2011 14:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:date:x-google-sender-auth
         :message-id:subject:from:to:content-type;
        bh=ABT6ykTrRv1TMEn0li79ISOAR0j+qIzZ5aP/ptmUglg=;
        b=S9jeACgmmIFF/c8SiYm5CAbGSJSJ8IUzvuCt+QoX6UhPUTCZqY0QPVvKFEE5j2QfVu
         V9YoDuCbliegCQKFmt/yJfGfFi+umwnlsH/jFkwVCBNtd8pmRFjQgqIxNFg7m7AqAjEA
         K/1KcumJs2Lktv21ViDTxtSm5IlDD9qXVSeu8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        b=ItdKYx+IXDGEJA5/G1T/a1YKsGqqX+++ibKdhZh/ffJ651TW8cA7irSoxNvy/dFrlP
         d2+kTxUxoi8FhjOLK8f9gftIIuh5UIuuexwwwt5Kb8Moy0tDdISD27K1jHB/ngwVpHJu
         vBQd61xs4bIDEvSyUEeuEOK3USXS9G3TjDrZ8=
Received: by 10.42.162.135 with SMTP id y7mr3501359icx.128.1302903295260; Fri,
 15 Apr 2011 14:34:55 -0700 (PDT)
Received: by 10.231.17.71 with HTTP; Fri, 15 Apr 2011 14:34:55 -0700 (PDT)
X-Google-Sender-Auth: SDwFIaCijvoBULKI93Yyr83seXI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171642>

Hello git@,

Small git-status argument processing issue:

[jacekm@localhost test]$ git init
Initialized empty Git repository in /private/tmp/test/.git/
[jacekm@localhost test]$ git status -v
# On branch master
#
# Initial commit
#
nothing to commit (create/copy files and use "git add" to track)
[jacekm@localhost test]$ git status -s
[jacekm@localhost test]$ git status -v -s
[jacekm@localhost test]$ git status -s -v
[jacekm@localhost test]$

Things look consistent until the last command: -v does not override -s,
which is unexpected given that -s does override -v.

Jacek
