From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Announce: gitbuilder, an autobuilder for git-based projects
Date: Sat, 30 Aug 2008 23:07:17 -0400
Message-ID: <32541b130808302007r3d570aa8ka221f210251944ba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git mailing list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 31 05:08:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZdIg-0006BG-9S
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 05:08:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755501AbYHaDHV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 23:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755005AbYHaDHU
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 23:07:20 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:18103 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754829AbYHaDHU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 23:07:20 -0400
Received: by yw-out-2324.google.com with SMTP id 9so164369ywe.1
        for <git@vger.kernel.org>; Sat, 30 Aug 2008 20:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=2bfFF6gxGiZueqlHLBkflJjWqQ16eFmlHw0eDiaYSmc=;
        b=LAFUQi096rXiGJqSquBKq6aWSp9Z9G2wMqpOcS3SvZu1BVu2AT/AnmjcdH1hbVPkpa
         1vsBUtzM7VdS2GvBkFG8j7Q4X3Uj98E3ZJnxs126PKK8JRrDelTQp6/By8jhRKnTCUtd
         1/jqM71jTgXtaU51Ky60Ev69FVZO25dZzSVpE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=malgQ+AmtpErIEof4INgtE45rXv9dPokieTQwYb6hYSJUK4w3LHCOPoCPwnmdiRqWL
         zNPDN0gqQdPY21AoSvhFLoQTKFK51XqrgQ7NgmahKA9evZuviyvVlQufE99jeC2LrEZu
         HkqiHs07GoX8sPyDUBuJfD8zXzvemuBdA0Siw=
Received: by 10.151.113.5 with SMTP id q5mr6670127ybm.37.1220152037663;
        Sat, 30 Aug 2008 20:07:17 -0700 (PDT)
Received: by 10.150.96.5 with HTTP; Sat, 30 Aug 2008 20:07:17 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94449>

Hi all,

I recently made the first public release of gitbuilder, a set of
relatively simple scripts for automatically building your favourite
git-hosted project, optionally running unit tests, and reporting
pass/fail results.  In case of failures, it automatically uses "git
rev-list --bisect" to try to track down the first commit that started
failing.  It's also smart about branches; it knows how to build each
commit only once, no matter how many branches include it, thus greatly
simplifying future bisections.

You can also get an RSS feed of the autobuilder results in case you
want live updates as things happen.

To find the scripts, see here:
http://github.com/apenwarr/gitbuilder/

And to see a sample autobuilder for git.git that I've been running at
work, check this out:
http://versabanq.com/demo/gitbuild/

(Note: the autobuilder you'll find here fails to build the html, todo,
and man branches (unsurprisingly) and also had some trouble with the
1.5.4 series because I don't have msgfmt installed.  I can fix these
up on my end, but I suppose it's illustrative to look at the output
as-is and see how the bisection gets displayed :))

I plan to leave this copy of the autobuilder up as a sample.  If there
are other interesting (more experimental?) git.git repositories I
should fetch from and add to the autobuilder, please feel free to let
me know.

I set up the same autobuilder tool for a couple of our projects at
work, which have more interesting output since our developers are
somewhat less careful to make sure the tests pass before committing.
git.git is a bit boring to look at because Junio is apparently so good
at his job.

Does anyone else find this useful? :)

Have fun,

Avery
