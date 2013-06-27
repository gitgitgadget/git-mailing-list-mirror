From: =?UTF-8?Q?Beno=C3=AEt_Person?= <benoit.person@ensimag.fr>
Subject: Re: contrib/mw-to-git/Git/Mediawiki.pm
Date: Thu, 27 Jun 2013 19:54:36 +0200
Message-ID: <CAETqRCif7K3MZiG4oMfnM-jps+KajDMYML4C5Hhy8eE7bj38xA@mail.gmail.com>
References: <51CC6189.6030701@web.de>
	<CAETqRCgctnVqrYaAYn7uZtv0rvQNawUAi513iTeWPufkZPRgAw@mail.gmail.com>
	<vpq4ncjcxt4.fsf@anie.imag.fr>
	<7vzjubsbqj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 27 19:54:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsGP7-000754-Ud
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 19:54:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752773Ab3F0Ryh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jun 2013 13:54:37 -0400
Received: from mail-wg0-f46.google.com ([74.125.82.46]:48783 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752593Ab3F0Ryh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 13:54:37 -0400
Received: by mail-wg0-f46.google.com with SMTP id c11so815348wgh.13
        for <git@vger.kernel.org>; Thu, 27 Jun 2013 10:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=85Sd2iCRtzkFejUPeF2PKEbM57QCc9hoY1nqD+t/o8k=;
        b=f7wCY9T8FxeabBP+GRo47wq5P77XpYg3Ls9zuXtv78rO5/PKJeGXsbkhIOhHkuerrk
         IvDHgWwhuCg+M2F8ysKe3pk1g44iuvRrYD7PC4YH3CHQHU3PbVg7zC6crhfsJcLPWYoY
         L8W+IHPEr+O6N/sB9LueEwNTJ4370kRU8z5kIdCnI57Bm5zuRbKwfQWdQJF/dHZJ6gPg
         rDn6adsHPQdJkQ+ZQQtjiIbapnjjRjdWx+AirdrbfuYq3gIfU4tKxQC+bDeGWWMQlLeM
         7ZXmezdHnZGfqd2TW/wlBgCxY672fuflD9ZHvhSRYgJV2irv0VEvcsu3wCVnrUcZOd1c
         sTtw==
X-Received: by 10.194.243.101 with SMTP id wx5mr7042977wjc.49.1372355676102;
 Thu, 27 Jun 2013 10:54:36 -0700 (PDT)
Received: by 10.216.245.196 with HTTP; Thu, 27 Jun 2013 10:54:36 -0700 (PDT)
In-Reply-To: <7vzjubsbqj.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: 2BRkLGmOywWsz17ZnDN-E_CRym0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229134>

> Hmph.  Does it even need to be in-tree then?  Is it insufficient to
> run ../../git from that directory instead?
Well, the fact is we use Perl packages now (Git.pm and
Git::Mediawiki.pm in contrib/mw-to-git/Git/). The way we build perl
scripts in the toplevel's Makefile makes those packages accessible
only in $GITPERLLIB if it's defined and defaults to $INSTLIBDIR to
seek for installed version of those packages.

We use a bin-wrapper to define that $GITPERLLIB variable so that the
installed version gets bypassed by the one presents in the directory
defined in $GITPERLLIB.

> I just noticed that the script is not strictly a text file, ending
> with an incomplete line, by the way.
an incomplete line ?
