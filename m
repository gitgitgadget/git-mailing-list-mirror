From: Ethan Reesor <firelizzard@gmail.com>
Subject: Pushing a git repository to a new server
Date: Sun, 10 Feb 2013 16:00:56 -0500
Message-ID: <CAE_TNin0Kb_38gnx9W36VZ8CTxYBZ9T1Dkhar1DUFHyQUq7ebg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 10 22:01:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4e20-00029E-BH
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 22:01:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756486Ab3BJVBS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 16:01:18 -0500
Received: from mail-qe0-f42.google.com ([209.85.128.42]:54513 "EHLO
	mail-qe0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756325Ab3BJVBR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 16:01:17 -0500
Received: by mail-qe0-f42.google.com with SMTP id 2so2366455qeb.1
        for <git@vger.kernel.org>; Sun, 10 Feb 2013 13:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=lta+DtGK73x8QeimTXfYIOkvE74HmS92P1ecWkT/NKU=;
        b=XxTbxDriSPN5arXCIzlngCjJDBzwOQWk0CDHeVY2IpAELqFBjHDJJszY4zG6HLEFA/
         7cZGyWhmrGWI9i2Bvsg+f0IJ6mjPzMY/HOF5eyx335P7Gd7hxTgiwSl7I5fMV49gHDkP
         /wpq7ZHDtuiP4Hmb15JsIlcQs2k6enDDfPJtMlAAGqX7bde7uBvHx5/wYMEqiAiXJVr0
         r/VcdgTdBZAd2SWhalBEZsZYUvXZRSO9TGzjJn1zes39Pbr6iVHF1L7cuq+nudBgAkCB
         pnlf24p9xaI8UbRRRTe8LmRIh/CNGI0y4fRotMhC4WpHiR6Swy5xcfm0dE4OCeoBwXL0
         3SsA==
X-Received: by 10.224.180.212 with SMTP id bv20mr4493110qab.6.1360530076869;
 Sun, 10 Feb 2013 13:01:16 -0800 (PST)
Received: by 10.49.95.225 with HTTP; Sun, 10 Feb 2013 13:00:56 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215932>

I'm looking to make a command to push a git repo to a new server. The
way I just did it is as follows:

localhost> git clone --bare /path/to/MyRepo /path/to/tmpdir/MyRepo.git
localhost> tar xz /path/to/tmpdir/MyRepo.git | ssh myuser@remotehost
tar cz \~/      # If I don't escape '~', my local machine expands it
localhost> ssh myuser@remotehost
remotehost> sudo chown -R git:git MyRepo.git

The reason I had to use my user is the git user's shell is git-prompt
and ~git/git-shell-commands is empty. I have repos set up using
'git@remotehost:MyOtherRepo.git' as the remote and everything works.

How do I make a git command that can talk to the server using
git-prompt like the other commands do?

--
Ethan Reesor
