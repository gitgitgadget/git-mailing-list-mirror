From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 0/9] Introduce publish tracking branch
Date: Fri, 11 Apr 2014 11:15:55 +0200
Message-ID: <vpqtxa0jkfo.fsf@anie.imag.fr>
References: <1397156686-31349-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>,
	John Szakmeister <john@szakmeister.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 11 11:16:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYXZj-0004Uf-HM
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 11:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756137AbaDKJQi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2014 05:16:38 -0400
Received: from mx2.imag.fr ([129.88.30.17]:33271 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755949AbaDKJQf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2014 05:16:35 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s3B9FtsM020858
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 11 Apr 2014 11:15:55 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s3B9FtG8028964;
	Fri, 11 Apr 2014 11:15:55 +0200
In-Reply-To: <1397156686-31349-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Thu, 10 Apr 2014 14:04:37 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 11 Apr 2014 11:15:55 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s3B9FtsM020858
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1397812558.01223@Ec3DEOxUT7puGwlQ9StVxw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246075>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> As it has been discussed before, our support for triangular workflows is
> lacking, and the following patch series aims to improve that situation.

I'm not a heavy user of triangular workflow, so I'm not in the best
position to comment (and I have no time for a real review, sorry).

On overall, I do like the change. I played a bit with it, and do not
understand what "git push" does:

  $ git status
  On branch master
  Your branch is ahead of 'origin/new' by 4 commits.
    (use "git push" to publish your local commits)

=> OK, it's using the publish branch to tell me whether I should push.

  $ git push -v
  Pushing to /tmp/git
  To /tmp/git
   = [up to date]      master -> master
  updating local tracking ref 'refs/remotes/origin/master'
  Everything up-to-date

=> Err, it still pushes to the upstream branch ... Wasn't that the point
of the change to push to publish? Did I do something wrong?


Your series lacks documentation of branch.<name>.* in
Documentation/config.txt.

It seems strange to me to name the config variables "branch.<name>.push"
and "branch.<name>.pushremote" and call the same thing "@{publish}"
elsewhere. We're already not consistant with @{upstream} corresponding
to branch.<name>.merge, but I do not consider it as a good reason to
introduce one more inconsistancy.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
