From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Documentation: Don't assume git-sh-setup and
 git-parse-remote are in the PATH
Date: Sun, 29 Jun 2008 12:08:53 -0700
Message-ID: <7vbq1kawje.fsf@gitster.siamese.dyndns.org>
References: <20080627151001.BIA19424@m4500-01.uchicago.edu>
 <20080628205817.GB3172@steel.home>
 <7vvdztmfrk.fsf@gitster.siamese.dyndns.org>
 <20080629053823.GA8262@sigill.intra.peff.net>
 <Pine.GSO.4.62.0806291026310.8371@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>,
	Jeff King <peff@peff.net>
To: jrnieder@uchicago.edu
X-From: git-owner@vger.kernel.org Sun Jun 29 21:10:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KD2Hm-0006eb-Ap
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 21:10:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756125AbYF2TJG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 15:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756071AbYF2TJF
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 15:09:05 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61859 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756014AbYF2TJE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 15:09:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3ED53C762;
	Sun, 29 Jun 2008 15:09:03 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8A79FC761; Sun, 29 Jun 2008 15:08:56 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D674DF42-460E-11DD-B6B4-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86821>

jrnieder@uchicago.edu writes:

> How about this documentation patch? (This time tested! With hg-fast-export
> appropriately modified:
>   $ hg clone http://hg.sharesource.org/asciidoc
>   $ mkdir asciidoc-git && cd asciidoc-git
>   $ git init && hg-fast-export.sh -r /path/to/asciidoc --quiet
>   $ git checkout
>   $ sudo ./install.sh
>   $ cd /path/to/git/Documentation && make git-{sh-setup,parse-remote}.html
> I haven't tried rebuilding manpages, though.)
>
> Junio: I stole the commit message from you. I hope you don't mind.

I don't, but reading the script again, I suspect it is not clear enough
that the user is also responsible for setting up GIT_DIR appropriately
before using it, perhaps by sourcing git-sh-setup.  We probably would want
to add it in a separate patch.
