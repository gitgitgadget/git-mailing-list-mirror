From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: rebase when an author uses accents in name on MacOSx
Date: Fri, 01 Jun 2012 09:19:26 -0700
Message-ID: <7vmx4n3sz5.fsf@alter.siamese.dyndns.org>
References: <06DD2F56-F956-46DF-84A4-3443D4702CDE@spotinfluence.com>
 <7vehq18c82.fsf@alter.siamese.dyndns.org>
 <20120531011911.GC5488@sigill.intra.peff.net>
 <7v62bc97w1.fsf@alter.siamese.dyndns.org>
 <78E7FEAC-6587-4EB3-B78B-08D321F53BF9@spotinfluence.com>
 <7vtxyw6ypx.fsf@alter.siamese.dyndns.org>
 <69ED148F-BD10-4DE3-91F2-D31F83A0EAB7@spotinfluence.com>
 <7vd35k6w0i.fsf@alter.siamese.dyndns.org>
 <168277BB-0E71-4987-A2BE-6202034A96F1@spotinfluence.com>
 <20120601093039.GD32340@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lanny Ripple <lanny@spotinfluence.com>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 01 18:19:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaUZa-00082b-Fp
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 18:19:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965374Ab2FAQTa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jun 2012 12:19:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36409 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964978Ab2FAQT3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2012 12:19:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D64DF8B96;
	Fri,  1 Jun 2012 12:19:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Up2C9n0uWEkNBU+yu5hecyNHlYk=; b=jPmJMc
	pQq52F0y+3e6qkumR4GnEN3EFZ8Zu/4nNmH8+SeU5yK6p4+mpPXzcAnJnF6hFKUs
	Eg2kGuWAJHf9UhkimkQEYtlWre17NL+l2splE4kzJX1eVJ2z8y/Hq3cZnTXNZiLx
	W95EBNGGTbGcUCBD8uMBXrDugzykFq3XgIXyE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Wax7RHlAw7kho/aqyMkwFYTSPcilb05Q
	GIcFsnTA/t6uU9zGDHLyafe7JjnJcSFQ395kteb2NKQv4iMrTqY0xT06Dmq5jE7b
	vW7YEFsLbHtQkk+x/ZkwiaiZDnCxUjMKXn3ERnrOHbQB3gGePVNDf4XM63o3tPvn
	+EkdeCSNxXs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB3D18B93;
	Fri,  1 Jun 2012 12:19:28 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2BC188B90; Fri,  1 Jun 2012
 12:19:28 -0400 (EDT)
In-Reply-To: <20120601093039.GD32340@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 1 Jun 2012 05:30:39 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8F9BE01E-AC05-11E1-AA6D-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198998>

Jeff King <peff@peff.net> writes:
> [Please don't top-post.]
> ...
> But you have to keep in mind all of the people who will be led down the
> wrong path by your breadcrumb when the failure is caused by a
> _different_ problem. What is the probability that it is helpful versus
> not helpful?  If you are going to give advice that sed might be broken,
> you should at least test to see if it is broken and report it.

Eek, do that at runtime in the error code path?

Add something like

	suspected_sed_breakage () {
		xxxxx=$(printf "\370\235\204\236\n" | LC_CTYPE=C sed 's/./x/g')
                if test "x$xxxxx" != "xxxxx"
                then
			die "Your sed is broken; cannot run $1"
		fi
	}

to git-sh-setup, and do something like:

	. "$dotest/author-script" || suspected_sed_breakage "$0"

in git-am?

The problem I see is that at that point where we have to suspect
something fundamental as sed broken on the platform, we cannot even
trust printf, test, or even the shell itself behaving sanely.

So I would say, although it is a fun thought-experiment, such a test
and breadcrumb is not really worth it.
