From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Document rev^! and rev^@ as revision specifiers
Date: Fri, 06 Jul 2012 00:21:06 -0700
Message-ID: <7vtxxlnyn1.fsf@alter.siamese.dyndns.org>
References: <7vpq8aqdzb.fsf@alter.siamese.dyndns.org>
 <1341532890-13829-1-git-send-email-max@quendi.de>
 <1341532890-13829-2-git-send-email-max@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Fri Jul 06 09:36:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sn35N-0000I8-Av
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 09:36:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393Ab2GFHgG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jul 2012 03:36:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51245 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932084Ab2GFHgF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2012 03:36:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C656A97A0;
	Fri,  6 Jul 2012 03:21:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pPY4bHW8MmtfN9wcTdcg/ZxxaeE=; b=qEPzZV
	6pnwlUwXW6VKYrzE5+H2c4iI+GElmxTnGJbchgebtyvY2gYdlHi/mf3vgoMjPbSs
	exlkV3TPCFr2kxCaozH841oaBLZJUU9MqaJyeL0uqkNm0HxU67uLBhqrnXPmsTxN
	jjvsA4vdsUxDqRjQnQLfPWjZyrZ+4xFZ7wF0c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rW0a4t/T17m/pRgmEmZCExF9MEiYnXpW
	l1BP0eRoEF9R6dddxRk8Fcb2iDOa12McEL+zvymxfRRJtV0VbyCAR6hCYHR801nR
	EPiDp3/SGwfeEvo6tWRNjV66hWwtJ/3Pzsjm63wKQ1eLcE3AnjUNdUJ1lBCZYHMc
	9PMa6vG9eGk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BDA76979E;
	Fri,  6 Jul 2012 03:21:08 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 45755979D; Fri,  6 Jul 2012
 03:21:08 -0400 (EDT)
In-Reply-To: <1341532890-13829-2-git-send-email-max@quendi.de> (Max Horn's
 message of "Fri, 6 Jul 2012 02:01:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 27D2E92C-C73B-11E1-A4B8-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201089>

Max Horn <max@quendi.de> writes:

> +'<rev>{caret}@', e.g. 'HEAD{caret}@'::
> +  A suffix '{caret}' followed by an at sign
> +  means all parents of '<rev>'.
> +  This is somewhat different from the other specifiers in this
> +  section in that it may refer to multiple commits at once.
> +  See also the next section on SPECIFYING RANGES.

Looks good.


> +'<rev>{caret}!', e.g. 'HEAD{caret}!'::
> +  A suffix '{caret}' followed by an exclamation mark
> +  means commit '<rev>' but forces all of its parents to be excluded. For
> +  commands that deal with a single revision, this is the same as '<rev>".

Is this sentence correct?  "git commit -C 'HEAD^!'" might be a
command that expects a single revision, but I do not think it is the
same as "git commit -C HEAD".

> +  Hence it is primarily used with commands expecting commit ranges.

That is correct.
