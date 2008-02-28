From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] templates/Makefile: don't depend on local umask setting
Date: Thu, 28 Feb 2008 12:52:25 -0800
Message-ID: <7vve48hkhi.fsf@gitster.siamese.dyndns.org>
References: <20080228184442.13993.qmail@c0e6a439c34263.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Thu Feb 28 21:53:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUpkp-0003Rj-2z
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 21:53:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761598AbYB1Uwo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 15:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761510AbYB1Uwn
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 15:52:43 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44575 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761229AbYB1Uwn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 15:52:43 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EF6232E6A;
	Thu, 28 Feb 2008 15:52:40 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 5B2072E69; Thu, 28 Feb 2008 15:52:35 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75454>

Gerrit Pape <pape@smarden.org> writes:

> Don't take the local umask setting into account when installing the
> templates/* files and directories, running 'make install' with umask set
> to 077 resulted in template/* installed with permissions 700 and 600.

Well spotted.  As the current Makefile seems to assume the users
like 022 umask (existing "$(INSTALL) -d" uses "-m 755"), your
changes are consistent with it.

