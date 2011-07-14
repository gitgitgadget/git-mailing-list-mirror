From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-archive and tar options
Date: Thu, 14 Jul 2011 14:38:05 -0700 (PDT)
Message-ID: <m3k4bka6jb.fsf@localhost.localdomain>
References: <ivla29$liu$1@dough.gmane.org>
	<20110714015656.GA20136@sigill.intra.peff.net>
	<4E1F2468.6080409@lsrfire.ath.cx>
	<20110714172718.GA21341@sigill.intra.peff.net>
	<7vei1s36bl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	=?iso-8859-15?q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 14 23:38:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhTbr-0000cy-3l
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 23:38:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371Ab1GNViJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 17:38:09 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:39108 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932232Ab1GNViI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 17:38:08 -0400
Received: by fxd18 with SMTP id 18so1638372fxd.11
        for <git@vger.kernel.org>; Thu, 14 Jul 2011 14:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=IggmTfqzSvVCjAIZUy6jSgVRJ4UNf+c9/NJ2Iw4hDRg=;
        b=vHjiufg4hlbzT/OX8f5dCZCc917fkmKoFuWEqLueUBqYMevK1Zc5CbpVta/JnEbwJ+
         uJjsS0OSQ+tLuojCGgU0H9hgpTi5lHdPiKLLI2C3ORJYFUs5BXnCYE3BWA5wToDjcJ6D
         iG5vi0ISoqCl3igs9Np7gFSKDxBFGXttbP9Sg=
Received: by 10.223.144.140 with SMTP id z12mr4157444fau.147.1310679487225;
        Thu, 14 Jul 2011 14:38:07 -0700 (PDT)
Received: from localhost.localdomain (abva152.neoplus.adsl.tpnet.pl [83.8.198.152])
        by mx.google.com with ESMTPS id a24sm363508fak.36.2011.07.14.14.37.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Jul 2011 14:38:05 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p6ELbEOr006500;
	Thu, 14 Jul 2011 23:37:24 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p6ELaeJR006482;
	Thu, 14 Jul 2011 23:36:40 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vei1s36bl.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177181>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
> 
> > Couldn't you also do:
> >
> >   git archive --prefix=$prefix HEAD:$subdir >my.tar
> >
> > ? I guess that loses the pax header with the commit sha1 in it, though,
> > because you are feeding a straight tree instead of a commit.
> >
> > We didn't when git-archive was written, but these days we have
> > get_sha1_with_context to remember incidental things about an object we
> > look up. It should perhaps remember the commit (if any) we used to reach
> > a treeish, and then the above command line could still insert the pax
> > header.
> 
> Why?
> 
> The tree you are writing out that way look very different from what is
> recorded in the commit object. What's the point of introducing confusion
> by allowing many tarballs with different contents written from the same
> commits with such tweaks all labelled with the same pax header?
 
Perhaps pax header should contain <commit-id>:<subdir> then?
Just a thought.

-- 
Jakub Narebski
