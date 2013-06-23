From: John Keeping <john@keeping.me.uk>
Subject: Re: fast-import bug?
Date: Sun, 23 Jun 2013 15:55:03 +0100
Message-ID: <20130623145503.GH4676@serenity.lan>
References: <m2zjuj2504.fsf@cube.gateway.2wire.net>
 <20130622102157.GE4676@serenity.lan>
 <m2txkp1shb.fsf@cube.gateway.2wire.net>
 <20130623110933.GG4676@serenity.lan>
 <m2ppvc29le.fsf@cube.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Dave Abrahams <dave@boostpro.com>
X-From: git-owner@vger.kernel.org Sun Jun 23 16:55:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqlhG-0005zZ-Rm
	for gcvg-git-2@plane.gmane.org; Sun, 23 Jun 2013 16:55:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505Ab3FWOzP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Jun 2013 10:55:15 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:34278 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191Ab3FWOzN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jun 2013 10:55:13 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 4BF5C6064D7;
	Sun, 23 Jun 2013 15:55:11 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -10.999
X-Spam-Level: 
X-Spam-Status: No, score=-10.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wd7gCu7lOgFx; Sun, 23 Jun 2013 15:55:10 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id D44796064D6;
	Sun, 23 Jun 2013 15:55:10 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id CAB2D161E3F1;
	Sun, 23 Jun 2013 15:55:10 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sWygvyRJFqxq; Sun, 23 Jun 2013 15:55:10 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 34559161E3FB;
	Sun, 23 Jun 2013 15:55:05 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <m2ppvc29le.fsf@cube.gateway.2wire.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228740>

On Sun, Jun 23, 2013 at 07:19:25AM -0700, Dave Abrahams wrote:
> on Sun Jun 23 2013, John Keeping <john-AT-keeping.me.uk> wrote:
> > In this case, I think I do now understand why the mode is 0: in
> > parse_ls a new tree object is created and the SHA1 of the original is
> > copied in but the mode is left blank; clearly this should be set to
> > S_IFDIR when the SHA1 is non-null.
> >
> > I think the patch I now have is correct (and addresses the "copy from
> > root" scenario), but I need to spend some time understanding t9300 so
> > that I can add suitable test cases.
> 
> t9300?  

t/t9300-fast-import.sh in Git's source tree - it's where the tests for
fast-import live.

> Thanks; I'll try this one too.

Thanks.  I now have a patch series incorporating this which also adds a
few tests for handling of empty paths.  I'm sending it out in the next
few minutes.
