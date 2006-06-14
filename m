From: Junio C Hamano <junkio@cox.net>
Subject: Re: Repacking many disconnected blobs
Date: Wed, 14 Jun 2006 05:33:22 -0700
Message-ID: <7vejxrgbn1.fsf@assigned-by-dhcp.cox.net>
References: <1150269478.20536.150.camel@neko.keithp.com>
	<20060614072923.GB13886@spearce.org>
	<Pine.LNX.4.63.0606141104050.15578@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 14 14:34:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqUYr-0005jB-OE
	for gcvg-git@gmane.org; Wed, 14 Jun 2006 14:33:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbWFNMdY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Jun 2006 08:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbWFNMdY
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jun 2006 08:33:24 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:9139 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932330AbWFNMdX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jun 2006 08:33:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060614123323.GVQL15767.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 14 Jun 2006 08:33:23 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606141104050.15578@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 14 Jun 2006 11:07:52 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21841>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Alternatively, you could construct fake trees like this:
>
> README/1.1.1.1
> README/1.2
> README/1.3
> ...
>
> i.e. every file becomes a directory -- containing all the versions of that 
> file -- in the (virtual) tree, which you can point to by a temporary ref.

That would not play well with the packing heuristics, I suspect.
If you reverse it to use rev/file-id, then the same files from
different revs would sort closer, though.
