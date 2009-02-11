From: Sam Vilain <sam@vilain.net>
Subject: Re: RFC: Flat directory for notes, or fan-out?  Both!
Date: Wed, 11 Feb 2009 14:14:38 +1300
Message-ID: <4992267E.6050707@vilain.net>
References: <alpine.DEB.1.00.0902092200170.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, peff@peff.net, spearce@spearce.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 11 02:16:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX3iD-000473-EW
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 02:16:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754642AbZBKBO6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 20:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753875AbZBKBO5
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 20:14:57 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:39292 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752451AbZBKBO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 20:14:56 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 3E8EA21D141; Wed, 11 Feb 2009 14:14:46 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	PLING_QUERY autolearn=no version=3.2.5
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id C6A7221C491;
	Wed, 11 Feb 2009 14:14:39 +1300 (NZDT)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <alpine.DEB.1.00.0902092200170.10279@pacific.mpi-cbg.de>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109363>

Johannes Schindelin wrote:
> Hi,
>
> Shawn triggered some well needed thinking on my part about the notes 
> implementation.  At the moment, we have flat directory structure, and read 
> all of them in one go (when needed).
>
> I think we should support that, because it is relatively easy to generate 
> that kind of trees for small-scale applications.
>
> However, I think there is also a benefit to handle fan-out directory 
> structures, too: they scale much nicer.
>
> If the commit name was not found as a filename, it could be searched in 
> whatever subdirectory whose name is a prefix of said commit name (first 
> wins).
>   

Great idea! Glad I thought of it! ;-)

http://thread.gmane.org/gmane.comp.version-control.git/106715/focus=107975

I hoped my approach allowed for smarter things later, such as splitting
into smaller buckets whenever a directory gets more than N entries or
periodically rebalancing if required. But the initial version is at
least forward thinking to support reading it.

Merging them will need to be savvy of this of course.

Sam.
