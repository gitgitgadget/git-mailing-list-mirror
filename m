From: Junio C Hamano <gitster@pobox.com>
Subject: Re: List of files aded/removed/modified by "git-checkout"
Date: Wed, 06 Feb 2008 19:51:00 -0800
Message-ID: <7vve51qva3.fsf@gitster.siamese.dyndns.org>
References: <jwvodatkbdm.fsf-monnier+gmane.comp.version-control.git@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Monnier <monnier@iro.umontreal.ca>
X-From: git-owner@vger.kernel.org Thu Feb 07 04:51:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMxng-0008Mb-KK
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 04:51:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754532AbYBGDvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 22:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754474AbYBGDvI
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 22:51:08 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60381 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754414AbYBGDvH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 22:51:07 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A76D2310;
	Wed,  6 Feb 2008 22:51:05 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id BD4C8230F;
	Wed,  6 Feb 2008 22:51:02 -0500 (EST)
In-Reply-To: <jwvodatkbdm.fsf-monnier+gmane.comp.version-control.git@gnu.org>
	(Stefan Monnier's message of "Wed, 06 Feb 2008 16:47:19 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72887>

Stefan Monnier <monnier@iro.umontreal.ca> writes:

> Whenever I do a git-checkout to switch between branches, I'm
> disappointed by the absence of a "-v" option which would list the
> operations performed.
>
> How can I get this information?

I'd be mightily annoyed with it myself, though, as I switch
between 'master', 'next', 'pu' and 'maint' pretty often.

Have something like this in .git/hooks/post-checkout and make it
executable, perhaps?  Modify the options to suit your taste.

#!/bin/sh
case "$3" in
1)
	git diff --stat --summary -M "$1" "$2" ;;
esac
