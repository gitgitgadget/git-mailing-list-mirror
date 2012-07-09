From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02.5/11] Makefile: fold XDIFF_H and VCSSVN_H into LIB_H
Date: Mon, 09 Jul 2012 07:59:57 -0700
Message-ID: <7vfw91kmj6.fsf@alter.siamese.dyndns.org>
References: <20120620182855.GA26948@sigill.intra.peff.net>
 <20120620183055.GB30995@sigill.intra.peff.net>
 <20120620210730.GB6142@burratino>
 <20120620221125.GA3302@sigill.intra.peff.net>
 <20120707033918.GB3574@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Thomas Rast <trast@student.ethz.ch>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 09 17:00:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoFRa-0000Tc-0w
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jul 2012 17:00:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317Ab2GIPAB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jul 2012 11:00:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35440 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750754Ab2GIPAA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2012 11:00:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C223E7951;
	Mon,  9 Jul 2012 10:59:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zhurgaKm1QBRZWQNekTyjBH9T/Q=; b=f+8vNS
	sW9MymcoEPCprbcy72ICKRfdbO3CjzyQciTIp4w7lIY3ab/J887SELEM6aMZx//9
	acM7oNlyb1YZUnfvXiVNTSoLQOz/39bWLD8h9skMAwx/xUIgEEVPWhDxoeD9rX2n
	WE9PFV8qB7olo573wKX+Ss2YqNONaPx6s8AvU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WoXGEJQ7mWpCw4Ox6AkNOt2gF3qhpBZo
	8KxMyyULKGrTKXcAJv276wjOeUGH8j5F+cG5aEhdCjKGEgCkAEAdLBx+R6B3Wgjr
	fFU4xtbZCn4l9eEME892EA2o9DLsK5VyXELN7AjnVmHwdDu8Pbd/Ei42CqHHL82t
	t9ZyUoPI3gw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B68657950;
	Mon,  9 Jul 2012 10:59:59 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4AD30794F; Mon,  9 Jul 2012
 10:59:59 -0400 (EDT)
In-Reply-To: <20120707033918.GB3574@burratino> (Jonathan Nieder's message of
 "Fri, 6 Jul 2012 22:39:18 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C0D4A26C-C9D6-11E1-813E-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201207>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Just like MISC_H (see previous commit), there is no reason to track
> xdiff and vcs-svn headers separately from the rest of the headers.
> The only purpose of these variables is to keep track of recompilation
> dependencies.
>
> As a pleasant side effect, folding these into LIB_H lets us stop
> tracking GIT_OBJS and VCSSVN_TEST_OBJS separately from the list of all
> OBJECTS.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Jeff King wrote:
>> On Wed, Jun 20, 2012 at 04:07:30PM -0500, Jonathan Nieder wrote:
>
>>> Should XDIFF_H and VCSSVN_H be folded into STATIC_HEADERS, too?
>>
>> I stopped short of that, but I'd be tempted to do so.
>
> Here goes.

Very tempting.  Will try squeezing this in between 2/11 and 3/11 and
see how the result looks.
