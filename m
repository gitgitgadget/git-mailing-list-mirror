From: "Lee Marlow" <lee.marlow@gmail.com>
Subject: Showing changes about to be commited via git svn dcommit
Date: Mon, 28 Jul 2008 16:54:19 -0600
Message-ID: <7968d7490807281554u3954cf51qe2cd87b94284c77f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 00:55:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNbch-00029S-0M
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 00:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752214AbYG1WyV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 18:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752033AbYG1WyU
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 18:54:20 -0400
Received: from rv-out-0506.google.com ([209.85.198.232]:64858 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991AbYG1WyU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 18:54:20 -0400
Received: by rv-out-0506.google.com with SMTP id k40so4715782rvb.1
        for <git@vger.kernel.org>; Mon, 28 Jul 2008 15:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=uGLlo9daet7yQC5sFctu8tO3z4SPkPHq8FRXHgQAB3c=;
        b=nBpKD8GvOeuWTbKmbQ9OlOThQXohXNLvX6aHMXqfPsHgVBee03HiJOmXWK38anV2hL
         QCiADcAl4dPkd8X6UsRwMZNES+JhFTeD459CcT/9Jd+ub8McrJ/OQ62leuxM+mtRZSjd
         4+lwDY29/i61aFAE3CD6haFe6j2js+B3iNsFk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=s4RdPtrHGOnxzJD4O0FCUcBnTq4P6uX6zkbbm53ySdU85pBe80jezJh+Kkxi5leiNR
         5NDyBosXvRrrqvXor0AXuuDi8sdbjN06oNpiIM+DY/mRfTdiOUqEd9EZkNt0hki0hHUa
         vNTUR+vMUO8Lp2nq5LPbVP3IAJYolEDe2CaTc=
Received: by 10.141.156.11 with SMTP id i11mr2639531rvo.1.1217285659740;
        Mon, 28 Jul 2008 15:54:19 -0700 (PDT)
Received: by 10.141.69.4 with HTTP; Mon, 28 Jul 2008 15:54:19 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90518>

git-svners,

I often like to look at the diff of what I'm about to commit before
taking the plunge.  I'd really like an easy way to see a 'git log -p'
output of what would be committed to the central svn repository with a
dcommit.  I found --dry-run and finally made a "one-liner" that
outputs what I want, but it seems like a lot of work for something I
do quite often.  The one-liner I used is:

$> git svn dcommit --dry-run | grep -E '^diff-tree ' | cut -b 11- |
git diff-tree --stdin -p -v

Is this the real way to do it?  Do others do something similar?

Curious and looking for a better way.

-Lee
