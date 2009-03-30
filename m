From: Aaron Davies <aaron.davies@gmail.com>
Subject: newb questions: post-cherry-pick status cleanup, shared local 
	repository permissions
Date: Mon, 30 Mar 2009 11:03:28 +0800
Message-ID: <c4e763ac0903292003j22934e7ax9f9ae986bdcd6abb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 30 05:05:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lo7o7-0001FC-UL
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 05:05:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756899AbZC3DDb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2009 23:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756868AbZC3DDb
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 23:03:31 -0400
Received: from mail-gx0-f160.google.com ([209.85.217.160]:50267 "EHLO
	mail-gx0-f160.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756502AbZC3DDb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Mar 2009 23:03:31 -0400
Received: by gxk4 with SMTP id 4so3981181gxk.13
        for <git@vger.kernel.org>; Sun, 29 Mar 2009 20:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=4nuuFJIleZsiA6v5ZzRU6iU992FCc60IIVJw5CNTQlk=;
        b=T8p6iFDrIZop+SK0qwVvjyeVwuhXv3xtMfTAmSFxM5h0KWL0w6ivFLiYf8+J2DOJZS
         /1ZLn5x4Z5oN4Garg56fNlc95KKg4xptwT+HdRXT+6GqcV/w5NKr6cTqWMjR4q4QCOUI
         5O5oa23c/bVxEt3hpEPTavGcFAXXAs7rZxN/k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=SpSG16YNYjBeRiS6J/lOBV6Pe9rp+zsrND0Foydtc1t6JhVxfsxPBq3J/e04dOHADn
         Bani3HOgUi4G+wvXmc3W2P3ENO/V/Y6ZTR9jMgNPNtSJKZXPT13LwXhr+M0Y242K0Zkc
         Nn5kQmiS5o4cHvpKChrxxdxeVrI0gkMfzBh28=
Received: by 10.150.156.5 with SMTP id d5mr1938906ybe.119.1238382208810; Sun, 
	29 Mar 2009 20:03:28 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115055>

hi, i'm new to git, and have a couple questions which are probably
very stupid and/or indicate that i've been doing it wrong.

first, a couple words about my setup/workflow: i'm currently sole
developer on a project which may at some point get some other coders.
the environment is three linux boxes, one for development and two for
production, and three accounts, mine, dev, and prod. all homedirs are
hosted on the network and are accessible from all three boxen.

i have a "central" (i.e. bare) repository stored in dev's homedir, and
regular copies in all three homedirs. the language involved is
interpreted, so the code tree is the deployment.

my main workflow is to hack on a branch in my homedir, then merge and
push when i have a feature ready. then i go to the dev account and
pull, which constitutes dev deployment. once it's thoroughly tested, i
do the same in the prod account.

now, the questions: an exception to this workflow occurred a couple
months ago, when i made some urgent bugfixes that needed to move to
prod before other stuff that was currently being tested in dev. this
was done via cherry-picking some specific commits into prod. now, in
prod, when i do "git status", it says "# Your branch is ahead of
'origin/master' by 8 commits." is there an easy way to get rid of
this? last time i tried it on my own, i attempted some sort of push
from prod back to dev, wiped out most of the changes since those
cherry-picks, and had to recover by restoring my repository from
backup.

second, the ownership structure i currently have for the "central"
repository feels wrong to me--the whole thing is owned by my personal
account, depsite being hosted in dev's account. since i'm the only one
who ever pushes into it, this is not currently a problem, but it's
caused permissions issues on the rare occasions i've tried to push
from other accounts (e.g. prod, above), and will presumably cause many
more if anyone else ever starts coding on this project.

advice?
-- 
Aaron Davies
aaron.davies@gmail.com
