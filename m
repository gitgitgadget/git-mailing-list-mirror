From: "Jonathan Blanton" <jonathan.blanton@gmail.com>
Subject: malloc fails when dealing with huge files
Date: Wed, 10 Dec 2008 10:42:29 -0500
Message-ID: <43c10b980812100742t3a65466yb9b7310bfedb2b18@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 10 16:44:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LARET-0002ff-7o
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 16:44:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755587AbYLJPmf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 10:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753218AbYLJPmf
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 10:42:35 -0500
Received: from mail-qy0-f11.google.com ([209.85.221.11]:53523 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755558AbYLJPme (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 10:42:34 -0500
Received: by qyk4 with SMTP id 4so770741qyk.13
        for <git@vger.kernel.org>; Wed, 10 Dec 2008 07:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=poeK+VRQaQk0D5dC1WQ5La+y8Yvg9iOBX1VexThYQy4=;
        b=K3vlU9K9u0CkuuoeMWyh5rj9BSe+5D5E20sURJrAh3y9Iq0J8YOlm7BO3A0HNuh/2Y
         xnh83QsXkIPDM6TYQOK5XdiH5lsNQy96dYnZpn3bzymGkix/F4ZNT73U0AuiEnJKfthD
         Mce+dBSkCdcCeqBj9gJrDDcb3pDUNCgrc3kVc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=WuKfRY1nMLSI5lT5Mu697dnIRBYA1vC5BOIn0EejHY1SM9IrtO7EM62t8pMMmZkur7
         MVb1FupldrwcSCphYCSo03Q3LzH7wWuukNXNqBwAGVtFC0ewj23MesJCbDL3M9CTyF7i
         MINbQsh6BmqxJ4Tc+ceb31nY3EyAggzlpyP2E=
Received: by 10.143.12.20 with SMTP id p20mr275651wfi.169.1228923749901;
        Wed, 10 Dec 2008 07:42:29 -0800 (PST)
Received: by 10.142.210.2 with HTTP; Wed, 10 Dec 2008 07:42:29 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102693>

I'm using Git for a project that contains huge (multi-gigabyte) files.
 I need to track these files, but with some of the really big ones,
git-add aborts with the message "fatal: Out of memory, malloc failed".
 Also, git-gc sometimes fails because it can't allocate enough memory.
 I've been using the "--window-memory" option to git- repack to work
around the git-gc problem, but I don't know of a similar trick for
git-add.  Is there any way (aside from adding more memory, of course)
that I can deal with these huge files?  I'm using git 1.5.6.2 on
Debian 4.0.

Thanks in advance.

Jonathan Blanton
