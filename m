From: "Constantine Plotnikov" <constantine.plotnikov@gmail.com>
Subject: Bug: UTF-16, UCS-4 and non-existing encodings for git log result in incorrect behavior
Date: Wed, 12 Nov 2008 16:32:23 +0300
Message-ID: <85647ef50811120532h778769ddx69f0b111dbad359a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 12 14:36:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0FtS-0003t8-43
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 14:36:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898AbYKLNc0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 08:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751937AbYKLNc0
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 08:32:26 -0500
Received: from fk-out-0910.google.com ([209.85.128.188]:34907 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751587AbYKLNcZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 08:32:25 -0500
Received: by fk-out-0910.google.com with SMTP id 18so440052fkq.5
        for <git@vger.kernel.org>; Wed, 12 Nov 2008 05:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=yvjwjpNg1MDKO/dQMUyw3YfiY9WNWHvNiVUJLvFtquA=;
        b=VlalJl7npGqt25P2/TSPvl+RHFNj2VGeiA8nbF9/jrr6a21Q7XwCWIFTa1SIjjktAJ
         CS29WyEBQmuQDn7iPTr7nJONUC4LS1GIChd9fDyRpoBppTI8Y3+4p6rLXU4dSZKgdCKT
         cWKT00slCPl30i5oTQNnAiEEnxWq2YetE0FPA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=ZwsvNGR4aX94lxrftUQ8iWf7WspvANC7Sv/8RqtgrPKgInHbeLd+XinVnbBKrJhPz9
         LktAIUu1KsCwA3b8RDUMZ/4xLLHWwQGLpKlVdJBe1bwYhDhUceb6ssPmlFrONkGQ7O0z
         Ixw2PFjWp6nfaB/ja+OE8JVNzHJwIru4J3du0=
Received: by 10.181.214.13 with SMTP id r13mr2837739bkq.202.1226496743932;
        Wed, 12 Nov 2008 05:32:23 -0800 (PST)
Received: by 10.180.230.10 with HTTP; Wed, 12 Nov 2008 05:32:23 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100748>

If UTF-16[BE|LE] or UCS-4[BE|LE] encodings are used with git log, the
git completes successfully but commit messages and author information
are not shown. I suggest that git should fail with fatal error if such
zero producing encoding is used.

If the incorrect encoding name is used, the git log does not perform
any re-encoding, but just display commits in their native encoding. I
suggest that git should fail with fatal error in this case as well.

Regards,
Constantine
