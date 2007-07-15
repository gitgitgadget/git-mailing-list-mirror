From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Add --show-size to git log to print message size
Date: Sun, 15 Jul 2007 11:35:29 +0200
Message-ID: <20070715093529.GD2568@steel.home>
References: <e5bfff550707140952hb60735bi95a4f03636c4aa99@mail.gmail.com> <7vodiehko7.fsf@assigned-by-dhcp.cox.net> <e5bfff550707141346q2eba4ab8ka1c85e8b5a2c1b1d@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 15 11:35:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IA0Vq-0006wC-OM
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 11:35:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755622AbXGOJfc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 05:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755329AbXGOJfc
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 05:35:32 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:52398 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755416AbXGOJfb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 05:35:31 -0400
Received: from tigra.home (Fca5f.f.strato-dslnet.de [195.4.202.95])
	by post.webmailer.de (mrclete mo35) (RZmta 8.3)
	with ESMTP id a00259j6F51PBM ; Sun, 15 Jul 2007 11:35:29 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 67BBB277BD;
	Sun, 15 Jul 2007 11:35:29 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 4404AC164; Sun, 15 Jul 2007 11:35:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <e5bfff550707141346q2eba4ab8ka1c85e8b5a2c1b1d@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTNzsQ==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52537>

Marco Costalba, Sat, Jul 14, 2007 22:46:39 +0200:
> Finding the delimiting '\0' it means to loop across the whole buffers
> and _this_ is the expensive and not needed part. If just after the

It is _not_ expensive. It could be made expensive, though. By using
QString and QByteArray, for instance.

> first line would be possible to point to the beginning of the next
> revision this seeking for '\0' would be not necessary anymore.

But this will make your reading different: you have to handle the case
when the next revision is not _fully_ read in yet, but you already
know its size.

> Hope I have explained clearly enough, I have some problems writing in
> at late evening ;-)

P.S. BTW, why do you have some 20 source files marked executable in
your qgit4 repository?
