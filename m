From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-pull: don't complain about branch merge config if only fetching tags
Date: Thu, 27 Dec 2007 02:39:17 -0800
Message-ID: <7vwsr0ifqi.fsf@gitster.siamese.dyndns.org>
References: <20071221124400.20725.qmail@db93e79e204cd8.315fe32.mid.smarden.org>
	<7v8x3oatvi.fsf@gitster.siamese.dyndns.org>
	<20071227093016.18337.qmail@e6d9fb481b7087.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Thu Dec 27 11:39:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J7q9c-0004jP-L6
	for gcvg-git-2@gmane.org; Thu, 27 Dec 2007 11:39:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751895AbXL0Kjb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Dec 2007 05:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751830AbXL0Kjb
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Dec 2007 05:39:31 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64067 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335AbXL0Kjb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Dec 2007 05:39:31 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A1576FEA;
	Thu, 27 Dec 2007 05:39:29 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C57436FE9;
	Thu, 27 Dec 2007 05:39:24 -0500 (EST)
In-Reply-To: <20071227093016.18337.qmail@e6d9fb481b7087.315fe32.mid.smarden.org>
	(Gerrit Pape's message of "Thu, 27 Dec 2007 09:30:16 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69261>

Gerrit Pape <pape@smarden.org> writes:

>> I've seen this patch on this list in the past, but isn't "git
>> pull -t" a user-error?
>
> If so, we shouldn't advertise the -t switch in the git-pull(1) manpage.

Perhaps.  Patches are welcomed as always.

> As it stands, I'd understand 'git pull -t' as 'fetch _all_ tags and
> branch heads and merge according to the configuration'.

Yeah, but that would mean that the current error message needs
to be kept, as that is the logical conclusion of "merge
according to the configuration".  Which is not so nice.

Perhaps using the same logic as your patch to detect the case of
"pull --tags and nothing else" case, and exit with non-zero
saying "you probably meant fetch --tags" would be a sane
compromise?  I dunno.
