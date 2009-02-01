From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2009, #07; Wed, 28)
Date: Sat, 31 Jan 2009 17:31:27 -0800
Message-ID: <7vr62j0wpc.fsf@gitster.siamese.dyndns.org>
References: <7vwscej26i.fsf@gitster.siamese.dyndns.org>
 <20090129035138.GC11836@coredump.intra.peff.net>
 <bd6139dc0901290327u572cc30ci9dc719c912fbf875@mail.gmail.com>
 <20090129113735.GA6505@coredump.intra.peff.net>
 <351A6988-32EB-473F-B6E5-8FBB38D91F88@ai.rug.nl>
 <bd6139dc0901290345u4962f747gbe93c945ab35c9cb@mail.gmail.com>
 <20090129115026.GB10792@coredump.intra.peff.net>
 <bd6139dc0901290420x1216a399w656e4d1622178a06@mail.gmail.com>
 <20090130045131.GB18655@coredump.intra.peff.net>
 <alpine.DEB.1.00.0901301415260.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Sverre Rabbelier <srabbelier@gmail.com>,
	Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 01 02:33:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTRCr-0003aJ-4g
	for gcvg-git-2@gmane.org; Sun, 01 Feb 2009 02:33:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753186AbZBABbj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 20:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752731AbZBABbj
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 20:31:39 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40777 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752630AbZBABbi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 20:31:38 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4E88595852;
	Sat, 31 Jan 2009 20:31:36 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 85DB395851; Sat,
 31 Jan 2009 20:31:28 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 10C670F2-F000-11DD-BF6E-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107961>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> How about installing
>
> 	[branch "master"]
> 		remote = origin
> 		merge = refs/heads/master
>
> by default?  It is a safe bet that this will be the case for 99% of all 
> users that want to clone an empty repository (especially if they are 
> putting their public repositories on something like repo.or.cz, where you 
> cannot change the default branch from "master" to something else).

I think this is a reasonable thing to do.  Even though cloning from a void
is not entirely a reasonable thing to do to begin with, because we are
going ahead to allow it now, it would be the best thing to do when cloning
a repository served by the currently deployed git.

We _could_ do better if we were to resurrect my earlier series to add
"where does the HEAD point at" protocol extension, but even then we would
need a fallback like your suggestion when talking to older servers anyway.
