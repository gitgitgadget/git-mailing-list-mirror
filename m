From: Frank Li <lznuaa@gmail.com>
Subject: http getpass function in msysgit
Date: Wed, 3 Feb 2010 11:18:23 +0800
Message-ID: <1976ea661002021918m19d9b37fx1872557d3c810e3a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org, msysGit <msysgit@googlegroups.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 04:18:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcVl9-0001jO-58
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 04:18:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804Ab0BCDSZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 22:18:25 -0500
Received: from mail-yw0-f198.google.com ([209.85.211.198]:39179 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174Ab0BCDSY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 22:18:24 -0500
Received: by ywh36 with SMTP id 36so863626ywh.15
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 19:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=5yTb80e7ZZ2ZYHHoZiiaPO8haeNCDPH5ksjOpVMRt6k=;
        b=xlXVe+ZibN7FZW6c7McJnDqTG60AA/5i5Y1cUFUY7ItVrJCAhTF76EZLll8+Lcxr4A
         LeOim713F0kI4W8lrYJDeyGowVGX3wfmzq10pbC8k5rF2xIkA3pH4Oh94Co+OHOhzusF
         BziYQtHQT9EwEvfVjh3XK+i20XHTtcpBLb5Ko=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=Cu079oCB00j+WOh5zpAbBJZRe5/z6g8uGOoGz/prnGeFJ8ZXQqHEsLWlqhVE5DR9xp
         B+kwc6BSe9f7hVhlzdIwoStog9JaPTYCaN4N9aEP/s4emXZ7FxJfaY3YQp+t3/Vp7vx4
         hy9GrZXumPfV/Fs7fe5++m1Ap2EgFffbSc9mg=
Received: by 10.150.128.30 with SMTP id a30mr9847243ybd.252.1265167103968; 
	Tue, 02 Feb 2010 19:18:23 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138805>

ALL:

        getpass at mingw.c is direct read character with function _getch().
        GUI application, such tortoisegit will halt when http need
password input because gui don't know git wait for inputing passwords.

        To resolve this problem, I have two options.
        Options 1:
                Check if terminal is exist, if exist, using old
method. Otherwise launch internal password dialog.

        Options 2:
                like openSSH,  Check if terminal is not exist and
environment HTTP_ASKPASS exist, if true, run application which
HTTP_ASKPASS point, otherwise using old ways.

       Which one do you prefer,  I can implement it.

best regards
Frank Li
