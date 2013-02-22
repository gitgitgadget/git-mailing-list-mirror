From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Crashes while trying to show tag objects with bad timestamps
Date: Fri, 22 Feb 2013 14:53:48 -0800
Message-ID: <7vy5egark3.fsf@alter.siamese.dyndns.org>
References: <kg8ri2$vjb$1@ger.gmane.org>
 <20130222224655.GB21579@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mantas =?utf-8?Q?Mikul=C4=97nas?= <grawity@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 22 23:54:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U91VR-0005Ye-7o
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 23:54:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758248Ab3BVWxw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2013 17:53:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35933 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754218Ab3BVWxv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 17:53:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DD32AC25;
	Fri, 22 Feb 2013 17:53:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rpU5Cf1aHQcJJ9bdg5LKRtjaJGg=; b=MhnbMx
	koj8vYKTrdloMA6UgGgumtYxF9dysQ6KMFCinlO+/pp34q7Rja3YbuN6FKeVV39m
	FLG5Q4BdrlPPbSulr6wb4YMtw77EcV9EspbWyBmDwcyoURaGcREkxqHUfT/KT9yw
	6XBI0vgH4jVF97ojwn3pSuSUz5IYq2pNYuPi8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RZ8t7kXjERReJ16UeUPszzfTH1cuZOwX
	DL/IeFi02Io7wN1zTrHI7NbRLVJv1GOQZEGar7SZAP6ncAQCPUlEyPX6Vm92sByx
	A5xvg+xF/ToEjz8TVZYWmQ0Mqjja2cjq0VTcP0XSW7xnu0A7ADS3lxHhekcFde+Y
	PTnkGW2EKwk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 029A0AC24;
	Fri, 22 Feb 2013 17:53:51 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7A9A4AC1A; Fri, 22 Feb 2013
 17:53:50 -0500 (EST)
In-Reply-To: <20130222224655.GB21579@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 22 Feb 2013 17:46:55 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B95369C2-7D42-11E2-AE04-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216874>

Jeff King <peff@peff.net> writes:

> I guess we should probably issue a warning, too. Also disappointingly,
> git-fsck does not seem to detect this breakage at all.

Yes for the warning, and no for disappointing.  IIRC, in the very
early implementations allowed tag object without dates.

I _think_ we can start tightening fsck, though.
