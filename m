From: Ryan Anderson <ryan@michonline.com>
Subject: Re: non-trivial merge failures
Date: Sun, 20 Nov 2005 18:07:38 -0500
Message-ID: <20051120230738.GA16861@mythryan2.michonline.com>
References: <20051120.134945.104623647.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 21 00:08:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdyHf-0002VC-PL
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 00:07:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbVKTXHl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Nov 2005 18:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbVKTXHl
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Nov 2005 18:07:41 -0500
Received: from mail.autoweb.net ([198.172.237.26]:9898 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S932106AbVKTXHk (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Nov 2005 18:07:40 -0500
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.50)
	id 1EdyHb-0006oB-Cm; Sun, 20 Nov 2005 18:07:39 -0500
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1EdyHb-0008GL-00; Sun, 20 Nov 2005 18:07:39 -0500
Received: from ryan by mythical with local (Exim 4.54)
	id 1EdyHa-0005BX-Hr; Sun, 20 Nov 2005 18:07:38 -0500
To: "David S. Miller" <davem@davemloft.net>
Content-Disposition: inline
In-Reply-To: <20051120.134945.104623647.davem@davemloft.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12408>

On Sun, Nov 20, 2005 at 01:49:45PM -0800, David S. Miller wrote:
> 
> Every time I try to do a non-trivial merge, I always
> get this:

git-merge-recursive became the default merge tool recently, and Debian
uses Python 2.3 as the default, which lacks "subprocess.py".  Luckily,
git ships a backport, so you can do:

	make WITH_OWN_SUBPROCESS_PY=YesPlease all doc test install install-doc
or
	make PYTHON_PATH=/usr/bin/python2.4 all doc test install install-doc

and fix things up (the second assuming, of course, you have python-2.4
installed)

Alternatively, you can build your own Debian packages with "make deb"
and just install them.


-- 

Ryan Anderson
  sometimes Pug Majere
