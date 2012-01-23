From: Junio C Hamano <gitster@pobox.com>
Subject: Re: make install rewrites source files
Date: Mon, 23 Jan 2012 12:15:07 -0800
Message-ID: <7vhazm89bo.fsf@alter.siamese.dyndns.org>
References: <hbf.20120123bz2f@bombur.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>
X-From: git-owner@vger.kernel.org Mon Jan 23 21:15:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpQIP-0008VI-U2
	for gcvg-git-2@lo.gmane.org; Mon, 23 Jan 2012 21:15:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753699Ab2AWUPL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jan 2012 15:15:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34228 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751770Ab2AWUPK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jan 2012 15:15:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 605A152EA;
	Mon, 23 Jan 2012 15:15:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Wq/Sb2+uCwWavaYA/bW778snbqg=; b=G1aE0X
	eLFA0FiYpY3h11zGwIz7zpLbrqUR3C0pWl3/fta07LVAe2R1IcH9gC39MIEiO2r7
	BdSw1KYq8wAuoyynIJDyiqDhQPqmZiBj2iUtTNnk4iUtwmMBIMnTve4vknyHy0Y8
	nK79KsFgexa1IfsxHa7n32OhNOU+8hUFJxUj0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p68mWxLrrDuGVySm/ng7pP3D1NxnkJGf
	SdZPxAnhFEO6h1Y1cjRWRkRVb1+9nqf6axNA6x+ArbLA/hkwneTiXFAstreObjeo
	jibBs6PEIJC2jJ/D/es0YYw+Y8uG6epGV87/89YHMbv3CWrkCZAbXBRDVmEohKBw
	CLVIZOEla2Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5519752E9;
	Mon, 23 Jan 2012 15:15:09 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 75F8152E6; Mon, 23 Jan 2012
 15:15:08 -0500 (EST)
In-Reply-To: <hbf.20120123bz2f@bombur.uio.no> (Hallvard Breien Furuseth's
 message of "Mon, 23 Jan 2012 15:18:18 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F22E14B2-45FE-11E1-9FB6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189010>

Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no> writes:

> INSTALL says we can install a profiled Git with
> 	$ make profile-all
> 	# make install prefix=...
> This does not work...

We should just drop prefix=... from that line, as the "prefix=value must
be the same while building and installing" is not only about the "profile"
build but applies to any other build.

I however wonder why you would need a separate profile-install target,
though.  Shouldn't 

	$ make foo-build && make install

install a funky 'foo' variant of the build for any supported value of
'foo'?
