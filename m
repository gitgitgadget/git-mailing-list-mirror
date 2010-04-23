From: Ulrich =?utf-8?B?U3DDtnJsZWlu?= <uqs@spoerlein.net>
Subject: Re: SVN to Git: trunk moved during repository history
Date: Fri, 23 Apr 2010 17:12:35 +0200
Message-ID: <20100423151235.GZ92627@acme.spoerlein.net>
References: <l2x2f0f6ced1004191416jd8db7d5eyf8fc7a55f5efa2cc@mail.gmail.com>
 <o2i2f0f6ced1004191418i6a144652sd9ac38b07fb7b661@mail.gmail.com>
 <hqir8c$sqh$1@dough.gmane.org>
 <l2o2f0f6ced1004210703rf3ce8781kd209e99d2b577b76@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Kelly <steveire@gmail.com>, git@vger.kernel.org
To: Bradley Wagner <bradley.wagner@hannonhill.com>
X-From: git-owner@vger.kernel.org Fri Apr 23 17:20:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5Kg8-0006W7-MK
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 17:20:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752487Ab0DWPUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Apr 2010 11:20:23 -0400
Received: from acme.spoerlein.net ([188.72.220.29]:16698 "EHLO
	acme.spoerlein.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751564Ab0DWPUW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Apr 2010 11:20:22 -0400
X-Greylist: delayed 464 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Apr 2010 11:20:21 EDT
Received: from acme.spoerlein.net (localhost.spoerlein.net [IPv6:::1])
	by acme.spoerlein.net (Postfix) with ESMTPS id 01BF95C89;
	Fri, 23 Apr 2010 17:12:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=spoerlein.net;
	s=dkim200908; t=1272035556;
	bh=f/3et3+t94n6spXJou4dkAm2gRxo1lezcljt3SIRF54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=veEDQme6qbRuEEHhGcbCcfzmZENKLbKu48LdV50TA5+zraLYI3Lj4Hd/EDDog71X5
	 9HcUtnPukDjNNZdpGYE7ddKJiBxHnbjbkY/Jyx5qm1zHZpS3fMpiaKLbcP1RuixZ7j
	 y5cS122PPdIJK+EuppwBHxLZJ9zR53pNyno5CJ4I=
Received: (from uqs@localhost)
	by acme.spoerlein.net (8.14.4/8.14.4/Submit) id o3NFCZmf067553;
	Fri, 23 Apr 2010 17:12:35 +0200 (CEST)
	(envelope-from uqs@spoerlein.net)
Content-Disposition: inline
In-Reply-To: <l2o2f0f6ced1004210703rf3ce8781kd209e99d2b577b76@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145623>

On Wed, 21.04.2010 at 10:03:16 -0400, Bradley Wagner wrote:
> Hmm, I'm not seeing where in the documentation you would instruct it
> to look in multiple locations in the SVN repository's history for the
> trunk branch.

I did this for the FreeBSD repo, where one or two branches were moved to
some other level. I can't get to the rule file right now, but you need
to figure out the revisions when the layout changed.

Then use something like this (from the top of my head, most likely
buggy)

match /
  min-revision 1
  max-revision 100
  branch master
end

match /trunk
  min-revision 101
  branch master
end

... you get the drift. Ask again if something is unclear, next time I
get to my rules files I can give you a better example.

Bye,
Uli
