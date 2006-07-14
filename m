From: Junio C Hamano <junkio@cox.net>
Subject: Re: Kernel headers git tree
Date: Thu, 13 Jul 2006 17:39:55 -0700
Message-ID: <7v4pxlt3xg.fsf@assigned-by-dhcp.cox.net>
References: <1152835150.31372.23.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 14 02:40:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1Biy-0002JN-Lk
	for gcvg-git@gmane.org; Fri, 14 Jul 2006 02:40:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbWGNAj5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 13 Jul 2006 20:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751526AbWGNAj5
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 20:39:57 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:44191 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751430AbWGNAj5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Jul 2006 20:39:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060714003956.VYV12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 13 Jul 2006 20:39:56 -0400
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1152835150.31372.23.camel@shinybook.infradead.org> (David
	Woodhouse's message of "Fri, 14 Jul 2006 00:59:09 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23862>

David Woodhouse <dwmw2@infradead.org> writes:

> =B9 http://david.woodhou.se/extract-khdrs-git.sh and
>   http://david.woodhou.se/extract-khdrs-stage2.sh for the stout of st=
omach

With modern enough git, you can rewrite

	KBUILDSHA=3D`git ls-tree $TREE -- Kbuild | cut -f3 -d\  | cut -f1`

with

	KBUILDSHA1=3D`git rev-parse $TREE:Kbuild`

I am not sure what function incparent() is trying to do with
this:

	git rev-list --max-count=3D1 --topo-order $1 -- .
