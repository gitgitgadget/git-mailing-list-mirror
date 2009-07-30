From: Jeffrey Middleton <jefromi@gmail.com>
Subject: exec-path behavior
Date: Thu, 30 Jul 2009 12:00:29 -0500
Message-ID: <4389ce950907301000m5b264771jf87cc06398bee7e0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 30 19:01:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWYzz-0006aL-C8
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 19:00:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577AbZG3RAw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Jul 2009 13:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbZG3RAw
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jul 2009 13:00:52 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:34156 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335AbZG3RAv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Jul 2009 13:00:51 -0400
Received: by ewy10 with SMTP id 10so910096ewy.37
        for <git@vger.kernel.org>; Thu, 30 Jul 2009 10:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type:content-transfer-encoding;
        bh=gSgnmlkJdbjsy73EgcDzYT9G2nVQyykX+gsqe+G67Xs=;
        b=ozVo/gssB1qXxsQcHEERAyn1JxqMsik1IukBKAOvmd97huJ2zWDGonWnB/Dwb7+i5I
         FJ/Oau1oSNUkz6lPc4lro4pD5+thKezdR1HszW/5YFDQs15XkFoKxB17KoIBbYZgO2Ut
         P05fa1X9VfUW57e+o8owUBxE5XQLXhLeeGt2E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=pu7wGUKKi4ZcU+l2XcVYv5l2fLsn3zH8r/O6zH/DF5oJUwHs/VKmS7ZIhlEeso4j+i
         FSwm/VTVA5ZlZSudQVuKKWQRuoIuRBA6dxYiL9M2y7rcj96DQn1fyb9EFf6joivs43J+
         k/SVhJdUSQ6/eqmoaBa52HKfdjCYoOvgwkPa0=
Received: by 10.211.194.4 with SMTP id w4mr1756326ebp.46.1248973249118; Thu, 
	30 Jul 2009 10:00:49 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124470>

I'm wondering about the intended behavior of the
--exec-path/GIT_EXEC_PATH option - is it supposed to override or add
to the built-in path?=A0 It seems to do some of both.

$ git --exec-path=3Dfoo rebase
git: 'rebase' is not a git-command. See 'git --help'.

but:

$ git --exec-path=3Dfoo status
# On branch master
nothing to commit (working directory clean)

There are plenty of commands in each category, and it's not
immediately obvious to me what criteria separate them.=A0 Not a huge
problem, since it's easy enough to use --exec-path=3Dfoo:<normal-path>,
but I was in the process of adding support for exec-path to the bash
completion, and it's an important distinction there - and much easier
if it adds to the built-in, of course.


Thanks,
Jeffrey
