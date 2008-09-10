From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-rebase-interactive: do not squash commits on abort
Date: Wed, 10 Sep 2008 15:36:34 -0700
Message-ID: <7vfxo7vdal.fsf@gitster.siamese.dyndns.org>
References: <1220906569-26878-1-git-send-email-dpotapov@gmail.com>
 <7v7i9mdvyr.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0809091616200.13830@pacific.mpi-cbg.de.mpi-cbg.de>
 <20080909205036.GD28210@dpotapov.dyndns.org>
 <alpine.DEB.1.00.0809101150570.13830@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Potapov <dpotapov@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Sep 11 00:38:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdYJq-0006di-Ex
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 00:37:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753547AbYIJWgm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 18:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753026AbYIJWgm
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 18:36:42 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56311 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751939AbYIJWgl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 18:36:41 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6CD907CFE;
	Wed, 10 Sep 2008 18:36:40 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 9BD5B7CFD; Wed, 10 Sep 2008 18:36:36 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0809101150570.13830@pacific.mpi-cbg.de.mpi-cbg.de> (Johannes
 Schindelin's message of "Wed, 10 Sep 2008 11:53:05 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EFAD102A-7F88-11DD-96CB-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95563>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
>> index 929d681..aaca915 100755
>> --- a/git-rebase--interactive.sh
>> +++ b/git-rebase--interactive.sh
>> @@ -427,14 +427,18 @@ do
>>  		else
>>  			. "$DOTEST"/author-script ||
>>  				die "Cannot find the author identity"
>> +			amend=""
>
> Sorry, my mistake... I should have been more explicit.  In most (if not 
> all) shell scripts, we prefer to set to the empty string with the 
> expression
>
> 			amend=

Don't worry.  I would notice and remove "" in my MUA for things like
these; especially the patch is this small it is hard to miss.
