From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3 v3] Use an external program to implement fetching
 with curl
Date: Wed, 05 Aug 2009 10:46:09 -0700
Message-ID: <7vk51i9mse.fsf@alter.siamese.dyndns.org>
References: <alpine.LNX.2.00.0907310112400.2147@iabervon.org>
 <alpine.DEB.1.00.0908051203550.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 05 19:46:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYkZJ-00040J-59
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 19:46:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521AbZHERqT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 13:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbZHERqR
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 13:46:17 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62188 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251AbZHERqQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 13:46:16 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 33AE72180F;
	Wed,  5 Aug 2009 13:46:15 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 76F442180E; Wed, 
 5 Aug 2009 13:46:11 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0908051203550.8306@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Wed\, 5 Aug 2009 12\:05\:09 +0200
 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DF54DDAE-81E7-11DE-A86A-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124933>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>>  Makefile      |    5 ++
>>  remote-curl.c |  139 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  transport.c   |  136 +-------------------------------------------------------
>>  3 files changed, 145 insertions(+), 135 deletions(-)
>>  create mode 100644 remote-curl.c
>
> I wanted to suggest using the -C option so that the patch would consist of 
> mostly deleted lines (easier to verify then that it was a code move), but 
> transport.c is over 1000 lines, so that would not have worked!

Not that matters, but ;-)

$ git show --oneline -B1/1 -C --stat a2d725b
a2d725b Use an external program to implement fetching with curl
 Makefile      |    5 +
 remote-curl.c |  139 ++++
 transport.c   | 2132 +++++++++++++++++++++++++++------------------------------
 3 files changed, 1143 insertions(+), 1133 deletions(-)
