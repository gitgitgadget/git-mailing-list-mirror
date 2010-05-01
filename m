From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] pretty.c: add %O format specifier to
 format_commit_one()
Date: Sat, 01 May 2010 10:18:35 -0700
Message-ID: <7vsk6b5yms.fsf@alter.siamese.dyndns.org>
References: <1272711401-29005-1-git-send-email-ash@koowaldah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexander Shishkin <ash@koowaldah.org>
X-From: git-owner@vger.kernel.org Sat May 01 19:18:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8GL5-00021e-Bg
	for gcvg-git-2@lo.gmane.org; Sat, 01 May 2010 19:18:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753272Ab0EARSp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 May 2010 13:18:45 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40566 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289Ab0EARSp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 May 2010 13:18:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6DDBAAFC06;
	Sat,  1 May 2010 13:18:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=juTp1C0rf1gBE6wHYqJzEIBkIr0=; b=IBOUfQdVmdIGfsJby7YlGTo
	tKPGPjRq1QalP59M5WwDbJmkCTsCqv5s7XF3Gzm+CiI2ww03hDgHN91rVcesYpjk
	4qGdOYcjjp2FheK1Wln4WFiHUrL+Dx2Bdf5jJzs/bw0ToNEHB/RGUMnIqa6lxgjC
	KGQBStpm+oaTlNgJOrd8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=NjD1SngG6JNX9D24UUcbj+IJSicUd8ip89WFD89t7ZqUOH2zZ
	cbkb74SvUHTbFa/PBdW9PdRmihQ9XUcvRPefjlJb0Sny9qMRwuh/EWzAYUP3qJuq
	WNuoljBhIXo6ApnDANt1AlcWO4K4CFvNRp+HkXkoOL6Tb7A2BMV3BSKVW8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B5B7AFC05;
	Sat,  1 May 2010 13:18:39 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BCC2DAFC04; Sat,  1 May
 2010 13:18:36 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9572366E-5545-11DF-BDD5-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146096>

Alexander Shishkin <ash@koowaldah.org> writes:

> This specifier represents the number of each commit in the output
> stream.

I don't like this.  What does such a number _mean_ in a non-linear
history?

Also the next person who sees this will inevitably ask for %TOTAL to so
that the output can say [N/M], but that would mean the list has to be
limited and we cannot stream the output anymore.
