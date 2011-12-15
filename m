From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Improve git-bundle builtin
Date: Thu, 15 Dec 2011 13:30:38 -0800
Message-ID: <7vobv9msjl.fsf@alter.siamese.dyndns.org>
References: <20111208175913.GK2394@elie.hsd1.il.comcast.net>
 <1323967528-10537-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Joey Hess <joey@kitenet.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 15 22:30:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbIt4-0000kI-Af
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 22:30:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759494Ab1LOVam (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 16:30:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37325 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751855Ab1LOVal (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 16:30:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC01A62A4;
	Thu, 15 Dec 2011 16:30:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ahkXM+jWkmesy5Gy5hnApHc15EY=; b=Oqv0Hx
	Vch3HnGunLfcgRz52uLVsx/KmXZf2VlBQ9pf+C519q22cv90BKzmPfGBuWlALH68
	6mVTG/bNoAOQhK4Y04xAVANssewWIWshi7oDhhXDBN1XMwRRTSwgaxJndG/rV/3A
	anPLuBe8qRBvblxCC3mA/i2/p1o3RHskXYyS8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pHiXtfgnExVf5yaYTWjX4Sw1TXej51yG
	IjAZA3dSYYyRN2rVmGd4mS9RRqspOA1Peh4e4gtJfEfoup7qlp3ZB2BzHztTJpOn
	7UWZccOlQd38nXawX1w4uEwXjUKdqIgWyV8sPa9ffOBz7v2GQv9NIpp3MeA5o2QW
	1YCWmZ+61d0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D295B62A3;
	Thu, 15 Dec 2011 16:30:40 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 69E3062A2; Thu, 15 Dec 2011
 16:30:40 -0500 (EST)
In-Reply-To: <1323967528-10537-1-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Thu, 15 Dec 2011 22:15:26 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0952BE04-2764-11E1-AF7F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187238>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> A couple of thoughts:
>
> 1. There's a SP between the OBJID and the ref name in list-heads as
> opposed to the TAB used by other git commands such as ls-remote,
> diff-tree.  Will fixing it break someone's parser somewhere?

If somebody will get broken when you change something, that change is not
"fixing" but just "changing". Why do you even want to "fix" it?

> 2. Is it worth fixing the "--stdin" tests?  What is the usecase?

Having to pack too many refs that would not fit on a command line length
limit, which is not an unusual requirement.
