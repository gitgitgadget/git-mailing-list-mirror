From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Tilde spec - befuzzled
Date: Tue, 28 Feb 2012 11:20:39 -0800
Message-ID: <7vaa42zrw8.fsf@alter.siamese.dyndns.org>
References: <4F4C995D.9000504@diamand.org> <4F4CA354.2070503@op5.se>
 <87zkc38a3v.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, Luke Diamand <luke@diamand.org>,
	Git List <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Feb 28 20:20:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2SbQ-0007ev-A8
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 20:20:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966004Ab2B1TUn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 14:20:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58171 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964997Ab2B1TUm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 14:20:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A902611B;
	Tue, 28 Feb 2012 14:20:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=e+CU9JIWyZkfuyJHIwBV9iD2Lt8=; b=Rg8OeF
	7/DcNOp6JSlXjUIfN2tv2wzthFar6U2VdQxnFGyn5ivatZbl5GpOUcelku4qJxlg
	vFpoYjla4UDaS3SnuNE7hMVYOL5xHNXn0nIJHsG82+Z/PqN+l0s3t949jM3V1LOK
	mszN+NcU2hXvWdwna/iSybSaVTwnsO7tZ4Qss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lVTPdv/LmQnNAmdMUIEhme0JEiqXzZ4H
	lbEdd0nTAVYoKrYGWz7O6/xpqlRt4QihdxfDN+Ri1hDS89wVcJ3BaH0agazJoEFh
	F4WWOZtPDo2DleE9+8I0Ws20waxNAIPxCAI8xs6KI/eMTGN8pzPTC3HfeMtuqAMR
	/njdugLgIJc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 41F16611A;
	Tue, 28 Feb 2012 14:20:41 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CDAA46117; Tue, 28 Feb 2012
 14:20:40 -0500 (EST)
In-Reply-To: <87zkc38a3v.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Tue, 28 Feb 2012 12:34:44 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4D62F862-6241-11E1-9F4F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191768>

Thomas Rast <trast@inf.ethz.ch> writes:

>>> '<rev>{tilde}<n>', e.g. 'master{tilde}3'::
>>> A suffix '{tilde}<n>' to a revision parameter means the commit
>>> object that is the <n>th generation grand-parent of the named
>>> commit object, following only the first parents.
>>> 
>>> Hang on, *grand*-parents?
>>> ...
>
> Perhaps we should reword it as "n-th first-parent ancestor"?  Barring
> confusion about the position of the dashes, that leaves little room for
> error.

I think we could either go "easier to read but not precise"

	... that is the <n>th generation (grand-)parent of ...

or "may sound scary but correct"

	the ancestor reached by walking the first-parent chain <n> times

I am not sure which bucket "n-th first-parent ancestor" falls into.
