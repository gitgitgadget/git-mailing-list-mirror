From: Junio C Hamano <junkio@cox.net>
Subject: Re: Handling merge conflicts a bit more gracefully..
Date: Wed, 08 Jun 2005 18:04:12 -0700
Message-ID: <7v4qc8z6gj.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0506081336080.2286@ppc970.osdl.org>
	<7vis0o30sc.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506081629370.2286@ppc970.osdl.org>
	<7vzmu01jmc.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506081738000.2286@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 09 03:04:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgBSg-0005aV-18
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 03:03:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262229AbVFIBHA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 21:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261556AbVFIBGZ
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 21:06:25 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:41880 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S262210AbVFIBEO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2005 21:04:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050609010412.WRVE550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 8 Jun 2005 21:04:12 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506081738000.2286@ppc970.osdl.org> (Linus
 Torvalds's message of "Wed, 8 Jun 2005 17:41:56 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> I'll instead make it do

LT> 	git-update-cache --add --cacheinfo ... &&
LT> 		git-checkout-cache -u -f "$4"

LT> which seems even simpler.

I like that one much much better.  Consistently using
checkout-cache -f everywhere is much preferred.  It creates the
leading paths itself, and even nukes interfering files it finds
while creating leading directories, which the verify_path using
mkdir -p would not give you.

