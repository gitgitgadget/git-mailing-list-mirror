From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: stg branch -r instructions
Date: Mon, 17 Mar 2008 13:14:07 +0100
Message-ID: <87d4ptczu8.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 13:14:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbEEb-000458-Oe
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 13:14:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753122AbYCQMNw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Mar 2008 08:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753164AbYCQMNw
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 08:13:52 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:47455 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753071AbYCQMNv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2008 08:13:51 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id B882D200A251;
	Mon, 17 Mar 2008 13:13:49 +0100 (CET)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 12975-01-29; Mon, 17 Mar 2008 13:13:46 +0100 (CET)
Received: from krank (unknown [87.96.142.66])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 3EBC5200A232;
	Mon, 17 Mar 2008 13:13:46 +0100 (CET)
Received: by krank (Postfix, from userid 1000)
	id 9DCD17B40A1; Mon, 17 Mar 2008 13:14:07 +0100 (CET)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77429>

It isn't easy to figure out how to rename a branch in stg from looking
at the help texts.

  Usage: stg branch [options] branch-name [commit-id]

  ...

    -r, --rename          rename an existing development branch

So, how do I rename branch A to B?

Reading the source, it appears that you write

  stg branch -r A B

so, the usage string is wrong. In fact, the described usage string is
only for the default action to create a new branch.

The optparse library doesn't really make it easy to describe these
kinds of options-as-subcommands, so I don't have a patch to fix it
right away. I'm not even sure how the result should look.

Maybe it would have been better to have separate stg subcommands?

  stg branch NAME [COMMIT]
  stg list-branches
  stg rename-branch OLD NEW
  ... etc ...

--=20
David K=C3=A5gedal
