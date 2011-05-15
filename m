From: Jay Soffian <jaysoffian@gmail.com>
Subject: Reverting a subdirectory of a repo
Date: Sun, 15 May 2011 09:10:29 -0400
Message-ID: <BANLkTikzV7EHyZUqUXqORebjWAkb_PAX6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 15 15:11:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLb69-0000pV-To
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 15:11:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759889Ab1EONLA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2011 09:11:00 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:50960 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753167Ab1EONK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2011 09:10:59 -0400
Received: by pwi15 with SMTP id 15so1768855pwi.19
        for <git@vger.kernel.org>; Sun, 15 May 2011 06:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=SP2U/dZnjlQwNhersUuXNQVpiiNHqQ4T5BD7baN+cBE=;
        b=Busuavc/NQ4qm3YKghHrBbn3NOi0NVeng5DTa4fPs7HlapGtRo01bLXrA+nlYtZDPD
         nxBvbBkU1iFzGgB9FqHUtN9rE/DRO7i81Ha5Jbyw5BHbQc69Y1hfpOC4YGEyaLjMl1RQ
         TD2COjo4GRVw4RwmZ1CeegRQ/9WjTfPEli4Z8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=ha6tA1angga9AlD+5G1iloKXfsprblFREqDAbwHn8y5cN4S9467d8CtVnxGHmm0drn
         PT1k+pJIcINRgTRlyyafLatJAPorZU1t7QAlL8OdWe/mQgdtAbJ1iZSI6Z/fg88vF5FU
         lnr7/kBb7gERuUFq3vLBfawTxRatgdLPsJHVY=
Received: by 10.142.191.6 with SMTP id o6mr2203389wff.312.1305465059063; Sun,
 15 May 2011 06:10:59 -0700 (PDT)
Received: by 10.142.174.16 with HTTP; Sun, 15 May 2011 06:10:29 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173634>

Recently I wanted to revert a subdirectory of a repo to an earlier
state, so I did this:

$ git checkout <revision> -- /path/to/subdir
$ git commit

And I was surprised that the subdir retained files that had been added
since <revision>. To get a clean revert, I had to:

$ git rm -r /path/to/subdir
$ git checkout <revision> -- /path/to/subdir
$ git commmit

And I'm wondering if requiring the "rm" first is bug or a feature. On
the one hand, in retrospect I understand why it's needed, but otoh, it
did catch me off guard the first time.

j.
