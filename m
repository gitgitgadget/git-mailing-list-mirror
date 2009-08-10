From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: backups with git
Date: Mon, 10 Aug 2009 19:08:49 +0530
Message-ID: <2e24e5b90908100638m797ccf8ei8437714952b4f2d5@mail.gmail.com>
References: <41CB836B-6057-448E-805F-F25EAF765D27@roalddevries.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Roald de Vries <rdv@roalddevries.nl>
X-From: git-owner@vger.kernel.org Mon Aug 10 15:44:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaVAq-000551-2d
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 15:44:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754749AbZHJNoW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 09:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754732AbZHJNoW
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 09:44:22 -0400
Received: from mail-yw0-f193.google.com ([209.85.211.193]:35076 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754731AbZHJNoV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 09:44:21 -0400
X-Greylist: delayed 328 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Aug 2009 09:44:20 EDT
Received: by ywh31 with SMTP id 31so3878346ywh.4
        for <git@vger.kernel.org>; Mon, 10 Aug 2009 06:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Cv8ZZvIYjzQVwuJ7o5PVk++/WRQ7N2P12nxS58eIOtw=;
        b=HaEeh+MWjq1VRYFKM1duT3XejFk8U9e2oRWglWxM8nBdYkiqVBlY5D5p+3aOU80PQn
         OY40WkN73RWBdwQaHdo5BKFj4lKJvg5M/+eh6VRF/D0DXOMu0uUDXkEq+yXfNqF1LQ2A
         Q02AmaH18/u1IjiHbY+2grAgc+k9qxNtJDyu8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bH8TRMl399/b4oxDTBTAy1ugiQ34x5eXH5BbRaZI9JiLtycaWsqe4D6HehiiPKB42k
         wZOlZGMsBn2ENTYz0uuRo9Jok3DEbZP1B/pHGumY3LO28FdEOAdY97HtYXW502MyN70B
         rHpNYkxDtmi91WHHWPINRboWDag0l5ZLfH9Z0=
Received: by 10.231.32.134 with SMTP id c6mr1560175ibd.34.1249911529713; Mon, 
	10 Aug 2009 06:38:49 -0700 (PDT)
In-Reply-To: <41CB836B-6057-448E-805F-F25EAF765D27@roalddevries.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125443>

On Mon, Aug 10, 2009 at 1:57 PM, Roald de Vries<rdv@roalddevries.nl> wrote:

> I'm thinking of using git as a backup solution for my whole system, setting
> my $GIT_DIR to something like "/backupdisc/backup". Does that seem sensible?

The two questions you have to ask yourself are: will I ever branch and
merge in this "repo", and do I really want versions from weeks and
months ago?

A "no" to the first question means you're essentially using a very
powerful VCS as a mere backup system.  I suggest rdiff-backup or (if
it's mature enough now, not sure) duplicity..

A "no" to the second question means you're needlessly keeping lots of
old data, and have to jump through hoops to get rid of it if you need
to.

There's a limit to how much you can Macgyver git into doing what it is
not intended for :-)

Having said all that, I do use git to manage parts of my $HOME that do
satisfy those constraints (config files, ~/bin, etc) -- I do sometimes
branch and merge, and I do want really old versions.  I do this by
putting all of them in a repo, and symlinking them to $HOME.

Regards,

Sitaram
