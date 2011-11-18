From: Shawn Ferris <shawn.ferris@gmail.com>
Subject: .git ignored regardless of --git-dir value
Date: Fri, 18 Nov 2011 13:56:56 -0700
Message-ID: <CAC2kKA_PZNDg_dPjWXKeFU4ZVpMas3PubZfSgTnfCfVPuNPdsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 21:57:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRVUb-000403-PA
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 21:57:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753511Ab1KRU45 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Nov 2011 15:56:57 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:43061 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300Ab1KRU44 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2011 15:56:56 -0500
Received: by vbbfc21 with SMTP id fc21so593494vbb.19
        for <git@vger.kernel.org>; Fri, 18 Nov 2011 12:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=7panC9w47axTulHLbGNohZ0yqZ90b6HFZO3gbJtLkyo=;
        b=g+1GhLuClX2Mg/HuBAKDAAyeOydYhlhXbGwgwmgTZvbBEFOyV/wC/S2E7OK6shBKa+
         I/hhWP4tfDSmgMeobIJPcmWa5IOz2Gx3BQV0frFDRXDlNcI+CMk4KxXjP5iM9QnlDmam
         LoihILYedIKm+q9OqwZt54kCstOyKUzIMJ6C0=
Received: by 10.52.68.240 with SMTP id z16mr5012185vdt.120.1321649816164; Fri,
 18 Nov 2011 12:56:56 -0800 (PST)
Received: by 10.220.227.3 with HTTP; Fri, 18 Nov 2011 12:56:56 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185678>

Hi All --

Is it expected behavior to have the .git directory ignored, even after
specifying an alternate location with --git-dir? For example:

$ git --git-dir=.foo init
Initialized empty Git repository in /home/sferris/work/t/.foo/

$ mkdir .git
$ touch .git/filea

$ git --git-dir=.foo --work-tree=. add .

$ git --git-dir=.foo --work-tree=. status
# On branch master
#
# Initial commit
#
# Changes to be committed:
#   (use "git rm --cached <file>..." to unstage)
#
#    new file:   .foo/HEAD
#    new file:   .foo/config
#    new file:   .foo/description
#    new file:   .foo/hooks/applypatch-msg.sample
#    new file:   .foo/hooks/commit-msg.sample
#    new file:   .foo/hooks/post-update.sample
#    new file:   .foo/hooks/pre-applypatch.sample
#    new file:   .foo/hooks/pre-commit.sample
#    new file:   .foo/hooks/pre-rebase.sample
#    new file:   .foo/hooks/prepare-commit-msg.sample
#    new file:   .foo/hooks/update.sample
#    new file:   .foo/index.lock
#    new file:   .foo/info/exclude
#
# Changes not staged for commit:
#   (use "git add/rm <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#    deleted:    .foo/index.lock
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#    .foo/index
#    .foo/objects/

Notice that .foo was added, but .git was ignored. I would have
expected .foo to be ignored and .git to be added? (right, wrong or
indifferent..)

Thanks for any info!

Shawn
