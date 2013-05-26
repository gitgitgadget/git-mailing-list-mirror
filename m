From: John Keeping <john@keeping.me.uk>
Subject: Re: git clone does not understand insteadOf URLs
Date: Sun, 26 May 2013 19:14:31 +0100
Message-ID: <20130526181430.GL27005@serenity.lan>
References: <51A11DD0.4040802@svario.it>
 <CA+EOSB=ow9Vc2J8qb3GAp4xj2GgY8qes=5Q-k-rH6VsVLjzCsg@mail.gmail.com>
 <51A24C75.3090100@svario.it>
 <87a9nhhb9c.fsf@hase.home>
 <51A24FF4.4010102@svario.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
To: Gioele Barabucci <gioele@svario.it>
X-From: git-owner@vger.kernel.org Sun May 26 20:14:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgfSy-0004Va-Gr
	for gcvg-git-2@plane.gmane.org; Sun, 26 May 2013 20:14:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754774Ab3EZSOo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 May 2013 14:14:44 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:43615 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754737Ab3EZSOo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 May 2013 14:14:44 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 5D936606502;
	Sun, 26 May 2013 19:14:43 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hdHaAWj+Hizu; Sun, 26 May 2013 19:14:43 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id 822596064EF;
	Sun, 26 May 2013 19:14:40 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 754AD161E26E;
	Sun, 26 May 2013 19:14:40 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Yl2S6WORAJj0; Sun, 26 May 2013 19:14:39 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 3986D161E3D4;
	Sun, 26 May 2013 19:14:32 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <51A24FF4.4010102@svario.it>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225560>

On Sun, May 26, 2013 at 08:09:56PM +0200, Gioele Barabucci wrote:
> Il 26/05/2013 20:00, Andreas Schwab ha scritto:
> >> Simple, I keep all my projects on the same server, so I would like to
> >> refer to that server + path using 'remote-repo'.
> >>
> >> "git+ssh://git.example.org//users/gioele/projects" insteadOf "remote-repo"
> >
> > You can use "remote-repo:" instead.
> 
> Do you mean I could use 
> "git+ssh://git.example.org//users/gioele/projects" insteadOf 
> "remote-repo:"? Yes, but now I have dozens of repositories already set 
> up in various workstations and I do not want to go and change all of them.
> 
> What really bugs me is the fact that `git clone` and `git remote add` 
> parse the same path in different ways. Git already has many 
> inconsistencies. This one can be easily ironed out.

In what way do you think that `git remote add` handles the path?

All `git remote add` does is add a new "remote.<name>.url" entry to the
configuration file with the value as given on the command line.  The
insteadOf mapping will only be applied when you try to fetch from/push
to the remote.
