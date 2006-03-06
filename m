From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH] git-blame: Use the same tests for git-blame as for git-annotate
Date: Mon, 6 Mar 2006 13:29:32 +1300
Message-ID: <46a038f90603051629ke34a0a6u89dad995bbd777b0@mail.gmail.com>
References: <20060305111334.GB23448@c165.ib.student.liu.se>
	 <440B751F.5000801@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Fredrik Kuivinen" <freku045@student.liu.se>, git@vger.kernel.org,
	junkio@cox.net
X-From: git-owner@vger.kernel.org Mon Mar 06 01:29:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FG3bY-0001eS-6I
	for gcvg-git@gmane.org; Mon, 06 Mar 2006 01:29:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbWCFA3e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 19:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbWCFA3e
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 19:29:34 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:16189 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750837AbWCFA3d convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Mar 2006 19:29:33 -0500
Received: by wproxy.gmail.com with SMTP id 71so1038921wra
        for <git@vger.kernel.org>; Sun, 05 Mar 2006 16:29:33 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=A6BrijaXRXp/+lrpzisCQTfld55EHTTctXsyb5wnnLP3Zv7TvaBc0NK9VobbvrNbLYtEOC9nBFU1uMNN2X0WyOVaUlHcivS9zM7S/DT5MGrIDhZi/DRZuVgOJRInW5nLK52OqdPvYVZ3bV2ZF6+zWcvQXnoT+EzVmrqpyYuVVpU=
Received: by 10.54.116.18 with SMTP id o18mr646861wrc;
        Sun, 05 Mar 2006 16:29:32 -0800 (PST)
Received: by 10.54.71.5 with HTTP; Sun, 5 Mar 2006 16:29:32 -0800 (PST)
To: "Ryan Anderson" <ryan@michonline.com>
In-Reply-To: <440B751F.5000801@michonline.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17254>

On 3/6/06, Ryan Anderson <ryan@michonline.com> wrote:
> Along these lines, if anyone can pin down the complicated cases that
> annotate and blame get differently, adding them as a test would be
> *exceedingly* appreciated, even if it makes annotate (or blame) fail for
> a bit, it gives us something to work against.

It would be great if they both worked properly with paths that existed
in the past. Right now, I can't git-annotate or git-blame a file I
know was there in a past revision. I think I had taught Johannes'
annotate to deal with this, or at least intended to. As things stand,
git-annotate/git-blame need a checkout, which is really silly.

Tools like gitweb and cvsserver should be able to do:

  GIT_DIR=/somebarerepo/git.git git-(annotate|blame) -h headname Makefile

and not worry about creating a temporary index *and* checking out
Makefile so that things work. That's what cvsserver does now, anyway.
Ugly :-(

cheers,



m
