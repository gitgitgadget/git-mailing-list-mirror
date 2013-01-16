From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 0/8] push: update remote tags only with force
Date: Wed, 16 Jan 2013 08:00:15 -0800
Message-ID: <7vwqvdxgmo.fsf@alter.siamese.dyndns.org>
References: <1354239700-3325-1-git-send-email-chris@rorvick.com>
 <DBF53EC2-A669-4B77-B88E-BFCDF43C862E@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Rorvick <chris@rorvick.com>, git@vger.kernel.org,
	Angelo Borsotti <angelo.borsotti@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Wed Jan 16 18:05:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvWQK-00076Q-GK
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 18:05:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757381Ab3APREv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 12:04:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36534 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757328Ab3APQAR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 11:00:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 66B46BE07;
	Wed, 16 Jan 2013 11:00:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0ouuje3OjJMtCd7UZd96xXP3OYs=; b=hIgviT
	paNUsihYsC4REKUgvMTU6aHfscijH59qzDW006dttRjZ0A+Bg7PWLDDLr5tcX3ze
	xqiPYOF4WqMUohgwJtLlMLulni0oin8F51Z8b+PA2fTDXWj+TEqutrW4XvTpnpdJ
	5Z+Go5rZoAHTti9X9OMn1CFnA8dcSfbn/VKE8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VjQTuyTCWrpgl1ghGdr2AYeD365GSo6g
	WKuMT9L4qnY14eUhsEOcRl2GHAxpXXQGn1mT9GoS4ru3HrsuKfoE4gLOmtFBsK49
	UJ87ee+nD59mbT95XzuG3PKn/iuisGz278TjwSihVRQqFQrvBQIbmZWR4whg312D
	kieJuYS0170=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A9A1BE06;
	Wed, 16 Jan 2013 11:00:17 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C2601BDFF; Wed, 16 Jan 2013
 11:00:16 -0500 (EST)
In-Reply-To: <DBF53EC2-A669-4B77-B88E-BFCDF43C862E@quendi.de> (Max Horn's
 message of "Wed, 16 Jan 2013 14:32:03 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D1F0DCD6-5FF5-11E2-B78E-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213771>

Max Horn <max@quendi.de> writes:

> But with next, I get this:
>
>  ! [rejected]        master -> master (already exists)
> error: failed to push some refs to '/Users/mhorn/Projekte/foreign/gitifyhg/bugs/git-push-conflict/repo_orig'
> hint: Updates were rejected because the destination reference already exists
> hint: in the remote.
>
> This looks like a regression to me.

It is in master now X-<, and this looks like a bug to me.
