From: Thomas Jarosch <thomas.jarosch@intra2net.com>
Subject: Re: [PATCH] setup_revisions(): do not access outside argv
Date: Fri, 22 May 2009 16:23:44 +0200
Organization: Intra2net AG
Message-ID: <200905221625.07628.thomas.jarosch@intra2net.com>
References: <1242806900-3499-1-git-send-email-pclouds@gmail.com> <20090522075620.GC1409@coredump.intra.peff.net> <20090522080258.GD1409@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 22 16:56:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7WAR-00058M-96
	for gcvg-git-2@gmane.org; Fri, 22 May 2009 16:56:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757201AbZEVO4E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2009 10:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756433AbZEVO4C
	(ORCPT <rfc822;git-outgoing>); Fri, 22 May 2009 10:56:02 -0400
Received: from re01.intra2net.com ([82.165.28.202]:50162 "EHLO
	re01.intra2net.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753051AbZEVO4A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2009 10:56:00 -0400
X-Greylist: delayed 1848 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 May 2009 10:56:00 EDT
Received: from intranator.m.i2n (unknown [172.16.1.99])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by re01.intra2net.com (Postfix) with ESMTP id 798455F24;
	Fri, 22 May 2009 16:25:09 +0200 (CEST)
Received: from localhost (intranator.m.i2n [127.0.0.1])
	by localhost (Postfix) with ESMTP id 29B132AC4F;
	Fri, 22 May 2009 16:25:09 +0200 (CEST)
Received: from storm.localnet (storm.m.i2n [172.16.1.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by intranator.m.i2n (Postfix) with ESMTP id 490362AC4E;
	Fri, 22 May 2009 16:25:08 +0200 (CEST)
User-Agent: KMail/1.11.0 (Linux/2.6.27.21-78.2.41.fc9.i686; KDE/4.2.3; i686; ; )
In-Reply-To: <20090522080258.GD1409@coredump.intra.peff.net>
Content-Disposition: inline
X-Virus-Scanned: by Intranator (www.intra2net.com) with AMaViS and F-Secure AntiVirus (fsavdb 2009-05-22_05)
X-Spam-Status: hits=-1.8 tests=[ALL_TRUSTED=-1.8,BAYES_50=0.001]
X-Spam-Level: 982
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119732>

On Friday, 22. May 2009 10:02:58 Jeff King wrote:
> On Fri, May 22, 2009 at 03:56:20AM -0400, Jeff King wrote:
> > Yeah, it is fine because it just passes the result to prep_temp_blob,
> > which respects the length. I don't know if it is worth making it more
> > safe (arguably it should just be using strbuf_readlink anyway, but that
> > does introduce an extra malloc).
>
> And here is the strbuf_readlink version, which actually does make the
> source shorter and easier to read.

Good work! Patch looks fine to me. Guess you can't even benchmark
the "extra" malloc ;-)

Have a nice weekend,
Thomas
