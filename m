From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] add update to branch support for "floating
 submodules"
Date: Wed, 09 Nov 2011 10:01:33 -0800
Message-ID: <7vr51htbsy.fsf@alter.siamese.dyndns.org>
References: <20111109174027.GA28825@book.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed Nov 09 19:01:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROCSz-0004HW-DN
	for gcvg-git-2@lo.gmane.org; Wed, 09 Nov 2011 19:01:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752871Ab1KISBh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Nov 2011 13:01:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60916 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751243Ab1KISBg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2011 13:01:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 325176A9B;
	Wed,  9 Nov 2011 13:01:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=t7P3YnFliIXOqLTCtMEnOlF0ZqY=; b=U0z1e1
	4xQZ9xYWUi211j85mFfcCd/Ard5h84Ey5R+txwloeYBzzU9utkBeXmv3crofGnCs
	qHBib/q/J/xuRpXP3SY7cpXXB2MTon+nbP47D2fQ+xetEbmYMHYtUQglo0OrLQgT
	V9N7CXDdjDg5ljwx5sb0PApkLHR5r08GEy2S4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dU5oddzvCA18ovY2K/yf9au1r5hbRAo0
	liD6JCzWDAtYvup+T54Nkv2vd6nWEg4rnhZdGUZSkxDZU7QH/pzeUbRwr/k4n1QW
	QbzkWyxV39O9ZeUMYwRoK1DWjxz7lNsObfUgM/PA5Mxka1YnrFbKk2kfzuK3tua/
	ox9RnNmZwvM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 29B7A6A9A;
	Wed,  9 Nov 2011 13:01:35 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B65C36A99; Wed,  9 Nov 2011
 13:01:34 -0500 (EST)
In-Reply-To: <20111109174027.GA28825@book.fritz.box> (Heiko Voigt's message
 of "Wed, 9 Nov 2011 18:40:27 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DCA39D7A-0AFC-11E1-89BD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185165>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> This is almost ready but I would like to know what users of the
> "floating submodule" think about this.

Thanks for working on this.

I do like to hear from potential users as well, because the general
impression we got was that floating submodules is not a real need of
anybody, but it is merely an inertia of people who (perhaps mistakenly)
thought svn externals that are not anchored to a particular revision is a
feature when it is just a limitation in reality. During the GitTogether'11
we learned that Android that uses floating model does not really have to.
