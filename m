From: Junio C Hamano <gitster@pobox.com>
Subject: Re: make install rewrites source files
Date: Thu, 26 Jan 2012 16:49:44 -0800
Message-ID: <7vobtq0y1j.fsf@alter.siamese.dyndns.org>
References: <hbf.20120123bz2f@bombur.uio.no>
 <7vhazm89bo.fsf@alter.siamese.dyndns.org> <hbf.20120123j61g@bombur.uio.no>
 <20120126225231.GA14753@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>,
	git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Fri Jan 27 01:49:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rqa0m-0000WQ-A4
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 01:49:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754510Ab2A0Ats (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jan 2012 19:49:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54368 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751864Ab2A0Atr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2012 19:49:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D6729625C;
	Thu, 26 Jan 2012 19:49:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wUxrfyKPA4UNw+m5uBbF9fTNWPg=; b=BD8AAe
	NqF/WM3wj0lzK1mg2rW7p9nKyHxqF2W4QQ22Wep96CXRrMSPjttax0h/+73zXdRe
	LZ2VCDcD+F4vx4IsWlpxgkup44PUHnEuBXZvE8LL5sBbukaWqfnuX4cyhcwc9QDZ
	eot5NWwDV3zxqonny73d2CYFfEAFlJeglw9Fo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZCSzYbUKaF1rilGkFxsil+tLyS9OH56Y
	BvXRVb2t4EH8wumRBc3Ye9iRYPqbXLrUz3dz2OaE9imCRXsKD1spQs0xWMyJ2j/d
	32Zf7wEzlymjk5aVpXQBOwCjyuLbJLEfzn//lqM2BWGfdtkqANXtBWn2F+Ckp7/q
	9p3An13JvJM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC911625B;
	Thu, 26 Jan 2012 19:49:46 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 478646257; Thu, 26 Jan 2012
 19:49:46 -0500 (EST)
In-Reply-To: <20120126225231.GA14753@ecki> (Clemens Buchacher's message of
 "Thu, 26 Jan 2012 23:52:31 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CEF585DC-4880-11E1-B492-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189182>

Clemens Buchacher <drizzd@aon.at> writes:

> How about removing the profile-all target and making it a build option
> instead? To enable it, do the usual:
>
>  echo PROFILE_BUILD=YesPlease >> config.mak
>  echo prefix=... >> config.mak
>  make
>  su make install

Yeah, I would prefer something like that. We could even keep "profile-all"
target for b/c if we wanted to, no?
