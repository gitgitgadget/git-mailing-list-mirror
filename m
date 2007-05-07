From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Use GIT_OBJECT_DIR for temporary files of pack-objects
Date: Mon, 7 May 2007 23:33:47 +0200
Message-ID: <20070507213347.GB3436@steel.home>
References: <81b0412b0705040225p26679dbib6a1261a1a43ee67@mail.gmail.com> <7vy7k4ud3d.fsf@assigned-by-dhcp.cox.net> <81b0412b0705040342p4fed3a4bnee92cce6b5fb6b9@mail.gmail.com> <7vslacttij.fsf@assigned-by-dhcp.cox.net> <81b0412b0705041024i43d7fc5ah1967d6a6192dc6ee@mail.gmail.com> <7v6478tmyy.fsf@assigned-by-dhcp.cox.net> <20070507173324.GA3436@steel.home> <56b7f5510705071051l75d701d7r94b7c4629cc425f@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 07 23:33:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlAqB-0004so-3t
	for gcvg-git@gmane.org; Mon, 07 May 2007 23:33:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966570AbXEGVdv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 17:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966586AbXEGVdu
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 17:33:50 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:25315 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966570AbXEGVdu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 17:33:50 -0400
Received: from tigra.home (195.4.201.72)
	by post.webmailer.de (fruni mo6) (RZmta 5.9)
	with ESMTP id Q049e8j47J1hfZ ; Mon, 7 May 2007 23:33:48 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 11131277BD;
	Mon,  7 May 2007 23:33:48 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 89A8BD171; Mon,  7 May 2007 23:33:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <56b7f5510705071051l75d701d7r94b7c4629cc425f@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaFzALfsw==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46493>

Dana How, Mon, May 07, 2007 19:51:24 +0200:
> On 5/7/07, Alex Riesen <raa.lkml@gmail.com> wrote:
> >I'm not sure about fsck cleaning up after crashed/killed pack-objects:
> >not sure I _can_ detect if the temp files really are just leftovers.
> 
> It looks like you create temp file in objects , not objects/pack .
> 
> So a rule could be : packs left in the former are crashed/killed,
> and packs in the latter are complete?

How do you know for sure that they are _left_ already?

> You should also look at $PACKTMP in git-repack.sh .
> In it $GIT_DIR should probably be $GIT_OBJECT_DIRECTORY ?

I think it should, but it is already not the working directory, so my
original complaint does not apply
