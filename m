From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] builtin-checkout: suggest creating local branch when
 appropriate to do so
Date: Sun, 18 Oct 2009 00:58:06 -0700
Message-ID: <7vzl7pyvzl.fsf@alter.siamese.dyndns.org>
References: <1254775583-49452-1-git-send-email-jaysoffian@gmail.com>
 <alpine.DEB.1.00.0910052314580.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Oct 18 10:00:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzQga-0006Ut-2H
	for gcvg-git-2@lo.gmane.org; Sun, 18 Oct 2009 10:00:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752765AbZJRH6O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2009 03:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752329AbZJRH6N
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 03:58:13 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44980 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076AbZJRH6N (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2009 03:58:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 147215DBFD;
	Sun, 18 Oct 2009 03:58:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=fkTSyX7mhaa6q/Ic/mlJLuO1WKo=; b=mDl7lUNKpM/r+MCU1nENsM6
	TZ2ARujugkgdIeZEFzoJRZyMkUwivwH3bY/Ax1d6lUBhfTyrzuObIQhXCT+tB8BV
	g9MQlLie0E3uI+gOE45/k9urSbrndKyLCfGwe7Brt6wd7tso02q6v41HUieR5kpM
	7hKa6a2V5U+qXRZ8NB3I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=iIk0+kDhK0mZtW1d7rbbBgdgb3Xmqi3Bd6iXp0EEBdo3/7SGQ
	GrQT2o7Ah9EN/D6bYTgsFKXrUuSLf+BmQb+KJc61BFH6GEBAHPCQSxF16xcU8nTz
	YYo4Jwyd5iVef2Xu5ZGQOzyVrw6+YBCVoiLFEPkIhLF1pmL2/vuUZV6z8M=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DD0685DBFC;
	Sun, 18 Oct 2009 03:58:11 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 41FBA5DBFB; Sun, 18 Oct
 2009 03:58:08 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FB65FC0E-BBBB-11DE-8696-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130586>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Actually, we should really think long and hard why we should not 
> automatically check out the local branch "next" in that case.

While people were thinking long and hard, I've spent some quality time
having fun with these patches, and realized that if we limit the scope of
the change to make sure that we only change the behaviour of a case where
we refused to do anything, this is not even something we need to think
long nor hard after all.

At least from the maintainer's point of view, that is.

I on the other hand do agree that we need to think long and hard when it
comes to the matter of explaining this to the users, though.  I couldn't
come up with a good (re-)ordering of the documentation to fit this new
"short-cut" into the manpage.

A three-patch series will follow shortly.
