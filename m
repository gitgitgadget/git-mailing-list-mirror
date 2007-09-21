From: "Chris Moore" <christopher.ian.moore@gmail.com>
Subject: GIT_PAGER=cat git-svn log --> Illegal seek
Date: Sat, 22 Sep 2007 01:40:39 +0200
Message-ID: <a9691ee20709211640q63881718k75ebf416bf5e217f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 22 01:40:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYs74-0005Xj-AN
	for gcvg-git-2@gmane.org; Sat, 22 Sep 2007 01:40:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757327AbXIUXkk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 19:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750987AbXIUXkk
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 19:40:40 -0400
Received: from rv-out-0910.google.com ([209.85.198.186]:30645 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807AbXIUXkj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 19:40:39 -0400
Received: by rv-out-0910.google.com with SMTP id k20so926961rvb
        for <git@vger.kernel.org>; Fri, 21 Sep 2007 16:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=x6dLY9509jFfzKIND1yIipDiq57/CAE8VZ1qYpLPOS8=;
        b=HwOdiVuAmwH5vGIdSQNUndRECzkLdRrKOF2lfsbL9058FgTzfQsvbkHYyHbt4zcakx/U+h6uDBPA0RX/O+5DKKHsJ9Hupe/R8wV/b2/STrKm5T2qzUEESrh8gPmg9/FjF88mw6XtHlYRp7z0fk/VX7vL/eIuy/v9fOSrtdlzijo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=IomDPLrDq3eP4oqvN+SuoWFa2d/1iv5ghdzGtSHJNupwTM/3OWKjUiT8/JEcAdqhBZtVa4SLz/osMkwLhLL+01iAeQ4W2yWqD7/6985gRZA4yuYiqvEeeKBpRGJxXKxrlo5VDT6I3Y408bULXtzQ/jYTDSFKt2cVuuq+K8SxazM=
Received: by 10.115.17.1 with SMTP id u1mr3084134wai.1190418039344;
        Fri, 21 Sep 2007 16:40:39 -0700 (PDT)
Received: by 10.114.235.7 with HTTP; Fri, 21 Sep 2007 16:40:39 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58892>

I run my git commands inside an Emacs *shell* buffer, so I don't want
it running 'less' all the time.  I export GIT_PAGER=cat to stop it.

I just tried a "git-svn log" and it failed:

$ GIT_PAGER=cat git-svn log
Use of uninitialized value in exec at /usr/bin/git-svn line 3451.
Use of uninitialized value in concatenation (.) or string at
/usr/bin/git-svn line 3451.
Can't run pager: Illegal seek ()

I don't get a shell prompt back.  It just hangs.

This is on ubuntu feisty with the ubuntu-backport repositories enabled:

ii  git-core                                     1.5.2.5-2~feisty1
ii  git-svn                                      1.5.2.5-2~feisty1
