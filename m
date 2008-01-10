From: Sam Vilain <sam@vilain.net>
Subject: Re: Decompression speed: zip vs lzo
Date: Fri, 11 Jan 2008 10:45:15 +1300
Message-ID: <478691EB.1080704@vilain.net>
References: <e5bfff550801091401y753ea883p8d08b01f2b391147@mail.gmail.com> <7v4pdmfw27.fsf@gitster.siamese.dyndns.org> <47855765.9090001@vilain.net> <alpine.LSU.1.00.0801092328580.31053@racer.site> <47856E8D.4010006@vilain.net> <4785A6DB.3080007@vilain.net> <20080110091607.GA17944@artemis.madism.org> <alpine.LFD.1.00.0801101332150.3054@xanadu.home> <alpine.LFD.1.00.0801101252030.3148@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marco Costalba <mcostalba@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jan 10 22:45:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JD5Dk-00057M-ML
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 22:45:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752218AbYAJVpY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 16:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752021AbYAJVpY
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 16:45:24 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:41872 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752367AbYAJVpX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 16:45:23 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 65534)
	id 74BD521D188; Fri, 11 Jan 2008 10:45:21 +1300 (NZDT)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id D599121D183;
	Fri, 11 Jan 2008 10:45:16 +1300 (NZDT)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <alpine.LFD.1.00.0801101252030.3148@woody.linux-foundation.org>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on 
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70097>

Linus Torvalds wrote:
> Maybe the difference to other repositories isn't huge, and maybe the 
> kernel *is* a good test-case, but I just wouldn't take that for granted. 
>
> Try with the gcc repo, especially the one that has deep delta chains (so 
> it has even *more* deltas in relation to full objects than the kernel has)

For reference, 20 years of Perl with very deep deltas:

wilber:~/src/perl-preview$ du -sk .git
73274   .git
wilber:~/src/perl-preview$ git-repack -a
Counting objects: 244360, done.
Compressing objects: 100% (55493/55493), done.
Writing objects: 100% (244360/244360), done.
Total 244360 (delta 181061), reused 244360 (delta 181061)
wilber:~/src/perl-preview$ du -sk .git/objects/pack/
75389   .git/objects/pack/
wilber:~/src/perl-preview$

There are a few generated files in this history, but really only yacc
files etc.  It is in general also a lot of small changes.

Sam.
